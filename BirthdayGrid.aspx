<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="BirthdayGrid.aspx.cs" Inherits="BirthdayGrid" %>

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

            var result = confirm('Confirm whether to send the greetings?');

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
    <%--<div id="content">--%>
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

    <div>
        <div class="main_cnt">
            <div class="first_cnt">
                <div style="width: 92%; min-height: 400px">

                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnreturnfromlevelX" runat="server" Text="Return" CssClass="btn btn-info" Visible="true" 
                                                                            OnClick="btnreturnfromlevelX_Click"  ToolTip="Click here to return Care" />
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                            </td>
                        </tr>
                        </table>
 
                    <table style="width:100%">
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwSpecialReport" Width="700" Height="280" VisibleOnPageLoad="false" runat="server"  Title="Profile++" Modal="true">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                  <telerik:RadGrid ID="rgSpecialReport" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="250px" Width="600px" AllowFilteringByColumn="false" AllowSorting="true" AllowPaging="false" PageSize="5"  Skin="Sunset">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="RARSN" HeaderText="RARSN" UniqueName="RARSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                     <telerik:GridBoundColumn DataField="RTRSN" HeaderText="RTRSN" UniqueName="RTRSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                     <telerik:GridBoundColumn DataField="Code" HeaderText="Code" UniqueName="Code"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                 
                                                                    <telerik:GridBoundColumn DataField="Details" HeaderText="Details" UniqueName="Details"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                       <telerik:GridBoundColumn DataField="ContactNo" HeaderText="ContactNo" UniqueName="ContactNo"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"  Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"  Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Emailid" HeaderText="Emailid" UniqueName="Emailid"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </telerik:RadWindow>
                            </td>
                        </tr>
                    </table>


                    <table>
                        <tr>
                            <td style="width:50px">
                                <asp:Label ID="LblBday" runat="Server" Text="From" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="FromBday" AutoPostBack="true" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Select a date from which you wish to view the list of people celebrating their Birthdays."
                                    Culture="English (United Kingdom)" Skin="Default"  EnableTyping="False" >
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput1" DateFormat="ddd dd-MMM-yyyy"  runat="server"  AutoPostBack="true" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                    </DateInput>
                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay  Repeatable="Today">
                                                <ItemStyle BackColor="bisque" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>


                            <td>
                                <asp:Label ID="lblTill" runat="Server" Text="Till" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="TillBday" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Select a date till which you wish to view the list of people celebrating their Birthdays"
                                    Culture="English (United Kingdom)" AutoPostBack="true"     Skin="Default" EnableTyping="False">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput2" DateFormat="ddd dd-MMM-yyyy" AutoPostBack="true" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                    </DateInput>
                                    <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="bisque" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                            <td style="width:20px">

                            </td>
                           <%-- <td>
                                 <asp:Button ID="Btnshow" runat="server" ToolTip="Click here to show the birthdays occuring between selected dates." CssClass="btn btn-primary" Text="Show" OnClick="Btnshow_Click" ></asp:Button>
                            </td>--%>
                        </tr>
                        </table>
                    <table>
                        <tr>
                            <td>

                                <telerik:RadGrid ID="BirthdaygrdView" runat="server" AllowPaging="True" PageSize="10"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"
                                    AllowFilteringByColumn="true"
                                    OnPageIndexChanged="BirthListView_PageIndexChanged"
                                    OnPageSizeChanged="BirthListView_PageSizeChanged" OnSortCommand="BirthListView_SortCommand"
                                    CellSpacing="20" Width="100%"
                                    MasterTableView-HierarchyDefaultExpanded="true" OnInit="BirthdaygrdView_Init">
                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                    </HeaderContextMenu>
                                    <GroupingSettings CaseSensitive="false" />
                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                       <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                </ClientSettings>
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
                                            <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="false" Visible="true"
                                                ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-ForeColor="LightGray" ItemStyle-Font-Size="XX-Small" ItemStyle-HorizontalAlign="left"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="100px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true" ItemStyle-Width="150px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                           
                                            <%-- <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>--%>


                                         <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" DataField="RTName" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                            HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="RTName">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction" CommandName='<%# Eval("RTRSN")%>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn HeaderText="Birthday" DataField="DOB" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Width="150px"
                                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false" ItemStyle-Width="150px"
                                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" Visible="true"
                                                ItemStyle-CssClass="Row1" HeaderStyle-HorizontalAlign="Center">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                                HeaderText="Mail ID" HeaderStyle-Font-Names="Calibri" UniqueName="MailID" SortExpression="MailID">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnContactMail" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                        Text='<%# Eval("Contactmail")%>' Font-Underline="true" Font-Bold="true"
                                                       
                                                        ForeColor="#7049BA" OnClick="lbtnContactMail_Click" ToolTip="Click here to compose greet mail.">
                                                    </asp:LinkButton>
                                                     <%-- OnClientClick="ConfirmMsg()"--%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                         
                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                                HeaderText="Remarks" HeaderStyle-Font-Names="Calibri" UniqueName="Remarks" SortExpression="Remarks">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnremarks" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                        Text='<%# Eval("Remarks")%>' Font-Underline="true" Font-Bold="true"
                                                        ForeColor="#7049BA" >
                                                    </asp:LinkButton>
                                                     <%-- OnClientClick="ConfirmMsg()"--%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

     

                                            <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px"
                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="SendGreetings" SortExpression="Send Greetings">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LnkSendgreetings" runat="server" Text="Send Greetings"  ForeColor="#7049BA" BackColor="White" Font-Bold="true" ToolTip="Click here to send birthday greetings." OnClick="LnkSendgreetings_Click" />
                                            <%--<asp:ImageButton ID="ImageBtnnView" Height="15px" ToolTip="Click here to View resident details" Width="25px" ImageUrl="~/App_Theme/view-icone.png" OnClick="ImageBtnnView_Click" runat="server" />--%>
                                            <%-- </ItemTemplate>
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
                                <asp:HiddenField ID="CnfResult" runat="server" />

                            </td>
                                
                        </tr>

                        <%-- <tr>
         <td align ="Right">


<asp:Button ID="btnSendMail" runat="Server" Width="150px" Text="Send Greetings" ToolTip="Clik here to send greetings for resident" ForeColor="white" BackColor="#7049BA" Font-Bold="true" Font-Names=" Calibri" Font-Size="Small" OnClick="btnSendmail_Click1" />

         </td>

     </tr>--%>
                    </table>
                    <table>
                        <tr>
                             <td>
                                                <telerik:RadWindow ID="RwBirthday" VisibleOnPageLoad="false" Width="400px" Height="350px" runat="server">
                                                    <%--OpenerElementID="<%# imgbtnAddWorkDetails.RSN  %>"--%>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="upBirthday" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <div>

                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="2" style="text-align: center;">
                                                                                <asp:Label ID="LblTitle" runat="Server" Text="" ForeColor="DarkOliveGreen" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                                                <br />
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblsub" runat="Server" Text="Subject:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtsub" runat="Server" MaxLength="2400" ToolTip="Enter the subject for your greet. " ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="225px" Height="50px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <asp:HiddenField ID="HDRTRSN" runat="server" />

                                                                        <%--<tr>
                                                                            <td>
                                                                                <asp:Label ID="lblcvalue" runat="Server" Text="Value:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtvalue" runat="Server" MaxLength="13" ToolTip="Does the entry have a value attached (Ex:  Expenses Incurred)? If so mention it here." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Width="310px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>--%>

                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblBody" runat="Server" Text="Message :" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtBody" runat="Server" MaxLength="2400" ToolTip="Write your message to wish the selected person." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="100px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>




                                                                        <tr>
                                                                            <td colspan="2" style="text-align: center">
                                                                                <asp:Button ID="btnMISave" runat="Server" Width="100px" Text="Send" OnClientClick="ConfirmMsg()" ToolTip="Press to send the greetings with your entered greet details." CssClass="btnAdminSave" OnClick="btnMISave_Click" />
                                                                 <%--               <asp:Button ID="btnMIUpdate" runat="Server" Width="100px" Text="Update" OnClientClick="StageConfirmMsg2()" ToolTip="Press to Update the Information to the Work Details grid for the customer." CssClass="btnAdminSave" OnClick="btnMIUpdate_Click" />--%>
                                                                                <asp:Button ID="btnMIClear" runat="Server" Width="100px" Text="Clear" ToolTip="Press Clear if you want to start all over again." CssClass="btnAdminClear" OnClick="btnMIClear_Click" />
                                                                                <asp:Button ID="btnMIExit" runat="Server" Width="100px" Text="Exit" ToolTip=" Press Exit to return to the Level X" CssClass="btnAdminExit" OnClick="btnMIExit_Click" />
                                                                            </td>
                                                                        </tr>

                                                                        <%--<tr>
                                                                            <td colspan="2" style="text-align: center">
                                                                                <asp:Label ID="Label43" runat="Server" Text="A diary entry can be automatic from the system (Ex: Milestones Update).  But here, you can also record a diary notes manually. A Manual entry is indicated as MNUL.You can only edit the Response field and only for a manual entry." ForeColor="Gray" Font-Names="Calibri" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                        </tr>--%>

                                                                        <tr>
                                                                            <td colspan="2"></td>
                                                                        </tr>
                                                                    </table>


                                                                </div>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:PostBackTrigger ControlID="btnMISave" />
                                                              <%--  <asp:PostBackTrigger ControlID="btnMIUpdate" />--%>
                                                                <asp:PostBackTrigger ControlID="btnMIClear" />
                                                                <asp:PostBackTrigger ControlID="btnMIExit" />

                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </telerik:RadWindow>
                                            </td>
                        </tr>
                    </table>
                </div>






            </div>
        </div>
    </div>

    <%--</div>--%>
    <%--<div style="margin-top: -6%;"></div>--%>
</asp:Content>

