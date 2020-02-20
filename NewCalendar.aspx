<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewCalendar.aspx.cs" MasterPageFile="~/CovaiSoft.master" Inherits="NewCalendar" %>

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
    <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
   
</style>

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

                var result = confirm('Do you want to add this Calendar?  Have you chosen option to inform all via email?');

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
                 return "Please enter the title/subject of the calendar." + "\n";
             } else {
                 return "";
             }
         }

         function Desc() {
             var Desc = document.getElementById('<%= txtdesc.ClientID %>').value;
             if (Desc == "") {
                 return "Please enter the description of the calendar.";
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


                                         <table  style="width:100%">
                                        <tr>
                                            <td valign="top">
                                                <table style="width: 100%;">
                                        <tr>
                                            <td align="center">
                                                <%--<asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Font-Underline="false"></asp:LinkButton>--%>
                                                <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:Label>
                                            </td>
                                        </tr>
                                           </table>
                                                <table>
                                                    
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;">Date</text>
                                                            <%--<text style="color: red;">*</text>--%>
                                                        </td>
                                                        <td>
                                                           
                                                            <telerik:RadDatePicker ID="FromDate" runat="server"  AutoPostBack="true" Font-Names="Verdana" OnSelectedDateChanged="FromDate_SelectedDateChanged" Font-Size="Small" ToolTip="Calendar date."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False"  ZIndex="99999999">
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
                                                   <%-- <tr>
                                                        <td>
                                                            <text style="font-weight: bold;"> Till Date</text>
                                                         
                                                        </td>
                                                        <td>
                                                           
                                                            <telerik:RadDatePicker ID="TillDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select an end date if applicable."
                                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False"  ZIndex="99999999">
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
                                                    </tr>--%>
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;"> Title</text>
                                                            <text style="color: red;">*</text>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEventName" runat="server" ToolTip="Give title/subject for the particular day." MaxLength="80" Width="380px" Height="25px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <text style="font-weight: bold;"> Description</text>
                                                            <text style="color: red;">*</text>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtdesc" runat="server" ToolTip="Give a brief description of the Calendar" MaxLength="2400" TextMode="MultiLine" Width="380px" Height="70px"></asp:TextBox>
                                                        </td>
                                                    </tr>

                                                     <tr>
                                         <%--   <td>
                                                <asp:Label ID="lblImages" runat="Server" Text="Image" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>--%>


                                           <%-- <td>
                                              
                                                <asp:FileUpload ID="FileUpd" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Choose calendar image"></asp:FileUpload>
                                                 <asp:TextBox ID="TxtImge" Enabled="false" runat="Server" MaxLength="80" ToolTip="" Width="200px" Height="25px" ForeColor=" DarkBlue" Visible="false" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>--%>
                                            <td>

                                                <asp:Image ID="Custimage" runat="server" Height="100px" Width="100px" Visible="false" />
                                            </td>
                                            </tr>
                                                    
                                                    <%--<tr>
                                                        <td></td>
                                                        <td>
                                                            <asp:CheckBox ID="chkIsSentMail" runat="server" Text="Inform all residents via email." Font-Names="verdana" ToolTip="When you click here, all the residents with valid Email IDs will be informed about the Event via Email." /><br />
                                                            <asp:ImageButton ID="imgwapp" ImageUrl="~/Images/wapp2.png" Width="20px" Height="20px" runat="server" OnClick="imgwapp_Click" />
                                                            <asp:LinkButton ID="lnkwhatsapp" runat="server" Text="Inform all residents via WhatsApp" Font-Names="verdana" Font-Bold="true" OnClick="lnkwhatsapp_Click" ToolTip="When you click here,  you will be redirected to the Web.Whatsapp.com page.
                                                            Choose the contact name from the list that will appear,  and Paste the contents (Either by pressing CtrlV or by right-click ,Paste).
                                                            Make sure you have already connected your Smart Phone (with Whatsapp installed) with the Web.Whatsapp.com portal."></asp:LinkButton>

                                                        </td>
                                                    </tr>--%>
                                           
                                                    <tr>
                                                        <td></td>
                                                        <td style="font-family: Verdana; font-size: small; font-weight: bold;">
                                                            <asp:Button ID="btnAddEvent" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click here to add a Calendar" runat="server" Text="Add" Width="100px" OnClientClick="javascript:return AddEvent()"  OnClick="btnAddEvent_Click"/>
                                                            <asp:Button ID="btnUpdate" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" runat="server" Text="Update" Width="110px" OnClientClick="javascript:return UpdateEvent();" OnClick="btnUpdate_Click" ToolTip="Click here to update the details of the Calendar." />
                                                            <asp:Button ID="btnAddClear" ForeColor="White" BackColor="DarkOrange" Font-Bold="true" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" Width="100px" OnClick="btnAddClear_Click" />
                                                             <%--OnClientClick="Clear();"--%>
                                                            <asp:Button ID="btnAddCancel" ForeColor="White" BackColor="DarkBlue" OnClick="btnAddCancel_Click" Font-Bold="true" runat="server" Text="Return" Width="100px" ToolTip="Click here to go back to the dashboard." />

                                                           <%-- OnClientClick="Refresh();" --%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>

                                    </table>

                    <table style="width: 60%;">
                                        <tr>
                                            <td align="left">

                                            </td>
                                            <td align="right" >
                                               <asp:Button ID="btnviewall" runat="server" CssClass="btn btn-success"  Font-Bold="true" Text="View All" OnClick="btnviewall_Click" ForeColor="White" ToolTip="Click here to view all calendars" Visible="false" />
                                                <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success"  Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                                               
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 100%; vertical-align: middle;" align="left">
                                                <telerik:RadGrid ID="radgvEvents" OnItemDataBound="radgvEvents_ItemDataBound" FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="60%" Height="400px" Font-Names="Verdana" AllowFilteringByColumn="true" runat="server" Skin="WebBlue" OnItemCommand="radgvEvents_ItemCommand" MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true">
                                                    <ClientSettings>
                                                        <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                        <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                    </ClientSettings>
                                                    <MasterTableView Font-Size="Small">
                                                       
                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnradupdate" ToolTip="Click here to edit the event." ForeColor="Blue" Text="Edit" runat="server" Font-Size="Small" CommandName="UpdateRow" CommandArgument='<%# Eval("RSN") %>' ></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn Visible="false" HeaderText="Event" DataField="EventType" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="70px" ></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="FrmDate"  HeaderStyle-Width="70px" FilterControlWidth="55px" HeaderTooltip="Click here to sort for date."></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="End Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" DataField="TillDate"  HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Title" DataField="EventName" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="200px"  HeaderTooltip="Click here to sort for title/subject."></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Left" DataField="Description" HeaderStyle-Width="275px"  HeaderTooltip="Click here to sort for description." Visible="false"></telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn UniqueName="Image" HeaderText="Image" AllowFiltering="false" ItemStyle-Width="150px" HeaderStyle-Width="150px"  Visible="false">
                                                <ItemTemplate>
                                                    <%--<asp:LinkButton ID="lnkImage" runat="server" Text='<%# Eval("Image") %>' CommandArgument='<%# Eval("ShowImage") %>' CommandName="Image"></asp:LinkButton>--%>
                                                    <%-- <asp:HyperLink ID="ActionLink" alt="img" runat="server"><img src='<%# Eval("ShowImage") %>'  class="images" alt="img" width="90px" height="50px"></asp:HyperLink>--%>
                                                     <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ShowImage")%>'
                Width="100px" Height="100px" Style="cursor: pointer" OnClientClick="return LoadDiv(this.src);" AlternateText="No Image" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn HeaderText="Status" ItemStyle-HorizontalAlign="Left" DataField="Status" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false" ></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Type" ItemStyle-HorizontalAlign="Left" DataField="EventType" HeaderStyle-Width="100px" FilterControlWidth="75px" Display="false"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Remarks" Visible="true" ItemStyle-HorizontalAlign="Left" DataField="Remarks" HeaderStyle-Width="100px" Display="false"></telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
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
