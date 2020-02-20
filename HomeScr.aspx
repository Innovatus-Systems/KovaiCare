<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="HomeScr.aspx.cs" Inherits="HomeScr" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <html xmlns="http://www.w3.org/1999/xhtml">


    <title></title>
    <link href="CSS/Home.css" rel="stylesheet" />
    <link href="CSS/metro.css" rel="stylesheet" />
    <link rel="icon" href="favicon.ico" type="image/x-icon">

    <link rel="stylesheet" href="css/jquery.popup.css" type="text/css">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery.popup.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".js__p_start, .js__p_another_start").simplePopup();
        });
    </script>




    <body>
        <div id="cnt">
            <div id="demo">
                <div class="metro">
                    <div class="metro-sections unselectable">
                        <div class="metro-section">

                            <%--  ----------------------------------------------------------------------%>
                            <a href="ResidentAdd.aspx">
                                <div class="tile tile-double bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Residents
                                            <asp:Label ID="lblResidentsCNT" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/RESIDENT.png" />

                                            <asp:Label ID="lbldipT3" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <div class="tile tile-double  bg-color-blueDark">
                                <div class="tile-content-main">
                                    <span class="tile-label">Owners Away 
                                        <asp:Label ID="lblOwnersAway" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White"></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <%--<img src="Images/oa1.png" />--%>
                                        <asp:ImageButton ID="ImgBHome" runat="server" Width="100px" Height="100px" ImageUrl="~/Images/oa1.png" OnClick="ImgBHome_Click" ToolTip="" />

                                        <asp:Label ID="Label2" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-blueDark">
                                </div>
                            </div>


                            <%--  ----------------------------------------------------------------------%>
                            <a href="SAlone.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Staying Alone
                                            <asp:Label ID="lblStayAlone" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/sa1.JPG" />
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <div class="tile tile-double  bg-color-blueDark">
                                <div class="tile-content-main">
                                    <span class="tile-label">
                                        <%--   <asp:Label ID="Label1" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White">Our World</asp:Label>--%>
                                        <asp:textbox id="txtsearch" runat="server" enabled="true" tooltip="Enter the resident name, which you want to search" visible="true" height="15px" font-names="verdana" font-size="Small" width="175px" forecolor="black"
                                            onfocus="if (this.value == '- Search -') this.value = '';" onblur="if (this.value == '') this.value = '- Search -';" value="- Search -" style="color: Gray; text-align: center;" xmlns:asp="#unknown"></asp:textbox>
                                        <%--onfocus="if (this.value == 'Search') this.value = '';" onblur="if (this.value == '') this.value = 'Search';" value="Search" style="border-top-left-radius: 10px; border-top-right-radius: 10px;border-bottom-left-radius: 10px;border-bottom-right-radius: 10px;color:Gray; text-align:center;" xmlns:asp="#unknown"--%>
                                    </span>
                                    <div class="tile-icon-large">
                                        <%--<img src="Images/oa1.png" />--%>
                                        <span class="tile-label"></span>
                                        <asp:ImageButton ID="ImgebtnGlobe" runat="server" Width="100px" Height="100px" ImageUrl="~/Images/globe2.png" OnClick="ImgebtnGlobe_Click" ToolTip="" />

                                        <asp:Label ID="Label3" runat="server" Text=" "> </asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-blueDark">
                                </div>
                            </div>


                            <%--  ----------------------------------------------------------------------%>
                            <a href="BirthdayGrid.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">

                                        <%--<span class="tile-label">Oncoming_birthdays 
                                            <asp:Label ID="Label20" runat="server" Text=" "></asp:Label></span>--%>
                                        <span class="tile-label">Birthdays     
                                            <asp:Label ID="lbldispbirthdays" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White"></asp:Label>
                                        </span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Cake4.jpg" />
                                            <%----%>
                                            <br />

                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="FoodBillPosting.aspx">
                                <div class="tile tile-double bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Food Billing 
                                            <asp:Label ID="Label5" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Food4.jpg" />

                                            <asp:Label ID="Label6" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="DailyFoodBillReport.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Transactions 
                                            <asp:Label ID="Label13" runat="server" Text=""></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/reports2.png" />

                                            <asp:Label ID="Label14" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <div class="tile tile-double  bg-color-blueDark">
                                <div class="tile-content-main">
                                    <span class="tile-label">Staff  
                                         <asp:Label ID="lblStaffList" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White"></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <%-- <img src="Images/Picture2.png" />--%>
                                        <asp:ImageButton ID="imagestaff" runat="server" Width="100px" Height="100px" ImageUrl="~/Images/Picture2.png" OnClick="imagestaff_Click" ToolTip=" Click here to see staff details." />

                                        <asp:Label ID="Label4" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-darken">
                                </div>
                            </div>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="ExitEntry.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <%-- <asp:Label ID="lblRCHOUT" runat="server" Font-Size="X-Small" Font-Names="Verdana" ForeColor="White" Visible="false"></asp:Label>--%>
                                        <span class="tile-label">CheckOut     
                                            <asp:Label ID="lblRCHOUT" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Security4.jpeg" />

                                            <asp:Label ID="Label8" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>

                            <a href="Charts.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Charts 
                                            <asp:Label ID="Label11" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/chart4.jpg" />

                                            <asp:Label ID="Label12" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="Error_Check.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Missing Data
                                            <asp:Label ID="Label19" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/MissingData.jpg" />

                                            <asp:Label ID="Label22" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                                                        
                            <div class="tile tile-double  bg-color-blueDark">
                                <div class="tile-content-main">
                                    <span class="tile-label">Settings 
                                        <asp:Label ID="Label15" runat="server" Text=" "></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <img src="Images/settings.png" />

                                        <asp:Label ID="Label16" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-darken">
                                </div>
                            </div>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="TaskList.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Task List
                                            <asp:Label ID="Label7" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Task3.jpg" />

                                            <asp:Label ID="Label9" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="ProfilePP.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Profile ++
                                        <asp:Label ID="Label10" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                           

                                            <asp:Label ID="Label17" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>

                            <%--  ----------------------------------------------------------------------%>
                            <a href="MonthlyBilling.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Billing Summary
                                            <asp:Label ID="Label20" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/MonthlyStatement.jpeg" />

                                            <asp:Label ID="Label23" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>

                            <%--  ----------------------------------------------------------------------%>
                            <a href="ResidentTxnSummary.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Monthly Billing Per Resident
                                        <asp:Label ID="Label1" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                           

                                            <asp:Label ID="Label18" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>

                            <%--  ----------------------------------------------------------------------%>
                             
                            <a href="MonthlyStatement.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Monthly Statement
                                        <asp:Label ID="Label21" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                           

                                            <asp:Label ID="Label24" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                             <%--  ----------------------------------------------------------------------%>
                             
                            <a href="FoodMenu.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Food Menu
                                        <asp:Label ID="Label25" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                           

                                            <asp:Label ID="Label26" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                             
                            <a href="ItemMaster.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Item Master
                                        <asp:Label ID="Label27" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                           

                                            <asp:Label ID="Label28" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <%--<div class="tile tile-double  bg-color-blueDark">
                                <div class="tile-content-main">
                                    <span class="tile-label">Bill & Transactions  
                                        <asp:Label ID="Label9" runat="server" Text=" "></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <img src="Images/BillndTxns.png" />

                                        <asp:Label ID="Label10" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-darken">
                                </div>
                            </div>--%>
                            <%--  ----------------------------------------------------------------------%>
                            <telerik:RadWindow ID="RW1CEGridView" VisibleOnPageLoad="false" BackColor="Black" ForeColor="White" Width="750px" Height="370px" runat="server">
                                <ContentTemplate>
                                    <div>
                                        <table>
                                            <tr>
                                                <td style="text-align: center; color: Black; background-color: yellow; font-family: Verdana; font-weight: 200; font-size: medium">Emergency Contacts</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="AllGridView1CE" runat="server"
                                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                                        CellSpacing="0" Width="100%" AllowFilteringByColumn="true"
                                                        MasterTableView-HierarchyDefaultExpanded="true">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                        </ClientSettings>
                                                        <GroupingSettings CaseSensitive="false" />
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

                                                                <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="true"
                                                                    ItemStyle-Wrap="false" AllowFiltering="false" Visible="True" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn HeaderText="DoorNo." DataField="RTVILLANO" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true" FilterControlWidth="30px" ItemStyle-Width="30px"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Status" DataField="SDescription" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Title" DataField="RTTitle" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>


                                                                <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="left"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="30px" ItemStyle-Width="30px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="In Case of Emergency" DataField="RAText" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="left"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="30px" ItemStyle-Width="30px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                            <%--<EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>--%>
                                                            <%--  <PagerStyle AlwaysVisible="True"></PagerStyle>--%>
                                                        </MasterTableView>
                                                        <%-- <ClientSettings>--%>
                                                        <%-- <Selecting AllowRowSelect="True" />--%>
                                                        <%-- </ClientSettings>
                                <FilterMenu Skin="WebBlue" EnableTheming="True">
                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                </FilterMenu>--%>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </ContentTemplate>
                            </telerik:RadWindow>

                        </div>
                    </div>
                </div>
            </div>
        </div>




    </body>
    </html>
</asp:Content>

