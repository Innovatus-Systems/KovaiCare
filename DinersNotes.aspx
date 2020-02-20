<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DinersNotes.aspx.cs" Inherits="DinersNotes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet" />
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
    <script type="text/javascript" language="javascript">
        function HideUpdateProgress() {
            var updateProgress = document.getElementById("<%=UpdateProgress1.ClientID%>");
            updateProgress.style.display = 'none';
            Sys.Application.remove_load(HideUpdateProgress);
        }
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
                    <table style="width: 100%">
                        <tr>
                            <td align="center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 60%;">
                        <tr>
                            <td style="width: 5%;"></td>
                            <td style="width: 45%;">
                                <table style="width: 100%; padding: 10px;" cellspacing="3px">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbldate" runat="server" Text="Select Date :" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="Label4" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dtDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" AutoPostBack="true" ToolTip="Select date and session to enter diner notes.">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                    CssClass="TextBox" Font-Names="Calibri">
                                                </Calendar>
                                                <DatePopupButton></DatePopupButton>
                                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                    ForeColor="Black" ReadOnly="true">
                                                </DateInput>
                                            </telerik:RadDatePicker>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSession" runat="server" Text="Select Session :" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="Label1" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpSession" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Select date and session to enter diner notes.'Session All  -  Diner Notes is applicable for all the sessions for the day. If there are any exceptions, write it in Remarks.'"></asp:DropDownList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblForWhom" runat="server" Text="For Whom :" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpForWhom" CssClass="form-controlForResidentAdd" runat="server" OnSelectedIndexChanged="drpForWhom_SelectedIndexChanged" AutoPostBack="true" ToolTip="For whom is this notes applicable.">
                                                <asp:ListItem Text="Please Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text=" R - Resident" Value="R"></asp:ListItem>
                                                <asp:ListItem Text="G - Guest House Guest" Value="G"></asp:ListItem>
                                                <asp:ListItem Text="S - Staff" Value="S"></asp:ListItem>
                                                <asp:ListItem Text="O - Others" Value="O"></asp:ListItem>
                                            </asp:DropDownList>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Label ID="lblName" runat="server" Text="Select Name :" Font-Bold="true" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbResident" CssClass="form-controlForResidentAdd" runat="server" ForeColor="DarkBlue" AllowCustomText="true" AutoPostBack="true" Visible="false"
                                                Font-Names="Arial" Font-Size="Small" Width="350px" ToolTip="Select Resident diner / Guest house diner Name with doorno."
                                                RenderMode="Lightweight" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtName" runat="server" ToolTip=" Name of the diner." Visible="false" CssClass="form-controlForResidentAdd" Enabled="false"></asp:TextBox>
                                            <asp:Label ID="lblDN" runat="server" Text="" Font-Bold="true" Visible="false"></asp:Label>
                                            <asp:TextBox ID="txtAccCd" runat="server" ToolTip="Account code of the diner." Visible="false" CssClass="form-controlForResidentAdd" Enabled="false"></asp:TextBox>
                                            <asp:Label ID="lblStName" runat="server" Text="Name :" Font-Bold="true" Visible="false"></asp:Label>
                                            <asp:TextBox ID="txtStName" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Please enter Staff or others name." Visible="false"></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblNotesType" runat="server" Text="DNotes :" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="Label5" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpNotesType" CssClass="form-controlForResidentAdd" runat="server" ToolTip="From the standard list , Maintain separately."></asp:DropDownList>
                                            &nbsp;
                                                <asp:ImageButton ID="imgbtnAdditemDetails" runat="server" ImageUrl="~/Images/Add icon.png" OnClick="imgbtnAdditemDetails_Click" ToolTip="Click here to add a new DNotes Type." />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top;">
                                            <asp:Label ID="lblSplNotes" runat="server" Text="Remarks :" Font-Bold="true"></asp:Label>
                                            <asp:Label ID="Label6" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSplNotes" runat="server" CssClass="form-controlForResidentAdd" TextMode="MultiLine" Height="80px" Width="220px" MaxLength="40" ToolTip="Any additional information."></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px;"></td>
                                        <td colspan="2" style="margin-right: 100px;">
                                            <asp:Button Text="Update" runat="server" ID="btnUpdate" CssClass="btn btn-success" Visible="false" OnClick="btnUpdate_Click" ToolTip="To update detial, Please click here." />
                                            <asp:Button Text="Save" runat="server" ID="btnSave" CssClass="btn btn-success" Visible="true" OnClick="btnSave_Click" ToolTip="To Save detail, Please click here." />&nbsp;&nbsp; 
                                            <asp:Button Text="Clear" runat="server" ID="btnClear" CssClass="btn btn-danger" OnClick="btnClear_Click" ToolTip="To clear all the fields." />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                             <td style="width: 75px;"> </td>
                           <td colspan="4">
                               <table >
                        <tr>
                            <td>
                                <asp:Label ID="lblFrom" runat="server" Text="From :" Font-Bold="true"></asp:Label>&nbsp;&nbsp;
                                 <telerik:RadDatePicker ID="rdtFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                    CssClass="form-controlForResidentAdd" Width="185px" ReadOnly="true" AutoPostBack="true" OnSelectedDateChanged="rdtFrom_SelectedDateChanged"  ToolTip="Select from date">
                                     <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                         CssClass="form-control" Font-Names="Calibri" >
                                     </Calendar>
                                     <DatePopupButton></DatePopupButton>
                                     <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                         ForeColor="Black" ReadOnly="true">
                                     </DateInput>
                                 </telerik:RadDatePicker>
                           &nbsp;&nbsp;&nbsp;&nbsp;
                                           <asp:Label ID="lblTil" runat="server" Text="Till :" Font-Bold="true"></asp:Label>&nbsp;&nbsp;
                                 <telerik:RadDatePicker ID="rdtTill" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                     CssClass="form-controlForResidentAdd" Width="185px" ReadOnly="true" AutoPostBack="true" ToolTip="Select till date" OnSelectedDateChanged="rdtTill_SelectedDateChanged">
                                     <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                         CssClass="form-control" Font-Names="Calibri">
                                     </Calendar>
                                     <DatePopupButton></DatePopupButton>
                                     <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                         ForeColor="Black" ReadOnly="true">
                                     </DateInput>
                                 </telerik:RadDatePicker>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button Text="Search" runat="server" ID="btnSearch" CssClass="btn btn-primary" Visible="true" OnClick="btnSearch_Click" ToolTip="Click to search your date selection range." />
                           &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lblFilter" runat="server" Text="Filter :" Font-Bold="true"></asp:Label>&nbsp;&nbsp;
                                 <asp:DropDownList ID="drpDTypeFilter" CssClass="form-controlForResidentAdd" runat="server" AutoPostBack="true" ToolTip="From the standard list , Maintain separately." OnSelectedIndexChanged="drpDTypeFilter_SelectedIndexChanged"></asp:DropDownList>
                                 </td>
                        </tr>
                    </table>
                           </td>
                        </tr>
                       
                    </table>
                    
                    <table style="width: 90%" align="center">
                        <tr>
                            <td align="center" colspan="5">
                                <telerik:RadGrid ID="rgDinNts" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"
                                    CellSpacing="5" Width="98%"
                                    MasterTableView-HierarchyDefaultExpanded="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                    </ClientSettings>
                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                    </HeaderContextMenu>
                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                    <MasterTableView AllowCustomPaging="false">
                                        <NoRecordsTemplate>
                                            Select Date Range and click Search.
                                        </NoRecordsTemplate>
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="10px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="10px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="30px" FilterControlWidth="45px" HeaderTooltip="Click to Edit." HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                AllowFiltering="true" UniqueName="Edit" SortExpression="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" Font-Underline="true" runat="server" ToolTip="Click to Edit Particular diner Notes" Text="Edit" Font-Bold="true" OnClick="lnkEdit_Click">Edit</asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="85px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Date of diner notes." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="85px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="60px" DataField="SessionName" ReadOnly="true" HeaderTooltip="Session of diner notes." AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Notes" HeaderStyle-Width="80px" DataField="DNDesc" ReadOnly="true" AllowFiltering="true" HeaderTooltip="From the standard list , Maintain separately."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="120px" DataField="DNNOTES" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Any Additional information."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="For" HeaderStyle-Width="30px" DataField="ForWhom" ReadOnly="true" AllowFiltering="true" HeaderTooltip="For whom is notes applicable."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="90px" DataField="DN_Name" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Name of the diner."></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="60px" DataField="Rtvillano" ReadOnly="true" AllowFiltering="true" HeaderTooltip="House of the resident diner."></telerik:GridBoundColumn>
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
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

