<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="AttribLkUpAdd.aspx.cs" Inherits="AttribLkUpAdd" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });


        
       function Validate() {
           var summ = "";
           summ += Group();
           summ += ProfileCode();
           summ += Description();

           
           if (summ == "") {
               var result = confirm('Are you sure, you want to save?');

               if (result) {

                   document.getElementById('<%=Confirm.ClientID%>').value = "true";
               }
               else {
                   document.getElementById('<%=Confirm.ClientID%>').value = "false";
               }
           } else {
               alert(summ);
               return false;
           }
       }
        function Group() {
            var Group = document.getElementById('<%= ddlGroup.ClientID %>').value;
            if (Group == "-- Select --") {
                return "Please select a group." + "\n";
            } else {
                return "";
            }
        }

        function ProfileCode() {
            var ProfileCode = document.getElementById('<%= RACode.ClientID %>').value;
            if (ProfileCode == "") {
                return "Please enter the profile code." + "\n";
            } else {
                return "";
            }
        }

        function Description() {
            var Description = document.getElementById('<%= RADescription.ClientID %>').value;
            if (Description == "") {
                return "Please enter the description.";
            } else {
                return "";
            }
        }

        function ConfirmMsg() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=Confirm.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=Confirm.ClientID%>').value = "false";
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
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 90%; min-height: 400px">

                <table>
                    <%-- <tr>
                    <td>
                        <asp:Label ID="lblRBRSN" runat="Server" Text="RSN" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RBRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                    <tr>
                        <td style="width: 500px">
                            
                           <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                        <td>
                            <asp:Label ID="lblaphelp" runat="server" Text="Master reference codes which will be used when preparing the full profile of a resident.  More you add, more complete the profile will be.  You can define your reference codes also." Font-Names="verdana" Font-Size="Small"></asp:Label>

                        </td>

                    </tr>




                    <%--<tr>
                    <td>
                        <asp:Label ID="lblEntryBy" runat="Server" Text="EntryBy" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="EntryBy" runat="Server" MaxLength="8" ToolTip=" ML8." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                    <%-- <tr>
                    <td>
                        <asp:Label ID="lblEntryDate" runat="Server" Text="EntryDate" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="EntryDate" runat="Server" MaxLength="20" ToolTip=" ML." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                    <%-- <tr>
                    <td>
                        <asp:Label ID="lblModifiedBy" runat="Server" Text="ModifiedBy" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="ModifiedBy" runat="Server" MaxLength="8" ToolTip=" ML8." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                    <%-- <tr>
                    <td>
                        <asp:Label ID="lblModifiedDate" runat="Server" Text="ModifiedDate" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                    </td>--%>
                    <%--     <td>
                        <asp:TextBox ID="ModifiedDate" runat="Server" MaxLength="20" ToolTip=" ML." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                </table>

                <%-- <table>
                <tr>
                    <td>
                        <asp:GridView ID="gvtblRAttribLkUp" runat="server" AllowPagin="true" PageSize="10"
                            Font-Names="Calibri " Font-Size=" Small" ForeColor="DarkBlue " AutoGenerateColumns="True">
                            <Columns>
                                <asp:TemplateField HeaderText=" V/E " HeaderStyle-BackColor="DarkBlue" HeaderStyle-ForeColor=" White"
                                    ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" AlternateText=" Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                            CommandName=" Select " />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="" DataField="RBRSN" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="18px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="RACode" DataField="RACode" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="8px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="Description" DataField="RADescription" ReadOnly="true"
                                    HeaderStyle-BackColor="DarkBlue" HeaderStyle-ForeColor="White" ItemStyle-Width="40px"
                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="Remarks" DataField="RARemarks" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="240px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="EntryBy" DataField="EntryBy" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="8px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="EntryDate" DataField="EntryDate" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="ModifiedBy" DataField="ModifiedBy" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                    HeaderStyle-ForeColor="White" ItemStyle-Width="8px" HeaderStyle-HorizontalAlign="Left"
                                    ItemStyle-Font-Names="Ariel" />
                                <asp:BoundField HeaderText="ModifiedDate" DataField="ModifiedDate" ReadOnly="true"
                                    HeaderStyle-BackColor="DarkBlue" HeaderStyle-ForeColor="White" ItemStyle-Width="20px"
                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Ariel" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>--%>



                <asp:UpdatePanel ID="UPNLGrid" runat="server">
                    <ContentTemplate>

                        <table>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="AttbtsLkUpgrdView" runat="server" 
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true"
                                        OnPageIndexChanged="AttbtsLkUpgrdView_PageIndexChanged" OnItemCommand="AttbtsLkUpgrdView_ItemCommand"
                                        OnPageSizeChanged="AttbtsLkUpgrdView_PageSizeChanged" OnSortCommand="AttbtsLkUpgrdView_SortCommand"
                                        CellSpacing="20" Width="95%"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnInit="AttbtsLkUpgrdView_Init">
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings>
                                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
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
                                                <telerik:GridBoundColumn HeaderText="#" DataField="RBRSN" HeaderStyle-Wrap="false" Display="false"
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
                                                <telerik:GridBoundColumn HeaderText="High Priority" DataField="Priority" HeaderStyle-Wrap="true"
                                                    ItemStyle-Wrap="true" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px" FilterControlWidth="45px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="true"></HeaderStyle>
                                                    <ItemStyle Wrap="true"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Profile Code" DataField="RACode" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" DataField="RADescription" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="RARemarks" HeaderStyle-Wrap="false" ItemStyle-Width="200px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="true"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="EditLkUp" SortExpression="Edit">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit Profile Code." Text="Edit" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>

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
                    </ContentTemplate>

                </asp:UpdatePanel>

                <asp:HiddenField ID="Confirm" runat="server" />
            </div>
            <asp:LinkButton ID="lnkAddnew" Visible="false" ForeColor="#048080" runat="server" AutoPostback="true" Text="" Font-Size="Medium" Font-Bold="true" ToolTip="" OnClick="lnkAddnew_Click"></asp:LinkButton>
            <div id="divAddNewItem" runat="server" visible="false">
                <table>

                    <tr>

                        <td>
                            <asp:Label ID="lblGroup" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlGroup" Width="200px" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Select a 'Group' from the list shown."
                                OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                            </asp:DropDownList>
                            <%-- <asp:TextBox ID="RTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                        </td>
                    </tr>



                    <tr>
                        <td>
                            <asp:Label ID="lblRACode" runat="Server" Text="ProfileCode" ForeColor=" Black " Font-Names="Calibri"
                                Font-Size="Small"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="RACode" runat="Server" MaxLength="8" ToolTip="Code of the additional.Unique Ref Code. ML8." Width="150px" CssClass="form-controlForResidentAdd"
                                ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblpriority" runat="Server" Text="High Priority" Width="100px" ForeColor=" Black " Font-Names="Calibri"
                                Font-Size="Small"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlpriority" Width="200px" CssClass="form-controlForResidentAdd" runat="server" ToolTip="If Yes will  appear at the top of the list. Default is No."
                                Font-Names="Calibri" Font-Size="Small">
                                <asp:ListItem Value="N">No</asp:ListItem>
                                <asp:ListItem Value="Y">Yes</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblRADescription" runat="Server" Text="Description" ForeColor=" Black "
                                Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="RADescription" runat="Server" MaxLength="40" ToolTip="Describe the Profile Code in brief." Width="300px" CssClass="form-controlForResidentAdd"
                                ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblRARemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Calibri"
                                Font-Size="Small"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="RARemarks" runat="Server" MaxLength="480" ToolTip="You can describe the Profile Code in more detail here." Width="400px"
                                ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline"
                                CssClass="form-controlForResidentAdd" Height="70px"></asp:TextBox>
                        </td>



                    </tr>

                </table>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnSave" runat="Server" Width="100px" Text="Save" ToolTip="Click here to save the details."
                                ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" CssClass="btn" OnClientClick="javascript:return Validate()" Font-Size="Small" OnClick="btnSave_Click" />
                        </td>
                        <%-- End of Button Save --%>
                        <%-- Button Clear --%>
                        <td>
                            <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" CssClass="btn" ToolTip=" Click here to clear entered details."
                                ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                        </td>
                        <%-- End of Button Clear --%>
                        <%-- Button Exit --%>
                        <td>
                            <asp:Button ID="btnExit" runat="Server" Width="100px" CssClass="btn" Text="Return" ToolTip="Click here to Return."
                                ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                        </td>
                    </tr>
                </table>
            </div>


        </div>
    </div>

    <%--<div style="margin-top: -6%;"></div>--%>
</asp:Content>

