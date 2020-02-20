<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DinnersBooking.aspx.cs" Inherits="DinnersBooking" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<%--    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script--%>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode


            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function SaveValidate() {

            var result = confirm('Do you want to Update?');

            if (result) {

                return true;
            }
            else {

                return false;
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

        .centerdiv {
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

            .centerdiv img {
                height: 128px;
                width: 128px;
            }
    </style>
    <style>
        .rightAlign { text-align:right; }
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
       <script type="text/javascript">
           function PopUp() {
               $(function () {                  
                   $("#dialog").dialog({
                       title:'Alert!',
                       buttons: {
                           Continue: function () {
                               $("[id*=Button1]").click();
                               $(this).dialog('close');                              
                           },
                           Close: function () {
                               $(this).dialog('close');
                           }
                       }
                   });
               });
           };

           function PopUp2() {
               $(function () {
                   $("#dialog1").dialog({
                       title: 'Alert!',
                       buttons: {
                           Yes: function () {
                               $("[id*=Button1]").click();
                               $(this).dialog('close');
                           },
                           No: function () {                              
                               $(this).dialog('close');
                               return false;
                           }
                       }
                   });
               });
           };
           function PopUp3() {
               $(function () {
                   $("#dialog2").dialog({
                       title: 'Alert!',
                       buttons: {
                           Yes: function () {
                               $(this).dialog('close');
                           },
                           No: function () {
                               $(this).dialog('close');
                               return false;
                           }
                       }
                   });
               });
           };
    </script>
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
    <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
             <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlUpdate">
                        <ProgressTemplate>
                            <div class="Loadingdiv">
                                <div class="centerdiv">
                                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                                    <img alt="Loading...." src="Images/Loader.gif" />
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
            <div class="main_cnt">
                <div class="first_cnt">
                    <div id="dialog" style="display: none">
                       No booking exists for the date and session.                       
                    </div>
                     <div id="dialog1" style="display: none;">
                       You are attempting to enter bookings for a past session. Are you sure?                       
                    </div>
                     <div id="dialog2" style="display: none;">
                       You are attempting to enter bookings for a past session. Are you sure?                       
                    </div>
                    <asp:Button ID="Button1" runat="server" Text="Button" Style="display: none" OnClick="Button1_Click1" />
                   <table style="width: 100%">
                        <tr>
                            <td align="center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                    <table align="Center" style="width: 90%">

                        <tr>
                            <td>&nbsp; &nbsp;
                                <asp:Label ID="lbldate" runat="server" Text="Select Date :" Font-Bold="true"></asp:Label>
                                <telerik:RadDatePicker ID="dtDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                    Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" AutoPostBack="true" ToolTip="Select date in future to enter the booking.Select date in the past to enter the Actual counts.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                        ForeColor="Black" ReadOnly="true">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                &nbsp; &nbsp; &nbsp; &nbsp;
                         
                                <asp:Label ID="lblSession" runat="server" Text="Select Session :" Font-Bold="true"></asp:Label>
                                <asp:CheckBox ID="chkAll" AutoPostBack="true" runat="server" Text="All" OnCheckedChanged="chkAll_CheckedChanged" ToolTip="By default main session's are show,Click to book for any session." />
                                &nbsp; &nbsp;
                                <asp:DropDownList ID="drpSession" runat="server" CssClass="form-controlForResidentAdd"  ToolTip="Make sure you are selecting the right session which is yet to happen." AutoPostBack="true" OnSelectedIndexChanged="drpSession_SelectedIndexChanged"></asp:DropDownList>
                                
                                  &nbsp; &nbsp;
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" BorderColor="#3333ff" BackColor="#3333ff" OnClick="btnSearch_Click" ToolTip="To search particular date and session for booking and actual counts." />
                                 &nbsp; &nbsp;              
                                <asp:Button ID="btnExShRpt" CssClass="btn btn-success" Font-Bold="true" runat="server" Text="Excess / Shortage Rpt." BackColor="#ff6600" BorderColor="#ff6600"  ForeColor="white" Font-Size="Medium" ToolTip="Click to check Excess / Shortage Report." OnClick="btnExShRpt_Click"  />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                 <asp:Label ID="lbltiming" runat="server" Text="Session Timing :" Font-Bold="true" Visible="false"></asp:Label>
                                &nbsp; &nbsp;
                                  <asp:Label ID="lblTime" runat="server" Text="" Font-Bold="true" ForeColor="Maroon" Visible="false"></asp:Label>
                              
                                <asp:Label ID="lblhexcode" runat="server" Text="" Font-Bold="true" ForeColor="GrayText" Visible="false"></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="5">
                                <telerik:RadGrid ID="rgDinBkng" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"  Height="80px"
                                     Width="98%"
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

                                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="100px" DataField="Session" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="Regular" HeaderText="Regular" UniqueName="Regular" HeaderStyle-Width="80px"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of regular resident diners.Billing Rates or tariff may differ for regular and casual diners.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRegular" CssClass="rightAlign" runat="server" Width="50px"  Text='<%# Eval("Regular") %>' onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Casual" HeaderStyle-Width="80px" HeaderText="Casual" UniqueName="Casual"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of casual resident diners.Billing Rates or tariff may differ for regular and casual diners.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtCasual" runat="server" Width="50px"  CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("Casual") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                             <telerik:GridTemplateColumn DataField="Guests" HeaderStyle-Width="80px" HeaderText="Res.Guests" UniqueName="Guests"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of guest dinres for resident.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtGuests" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("Guests") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="HS" HeaderStyle-Width="80px" HeaderText="HomeDly." UniqueName="H.S"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of home dly. services.Refer diners Notes for additional information if any.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtHS" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("HS") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                           

                                            <telerik:GridTemplateColumn DataField="GH" HeaderStyle-Width="80px" HeaderText="G.House" UniqueName="GH"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of Guest diners in Guest House.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtGH" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("GH") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Staff" HeaderStyle-Width="80px" HeaderText="Staff" UniqueName="Staff"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="No. of staff who are dining.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtStaff" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("Staff") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Total" HeaderStyle-Width="80px" HeaderText="Total" UniqueName="Total"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Total diners for given date and session.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTotal" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);"  Text='<%# Eval("Total") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Actual" HeaderStyle-Width="80px" HeaderText="Actual" UniqueName="Actual"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Actual count of persons who dined on the particular date and session, This is entered after the session is over.This will help in excess / shortage montering.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtActual" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("Actual") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="RSN" HeaderStyle-Width="80px" HeaderText="RSN" UniqueName="RSN"
                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Display="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtRSN" runat="server" Width="50px" CssClass="rightAlign" onkeypress="return isNumberKey(event);" Text='<%# Eval("RSN") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <%-- <telerik:GridBoundColumn HeaderText="Regular" HeaderStyle-Width="80px" DataField="Regular" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Casual" HeaderStyle-Width="80px" DataField="Casual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="H.S" HeaderStyle-Width="80px" DataField="HS" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Guests" HeaderStyle-Width="80px" DataField="Guests" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="GH" HeaderStyle-Width="80px" DataField="GH" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Staff" HeaderStyle-Width="80px" DataField="Staff" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="80px" DataField="Total" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Actual" HeaderStyle-Width="80px" DataField="Actual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>--%>
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
                            <td style="vertical-align: top">
                                <asp:Button ID="btnSave" runat="server" Text="Update" ToolTip="Enter count and press update button." CssClass="btn btn-success" ForeColor="White" Font-Names="Verdana" Font-Size="Small" Width="90px" OnClick="btnSave_Click" OnClientClick="javascript:return SaveValidate()" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td style="width:65px;"></td>
                            <td>
                                <table align="left" style="width: 90%">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lblprevbkng" Text="Previous Bookings" Font-Bold="true" Font-Names="verdana" Visible="false" > </asp:Label>
                                          
                                        </td>
                                    </tr>
                        <tr>
                            <td align="left" colspan="5">
                                <telerik:RadGrid ID="rdPrevBkng" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowHeader="false"  Height="80px"
                                     Width="96%"
                                    MasterTableView-HierarchyDefaultExpanded="true" Visible="false">
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

                                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="100px" DataField="Session" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn HeaderText="Regular" HeaderStyle-Width="80px" DataField="Regular" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Casual" HeaderStyle-Width="80px" DataField="Casual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="HomeDly." HeaderStyle-Width="80px" DataField="HS" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Res.Guests" HeaderStyle-Width="80px" DataField="Guests" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="G.House" HeaderStyle-Width="80px" DataField="GH" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Staff" HeaderStyle-Width="80px" DataField="Staff" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="80px" DataField="Total" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Actual" HeaderStyle-Width="80px" DataField="Actual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
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
                            <td style="vertical-align: top">
                                <asp:Button ID="Button3" runat="server" Visible="false" Text="Update" ToolTip="Enter count and press update button." CssClass="btn btn-success" ForeColor="White" Font-Names="Verdana" Font-Size="Small" Width="90px" OnClick="btnSave_Click" OnClientClick="javascript:return SaveValidate()" />
                            </td>
                        </tr>
                    </table>
                            </td>
                            
                        </tr>
                    </table>
                    
                   
                    <table style="width: 95%" align="center">
                         <tr>
                             <td align="Left"> <asp:Label ID="Label1" runat="server" Text="Special Diners Notes" Font-Bold="true" ForeColor="DarkBlue" Font-Size="Medium"></asp:Label></td>
                            
                         </tr>
                        <tr>
                            
                            <td align="center" colspan="5">
                                                <telerik:RadGrid ID="rgDinNts" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" Height="200px"
                                    CellSpacing="5" Width="100%"
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
                                            <telerik:GridBoundColumn HeaderText="Notes" HeaderStyle-Width="80px" DataField="DNDesc" ReadOnly="true" AllowFiltering="true" HeaderTooltip="From the standard list , Maintains Separately."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="120px" DataField="DNNOTES" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Any Additional information."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="For" HeaderStyle-Width="30px" DataField="ForWhom" ReadOnly="true" AllowFiltering="true" HeaderTooltip="For whom is notes applicable."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="90px" DataField="DN_Name" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Name of the diners."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="60px" DataField="Rtvillano" ReadOnly="true" AllowFiltering="true" HeaderTooltip="House of the resident diners."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Rqstd. Date" HeaderStyle-Width="60px" DataField="ReqDate" ReadOnly="true" AllowFiltering="true" HeaderTooltip="When entered." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
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
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="chkAll" EventName="CheckedChanged" />
            <asp:AsyncPostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:PostBackTrigger ControlID="btnExShRpt" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

