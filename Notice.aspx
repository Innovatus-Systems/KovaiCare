<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Notice.aspx.cs" Inherits="Notice" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>

    <link href="Scripts/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/jquery.validate.js"></script>
    <script src="Scripts/moment.js"></script>

    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

    <script type="text/javascript">
        function pageLoad(sender, args) {
            Telerik.Web.UI.Calendar.Popup.zIndex = 100000;
        }

        function open() {
            var window = $find('<%= RadWindow1.ClientID %>');
            window.show();
        }
    </script>

  

    <script type="text/javascript">
        $(document).ready(function () {
        });
        $(function () {
            $("#<%= FromDate.ClientID %>").change(function () {
                //alert('test');
            });
        });
        function calendarShown(sender, args) {
            sender._popupBehavior._element.style.zIndex = 99999999;
        }

        function onRequestStart(sender, args) {
            if (args.get_eventTarget().indexOf("BtnnExcelExport") >= 0)
                args.set_enableAjax(false);
        }
        function Clear() {
            $("[id*='txtFromDate']").val('');
            $("[id*='txtTodate']").val('');
            $("[id*='txtEventName']").val('');
            $("[id*='txtdesc']").val('');
        }
        function AddEvent() {
            var ctrl = $("#<%= FromDate.ClientID %>");
            //alert(ctrl.val());
            //var start = $("[id*='txtFromDate']").val();
            //var till = $("[id*='txtTodate']").val();
            var start = $("#<%= FromDate.ClientID %>").val();
            var till = $("#<%= FromDate.ClientID %>").val();
            var event = $("[id*='txtEventName']").val();
            var desc = $("[id*='txtdesc']").val();
            var etype = $("[id*='ddlEventtype']").val();
            var smail = $('#<%= chkIsSentMail.ClientID %>').is(':checked');
            //start == '' || till == '' ||
            if (event == '' || desc == '') {
                alert('Enter all the fields');
                return false;
            } else {
                if (start > till) {
                    alert('Please check From and Till date');
                    return false;
                }
                var x = confirm('Do you want to add this Notice?  Have you chosen option to inform all via email?');
                if (x) {
                    $.ajax({
                        url: "Notice.aspx/AddEvents",
                        type: "POST",
                        data: "{'From':'" + start + "','Till':'" + till + "','Event':'" + event + "','Desc':'" + desc + "','Etype':'" + etype + "','smail':'" + smail + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var res = data.d;
                            //alert(res);
                            if (res == "true") {

                                alert('Notice added');

                                //Clear();

                            } else {
                                alert('Notice failed');
                            }
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                } else {
                    return false;
                }
            }
        }
        function UpdateClear() {
            $("[id*='txtupremarks']").val('');
            $("[id*='lblevedesc']").val('');
        }
        function UpdateEvent() {
            var desc = $("[id*='ddlupstatus']").val();
            //alert(desc);
            var remark = $("[id*='txtupremarks']").val();
            var Events = $("[id*='lblevent']").text();
            var from = $("#<%=lblfromdate.ClientID %>").val();
            var to = $("#<%=lblfromdate.ClientID %>").val();
            var uevents = $("[id*='lblevent']").val();
            var ueventdesc = $("[id*='lblevedesc']").val();
            //alert(Events);
            var salert;
            var RSN = $("[id*='hbtnRSN']").val();
            if (desc == '' || Events == '' || uevents == '' || ueventdesc == '') {
                alert('Please enter all the fields');
                return false;
            } else {
                if (desc == '20' || desc == '00') {
                    salert = 'Do you want to Update?';
                } else {
                    salert = 'Do you want to Cancel the notice?';
                }
                //alert(salert);
                var x = confirm(salert);
                if (x) {
                    $.ajax({
                        url: "Notice.aspx/UpdateEvents",
                        type: "POST",
                        data: "{'status':'" + desc + "','RSN':'" + RSN + "','remarks':'" + remark + "','Events':'" + Events + "','from':'" + from + "','to':'" + to + "','events':'" + uevents + "','eventsdesc':'" + ueventdesc + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var res = data.d;
                            //alert(res);
                            if (res == "true") {
                                alert('Notice details updated successfully');
                                UpdateClear();
                                Refresh();
                            } else {
                                alert('Notice failed to update');
                            }
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                } else {
                    return false;
                }
            }
        }
        function Refresh() {
            //alert('test');
            $("[id*='btnRefresh']").click();
            //window.location = "Events.aspx";
        }
        function OnDateSelected(sender, eventArgs) {
            var date1 = sender.get_selectedDate();
            //alert(date1);
            var datepicker = $find("<%= RadDatePicker1.ClientID %>");
            datepicker.set_selectedDate(date1);
        }

    </script>
    <style type="text/css">
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }

        .hide {
            display: none;
        }
    </style>

    <style type="text/css">
        .RadCalendarPopup {
            z-index: 99999999 !important;
        }

        .RadCalendarFastNavPopup {
            z-index: 11000 !important;
        }

        .selectbox {
            width: 10%;
            height: 27px;
            background-color: #FFF;
            font: 400 12px/18px 'Open Sans', sans-serif;
            color: #000;
            font-weight: normal;
            border: 1px solid #ccc;
            margin: 5px 0 0 0;
            padding: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">

           
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <div style="width: 100%; min-height: 500px; max-height: 900px;">

                        <%--<text style="color: gray; font-family: Verdana; font-size: small;">By Default Showing OnComing Events</text>--%>
                         <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" runat="server">
                </telerik:RadWindow>
            </Windows>
</telerik:RadWindowManager>

                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="center">
                                                <%--<asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Font-Underline="false"></asp:LinkButton>--%>
                                                <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="left">

                                                <%-- <asp: ID="btnRefresh" CssClass="btn-success" runat="server" Font-Bold="true" OnClick="btnRefresh_Click" Text="Refresh" Visible="false" />--%>
                                                <%-- </td>
                                            <td align="left">--%>
                                                <%-- <asp:Label ID="Label1" runat="server" Text="Type :"></asp:Label>
                                                <asp:DropDownList ID="ddlType" runat="server" ToolTip="" CssClass="selectbox" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true" Width="150px">
                                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Event" Value="E"></asp:ListItem>
                                                    <asp:ListItem Text="Notice" Value="I"></asp:ListItem>
                                                    <asp:ListItem Text="Calendar" Value="C"></asp:ListItem>
                                                </asp:DropDownList>--%>
                                                <asp:Button ID="btnAdd" runat="server" CssClass="btn-success" Font-Bold="true" Text="ADD" OnClick="lbtnAdd_Click" ForeColor="White" ToolTip="Click here to add a new Event / Notice / Calendar" Visible="false" />


                                            </td>
                                            <td align="right">
                                                <asp:Button ID="btnBack" runat="server" CssClass="btn-success" Font-Bold="true" Text="Back" OnClick="btnBack_Click" ForeColor="White" ToolTip="" />
                                                <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                                                <asp:Label ID="LSpace" runat="server" Width="100px"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 100%; vertical-align: middle;" align="left">
                                                <telerik:RadGrid ID="radgvEvents" OnItemDataBound="radgvEvents_ItemDataBound" FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="1100px" Height="400px" Font-Names="Verdana" AllowFilteringByColumn="true" runat="server" Skin="Sunset" OnItemCommand="radgvEvents_ItemCommand" MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true">
                                                    <ClientSettings>
                                                        <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                        <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                    </ClientSettings>
                                                    <MasterTableView>

                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnradupdate" ToolTip="Click here to edit the notice." ForeColor="Blue" Text="Edit" runat="server" CommandName="UpdateRow" CommandArgument='<%# Eval("RSN") %>' Visible='<%# Eval("Status").ToString() == "Scheduled" %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn Visible="false" HeaderText="Notice" DataField="EventType" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="70px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="FrmDate" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="End Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="TillDate" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Title/Subject" DataField="EventName" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="200px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Left" DataField="Description" HeaderStyle-Width="275px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Status" ItemStyle-HorizontalAlign="Left" DataField="Status" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Type" ItemStyle-HorizontalAlign="Left" DataField="EventType" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                                           <%-- <telerik:GridImageColumn ImageUrl='<%# Eval("Image") %>' AlternateText ="Notice image" DataAlternateTextField="Image" ImageAlign="Middle"  ImageHeight="50px" ImageWidth="90px"
                                                               HeaderText  ="Image" />--%>

                                                             <telerik:GridTemplateColumn UniqueName="Image" HeaderText="Image" AllowFiltering="false" ItemStyle-Width="150px" HeaderStyle-Width="150px">
                                                             <ItemTemplate><asp:HyperLink ID="ActionLink" alt="img"  runat="server"><img src='<%# Eval("Image") %>'  class="images" alt="img" width="90px" height="50px"></asp:HyperLink>
                                                                </ItemTemplate>
                                                              </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn HeaderText="Remarks" Visible="true" ItemStyle-HorizontalAlign="Left" DataField="Remarks" HeaderStyle-Width="100px" Display="false"></telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtnAdd" Width="120px" Visible="false" OnClick="lbtnAdd_Click" ToolTip="Click here to Add New notice." runat="server" Text="Add Notice"></asp:LinkButton>

                                                <asp:LinkButton ID="lbtnoncmng" Visible="false" Width="120px" runat="server" ToolTip="Click here to view Oncoming notice." Text="OnComing Notice" OnClick="lbtnoncmng_Click"></asp:LinkButton>

                                                <asp:LinkButton ID="lbtnAll" Visible="false" Width="120px" runat="server" ToolTip="Click here to view all notice." Text="All Notice" OnClick="lbtnAll_Click"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--Popup--%>
                    <div id="dvpopups" runat="server">
                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />

                        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
                            BackgroundCssClass="modalBackground">
                        </asp:ModalPopupExtender>

                        <asp:Panel ID="pnlpopup" runat="server" BackColor="#FFF9F0" Height="520px" Width="750px" Style="display: none">
                            <asp:UpdatePanel ID="upnlaview" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="border: Solid 4px lightblue; width: 750px; height: 520px; font-family: Verdana; font-size: small;">
                                        <tr>
                                            <td valign="top">
                                                <table style="width: 100%">
                                                    <tr style="background-color: #336699; height: 5%; width: 100%;">
                                                        <td style="color: White; font-weight: normal; font-family: Verdana; font-size: small" align="left">Update Notice</td>
                                                    </tr>
                                                    <tr style="height: 40px"></tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td align="left">
                                                            <text style="font-weight: bold;"> Date</text>
                                                        </td>
                                                        <td>
                                                            <%--<asp:Label ID="lblfromdate" runat="server"></asp:Label>--%>
                                                            <telerik:RadDatePicker ID="lblfromdate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Notice date."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                <DateInput ID="DateInput3" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                </DateInput>
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
                                                        <td align="left">
                                                            <%--<text style="font-weight: bold;"> Till Date</text>--%>
                                                        </td>
                                                        <td>
                                                            <%-- <asp:Label ID="lbltodate" runat="server"></asp:Label>--%>
                                                            <telerik:RadDatePicker ID="lbltodate" SkipMinMaxDateValidationOnServer="true" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select an end date if applicable."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" Visible="false">
                                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                <DateInput ID="DateInput4" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                </DateInput>
                                                                <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
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
                                                        <td align="left">
                                                            <text style="font-weight: bold;"> Title/Subject</text>
                                                        </td>
                                                        <td>
                                                            <%--<asp:Label ID="lblevent" runat="server"></asp:Label>--%>
                                                            <asp:TextBox ID="lblevent" runat="server" Enabled="true" ToolTip="Choose a title/subject for the notice." MaxLength="80" TextMode="MultiLine" Width="380px" Height="25px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <text style="font-weight: bold;"> Description</text>
                                                        </td>
                                                        <td>
                                                            <%-- <asp:Label ID="lblevedesc" runat="server"></asp:Label>--%>
                                                            <asp:TextBox ID="lblevedesc" runat="server" ToolTip="Give a brief description of the notice." MaxLength="2400" TextMode="MultiLine" Width="380px" Height="70px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <text style="font-weight: bold;"> Completion Remarks</text>
                                                            <text style="color: red;">*</text>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtupremarks" runat="server" ToolTip="Enter any completion remarks." TextMode="MultiLine" Height="60px" Width="380px" MaxLength="480"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <text style="font-weight: bold;"> Status</text>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlupstatus" runat="server" ToolTip="Select the status of notice." Width="150px">
                                                                <asp:ListItem Text="Scheduled" Value="00">                  
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="Conducted" Value="20">                  
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>
                                                            <asp:CheckBox ID="chkUISSentEmail" runat="server" Text="Inform all residents via email." Font-Names="verdana" ToolTip="When you click here, all the residents with valid Email IDs will be informed about the Notice via Email." /><br />
                                                            <asp:ImageButton ID="imgUwhatapp" ImageUrl="~/Images/wapp2.png" Width="20px" Height="20px" runat="server" OnClick="imgUwhatapp_Click" />
                                                            <asp:LinkButton ID="lnkuwhatsapp" runat="server" Text="Inform all residents via WhatsApp" Font-Names="verdana" Font-Bold="true" OnClick="lnkuwhatsapp_Click" ToolTip="When you click here,  you will be redirected to the Web.Whatsapp.com page.
                                                            Choose the contact name from the list that will appear,  and Paste the contents (Either by pressing CtrlV or by right-click ,Paste).
                                                            Make sure you have already connected your Smart Phone (with Whatsapp installed) with the Web.Whatsapp.com portal."></asp:LinkButton>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:HiddenField ID="hbtnRSN" runat="server" Value="" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnUpdate" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" runat="server" Text="Update" Width="110px" OnClientClick="return UpdateEvent();" OnClick="btnUpdateClear_Click" ToolTip="Click here to update the details of the notice." />
                                                            <asp:Button ID="btnCancel" ForeColor="White" BackColor="DarkOrange" OnClick="btnCancel_Click" Font-Bold="true" runat="server" Text="Return" Width="110px" ToolTip="Click here to go back to the notice listing page." />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnCancel" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:Panel>

                        <asp:Panel ID="pnlAdd" runat="server" BackColor="#FFF9F0" Height="430px" Width="700px" Style="display: none">
                            <asp:UpdatePanel ID="upnlaadd" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="border: Solid 4px lightbrown; width: 700px; height: 430px; font-family: Verdana; font-size: small;">
                                        <tr>
                                            <td valign="top">
                                                <table style="width: 100%">
                                                    <tr style="background-color: #336699; height: 5%; width: 100%;">
                                                        <td style="color: White; font-weight: normal; font-family: Verdana; font-size: small" align="left">Add a New Notice</td>
                                                        <%-- / Notice / Calendar--%>
                                                    </tr>
                                                    <tr style="height: 40px"></tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;">Type</text>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEventtype" runat="server" ToolTip="Notice - A not-so-happy occassion,a notification to be conveyed." Width="120px" Enabled="false">
                                                                <%--.Notice - A not-so-happy occassion,a notification to be conveyed.Calendar - General information.--%>
                                                                <%--<asp:ListItem Text="Event" Value="E"> </asp:ListItem>--%>
                                                                <asp:ListItem Text="Notice" Value="I"></asp:ListItem>
                                                               <%-- <asp:ListItem Text="Calendar" Value="C"></asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;"> Date</text>
                                                            <%--<text style="color: red;">*</text>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtFromDate" runat="server" Width="200px" Height="18px" CssClass="hide"></asp:TextBox>
                                                            <%--<asp:CalendarExtender ID="CalendarExtender1" OnClientShown="calendarShown()" TargetControlID="txtFromDate" PopupPosition="Right" runat="server"></asp:CalendarExtender>--%>
                                                            <telerik:RadDatePicker ID="FromDate" runat="server" ClientEvents-OnDateSelected="OnDateSelected" AutoPostBack="true" Font-Names="Verdana" OnSelectedDateChanged="FromDate_SelectedDateChanged" Font-Size="Small" ToolTip="Notice date."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                </DateInput>
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
                                                    <tr>
                                                        <td>
                                                            <%--<text style="font-weight: bold;"> Till Date</text>--%>
                                                            <%--<text style="color: red;">*</text>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTodate" runat="server" Width="200px" Height="18px" CssClass="hide"></asp:TextBox>
                                                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select an end date if applicable."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" Visible="false">
                                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
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
                                                            <text style="font-weight: bold;"> Title/Subject</text>
                                                            <text style="color: red;">*</text>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEventName" runat="server" ToolTip="Choose a title/subject for the notice.This forms the subject line for the email communication to the residents." MaxLength="80" Width="380px" Height="25px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;"> Description</text>
                                                            <text style="color: red;">*</text>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtdesc" runat="server" ToolTip="Give a brief description of the notice.Whatever written here is emailed to all residents." MaxLength="2400" TextMode="MultiLine" Width="380px" Height="70px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>
                                                            <asp:CheckBox ID="chkIsSentMail" runat="server" Text="Inform all residents via email." Font-Names="verdana" ToolTip="When you click here, all the residents with valid Email IDs will be informed about the Notice via Email." /><br />
                                                            <asp:ImageButton ID="imgwapp" ImageUrl="~/Images/wapp2.png" Width="20px" Height="20px" runat="server" OnClick="imgwapp_Click" />
                                                            <asp:LinkButton ID="lnkwhatsapp" runat="server" Text="Inform all residents via WhatsApp" Font-Names="verdana" Font-Bold="true" OnClick="lnkwhatsapp_Click" ToolTip="When you click here,  you will be redirected to the Web.Whatsapp.com page.
                                                            Choose the contact name from the list that will appear,  and Paste the contents (Either by pressing CtrlV or by right-click ,Paste).
                                                            Make sure you have already connected your Smart Phone (with Whatsapp installed) with the Web.Whatsapp.com portal."></asp:LinkButton>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td style="font-family: Verdana; font-size: small; font-weight: bold;">
                                                            <asp:Button ID="btnAddEvent" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click here to add a new notice.This will be conveyed to all resident via EMail." runat="server" Text="Add" Width="100px" OnClientClick="return AddEvent();" OnClick="btnAddClear_Click" />
                                                            <asp:Button ID="btnAddClear" ForeColor="White" BackColor="DarkOrange" Font-Bold="true" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" Width="100px" OnClick="btnAddClear_Click" />
                                                            <%--OnClientClick="Clear();"--%>
                                                            <asp:Button ID="btnAddCancel" ForeColor="White" BackColor="DarkBlue" OnClick="btnAddCancel_Click" Font-Bold="true" runat="server" Text="Return" Width="100px" ToolTip="Click here to go back to the notice listing page." />

                                                            <%-- OnClientClick="Refresh();" --%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>

                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnAddCancel" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:Panel>

                        <asp:Button ID="Button1" runat="server" Style="display: none" />
                        <%--  <asp:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="Button1" PopupControlID="pnlAdd"
                            CancelControlID="btnAddCancel" BackgroundCssClass="modalBackground" DropShadow="true">
                        </asp:ModalPopupExtender>--%>

                        <asp:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="Button1" PopupControlID="pnlAdd"
                            BackgroundCssClass="modalBackground">
                        </asp:ModalPopupExtender>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <%-- <asp:PostBackTrigger ControlID="btnRefresh" />--%>
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                    <asp:PostBackTrigger ControlID="FromDate" />
                    <asp:PostBackTrigger ControlID="imgwapp" />
                    <asp:PostBackTrigger ControlID="lnkwhatsapp" />
                    <asp:PostBackTrigger ControlID="imgUwhatapp" />
                    <asp:PostBackTrigger ControlID="lnkuwhatsapp" />
                    <asp:PostBackTrigger ControlID="btnAddCancel" />
                    <asp:PostBackTrigger ControlID="radgvEvents" />
                    <%--<asp:AsyncPostBackTrigger ControlID="ddlType" />--%>

                    <%--  <asp:AsyncPostBackTrigger ControlID="gvEvents" EventName="PageIndexChanging"  />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

