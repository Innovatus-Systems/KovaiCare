<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BillingPeriods.aspx.cs" Inherits="BillingPeriods" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

            var result = confirm('Are you sure, you want to Update?');

            if (result) {
                return true;
            }
            else {
                return false;
            }
        }

    </script>
    <script language="javascript" type='text/javascript'>
        function hideDiv() {
            if (document.getElementById) {
                document.getElementById('divtext').style.display = 'none';
            }
        }
        function showDiv() {
            if (document.getElementById) {
                document.getElementById('divtext').style.display = 'block';
            }
        }
</script>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 100%; min-height: 400px">

                <table style="width: 100%;" align="center">
                    <tr>
                        <td align="center">
                            <%--<asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Font-Underline="false"></asp:LinkButton>--%>
                            <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>


                <table align="center">
                    <tr>
                        <td>
                            <telerik:RadGrid ID="BPgrdView" runat="server"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"                               
                               Width="100%"
                                MasterTableView-HierarchyDefaultExpanded="true">
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
                                        <telerik:GridBoundColumn HeaderText="#" DataField="RSN" HeaderStyle-Wrap="false" Display="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50PX"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Month" DataField="BPNAME" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="From" DataField="BPFrom" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Untill" DataField="BPTill" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Spl. Msg." DataField="BPSpecialMsg" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" DataField="BStatus" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Billing Dt." DataField="BDate" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <%-- <telerik:GridBoundColumn HeaderText="Next Billing Date" DataField="NextBillingDate" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="15px"
                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="EditLkUp" SortExpression="Edit">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit  Details" Text="Edit" Font-Bold="true" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>

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
                </table>
                <div id="divtext" style="display:none;">
                    
                    <table style="width: 100%">
                        
                        <tr>
                            <td style="width:150px;">

                            </td>
                            <td>
                                <table > 
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Text="Update :"></asp:Label>
                                        </td>
                                    </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="Server" Text="Billing Month :" ForeColor=" Black " Font-Bold="true"
                                    Font-Names="Calibri" Font-Size="Small"></asp:Label><text style="color: red;">*</text>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBMonth" runat="server" CssClass="form-control"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBPFrom" runat="Server" Text="Billing Period From :" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small" Font-Bold="true"></asp:Label>
                                <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                                <text style="color: red;">*</text>
                            </td>
                            <td>

                                <telerik:RadDatePicker ID="BPFrom" runat="server" Font-Names="Calibri" ToolTip="Pick Billig Period From Date."
                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" CssClass="form-control">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                    </DateInput>
                                    <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="Pink" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBPTill" runat="Server" Text="Billing Period Till :" ForeColor=" Black " Font-Names="Calibri" Font-Bold="true"
                                    Font-Size="Small"></asp:Label><text style="color: red;">*</text>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="BPTill" runat="server" Font-Names="Calibri"  ToolTip="Pick Billing Period till Date."
                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="false" CssClass="form-control">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="Date" runat="server" DateFormat="dd-MMM-yyyy" >
                                    </DateInput>
                                    <%-- <DateInput ID="DateInput3" DateFormat="dd-MMM-yy ddd HH:MM:SS" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                            </DateInput>--%>
                                    <Calendar ID="Calendar3" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="Pink" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="Server" Text="Spl. Message :" ForeColor=" Black " Font-Bold="true"
                                    Font-Names="Calibri" Font-Size="Small" ></asp:Label><text style="color: red;">*</text>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSplMsg" runat="server" CssClass="form-control"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBStatus" runat="Server" Text="Billing Status :" ForeColor=" Black " Font-Bold="true"
                                    Font-Names="Calibri" ></asp:Label><text style="color: red;">*</text>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlBStatus" ToolTip="Select Billing Status" runat="server"
                                    Font-Names="Calibri" Font-Size="Small" CssClass="form-control">
                                    <asp:ListItem Text="OPEN" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="PREV. MONTH" Value="30"></asp:ListItem>
                                    <asp:ListItem Text="CLOSED" Value="90"></asp:ListItem>
                                    <asp:ListItem Text="NOT YET" Value="00"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="Server" Text="Billed Date :" ForeColor=" Black " Font-Names="Calibri" Font-Bold="true"
                                   ></asp:Label><text style="color: red;">*</text>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="dtBDATE" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Billed Date."
                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="false" CssClass="form-control">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="dd-MMM-yyyy">
                                    </DateInput>
                                    <%-- <DateInput ID="DateInput3" DateFormat="dd-MMM-yy ddd HH:MM:SS" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                            </DateInput>--%>
                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="Pink" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnnSave" runat="Server" Width="100px" Text="Update" ToolTip="Clik here to Update the details."
                                    ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" Font-Names=" Calibri" OnClientClick="ConfirmMsg()" Font-Size="Small" OnClick="btnnSave_Click" />
                            </td>
                            <%-- End of Button Save --%>
                            <%-- Button Clear --%>
                            <td>
                                <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details."
                                    ForeColor="White" BackColor="DarkOrange" CssClass="btn btn-default" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                            </td>
                            <%-- End of Button Clear --%>                        
                           
                        </tr>
                    </table>
                            </td>
                        </tr>
                    </table>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>

