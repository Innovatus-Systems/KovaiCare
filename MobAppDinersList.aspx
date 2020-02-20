<%@ Page Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MobAppDinersList.aspx.cs" Inherits="MobAppDinersList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script language="javascript" type="text/javascript">

        function TaskConfirmMsg() {
            var result = confirm('Are you sure you want to remove the selected diner? This process cannot be reversed.');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }
        }

    </script>
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 98%" align="center">
                <table style="width: 100%">
                    <tr>
                        <td align="center">
                            <asp:HiddenField ID="CnfResult" runat="server" />
                            <asp:LinkButton ID="lnktitle" runat="server" Text="Diners List - From Mobile App." Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>

                 <table>
                    <tr>
                         <td colspan="2">    
                                  
                             <asp:Label ID="Label3" runat="Server" Text="Dined date:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="true"></asp:Label>
                          
                         &nbsp;&nbsp;
                            <asp:Label ID="lblfordate" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the date from which you wish to view the diner details."  >
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                            &nbsp;&nbsp;
                        
                            <asp:Label ID="lbluntildate" runat="Server" Text="To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                            <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the date till which you wish to view the diner details."  >
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>

                              &nbsp;&nbsp;
                             
                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the diner details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click"  ></asp:Button>
                            <asp:Button ID="btnReturn" runat="server" CssClass="btn btn-primary" ToolTip="Clik here to return"  Text="Return" ForeColor="White" OnClick="btnReturn_Click"  ></asp:Button>
                             
                               
                         </td>
                   
                        
                    </tr>
                    
                </table>

                <table align="center">
                    <tr>
                        <td style="width: 98%; height: 185px; vertical-align: top;" align="center">
                            <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="false" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand" OnItemDataBound="ReportList_ItemDataBound"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="false" AllowFilteringByColumn="true" 
                                CellSpacing="5" Width="95%"  GroupingSettings-CaseSensitive="false"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false" ShowFooter="true">
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
                                        <telerik:GridTemplateColumn HeaderText="Remove" UniqueName="Delete" AllowFiltering="False" HeaderStyle-Width="35px" ItemStyle-Width="35px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkRemove" runat="server" CausesValidation="false" OnClientClick="javascript:return TaskConfirmMsg()" 
                                                    Text="Remove" Font-Underline="true" ForeColor="#00008B" OnClick="lnkRemove_Click" ToolTip="Click to remove the diner from the list.">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="10px" DataField="RSN" Display="false" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip=" " ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Resident ID/Name" HeaderStyle-Width="120px" DataField="Resident" ReadOnly="true" AllowFiltering="true" FilterControlWidth="85px" HeaderTooltip=" "></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="60px" DataField="DDate" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="80px" DataField="Session" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip=" " ></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Diners" HeaderStyle-Width="40px" DataField="Diners" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Guest" HeaderStyle-Width="45px" DataField="Guest" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Home Delivery" HeaderStyle-Width="60px" DataField="HmDly" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="40px" HeaderTooltip="" ></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Posted" HeaderStyle-Width="40px" DataField="Posted" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="40px" DataField="Code" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Confirmed On" HeaderStyle-Width="80px" DataField="ConfirmedOn" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true"  FilterControlWidth="55px" HeaderTooltip="" ItemStyle-CssClass="Row1" Aggregate="Count" FooterText="Row Count : " FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>

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


            </div>
        </div>
    </div>
</asp:Content>
