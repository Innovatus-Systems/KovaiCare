<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="AttributesAdd.aspx.cs" Inherits="AttributesAdd" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .preference .rwWindowContent {
            background-color: Green !important;
        }

        .availability .rwWindowContent {
            background-color: #7049BA !important;
        }
    </style>
    <style type="text/css">
        .nav-tabs a, .nav-tabs a:hover, .nav-tabs a:focus
        {
            outline: 0;
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



        function ConfirmMsg() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }

        function ConfirmMsg1() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=Confirm.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=Confirm.ClientID%>').value = "false";
            }

        }


        function DeleteConfirmMsg() {

            var result = confirm('Are you sure, you want to delete this record?');
            if (result) {
                var result1 = confirm('Confirm?');
                if (result1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                 return false;
            }

        }


    </script>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += Phno();
            summ += Email();

            if (summ == "") {
                var msg = "";
                msg = 'Are you sure, you want to save?';
                var result = confirm(msg, "Check");
                if (result) {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(summ);
                return false;
            }

        }

        function Phno() {
            var Name = document.getElementById('<%=RAContactNo.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Mobile No" + "\n";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=RAEmailId.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Email ID" + "\n";
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
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <asp:UpdatePanel ID="Updtpnl" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt">
                    <div style="width: 100%;">
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 65%;">
                                    <asp:Label ID="lblheading" Visible="true" Text=""
                                        Font-Bold="true" ForeColor="DarkBlue" Font-Size="Medium" runat="server" />
                                </td>
                                <%-- <td>
                                <asp:DropDownList ID="ddlDependDet" Width="175px" ToolTip="Click here to view the Profile++ of other residents in the same villa." runat="server" 
                                    Font-Names="Verdana" AutoPostBack="true" Font-Size="Small" OnSelectedIndexChanged="ddlDependDet_SelectedIndexChanged" >
                                </asp:DropDownList>
                            </td>--%>
                                <td>
                                    <asp:Button ID="btnhelptext" runat="server" Text="Help?" CssClass="btn btn-success" Visible="false"
                                        OnClick="btnhelptext_Click" ToolTip="Click here to view the help about this page." />
                                    <asp:LinkButton ID="lnkProfile" runat="server" Text="Resident's Profile" Font-Underline="true" ForeColor="#006600" Font-Size="Medium" Font-Names="verdana" OnClick="lnkProfile_Click" ToolTip="Click to go Profile Page." ></asp:LinkButton> &nbsp;&nbsp;
                                    <asp:Button ID="btnreturnfromlevelAdd"  runat="server" Text="Return" CssClass="btn btn-info" BackColor="Blue" Visible="true"
                                        OnClick="btnreturnfromlevelAdd_Click" ToolTip="Click here to return Resident's." />
                                </td>
                            </tr>
                        </table>
                
              <div class="panel panel-default" style="width: 94%;">
                <div id="Tabs" role="tabpanel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="active"><a href="#ICE" style="font-size: 17px;color: #4c63e0;font-weight:bold;" aria-controls="ICE" role="tab" data-toggle="tab">ICE</a></li>
                        <li><a href="#Personal"  style="font-size: 17px;color: #4c63e0;font-weight:bold;" aria-controls="Personal" role="tab" data-toggle="tab">Personal</a></li>
                        <li><a href="#Identity"  style="font-size: 17px;color: #4c63e0;font-weight:bold;"  aria-controls="Identity" role="tab" data-toggle="tab">Identity</a></li>
                        <li><a href="#Interest"  style="font-size: 17px;color: #4c63e0;font-weight:bold;" aria-controls="Interest" role="tab" data-toggle="tab">Interest</a></li>
                        <li><a href="#Health"  style="font-size: 17px;color: #4c63e0; font-weight:bold;" aria-controls="Health" role="tab" data-toggle="tab">Health</a></li>
                        <li><a href="#HWatch"  style="font-size: 17px;color: #4c63e0;font-weight:bold;" aria-controls="HWatch" role="tab" data-toggle="tab">HWatch</a></li>
                        <li><a href="#NOK"  style="font-size: 17px;color: #4c63e0;font-weight:bold;" aria-controls="NOK" role="tab" data-toggle="tab">NOK</a></li>
                        <li><a href="#Special"  style="font-size: 17px;color: #4c63e0; font-weight:bold;" aria-controls="Special" role="tab" data-toggle="tab">Special</a></li>
                        <li><a href="#Doc" style="font-size: 17px;color: #4c63e0; font-weight:bold;" aria-controls="Doc" role="tab" data-toggle="tab">Doc. Upload</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content" style="padding-top: 20px">
                        <div role="tabpanel" class="tab-pane active" id="ICE">
                           <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblICE" runat="server" Text="In Case of Emergency:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="AttbtsgrdView" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            OnPageIndexChanged="AttbtsgrdView_PageIndexChanged" OnPreRender="AttbtsgrdView_PreRender1"
                                            OnPageSizeChanged="AttbtsgrdView_PageSizeChanged" OnSortCommand="AttbtsgrdView_SortCommand"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText" MaxLength="40"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code, upto a maximum of 40 charactersx`.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Contact No." DataField="RAContactNo" AllowFiltering="false" Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="EMail ID" DataField="RAEmailId" AllowFiltering="false" Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" MaxLength="480" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                        <div role="tabpanel" class="tab-pane" id="Personal">
                           <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Personal:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgPersonal" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgPersonal_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false" Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false" Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Date" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Center" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                        <div role="tabpanel" class="tab-pane" id="Identity">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Identity:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgIdentity" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgIdentity_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false"  Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                        <div role="tabpanel" class="tab-pane" id="Interest">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Interest:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgInterest" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgInterest_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false"  Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                         <div role="tabpanel" class="tab-pane" id="Health">
                           <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text="Health:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgHealth" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgHealth_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false"  Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Date" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                         <div role="tabpanel" class="tab-pane" id="HWatch">
                           <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text="Hwatch:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgHwatch" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgHwatch_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false" Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="DOB" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" Display="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="Center" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false" Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                        <div role="tabpanel" class="tab-pane" id="NOK">
                           <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Next of Kin:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rdgNOK" runat="server" AllowPaging="false" PageSize="500"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                        CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgNOK_ItemCommand" >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" />
                                        </ClientSettings>
                                        <GroupingSettings CaseSensitive="false" />
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                    ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                    </HeaderTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                    AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                    AllowFiltering="true"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                    ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Contact No." DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                    Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                    ItemStyle-Width="150px">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="EMail ID" DataField="RAEmailId" AllowFiltering="false"  Display="false"
                                                    Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Date of Birth" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                    ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                    ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                    ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false"
                                                    Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                    Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                    <ItemTemplate>

                                                        <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>
                          <div role="tabpanel" class="tab-pane" id="Special">
                           <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label12" runat="server" Text="Special:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgSpecial" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdgSpecial_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="" AllowFiltering="false"
                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" ToolTip="By default only priority = 'Yes' codes are displayed.Click to view all other codes defined for the Profile++." AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RARSN" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN"
                                                        AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" DataField="RAGroup" HeaderStyle-Wrap="false" Display="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-CssClass=""
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" DataField="RACode" HeaderTooltip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                                                        AllowFiltering="true"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Details" DataField="RAText"
                                                        ItemStyle-Wrap="true" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Details relevant to the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAContactNo" AllowFiltering="false"  Display="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Contact Number if applicable for the Profile++ code."
                                                        ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RAEmailId" AllowFiltering="false"  Display="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="Left" HeaderTooltip="EMail ID if applicable for the Profile++ code.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="DOB" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        ItemStyle-CssClass="Row1" ItemStyle-Width="150px">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False" BackColor=""></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Value" DataField="RAValue" HeaderStyle-Wrap="false" Display="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-CssClass="Row1"
                                                        ItemStyle-HorizontalAlign="Left">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" AllowFiltering="false"
                                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" Visible="false"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="" DataField="RADate" AllowFiltering="false"
                                                        Visible="True" ItemStyle-HorizontalAlign="right" HeaderTooltip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-Wrap="false" AllowFiltering="false"
                                                        Visible="true" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Any additional remarks about the Profile++ Code. Ex.Postal address of son.">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click1">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>

                                                            <asp:LinkButton ID="Lnkbtndelete" runat="server" ToolTip="Click here to Delete additional particulars." Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="Lnkbtndelete_Click" CommandName='<%# Eval("RARSN") %>'>Delete</asp:LinkButton>

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
                        </div>

                        <div role="tabpanel" class="tab-pane" id="Doc">
                            <div>
                           <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                   <td>
                                        <asp:Label ID="Label13" runat="server" Text="Doc. Upload:" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:LinkButton ID="lnkAddDoc" runat="server" Text="+ Upload New Doc." Font-Names="Verdana" Font-Bold="true" Font-Size="Medium" ForeColor="DarkGreen" OnClick="lnkAddDoc_Click" ></asp:LinkButton>
                                    </td>
                                            </tr>
                                        </table>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdDoc" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="1000px"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdDoc_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                     <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="50px" DataField="RSN" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn HeaderText="RTRSN" HeaderStyle-Width="50px" DataField="RTRSN" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  Display="false"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="50px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="40px" DataField="Code" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                    <%--<telerik:GridBoundColumn HeaderText="URL" HeaderStyle-Width="150px" DataField="URL" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="" ></telerik:GridBoundColumn>--%>
                                                      
                                                    <telerik:GridTemplateColumn DataField="URL" HeaderText="File Name" SortExpression="URL" UniqueName="URL" FilterControlAltText="URL" FooterStyle-ForeColor="DarkBlue" HeaderTooltip="File Location">
                                                        <ItemTemplate>     
                                                            <asp:LinkButton ID="lnkDownload" Text='<%# Eval("URL") %>' CommandArgument='<%# Eval("URL") %>' ForeColor="DarkBlue" UniqueName="file_name" runat="server" CommandName="download_file"></asp:LinkButton>                                                    
                                                                </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                     <telerik:GridBoundColumn HeaderText="DOU" HeaderStyle-Width="60px" DataField="DOU" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="160px" DataField="Remarks" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="" ></telerik:GridBoundColumn>


                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LnkDocEdit" runat="server" ToolTip="Click here to Edit" Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="LnkDocEdit_Click">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LnkDocDelete" runat="server" ToolTip="Click here to Delete" Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="LnkDocDelete_Click" CommandName='<%# Eval("RSN") %>'>Delete</asp:LinkButton>
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

                            </div>                           
                        </div>

                        <asp:HiddenField ID="CnfResult" runat="server" />
            </div>
        </div>
    </div>


                        <%--*********************************--%>

                        <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkaddnewtask" runat="server" Visible="true" Text="" Font-Bold="true" ForeColor="DarkBlue" OnClick="lnkaddnewtask_Click" ToolTip="Click here to add new task"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblHeading2" Text="Add Profile++ information for the resident." Font-Bold="true" Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkBlue" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnladdnewtask" runat="server" Visible="false" BackColor="BurlyWood">
                                        <table>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRTVILLANO" runat="Server" Text="Villa No" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>

                                                </td>

                                                <td>
                                                    <asp:TextBox ID="TxtRTVILLANO" runat="Server" MaxLength="12" ToolTip="*Villa No of the Occupant." Enabled="false" Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRTSTATUS" runat="Server" Text="Status" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlstatus" runat="server" Width="150px" Height="25px" ToolTip="Resident Status" Font-Names="Calibri" Font-Size="Medium"></asp:DropDownList>
                                                    <%-- <asp:TextBox ID="TxtRTStatus" runat="Server" MaxLength="12" ToolTip="* Status of Occupant. " Enabled="false" Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRTName" runat="Server" Text="Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TxtRTName" runat="Server" MaxLength="80" Enabled="false" Width="250px" Height="25px" ToolTip="Name of the Occupant." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblGroup" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                    <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGroup" AutoPostBack="true" Width="150px" Height="25px" runat="server" ToolTip="Select a 'Group' from the list shown"
                                                        Font-Names="Calibri" Font-Size="Medium" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged">
                                                        <asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                                                        <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                                        <asp:ListItem Text="Identity" Value="Identity"></asp:ListItem>
                                                        <asp:ListItem Text="Interest" Value="Interest"></asp:ListItem>
                                                        <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                                                        <asp:ListItem Text="HWatch" Value="HWatch"></asp:ListItem>
                                                        <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                                                        <asp:ListItem Text="Special" Value="Special"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRACode" runat="Server" Text="Profile++ Code" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRACode" Width="150px" Height="25px" runat="server" ToolTip="Select a 'Code' from the list shown"
                                                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Medium" AutoPostBack="True" OnSelectedIndexChanged="ddlRACode_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                <asp:ImageButton ID="imgbtnAdditemDetails" runat="server" ImageUrl="~/Images/Add icon.png" OnClick="imgbtnAdditemDetails_Click" ToolTip="Click here to add a new Subgroup." />
                                                    <br />
                                                    <asp:Label ID="lbldescription" runat="Server" Text="" BackColor="Yellow" Width="250px"
                                                        ForeColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                            </tr>
                                             
                                            <%--<tr>
                                                <td>
                                                    <asp:Label ID="lblpriority" runat="Server" Text="Priority" ForeColor=" Black " Font-Names="Calibri"
                                                        Font-Size="Medium"></asp:Label>
                                                    <asp:Label ID="Label8" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlpriority" Width="150px" Height="25px" runat="server" ToolTip="Select the above chosen Subgroup's Priority."
                                                        Font-Names="Calibri" Font-Size="Medium" Enabled="false">
                                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>--%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRAText" runat="Server" Text="Details" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="RAText" runat="Server" MaxLength="40" ToolTip="Details relevant to the Profile++ code." Width="350px" Height="40px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDOB" runat="Server" Width="100px" Text="Date of Birth" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="FromDate" runat="server" Font-Names="Calibri" Font-Size="Medium" ToolTip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" Width="150px" Height="25px" MinDate="01-01-1200">
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput2" DateFormat="ddd dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Medium" ReadOnly="True">
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
                                                    <asp:Label ID="lblRAValue" runat="Server" Text="Value" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium" Visible="false"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="RAValue" runat="Server" MaxLength="10" ToolTip="Enter a Value of the Additional." Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium" Visible="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRADate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="RADate" runat="server" Font-Names="Calibri" Font-Size="Medium" Width="150px" Height="25px" ToolTip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date."
                                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False">
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Medium" ReadOnly="True">
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
                                                    <asp:Label ID="lblRAContactNo" runat="Server" Text="Contact No." ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="RAContactNo" runat="Server" MaxLength="80" ToolTip="Contact Number if applicable for the Profile++ code." Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRAEmailId" runat="Server" Text="Email ID" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="RAEmailId" runat="Server" MaxLength="80" ToolTip="EMail ID if applicable for the Profile++ code." Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRARemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="RARemarks" runat="Server" MaxLength="240" ToolTip="Any additional remarks about the Profile++ Code. Ex.Postal address of son." Width="350px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium" TextMode="Multiline" Height="60px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <%-- <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="Server" Text="PopUp" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                    <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPopup" AutoPostBack="true" Width="150px" Height="25px" runat="server" ToolTip="Select a 'Group' from the list shown"
                                                        Font-Names="Calibri" Font-Size="Medium">
                                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>--%>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <table>
                                        <tr>

                                            <td>
                                                <asp:Label ID="lblRTRSN" runat="Server" Text="RSN" ForeColor=" Black " Visible="false" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="TxtRTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" Visible="false" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                            </tr>
                        </table>
                        </td>
                        </tr>
                    </table>        

                    <%--*********************************--%>

                        <asp:Panel ID="pnlbtns" runat="server" Visible="false">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSave" runat="Server" Width="100px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" OnClientClick="javascript:return Validate()" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Medium" OnClick="btnSave_Click1" />
                                    </td>

                                    <td>
                                        <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                    </td>

                                    <td>
                                        <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Return" ToolTip="Press here to RETURN to Level S" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnExit_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>

                    </div>
                </div>
            </div>

            <telerik:RadWindow ID="RWHelpmessageAttributeadd" VisibleOnPageLoad="false" BackColor="Red" Font-Names="Calibri" ForeColor="blue" Width="600px" Height="350px" runat="server">
                <ContentTemplate>

                    <p style="color: white; font-weight: 400">* Add information into one or all the fields marked ! Depending on the Group and Item selected.</p>
                    <p style="color: white; font-weight: 400">* While the basic information about a Resident is included as part of the  main profile (seen in Level S), here in this screen additional particulars about the resident, are managed.</p>
                    <p style="color: white; font-weight: 400">* Additional particulars of similar type are grouped together. </p>
                    <p style="color: white; font-weight: 400">* Each Group can have several Items. </p>
                    <p style="color: white">* New groups apart from what are provided,  can be added by the Administrator.</p>
                    <p style="color: white; font-weight: 400">* Not all information are compulsory.</p>
                    <p style="color: white; font-weight: 400">* However, it is advisable to fill in important details like Emergency Contact Nos, Health Information etc. to provide prompt and efficient service to the Residents.</p>
                </ContentTemplate>
            </telerik:RadWindow>


            <%-------------------------------------------------------------------------------------------------------------------%>
            <telerik:RadWindow ID="RadItemadd" VisibleOnPageLoad="false" BackColor="Red" Font-Names="Calibri" ForeColor="blue" Width="900px" Height="550px" runat="server">
                <ContentTemplate>

                    <asp:Panel ID="PnlItemadd" runat="server" Visible="true">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lbllevelH" Visible="true" Text="Level H - Additional Particulars Master."
                                        Font-Bold="true" ForeColor="Blue" Font-Size="Medium" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlItemGroup" Width="200px" Height="30px" runat="server" ToolTip="Select a 'Group' from list Shown. "
                                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Medium">
                                        <asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                                        <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                                        <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                        <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                                        <asp:ListItem Text="Special" Value="Special"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="Server" Text="Subgroup" ForeColor=" Black " Font-Names="Calibri"
                                        Font-Size="Medium"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="RACode" runat="Server" MaxLength="8" ToolTip="Enter the Subgroup" Width="150px" Height="25px"
                                        ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="Server" Text="Subgroup Priority" ForeColor=" Black " Font-Names="Calibri"
                                        Font-Size="Medium"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" Width="200px" Height="30px" runat="server" ToolTip="Select Priority of the Subgroup."
                                        Font-Names="Calibri" Font-Size="Medium">
                                        <asp:ListItem Value="N">No</asp:ListItem>
                                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="lblRADescription" runat="Server" Text="Description" ForeColor=" Black "
                                        Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="RADescription" runat="Server" MaxLength="40" ToolTip="Enter clear description about Code." Width="300px" Height="25px"
                                        ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label7" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Calibri"
                                        Font-Size="Medium"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="Server" MaxLength="240" ToolTip="Enter any additional Remarks." Width="400px"
                                        ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium" TextMode="Multiline"
                                        Height="70px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>


                        <%----------------------------------------------------------------------------------------------%>


                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="BNSAVE" runat="Server" Width="100px" Text="Save" ToolTip="Clik here to save the details."
                                        ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" OnClientClick="javascript:return ConfirmMsg1()" Font-Size="Medium" OnClick="BNSAVE_Click" />
                                </td>
                                <%-- End of Button Save --%>
                                <%-- Button Clear --%>
                                <td>
                                    <asp:Button ID="BNCLEAR" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details."
                                        ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="BNCLEAR_Click" />
                                </td>
                                <%-- End of Button Clear --%>
                                <%-- Button Exit --%>
                                <td>
                                    <asp:Button ID="BNEXIT" runat="Server" Width="100px" Text="Exit" ToolTip="Clik here to Exit."
                                        ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="BNEXIT_Click" />
                                </td>
                            </tr>
                        </table>

                        <%-----------------------------------------------------------------------------------------------------------------------------%>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="AttbtsLkUpgrdView" runat="server" AllowPaging="True" PageSize="10"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True"
                                        OnPageIndexChanged="AttbtsLkUpgrdView_PageIndexChanged" OnItemCommand="AttbtsLkUpgrdView_ItemCommand"
                                        OnPageSizeChanged="AttbtsLkUpgrdView_PageSizeChanged" OnSortCommand="AttbtsLkUpgrdView_SortCommand"
                                        CellSpacing="20" Width="100%"
                                        MasterTableView-HierarchyDefaultExpanded="true" >
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
                                                <telerik:GridBoundColumn HeaderText="#" DataField="RBRSN" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50PX"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Group" DataField="RAGroup" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" DataField="RACode" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" DataField="RADescription" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Wrap="false" ItemStyle-Width="100%"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="true" Width="100%"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="EditLkUp" SortExpression="Edit">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit AddOn's Look Up" Text="Edit" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>

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

                    </asp:Panel>
                </ContentTemplate>
            </telerik:RadWindow>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:PostBackTrigger ControlID="AttbtsgrdView" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:HiddenField ID="Confirm" runat="server" />
</asp:Content>
