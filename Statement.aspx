<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="Statement.aspx.cs" Inherits="Statement" %>

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

<%-- ISRAPID CODE START: 24/02/2015 10:19:00 by:Mani --%>
<%-- ADD records into tblStatements --%>
<table>
<tr>
<td>
<asp:Label ID="lblProjectCode" runat="Server" Text ="ProjectCode" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="ProjectCode" runat="Server" MaxLength="4" ToolTip ="Please select Project code" Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDWNumber" runat="Server" Text ="DWNumber" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="DWNumber" runat="Server" MaxLength="8" ToolTip ="Please select DWNumber" Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStageID" runat="Server" Text ="StageID" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="StageID" runat="Server" MaxLength="5" ToolTip ="Please select StageID ML5." Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblType" runat="Server" Text ="Type" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="Type" runat="Server" MaxLength="8" ToolTip ="Please enter Type " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStageName" runat="Server" Text ="StageName" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="StageName" runat="Server" MaxLength="240" ToolTip ="Please enter StageName" Width= "600px"  ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small" TextMode="Multiline" Height="75px"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStageStatus" runat="Server" Text ="StageStatus" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="StageStatus" runat="Server" MaxLength="2" ToolTip ="Please enter stage status" Width= "150px" Height="25px"  ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStatusDate" runat="Server" Text ="StatusDate" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>

     <telerik:RadDatePicker ID="Statusdate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick Status date"
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

<%--<asp:TextBox ID="StatusDate" runat="Server" MaxLength="" ToolTip ="Please pick status date ML." Width= "0px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >--%>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblTentativeDate" runat="Server" Text ="TentativeDate" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
    <telerik:RadDatePicker ID="Tentativedate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick Status date"
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                            </DateInput>
                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle BackColor="Pink" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>



<%--<asp:TextBox ID="TentativeDate" runat="Server" MaxLength="" ToolTip ="Pick Tentative date ML." Width= "0px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >--%>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentPcnt" runat="Server" Text ="PaymentPercent" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="PaymentPcnt" runat="Server" MaxLength="5" ToolTip ="Please enter Payment percent " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentAmt" runat="Server" Text ="PaymentAmt" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="PaymentAmt" runat="Server" MaxLength="10" ToolTip ="Please enter payment amount " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblAmtPayable" runat="Server" Text ="Amount Payable" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="AmtPayable" runat="Server" MaxLength="10" ToolTip ="Please enter amount payable " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblRemarks" runat="Server" Text ="Remarks" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="Remarks" runat="Server" MaxLength="10" ToolTip ="Please enter Remarks " Width= "400px" Height="50px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStageType" runat="Server" Text ="StageType" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="StageType" runat="Server" MaxLength="8" ToolTip ="Please enter stage type " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPreviousStageID" runat="Server" Text ="PreviousStageID" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="PreviousStageID" runat="Server" MaxLength="5" ToolTip ="please enter previous stageID " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblInformFlag" runat="Server" Text ="InformFlag" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="InformFlag" runat="Server" MaxLength="12" ToolTip ="Please enter inform flag " Width= "200px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblFINTXNLink" runat="Server" Text ="FINTXNLink" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="FINTXNLink" runat="Server" MaxLength="0" ToolTip ="Please enter FINTXNLink " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblMFMSLink" runat="Server" Text ="MFMSLink" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="MFMSLink" runat="Server" MaxLength="0" ToolTip ="Please enter MFMSLink" Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDTxnNo" runat="Server" Text ="DTxnNo" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="DTxnNo" runat="Server" MaxLength="10" ToolTip ="Please enter DTxnNo " Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDTxnAmount" runat="Server" Text ="DTxnAmount" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="DTxnAmount" runat="Server" MaxLength="10" ToolTip ="Please enter DTxnAmount" Width= "250px" Height="25px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDTxnDate" runat="Server" Text ="DTxnDate" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
     <telerik:RadDatePicker ID="DTxnDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick Transaction date"
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                            </DateInput>
                            <Calendar ID="Calendar3" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle BackColor="Pink" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>




<%--<asp:TextBox ID="DTxnDate" runat="Server" MaxLength="" ToolTip ="Pick transaction date ML." Width= "0px" ForeColor=" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >--%>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDebitTxnID" runat="Server" Text ="DebitTxnID" ForeColor=" Black " Font-Names ="Verdana" Font-Size ="Small "></asp:Label>
</td>
<td>
<asp:TextBox ID="DebitTxnID" runat="Server" MaxLength="10" ToolTip ="please enter debit transaction ID " Width= "250px" Height="25px"  ForeColor =" DarkBlue" Font-Names ="Verdana" Font-Size ="Small"   ></asp:TextBox >
</td>
</tr>
</table>

<%-- ISRAPID CODE END FOR ADD into:tblStatements --%>
<%-- GridView Start --%>
<table>
<tr>
<td>
<telerik:RadGrid ID="StatementgrdView" runat="server" AllowPaging="True" PageSize="20"
                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"
                     OnPageIndexChanged="StatementView_PageIndexChanged"
                    OnPageSizeChanged="StatementView_PageSizeChanged" OnSortCommand="StatementView_SortCommand"
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
<table>
<tr>
<td>
<asp:Button ID="btnSave" runat="Server" width="100px" Text="Save" ToolTip ="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names =" Verdana" Font-Size ="Small"/>
</td>
<%-- End of Button Save --%>
<%-- Button Clear --%>
<td>
<asp:Button ID="btnClear" runat="Server" width="100px" Text="Clear" ToolTip =" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names ="Verdana" Font-Size ="Small"/>
</td>
<%-- End of Button Clear --%>
<%-- Button Exit --%>
<td>
<asp:Button ID="btnExit" runat="Server" width="100px" Text="Exit" ToolTip ="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names ="Verdana" Font-Size ="Small"/>
</td>
</tr>
</table>
<%-- End of Button Exit --%>












            </div>
     </div>
    </asp:Content>