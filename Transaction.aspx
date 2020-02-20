<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/CovaiSoft.master" CodeFile="Transaction.aspx.cs" Inherits="Transaction" %>

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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<div id="content">--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 <div class="main_cnt">
        <div class="first_cnt">

           <table>
<tr>
<td>
<asp:Label ID="lblCustomerID" runat="Server" Text ="CustomerID" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small"></asp:Label>
</td>
<td>
<asp:TextBox ID="CustomerID" runat="Server" MaxLength="0" ToolTip ="Please enter CustomerId"  Width= "200px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblCustomerName" runat="Server" Text ="CustomerName" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="CustomerName" runat="Server" MaxLength="80" ToolTip ="Please enter CustomerName ML80." Width= "250px" Height="25px"  ForeColor =" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblProjectCode" runat="Server" Text ="ProjectCode" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
     <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="ProjectCode" runat="Server" MaxLength="4" ToolTip ="Please enter ProjectCode ML4." Width= "200px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblType" runat="Server" Text ="Type" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="Type" runat="Server" MaxLength="8" ToolTip ="Please enter Type ML8." Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDWNumber" runat="Server" Text ="DWNumber" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
     <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="DWNumber" runat="Server" MaxLength="8" ToolTip ="Please enter DWNumber ML8." Width= "200px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXCD" runat="Server" Text ="TXCD" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
     <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXCD" runat="Server" MaxLength="2" ToolTip ="Please enter TXCD ML2." Width= "150px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXDATE" runat="Server" Text ="Transaction date" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
     <asp:Label ID="Label4" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
</td>
<td>
    <telerik:RadDatePicker ID="TXdate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick transaction date"
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                            </DateInput>
                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle BackColor="Pink" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

<%--<asp:TextBox ID="TXDATE" runat="Server" MaxLength="0" ToolTip ="Pick transaction date" Width= "0px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Medium"   ></asp:TextBox >--%>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXDRCR" runat="Server" Text ="TXDRCR" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
     <asp:Label ID="Label5" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXDRCR" runat="Server" MaxLength="2" ToolTip ="Please enter TXDRCR ML2." Width= "150px" Height="25px"  ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXAMOUNT" runat="Server" Text ="Transaction Amount" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXAMOUNT" runat="Server" MaxLength="10" ToolTip ="Please enter transaction amount ML10." Width= "250px" Height="25px"  ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXDESC" runat="Server" Text ="Transaction description" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXDESC" runat="Server" MaxLength="240" ToolTip ="Please enter transaction description ML240." Width= "500px"  ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small" TextMode="Multiline" Height="60px"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXDESCINTRNL" runat="Server" Text ="TXDESCINTRNL" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXDESCINTRNL" runat="Server" MaxLength="240" ToolTip ="Please enter TXDESCINTRNL ML240." Width= "500px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small" TextMode="Multiline" Height="60px"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStageID" runat="Server" Text ="StageID" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="StageID" runat="Server" MaxLength="5" ToolTip ="Please enter stageId ML5." Width= "150px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small" ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTXREFNO" runat="Server" Text ="TXREFNO" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="TXREFNO" runat="Server" MaxLength="12" ToolTip ="Please enter transaction reference number ML12." Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblCPFVCSLink" runat="Server" Text ="CPFVCSLink" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="CPFVCSLink" runat="Server" MaxLength="18" ToolTip ="Please choose link ML18." Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
</table>
            <table>
<tr>
<td>
<asp:Button ID="btnSave" runat="Server" width="100px" Text="Save" ToolTip ="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names =" Verdana" Font-Size ="Medium"/>
</td>
<%-- End of Button Save --%>
<%-- Button Clear --%>
<td>
<asp:Button ID="btnClear" runat="Server" width="100px" Text="Clear" ToolTip =" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names ="Verdana" Font-Size ="Medium"/>
</td>
<%-- End of Button Clear --%>
<%-- Button Exit --%>
<td>
<asp:Button ID="btnExit" runat="Server" width="100px" Text="Exit" ToolTip ="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names ="Verdana" Font-Size ="Medium"/>
</td>
</tr>
</table>

<%-- ISRAPID CODE END FOR ADD into:tblTransactions --%>
<%-- GridView Start --%>
<table>
        <tr>
            <td>
                 <telerik:RadGrid ID="TransactiongrdView" runat="server" AllowPaging="True" PageSize="20"
                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"
                     OnPageIndexChanged="TransactionListView_PageIndexChanged"
                    OnPageSizeChanged="TransactionListView_PageSizeChanged" OnSortCommand="TransactionListView_SortCommand"
                    CellSpacing="0" Width="70%" AllowFilteringByColumn="true" 
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
                             <telerik:GridBoundColumn HeaderText="CustomerID" DataField="CustomerID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="CustomerName" DataField="CustomerName" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="false"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="ProjectCode" DataField="ProjectCode" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="DWNumber" DataField="DWNumber" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn HeaderText="Address1" DataField="RTAddress2" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn HeaderText="TXCD" DataField="TXCD" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" 
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TXDATE" DataField="TXDATE" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn HeaderText="TXDRCR" DataField="TXDRCR" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn HeaderText="ContactNo" DataField="Contactno" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible ="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn HeaderText="TXAMOUNT" DataField="TXAMOUNT" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" visible ="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TXDESC" DataField="TXDESC" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn HeaderText="AlternateEMAILID" DataField="AlternateEMAILID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                             <telerik:GridBoundColumn HeaderText="TXDESCINTRNL" DataField="TXDESCINTRNL" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn HeaderText="StageID" DataField="StageID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn HeaderText="TXREFNO" DataField="TXREFNO" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                 ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <%--<telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                            <%--<telerik:GridTemplateColumn HeaderText="" HeaderButtonType="TextButton"
                             HeaderStyle-HorizontalAlign ="Left" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Italic="false">
                                <ItemTemplate>
                                       <asp:LinkButton ID="LnkRemove" runat="server" Text="Remove" 
                                       Font-Names="Verdana" Font-Size="Small" Font-Italic="false"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
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
<%-- GridView End --%>

<%-- Button Save --%>

    
</div>
     </div>

    </asp:Content>