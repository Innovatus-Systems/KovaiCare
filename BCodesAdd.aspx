<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BCodesAdd.aspx.cs" Inherits="BCodesAdd" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

    var result = confirm('Are you sure want to Update?');

    if (result) {

        document.getElementById('<%=HResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
            }

}
        
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_cnt">
                <div class="first_cnt">
                    <table>
                           <tr>
                        <td>
                            <telerik:RadGrid ID="BillingCodeListView" runat="server" AllowPaging="False" PageSize="20"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                OnPageIndexChanged="BillingCodeListView_PageIndexChanged" OnItemCommand="BillingCodeListView_ItemCommand"
                                OnPageSizeChanged="BillingCodeListView_PageSizeChanged" OnSortCommand="BillingCodeListView_SortCommand"
                                CellSpacing="0" Width="70%" AllowFilteringByColumn="true"
                                MasterTableView-HierarchyDefaultExpanded="true">
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

                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Viewresident" SortExpression="View">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Lnkbtnnview" runat="server" ToolTip="Click here to View profile" Text="View" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnnview_Click">View</asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Lnkbtnnedit" runat="server" ToolTip="Click here to Edit profile" Text="Edit" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnnedit_Click">Edit</asp:LinkButton>
                                                <%--<asp:ImageButton ID="ImagBtnnEdit" Height="15px" ToolTip="Click here to Edit resident details" Width="25px" ImageUrl="~/App_Theme/edit-icon1.png" OnClick="ImagBtnnEdit_Click" runat="server" />--%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>                                     

                                        <telerik:GridBoundColumn HeaderText="#" DataField="RSN" HeaderStyle-Wrap="true" 
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="TRUE"  ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Wheat" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Billing Code" DataField="BCode" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" DataField="BCodeDescription" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Max Per Day" DataField="MaxPerDay" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Right" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                                                               
                                        <telerik:GridBoundColumn HeaderText="Rate" DataField="BCodeRate" HeaderStyle-Wrap="false" 
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Right" Visible="True" 
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn HeaderText="Help" DataField="BCodeHelp" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Category" DataField="BCodeCategory" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
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

                    
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblBCC" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                 <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                 <asp:DropDownList ID="ddlCategory" AutoPostBack="true" Width="150px" Height="30px" runat="server" ToolTip="Select Category for Billing."
                                     Font-Names="Calibri" Font-Size="Small" >
                                     <asp:ListItem Text ="--- Select ---" Value ="0"></asp:ListItem>
                               <%-- <asp:ListItem Text ="Adhoc" Value ="Adhoc"></asp:ListItem>--%>
                            <asp:ListItem Text ="Food" Value ="FOOD"></asp:ListItem>
                              <asp:ListItem Text ="Services" Value ="SERVICES"></asp:ListItem>      
                                                           </asp:DropDownList>
                            </td>
                            </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBCode" runat="Server" Text="Billing Code" ForeColor=" Black " Visible="true" Font-Names="Calibri" Font-Size="Small "></asp:Label>
                                 <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtBCode" runat="Server" MaxLength="8" ToolTip="*Enter the Billing Code" Width="150px" Height="25px" Visible="true" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBDescription" runat="Server" Text="Billing Code Description" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>

                            <td>
                                <asp:TextBox ID="TxtBCD" runat="Server" MaxLength="40" ToolTip="*Enter the Description about Billing Code."  Width="250px" Height="40px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMPD" runat="Server" Text="Max Per Day" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                             <asp:DropDownList ID="ddlMPD" AutoPostBack="true" Width="100px" Height="25px" runat="server" ToolTip="Select Maximum allowable.(If it is 9,No Limit.If it is 0,Linked to No.Of Occupants."
                                     Font-Names="Calibri" Font-Size="Small" >
                                     <asp:ListItem Text ="- Select -" Value ="00"></asp:ListItem>
                                <asp:ListItem Text ="0" Value ="0"></asp:ListItem>
                            <asp:ListItem Text ="1" Value ="1"></asp:ListItem>
                              <asp:ListItem Text ="2" Value ="2"></asp:ListItem>      
                            <asp:ListItem Text ="3" Value ="3"></asp:ListItem>
                                  <asp:ListItem Text ="4" Value ="4"></asp:ListItem>
                            <asp:ListItem Text ="5" Value ="5"></asp:ListItem>
                              <asp:ListItem Text ="6" Value ="6"></asp:ListItem>      
                            <asp:ListItem Text ="7" Value ="7"></asp:ListItem>
                                  <asp:ListItem Text ="8" Value ="8"></asp:ListItem>
                            <asp:ListItem Text ="9" Value ="9"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            <%--<td>
                                <asp:TextBox ID="TxtMPD" runat="Server" MaxLength="1" ToolTip=" Enter the Maximum Allowable per day."  Width="100px" Height="20px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>--%>
                        </tr>
                        <tr>

                            <td>

                                <asp:Label ID="lblBCR" runat="Server" Text="Rate" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                
                            </td>
                          
                            <td>
                             
                                <asp:TextBox ID="TxtBCR" runat="Server" MaxLength="7"  Width="150px" Height="25px" ToolTip="Enter the Rate for Billing." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <asp:Label ID="lblBCH" runat="Server" Text="Help" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtBCH" runat="Server" MaxLength="2400" ToolTip="Enter the help text about Billing." Width="300px" Height="50px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>                   
                       <%--                                               
                        <tr>
                            
                            <td>
                                <asp:TextBox ID="TxtBCC" runat="Server" MaxLength="8" ToolTip="Enter the Category of Billing. " Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>--%>
                        
                       
                       
                       
                       
                    </table>

                    <asp:HiddenField ID="HResult" runat ="server" />


                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnnSave" runat="Server" Width="100px" Text="Save" ToolTip="Clik here to save the details" ForeColor="White"  OnClientClick ="ConfirmMsg()" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Small" OnClick="btnnSave_Click1"  />
                            </td>
                            <%-- End of Button Save --%>
                            <%-- Button Clear --%>
                            <td>
                                <asp:Button ID="btnnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnnClear_Click" />
                            </td>
                            <%-- End of Button Clear --%>
                            <%-- Button Exit --%>
                            <td>
                                <asp:Button ID="btnnExit" runat="Server" Width="100px" Text="Exit" ToolTip="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnnExit_Click" />
                            </td>
                        </tr>
                    </table>
                     <telerik:RadWindow ID="RWBillingCodeView" VisibleOnPageLoad="false" BackColor="Black" ForeColor="Gray" Width="600px" Height="300px" runat="server">
                                <ContentTemplate>
                                  <div>
                                        <table>
                                            <tr>
                                               <td style="text-align: center; color: darkcyan ;font-family: Calibri; font-size: medium"> Billing Code Details</td>


                                            </tr>
                                            <tr>

                                                <td style="text-align: left">
                                                    <asp:Label ID="LBLRSN" runat="Server" Text="RSN" Visible="false" ForeColor="DarkBlue" Font-Bold="True" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>  </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LBLRSN1" runat="Server" Text="" Visible="false"   ForeColor="Black" Font-Bold="True" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCode2" runat="Server" Text="Billing Code" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCode1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBDESC2" runat="Server" Text="Description" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblDESC1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>                                            
                                                 </tr>
                                             <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblMPD2" runat="Server" Text="Max Per Day" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblMPD1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCR2" runat="Server" Text="Rate" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCR1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>                                            
                                                 </tr>
                                             <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCH2" runat="Server" Text="Help" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCH1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCC2" runat="Server" Text="Category" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td> : </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="LblBCC1" runat="Server"  ForeColor="Black" Font-Bold="false" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>                                            
                                                 </tr>
                                             
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </telerik:RadWindow>

         </div>
        </div>









</asp:Content>

