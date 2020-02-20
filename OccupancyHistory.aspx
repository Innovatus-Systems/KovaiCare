<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="OccupancyHistory.aspx.cs" Inherits="OccupancyHistory" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <%--<script src="//code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });



        function askConfirm() {
            if (confirm("Are you sure, you want to save?"))
                alert(" ")
            else {
                //alert(" ")

                return false;
            }
        }
        //function FileUpd_Load() {
        //    // Get File Upload Path & File Name
        //    var file = document.getElementById("FileUpd");
        //    // Set Image Url from FileUploader Control
        //    document.getElementById("#Custimage").src = file.value;
        //    // Display Selected File Path & Name
        //    alert("You selected " + file.value);
        //    // Get File Size From Selected File in File Uploader Control 
        //    var inputFile = document.getElementById("FileUpd").files[0].size;
        //    // Displaty Selected File Size
        //    alert("File size: " + inputFile.toString());
        //}

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
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width:98%";>
                <table>
                    <tr>
                        <td>
                            
                        </td>
                    </tr>
                </table>
                <table style="width:100%">
                    <tr>
                        <td align="center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table>

                    <tr>
                        <td>
                             <telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="250px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="DoorNo" DataValueField="RSN" InputType="Text" MinFilterLength="1"
                                                    EmptyMessage="Choose DoorID / DoorNo / Type " ToolTip="Choose the DoorNoID / DoorNo / Type to view the details"  AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                    <TextSettings SelectionMode="Single" />
                                                </telerik:RadAutoCompleteBox>
                                                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RSN) +','+ DoorNo +','+ Type + ',' + convert(nvarchar(10),RSN) as DoorNo,RSN from tblvillamaster order by DoorNo asc"></asp:SqlDataSource>
                        </td>
                                         <%-- <td>
                                                <asp:Label ID="lblfordate" runat="Server" Text="From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="175px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date from which you wish to view the bills for daily usage of ORIS. " AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>

                                            <td>
                                                <asp:Label ID="lbluntildate" runat="Server" Text="To Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="175px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date till which you wish to view the bills for daily usage of ORIS." AutoPostBack="true" >
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>--%>

                       
                        <td style="right: auto">

                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to show house occupancy history for selected Door No." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                            
                        </td>
                        
                    </tr>
                    

                </table>
               
                <table>
                    <tr>

                        <td style="width: 1200px; height: 185px; vertical-align: top;">
                            <telerik:RadGrid ID="rgOccupancyHistory" runat="server" AllowPaging="false" PageSize="50" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
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

                                         <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="New Status" DataField="OldStatus" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="New Status Date" DataField="Date" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                       
                                        <telerik:GridBoundColumn HeaderText="Old Status" DataField="OldStatus" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Old Status Date" DataField="OldStatusDate" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                       
                                         
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
