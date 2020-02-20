<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewEvent.aspx.cs" MasterPageFile="~/CovaiSoft.master" Inherits="NewEvent" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%-- <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>--%>

   <%-- <script src="js/Maskdiv.js"></script>--%>

    <%-- <link href="Scripts/jquery-ui-1.8.16.custom.css" rel="stylesheet" />--%>

    <%-- <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/jquery.validate.js"></script>
    <script src="Scripts/moment.js"></script>--%>

    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
   
</style>
  <%--  <link href="StyleSheet.css" rel="stylesheet" />--%>

     <script type="text/javascript">
         function Show(GroupIndex) {
             alert(GroupIndex)
         }
         function NewWindow() {
             window.open("https://web.whatsapp.com/");
         }
         function chkvalue() {
             var starttime = $find("<%=dtpFromTime.ClientID %>").get_dateInput().get_value();
             <%--var endtime = $find("<%=dtptoTime.ClientID %>").get_dateInput().get_value();--%>
             if (starttime != null && starttime != "") {
                 var startDate = new Date("1/1/1900 " + starttime);
                 var endDate = new Date("1/1/1900 " + endtime);
                 //var difftime = endDate.getTime() - startDate.getTime();
                 //difftime /= 1000;
                 //var hrstomins = difftime / 60;
                 //var hours = parseFloat(difftime / 3600);
                 ////var mins = parseInt((difftime % 3600) / 60);
                 //var mins = parseFloat(hours * 60);


             }
             else {
                 //alert("No need to Check Any Conditions")
             }
         }
    </script>
    <script type="text/javascript">
        function LoadDiv(url) {
            var img = new Image();
            var bcgDiv = document.getElementById("divBackground");
            var imgDiv = document.getElementById("divImage");
            var imgFull = document.getElementById("imgFull");
            var imgLoader = document.getElementById("imgLoader");
            imgLoader.style.display = "block";
            img.onload = function () {
                imgFull.src = img.src;
                imgFull.style.display = "block";
                imgLoader.style.display = "none";
            };
            img.src = url;
            var width = document.body.clientWidth;
            if (document.body.clientHeight > document.body.scrollHeight) {
                bcgDiv.style.height = document.body.clientHeight + "px";
            }
            else {
                bcgDiv.style.height = document.body.scrollHeight + "px";
            }
            imgDiv.style.left = (width - 650) / 2 + "px";
            imgDiv.style.top = "20px";
            bcgDiv.style.width = "100%";

            bcgDiv.style.display = "block";
            imgDiv.style.display = "block";
            return false;
        }
        function HideDiv() {
            var bcgDiv = document.getElementById("divBackground");
            var imgDiv = document.getElementById("divImage");
            var imgFull = document.getElementById("imgFull");
            if (bcgDiv != null) {
                bcgDiv.style.display = "none";
                imgDiv.style.display = "none";
                imgFull.style.display = "none";
            }
        }
</script>


    <script type="text/javascript">


        function AddEvent() {
            var summ = "";
            summ += Title();
            summ += Desc();

            if (summ == "") {

                var result = confirm('Do you want to add this Event?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }



        function Title() {
            var Title = document.getElementById('<%= txtEventName.ClientID %>').value;
            if (Title == "") {
                return "Please enter the title/subject of the event." + "\n";
            } else {
                return "";
            }
        }

        function Desc() {
            var Desc = document.getElementById('<%= txtdesc.ClientID %>').value;
             if (Desc == "") {
                 return "Please enter the description of the event.";
             } else {
                 return "";
             }
         }



         function UpdateEvent() {
             var summ = "";
             summ += Title();
             summ += Desc();

             if (summ == "") {

                 var result = confirm('Do you want to Update?');

                 if (result) {

                     document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                     return true;
                 }
                 else {
                     document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                     return false;
                 }
             } else {
                 alert(summ);
                 return false;
             }
         }





         function UpdateEventRating() {
             var summ = "";
             //summ += Title();
             //summ += Desc();

             if (summ == "") {

                 var result = confirm('Do you want to update resident count for this event? ');

                 if (result) {

                     document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }

    </script>

    <style type="text/css">
body
{
    margin: 0;
    padding: 0;
    height: 100%;
}
.modal
{
    display: none;
    position: absolute;
    top: 0px;
    left: 0px;
    background-color: black;
    z-index: 100;
    opacity: 0.8;
    filter: alpha(opacity=60);
    -moz-opacity: 0.8;
    min-height: 100%;
}
#divImage
{
    display: none;
    z-index: 1000;
    position: fixed;
    top: 0;
    left: 0;
    background-color: White;
    height: 550px;
    width: 600px;
    padding: 3px;
    border: solid 1px black;
}
</style>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <asp:HiddenField ID="CnfResult" runat="server" />


                    <div id="divBackground" class="modal">
                    </div>
                    <div id="divImage">
                        <table style="height: 100%; width: 100%">
                            <tr>
                                <td valign="middle" align="center">
                                    <img id="imgLoader" alt="" src="images/loader.gif" />
                                    <img id="imgFull" alt="" src="" style="display: none; height: 500px; width: 590px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="bottom">
                                    <input id="btnClose" type="button" value="close" onclick="HideDiv()" />
                                </td>
                            </tr>
                        </table>
                    </div>

                    <table style="width: 100%">
                        <tr>
                            <td valign="top">
                                <table style="width: 100%;">
                                    <tr>
                                        <td align="center">
                                            <%--<asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Font-Underline="false"></asp:LinkButton>--%>
                                            <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadWindowManager ID="rwmEventRating" runat="server">
                                                <Windows>
                                                    <telerik:RadWindow ID="rwEventRating" Title="Event Confirmation" BackColor="Beige" runat="server" Modal="true" Height="500px" Width="500px">
                                                        <ContentTemplate>
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnUnload="UpdatePanel_Unload">
                                                                <ContentTemplate>
                                                                    <div>
                                                                        <table>
                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <asp:Label ID="Label4" runat="Server" Text="Name : " ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                    <asp:Label ID="lblEventName" runat="Server" Text="" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                    <asp:Label ID="Label5" runat="Server" Text="Date : " ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                    <asp:Label ID="lblEventDate" runat="Server" Text="" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                </td>
                                                                            </tr>

                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblRTSTATUS" runat="Server" Text="Resident Name" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                    <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlAssignedTo" ToolTip=" Select the name of the resident who attending or attended the selected event. " Width="200px"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAssignedTo_SelectedIndexChanged"
                                                                                        Font-Names="Verdana" Font-Size="Small" CssClass="form-control">
                                                                                    </asp:DropDownList>
                                                                                    <asp:Label ID="lblTotalResident" runat="server" Text="" ForeColor="Maroon" Font-Names="verdana" Font-Size="Medium"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <asp:Label ID="lblmsg" runat="Server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="Label2" runat="Server" Text="Attending" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlAttending" ToolTip="" Width="200px"  runat="server" Font-Names="Verdana" Font-Size="Small" CssClass="form-control">
                                                                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                                                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    <asp:Label ID="lblTotalAttending" runat="server" Text="" ForeColor="Maroon" Font-Names="verdana" Font-Size="Medium"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="Label3" runat="Server" Text="Attended" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlAttended" ToolTip="" Width="200px"  runat="server" Font-Names="Verdana" Font-Size="Small" CssClass="form-control">
                                                                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                                                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    <asp:Label ID="lblTotalAttended" runat="server" Text="" ForeColor="Maroon" Font-Names="verdana" Font-Size="Medium"></asp:Label>
                                                                                </td>
                                                                            </tr>


                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <asp:Button ID="btnEventRatingUpdate" ForeColor="White" BackColor="DarkGreen" Width="120px" ToolTip="Click here to update the resident count attending and attended in the event." OnClientClick="javascript:return UpdateEventRating();" OnClick="btnEventRatingUpdate_Click" runat="server" Text="Update" />
                                                                                    <asp:Button ID="btnEventRatingClose" ForeColor="White" BackColor="DarkBlue" OnClick="btnEventRatingClose_Click" Font-Bold="true" runat="server" Text="Close" Width="100px" ToolTip="Click here to close event confirmation" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <telerik:RadGrid ID="rgresidents" FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="400px" Height="200px" Font-Names="Verdana" AllowFilteringByColumn="false" runat="server" Skin="Web20" MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true">
                                                                                        <ClientSettings>
                                                                                            <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                                                        </ClientSettings>
                                                                                        <MasterTableView>

                                                                                            <Columns>

                                                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="70px"></telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="Status" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn HeaderText="MobileNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="contactcellno" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>


                                                                                            </Columns>
                                                                                        </MasterTableView>
                                                                                    </telerik:RadGrid>
                                                                                </td>
                                                                            </tr>
                                                                        </table>

                                                                    </div>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:PostBackTrigger ControlID="btnEventRatingUpdate" />
                                                                    <asp:PostBackTrigger ControlID="btnEventRatingClose" />

                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                        </ContentTemplate>

                                                    </telerik:RadWindow>
                                                </Windows>
                                            </telerik:RadWindowManager>
                                        </td>
                                    </tr>
                                </table>
                                 <table style="width: 88%;">
                        <tr>
                            <td align="left"></td>
                            <td align="right">
                                 <asp:Button ID="btnRestrict" runat="server" CssClass="btn btn-success"  Font-Bold="true" Text="Restrict" OnClick="btnRestrict_Click" ForeColor="White" ToolTip="" Visible="false" />
                                <asp:Button ID="btnviewall" runat="server" CssClass="btn btn-success"  Font-Bold="true" Text="View All" OnClick="btnviewall_Click" ForeColor="White" ToolTip="Click here to view scheduled,Conducted and Cancelled events." />
                                <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                                <asp:Label ID="LSpace" runat="server" Width="100px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                                  <table style="width: 100%;">
                        <tr>
                            <td style="width: 100%; vertical-align: middle;" align="left">
                                <telerik:RadGrid ID="radgvEvents" OnItemDataBound="radgvEvents_ItemDataBound" FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="80%" Height="400px" Font-Names="Verdana" AllowFilteringByColumn="true" 
                                    runat="server" Skin="WebBlue" OnItemCommand="radgvEvents_ItemCommand" 
                                    MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" 
                                    AllowPaging="false" AllowSorting="true" OnInit="radgvEvents_Init">
                                    <ClientSettings>
                                        <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                        <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView Font-Size="Small">

                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" ItemStyle-HorizontalAlign="Center">

                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnradupdate" Font-Size="Small" ToolTip="Click here to edit the event." ForeColor="Blue" Text="Edit" runat="server" CommandName="UpdateRow" CommandArgument='<%# Eval("RSN") %>' Visible='<%# Eval("Status").ToString() == "Scheduled" %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn Visible="false"  HeaderText="Event" DataField="EventType" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="70px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Date"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="FrmDate" HeaderStyle-Width="80px" FilterControlWidth="60px" HeaderTooltip="Click here to sort for date."></telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn HeaderText="Time"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Time" HeaderStyle-Width="80px" FilterControlWidth="60px" HeaderTooltip="Click here to sort for Time."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="End Date"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="TillDate" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                            <%--<telerik:GridBoundColumn HeaderText="Scheduled Events" DataField="EventName" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="200px"></telerik:GridBoundColumn>--%>

                                            <telerik:GridTemplateColumn DataType="System.String"  HeaderStyle-Width="200px" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" HeaderText="Scheduled Events" ItemStyle-Width="200px" UniqueName="EventName" DataField="EventName" HeaderTooltip="Click here to sort for Events.">

                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkevents" Font-Size="Small" ToolTip="Click here to open events rating popup" ForeColor="Blue" Text='<%# Eval("EventName") %>' runat="server" CommandName="Events" CommandArgument='<%# Eval("RSN") %>' Visible='<%# Eval("Status").ToString() == "Scheduled" %>' Font-Underline="true"></asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn HeaderText="Description"  HeaderStyle-HorizontalAlign="Left" DataField="Description" HeaderStyle-Width="275px" HeaderTooltip="Click here to sort for description." ItemStyle-Font-Size="Medium"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Status"  ItemStyle-HorizontalAlign="Left" DataField="Status" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn UniqueName="Image" HeaderText="Image" AllowFiltering="false" ItemStyle-Width="150px" HeaderStyle-Width="150px" HeaderTooltip="Click on the image to get a full view.">
                                                <ItemTemplate>
                                                    <%--<asp:LinkButton ID="lnkImage" runat="server" Text='<%# Eval("Image") %>' CommandArgument='<%# Eval("ShowImage") %>' CommandName="Image"></asp:LinkButton>--%>
                                                    <%-- <asp:HyperLink ID="ActionLink" alt="img" runat="server"><img src='<%# Eval("ShowImage") %>'  class="images" alt="img" width="90px" height="50px"></asp:HyperLink>--%>
                                                     <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ShowImage")%>'
                                                                Width="100px" Height="100px" Style="cursor: pointer" OnClientClick="return LoadDiv(this.src);" AlternateText="No Image" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="Type" ItemStyle-HorizontalAlign="Left" DataField="EventType" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Remarks" Visible="true" ItemStyle-HorizontalAlign="Left" DataField="Remarks" HeaderStyle-Width="100px" Display="false"></telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>

                    </table>
                                
                                <table>

                                    <tr>
                                        <td>
                                            <text style="font-weight: bold;">Date / Time</text>
                                            <%--<text style="color: red;">*</text>--%>
                                        </td>
                                        <td>

                                            <telerik:RadDatePicker ID="FromDate" runat="server" AutoPostBack="true" Font-Names="Verdana" OnSelectedDateChanged="FromDate_SelectedDateChanged" Font-Size="Small" ToolTip="Event start date."
                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" ZIndex="99999999" CssClass="form-control">
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
                                             &nbsp;&nbsp;
                                            /
                                            &nbsp;&nbsp;
                                             <telerik:RadTimePicker ID="dtpFromTime" runat="server" CssClass="form-control" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                    <TimeView ID="TimeView6" runat="server">
                                                    </TimeView>
                                                    <ClientEvents OnDateSelected="chkvalue" />
                                                </telerik:RadTimePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                       <%-- <td>
                                            <text style="font-weight: bold;"> Till Date</text>
                                           <text style="color: red;">*</text>
                                        </td>--%>
                                        <td>

                                            <telerik:RadDatePicker ID="TillDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Event end date."
                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" ZIndex="99999999" Visible="false" CssClass="form-control">
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
                                            <asp:TextBox ID="txtEventName" CssClass="form-control" runat="server" ToolTip="Give title/subject of  the event.The same will be the subject line for the email communication to the residents." MaxLength="80" Width="380px" Height="25px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <text style="font-weight: bold;"> Description</text>
                                            <text style="color: red;">*</text>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtdesc" CssClass="form-control" runat="server" ToolTip="Give a brief description of the event.The Event description will be emailed to all residents." MaxLength="2400" TextMode="MultiLine" Width="380px" Height="70px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblImages" runat="Server" Text="Image" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                        </td>


                                        <td>
                                            <%--<asp:FileUpload ID="FileUpd" runat="server" OnLoad="ShowpImagePreview(this);"/>--%>
                                            <asp:FileUpload ID="FileUpd" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Choose an event image."></asp:FileUpload>
                                            <asp:TextBox ID="TxtImge" CssClass="form-control" Enabled="false" runat="Server" MaxLength="80" ToolTip="" Width="200px" Height="25px" ForeColor=" DarkBlue" Visible="false" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                        </td>
                                        <td>

                                            <asp:Image ID="Custimage" runat="server" Height="100px" Width="100px" Visible="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblcstatus" runat="server" Text="Status" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlupstatus" runat="server" ToolTip="Select the status of Event." Width="150px" CssClass="form-control">
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
                                            <asp:CheckBox ID="chkIsSentMail" runat="server" Visible="false" Text="" Font-Names="verdana" ToolTip="When you click here, all the residents with valid Email IDs will be informed about the Event via Email." /><br />
                                            <asp:ImageButton ID="imgwapp" ImageUrl="~/Images/wapp2.png" Visible="false" Width="20px" Height="20px" runat="server"  OnClick="imgwapp_Click" />
                                            <asp:LinkButton ID="lnkwhatsapp" runat="server" Text="" Visible="false" AutoPostBack="true" Font-Names="verdana" Font-Bold="true" OnClientClick="return NewWindow();"  OnClick="lnkwhatsapp_Click" ToolTip="When you click here,  you will be redirected to the Web.Whatsapp.com page.
                                                            Choose the contact name from the list that will appear,  and Paste the contents (Either by pressing CtrlV or by right-click ,Paste).
                                                            Make sure you have already connected your Smart Phone (with Whatsapp installed) with the Web.Whatsapp.com portal."></asp:LinkButton>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td style="font-family: Verdana; font-size: small; font-weight: bold;">
                                            <asp:Button ID="btnAddEvent" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" Font-Bold="true" ToolTip="Click here to add a new event." runat="server" Text="Add" Width="100px" OnClientClick="javascript:return AddEvent()" OnClick="btnAddEvent_Click" />
                                            <asp:Button ID="btnUpdate" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" Font-Bold="true" runat="server" Text="Update" Width="110px" OnClientClick="javascript:return UpdateEvent();" OnClick="btnUpdate_Click" ToolTip="Click here to update the details of the event." />
                                            <asp:Button ID="btnAddClear" ForeColor="White" BackColor="DarkOrange" CssClass="btn btn-default" Font-Bold="true" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" Width="100px" OnClick="btnAddClear_Click" />
                                            <%--OnClientClick="Clear();"--%>
                                            <asp:Button ID="btnAddCancel" ForeColor="White" BackColor="DarkBlue" CssClass="btn btn-default" OnClick="btnAddCancel_Click" Font-Bold="true" runat="server" Text="Return" Width="100px" ToolTip="Click here to go back to the dashboard." />

                                            <%-- OnClientClick="Refresh();" --%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                    </table>

                   
                  

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnAddEvent" />
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="radgvEvents" />
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>
