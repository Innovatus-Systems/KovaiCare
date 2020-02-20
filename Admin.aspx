<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
   <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
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

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=HRResult.ClientID%>').value = "true";
    }
    else {
        document.getElementById('<%=HRResult.ClientID%>').value = "false";
    }

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width:100%; min-height: 400px">
                <table align="center" style="width:100%;">
                    <tr>
                        <td align="center">
                           
                           <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                    </tr>

                    </table>
                <table align="center" style="width:100%;">
                    <tr>
                        <td align="center">
                            <table align="center">
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl1" runat="server" Font-Size="Medium" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                         <asp:Label ID="lbl2" runat="server" Font-Size="Medium" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl3" runat="server" Font-Size="Medium" Text="-"></asp:Label>
                                    </td align="center">
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl4" runat="server" Font-Size="Medium" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl5" runat="server" Font-Size="Medium" Text="-"></asp:Label>
                                    </td>
                                </tr>
                            </table>                        
   
                        </td>
                    </tr>
                    </table>
                <table>
                    <tr>
                        <td>
                            <%--<telerik:RadGrid ID="AdmingrdView" runat="server" AllowPaging="True" PageSize="10"
                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" 
                     OnPageIndexChanged="AdmingrdView_PageIndexChanged" OnItemCommand="AdmingrdView_ItemCommand"
                    OnPageSizeChanged="AdmingrdView_PageSizeChanged"     OnSortCommand="AdmingrdView_SortCommand" 
                    CellSpacing="20" Width="100%" height="400px" 
                    MasterTableView-HierarchyDefaultExpanded="true">
                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                    </HeaderContextMenu>
                     <GroupingSettings CaseSensitive="false" />
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
                             <telerik:GridBoundColumn HeaderText="#" DataField="RSN" HeaderStyle-Wrap="false" Visible="true"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50PX"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn> 
                            <telerik:GridBoundColumn HeaderText="Community Name" DataField="CommunityName" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>                           
                            <telerik:GridBoundColumn HeaderText="From ID" DataField="FromID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="From Mobile No" DataField="FromMobileNo" HeaderStyle-Wrap="false" 
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Contact Person Name" DataField="ContactPName" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Billing Period From" DataField="BPFrom" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn HeaderText="Till" DataField="BPTill" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Message" DataField="scrollmsg" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="EditLkUp" SortExpression="Edit">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit Admin Details" Text="Edit" Font-Bold="true" Font-Size="Small" ForeColor="Blue"  OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>
                                               
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
                </telerik:RadGrid>--%>

                            <table>

                                <tr>
                                    <td>
                                        <asp:Label ID="lblCName" Width="170px" runat="Server" Text="Licensed for" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                        <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtCommunityName" ForeColor=" DarkBlue" runat="Server" MaxLength="80" ToolTip="Name of the Senior Citizen Community for whom ORIS is licensed." Width="250px" CssClass="form-controlForResidentAdd"
                                            Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                    <td rowspan="3" style="vertical-align: top; width: 200px"></td>
                                    <td rowspan="3" style="vertical-align: top">
                                        <asp:Label ID="lblaphelp" runat="server" Text="ORIS helps save cost, improve cash flow and supports the Retirement Community Management to provide excellent care and service." Font-Names="verdana" Font-Size="Small"></asp:Label>

                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="Server" Text="Community Name" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCommnunityName" runat="Server" MaxLength="80" ToolTip="" Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="Server" Text="Address1" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress1" runat="Server" MaxLength="80" ToolTip="" Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label8" runat="Server" Text="Address2" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress2" runat="Server" MaxLength="80" ToolTip="" Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="Server" Text="City" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCity" runat="Server" MaxLength="80" ToolTip="" Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label10" runat="Server" Text="Pincode" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPincode" runat="Server" MaxLength="80" ToolTip="" Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFromID" runat="Server" Text="Master Email ID" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtFromID" runat="Server" MaxLength="80" ToolTip="This is the ID from which all Emails will be sent out." Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFromMobileNo" runat="Server" Text="Master Mobile No" ForeColor=" Black "
                                            Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtFromMobileNo" runat="Server" MaxLength="80" ToolTip=" This is the Cell No used for sending SMS Text if there is a SMS Gateway." Width="250px"  CssClass="form-controlForResidentAdd"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblContactPName" runat="Server" Text="Contact Person Name" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtContactPName" runat="Server" MaxLength="80" ToolTip="Name of the retirement community's contact person" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblScrollmessage" runat="Server" Text="Scroll message" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtscrollmessage" runat="Server" MaxLength="80" ToolTip="This is the message that will scroll at the bottom of the Home Page." Width="250px" TextMode="MultiLine"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                             CssClass="form-controlForResidentAdd" Height="60px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="Server" Text="Status" ForeColor="Black" Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtStatus" runat="Server" MaxLength="80" Width="250px"
                                            ForeColor="DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                             CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="Server" Text="Upto Date" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUptodate" runat="Server" MaxLength="80" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                             CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="Server" Text="Version Number" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtversionnumber" runat="Server" MaxLength="80" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        <asp:Label ID="Label4" runat="Server" Text="Billing Type" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlBillingType" runat="server" Font-Names="Calibri" Width="250px" ToolTip="This value is set at system implementation time based on the business rules followed in the retirement community.">
                                            <asp:ListItem Text ="Session Based" Value="S"></asp:ListItem>
                                            <asp:ListItem Text ="Menu Item Based" Value="M"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label5" runat="Server" Text="Billing Frequency" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlBillingFrequency" runat="server"  Font-Names="Calibri" Width="250px" ToolTip="This value is set at system implementation time based on the business rules followed in the retirement community.">
                                            <asp:ListItem Text ="Immediate" Value="I"></asp:ListItem>
                                            <asp:ListItem Text ="End of Month" Value="E"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <asp:Label ID="Label11" runat="Server" Text="Rate/Meal" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRatepermeal" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <asp:Label ID="Label12" runat="Server" Text="No.of.Meals/Day" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtnoofmealsperday" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label13" runat="Server" Text="Min.No.of Meals" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtminnoofmeals" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label14" runat="Server" Text="Rate Exception" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRateException" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label15" runat="Server" Text="House Keeping Rate/Sqft" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txthousekeepingratepersqft" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label18" runat="Server" Text="Kitchen overhead charges tax" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtkoht" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td>
                                        <asp:Label ID="Label17" runat="Server" Text="Monthly maintenance Charge" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtmmcg" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label16" runat="Server" Text="Monthly maintenance Charges tax" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtmmct" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                 </tr>
                                  <tr>
                                    <td>
                                        <asp:Label ID="Label19" runat="Server" Text="Service Tax" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txttaxs" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                 </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label20" runat="Server" Text="Cab Service Tax" ForeColor=" Black " Font-Names="Calibri"
                                            Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txttaxc" runat="Server" MaxLength="80" ToolTip="" Width="250px"
                                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Enabled="false"
                                            Height="30px"></asp:TextBox>
                                    </td>
                                 </tr>--%>
                               


                                <asp:HiddenField ID="HiddenField1" runat="server" />

                            </table>

                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlAdd" runat="server" Visible="true">
                    <table>


                        <%--<tr>
                    <td>
                        <asp:Label ID="lblNBD" runat="Server" Text="Next Billing Date" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <telerik:RadDatePicker ID="NextBDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Next  Billing Date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ></DatePopupButton>
                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
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
                   
                </tr>--%>
                        <asp:HiddenField ID="HRResult" runat="server" />

                    </table>

                </asp:Panel>

                <asp:Panel ID="pnlbtn" runat="server" Visible="true">
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnSave" runat="Server" Width="100px" Text="Save" ToolTip="Clik here to save the details."
                                    ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" OnClientClick="ConfirmMsg()" Font-Size="Small" OnClick="btnSave_Click" />
                            </td>
                            <%-- End of Button Save --%>
                            <%-- Button Clear --%>
                            <td>
                                <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details."
                                    ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                            </td>
                            <%-- End of Button Clear --%>
                            <%-- Button Exit --%>
                            <td>
                                <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Exit" ToolTip="Clik here to Exit."
                                    ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>

</asp:Content>

