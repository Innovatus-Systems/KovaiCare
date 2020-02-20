<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Confirmation.aspx.cs" Inherits="Confirmation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
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

    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <style>
        .rightAlign { text-align:right; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlUpdate">
                        <ProgressTemplate>
                            <div class="Loadingdiv">
                                <div class="centerdiv">
                                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                                    <img alt="Loading...." src="Images/Loader.gif" />
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
            <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
                <ContentTemplate>--%>

            <table style="width: 100%">
                <tr>
                    <td align="Left" style="width: 35%">
                        <asp:LinkButton ID="LinkButton1" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                    <td align="Center" style="width: 30%">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                    <td align="Right" style="width: 35%">
                        <asp:LinkButton ID="lnkDinersList" Font-Underline="true" runat="server" Text="App Conf.List" Font-Names="verdana" Font-Size="Medium" ForeColor="Red" ToolTip="Click to view the list of diners confirmed via mobile app." Font-Bold="true" OnClick="lnkDinersList_Click"></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="lnkFandB" Font-Underline="true" runat="server" Text="UnBilled Txn(s)" Font-Names="verdana" Font-Size="Medium" ForeColor="Red" ToolTip="Click To See Unbilled Txn(s). " Font-Bold="true" OnClick="lnkFandB_Click"></asp:LinkButton>
                    </td>
                </tr>
            </table>

            <table align="Center" style="width: 90%">

                <tr>
                    <td>
                        <asp:Label ID="lblSession" runat="server" Text="Select Session :" Font-Bold="true"></asp:Label>
                        <asp:DropDownList ID="drpSession" runat="server" ToolTip="Select a date and session for which you wish to do the diners billing.  
                                Must be in the current billing month and not in the future. 
                                What happens on the first date of a If it is the first date of a new billing month 
                                and if month end billing for the just ended month is not yet done:
                                you can only confirm for the sessions in the just closed billing month.
                                Ex: if it is 1st Dec 2017  and November has just ended, billing confirmation can be done only for November.
                                The rates for the session, the Txn.code , the Tax % and the unique session code are shown alongside."
                            OnSelectedIndexChanged="drpSession_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                        &nbsp; &nbsp;
                        <asp:Label ID="lbldate" runat="server" Text="Select Date :" Font-Bold="true"></asp:Label>

                        <telerik:RadDatePicker ID="dtDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small" OnSelectedDateChanged="dtDate_SelectedDateChanged"
                            Width="165px" CssClass="TextBox" ReadOnly="true" AutoPostBack="true" ToolTip="Select a date and session for which you wish to do the diners billing.  
                                                Must be in the current billing month and not in the future. 
                                                What happens on the first date of a 
                                                If it is the first date of a new billing month and if month end billing for the just ended month is not yet done:
                                                you can only confirm for the sessions in the just closed billing month.
                                                Ex: if it is 1st Dec 2017  and November has just ended, billing confirmation can be done only for November.
                                                The rates for the session, the Txn.code , the Tax % and the unique session code are shown alongside.">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                CssClass="TextBox" Font-Names="Calibri">
                            </Calendar>
                            <DatePopupButton></DatePopupButton>
                            <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                ForeColor="Black" ReadOnly="true">
                            </DateInput>
                        </telerik:RadDatePicker>

                        &nbsp; 
                        
                                <asp:Label ID="lbltiming" runat="server" Text="" Visible="false" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="lblTime" runat="server" Text="" Font-Bold="true" ForeColor="Maroon" Visible="false" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="lblhexcode" runat="server" Text="" Font-Bold="true" ForeColor="#cccccc" Visible="false" Font-Size="Smaller"></asp:Label>
                        &nbsp; &nbsp; 
                        <asp:CheckBox ID="chkSplSess" runat="server" AutoPostBack="true" Text="SPL. Session" OnCheckedChanged="chkSplSess_CheckedChanged" Visible="false" />

                        &nbsp; &nbsp; 
                         <asp:CheckBox ID="chkFrmApp" runat="server" ForeColor="Maroon" Text="From Mob. App." Font-Bold="true" ToolTip="If checked, data from dining confirmation app will be used." OnCheckedChanged="chkFrmApp_CheckedChanged" AutoPostBack="true" />
                        
                    </td>
                    <td align="Right">
                        <asp:Label ID="Label3" runat="server" Text="D-RS. :" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="lblDRate" runat="server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Text="G-RS. :" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="lblGRate" runat="server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="Label6" runat="server" Text="H.D-Rs. :" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                        <asp:Label ID="lblHRate" runat="server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Size="Smaller"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblName" runat="server" Text="For Whom? :" Font-Bold="true"></asp:Label>

                        <telerik:RadComboBox ID="drpName" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                            AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                            Width="250px" ToolTip="Select a Door No or Resident.  The Account Code , and the names of the residents in the house are shown alongside." OnSelectedIndexChanged="drpName_SelectedIndexChanged"
                            RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                        </telerik:RadComboBox>
                        <br />
                        <asp:Label ID="lblRDetails" runat="server" Text="-" ForeColor="Maroon" Visible="false"></asp:Label>
                    </td>
                    <td align="Right">
                        <asp:Label ID="lblMsg" runat="server" Text="" Font-Bold="true" Font-Size="Smaller">   </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                         <asp:Label ID="Label1" runat="server" Text="Confirmation via mobile app? Press save to retrieve." Font-Bold="true" ForeColor="Maroon" Visible="true" Font-Size="Small"></asp:Label>
                    </td>
                     
                       
                </tr>
            </table>
            <table>
                <tr>
                    <td style="vertical-align: top; width: 49%;">
                        <table>
                            <%-- <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Dining Confirmation" Font-Bold="true" ForeColor="DarkBlue" Font-Size="Medium"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rgConfir" runat="server" AutoPostBack="true"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" Height="80px"
                                        MasterTableView-HierarchyDefaultExpanded="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false">
                                            <NoRecordsTemplate>
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <%-- <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="100px" DataField="Session" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Door No." HeaderStyle-Width="40px" DataField="rtvillano" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Medium" ItemStyle-HorizontalAlign="Center" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Confirmation" HeaderStyle-Width="75px" DataField="rtname" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="left" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Medium" ItemStyle-HorizontalAlign="left" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Diners" UniqueName="Diners" ItemStyle-Width="7%" HeaderStyle-Width="7%" HeaderTooltip=" By default shows the number of Diners, Who dined for a particular session and date." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="ddlDiners" runat="server" CssClass="rightAlign" Text='<%# Bind("Diners") %>' Width="40px" OnTextChanged="ddlDiners_TextChanged" AutoPostBack="true" Font-Bold="true" Font-Size="Medium" ToolTip="Enter the number of diners from the list below. If there are more than 5, do the billing multiple times."></asp:TextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Casual/Guests" UniqueName="Guests" ItemStyle-Width="8%" HeaderStyle-Width="7%" HeaderTooltip=" By default shows the number of casual/guests bookings made by a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="ddlGuest" runat="server" CssClass="rightAlign" Text='<%# Bind("Guest") %>' Width="40px" OnTextChanged="ddlGuest_TextChanged" AutoPostBack="true" Font-Bold="true" Font-Size="Medium" ToolTip="Enter the number of casuals/guests for the resident from the list below. If there are more than 5, do the billing multiple times."></asp:TextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="HomeDly." UniqueName="HS" ItemStyle-Width="7%" HeaderStyle-Width="7%" HeaderTooltip=" By default shows the number of Home Delivery" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="ddlHomeDly" runat="server" CssClass="rightAlign" Text='<%# Bind("HS") %>' Width="40px" OnTextChanged="ddlHomeDly_TextChanged" AutoPostBack="true" Font-Bold="true" Font-Size="Medium" ToolTip="Enter the number of Home Delivery for the resident from the list below. If there are more than 5, do the billing multiple times."></asp:TextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <FilterMenu Skin="WebBlue" EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <table>
                                        <%--<tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text="Confirmation Counts." Font-Bold="true" ForeColor="DarkBlue" Font-Size="Medium"></asp:Label>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>

                                                <telerik:RadGrid ID="rdCount" runat="server" AutoPostBack="true"
                                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" Height="150px"
                                                    CellSpacing="5" Width="300px"
                                                    MasterTableView-HierarchyDefaultExpanded="true">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                    </HeaderContextMenu>
                                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                                    <MasterTableView AllowCustomPaging="false">
                                                        <NoRecordsTemplate>
                                                            No Records Found.
                                                        </NoRecordsTemplate>
                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Confirmed" DataField="Date" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Date and session (DD-MMM/S)." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="60px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Diners" HeaderStyle-Width="50px" DataField="REG" ReadOnly="true" HeaderTooltip="Total Regular Diners Count." AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Casual" HeaderStyle-Width="50px" DataField="GST" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Total Casual Diners Count." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="HmDly" HeaderStyle-Width="50px" DataField="HD" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Total Home Delivery Count." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>

                                                        </Columns>
                                                        <EditFormSettings>
                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                            </EditColumn>
                                                        </EditFormSettings>
                                                        <PagerStyle AlwaysVisible="True"></PagerStyle>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="True" />
                                                    </ClientSettings>
                                                    <FilterMenu Skin="WebBlue" EnableTheming="True">
                                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                    </FilterMenu>
                                                </telerik:RadGrid>
                                            </td>
                                            <td align="right" style="vertical-align: bottom;">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="lblTot" runat="server" Text="Billed Amount :Rs." ForeColor="White" Font-Names="Verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            &nbsp; &nbsp;
                                                        <asp:Label ID="lblTotal" runat="server" Text="-" ForeColor="White" Font-Names="Verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ToolTip=" Saves to local memory and you can alter the values later." />&nbsp;&nbsp; 
                                                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" ToolTip="Click to clear the counters above." />&nbsp;&nbsp;
                                                            <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="btn btn-danger" OnClick="btnPost_Click" ToolTip="When clicked, the transactions below, will be posted to the residents' accounts.  Any mistakes can be un-done only by a reversal." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            

                                                            </td>
                                                        </tr>

                                                </table>
                                                
                                            </td>
                                        </tr>
                                    </table>

                                </td>

                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; width: 60%;">
                        <table>
                            <%-- <tr>
                                <td align="Left">
                                    <asp:Label ID="Label1" runat="server" Text="Special Diners Notes" Font-Bold="true" ForeColor="DarkBlue" Font-Size="Medium" ToolTip=" If there are any notes for the particular day, these are displayed here. Helps to know if any diner has requested for a special service or if a diner will not be dining for a day."></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rgDinNts" runat="server" AutoPostBack="true"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" Height="200px"
                                        CellSpacing="5"
                                        MasterTableView-HierarchyDefaultExpanded="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false">
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Date and session to enter diners notes." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="60px" DataField="SessionName" ReadOnly="true" HeaderTooltip="Date and session to enter diners notes." AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Diners Notes" HeaderStyle-Width="80px" DataField="DNDesc" ReadOnly="true" AllowFiltering="true" HeaderTooltip="From the standard list , Maintains Separately."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="For" Visible="false" HeaderStyle-Width="30px" DataField="ForWhom" ReadOnly="true" AllowFiltering="true" HeaderTooltip="For whom is notes applicable."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="60px" DataField="Rtvillano" ReadOnly="true" AllowFiltering="true" HeaderTooltip="House of the resident diners."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="90px" DataField="DN_Name" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Name of the diners."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="120px" DataField="DNNOTES" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Any Additional information."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rqstd. Date" Visible="false" HeaderStyle-Width="60px" DataField="ReqDate" ReadOnly="true" AllowFiltering="true" HeaderTooltip="When entered." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="80px" Display="false" DataField="RSN" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <FilterMenu Skin="WebBlue" EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <table style="width: 30%">
            </table>
            <table>
                <tr>
                    <td>
                        <telerik:RadGrid ID="glTransactions" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                            Width="90%" AllowFilteringByColumn="false" AllowPaging="false" AutoPostBack="true">
                            <ClientSettings>
                                <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                            </ClientSettings>
                            <MasterTableView AllowCustomPaging="false" ShowFooter="true">
                                <NoRecordsTemplate>
                                    No Transaction Posted.
                                </NoRecordsTemplate>
                                <Columns>
                                    <telerik:GridTemplateColumn UniqueName="Delete" AllowFiltering="False"
                                        HeaderStyle-Width="45px" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblEdit" runat="server" CausesValidation="false"
                                                Text="Remove" Font-Underline="true" ForeColor="#00008B" OnClick="lblEdit_Click" ToolTip="Click to Edit particular transaction from grid.">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="S.No" HeaderStyle-Width="80px" DataField="RSN" Display="false" AllowFiltering="true" FilterControlWidth="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="80px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="DoorNo." HeaderStyle-Width="90px" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="180px"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="120px" DataField="Name" ReadOnly="true" AllowFiltering="true"  Aggregate="Count" FooterText="Row Count : " FooterStyle-Font-Bold="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="250px" DataField="Narration" ReadOnly="true" AllowFiltering="true" ></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Diners" HeaderStyle-Width="50px" DataField="Diners" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"  FooterText="DN : " FooterStyle-Font-Bold="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Guests" HeaderStyle-Width="50px" DataField="Guests" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"  FooterText="GU : " FooterStyle-Font-Bold="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="HomeDly." HeaderStyle-Width="50px" DataField="HomeDly" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="HD : "   FooterStyle-Font-Bold="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="60px" DataField="Total" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="Tot : "   FooterStyle-Font-Bold="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Amount" HeaderStyle-Width="80px" DataField="Amount" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Account" HeaderStyle-Width="80px" DataField="Account" ReadOnly="true" Display="false" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="D:" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;  
                                        <asp:Label ID="lblDCalc" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Bold="true" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;
                                               <asp:Label ID="lblDTol" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Bold="true" Font-Size="Small"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="G:" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;  
                                        <asp:Label ID="lblGCalc" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Bold="true" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;
                                               <asp:Label ID="lblGTol" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Bold="true" Font-Size="Small"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="H:" ForeColor="Maroon" Font-Names="Verdana" Visible="false" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;  
                                        <asp:Label ID="lblHCalc" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Visible="false" Font-Size="Small"></asp:Label>
                        &nbsp; &nbsp;
                                               <asp:Label ID="lblHTol" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Visible="false" Font-Size="Small"></asp:Label>

                    </td>
                </tr>
            </table>
            <%--  </ContentTemplate>
                <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="ddlDiners" />
                    <asp:AsyncPostBackTrigger ControlID="ddlGuest" />
                    <asp:AsyncPostBackTrigger ControlID="ddlHomeDly" />
                </Triggers>
            </asp:UpdatePanel>--%>
        </div>
    </div>
</asp:Content>

