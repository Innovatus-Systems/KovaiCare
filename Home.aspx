<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="HomePage" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .lblStyle1 {
            color: Black;
            font-family: Verdana;
            font-size: 13px;
        }

        .ButtonInfi {
            background-color: #38ACEC;
            width: 75px;
            height: 27px;
            padding: 5px;
            color: white;
            cursor: pointer;
            text-align: center;
            align-self: flex-start;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            behavior: url(/border-radius.htc);
            border-radius: 5px;
        }



        .TableBorder {
            border-bottom-style: ridge;
            border-bottom-color: Gray;
            border-bottom-width: thin;
            border-top-style: ridge;
            border-top-color: Gray;
            border-top-width: thin;
            border-left-style: ridge;
            border-left-color: Gray;
            border-left-width: thin;
            border-right-style: ridge;
            border-right-color: Gray;
            border-right-width: thin;
        }

        .bgimage {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .txtbox {
            padding: 4px 2px;
            border: solid 1px #AAA;
            display: inline-block;
            border-radius: 8px;
        }
    </style>

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>

    <link href="CSS/Home.css" rel="stylesheet" />
    <link href="CSS/HomeSPD.css" rel="stylesheet" />
    <link href="CSS/metro.css" rel="stylesheet" />
    <link href="CSS/MenuCSS.css" rel="stylesheet" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="css/jquery.popup.css" type="text/css" />
    <html xmlns="http://www.w3.org/1999/xhtml">

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
                        <div class="metro-section" style="width: 100%">

                            <asp:Panel ID="Panel1" runat="server" Width="100%" HorizontalAlign="Center" BackColor="#F0F0F0" DefaultButton="btnSearch">

                                <asp:Label ID="Label6" runat="server" Font-Size="Small" Text="Resident name search" Font-Names="Verdana" ForeColor="Black" Visible="true"></asp:Label>
                                &nbsp;
                                <asp:TextBox ID="txtNSearch" runat="server" Font-Size="Small" Font-Names="Calibri" Style="width: 300px; background-color: palegoldenrod" BorderStyle="Outset" BorderWidth=".1px" Font-Bold="false" ForeColor="Black" ToolTip="Press Enter key or Search button to Search"></asp:TextBox>
                                &nbsp;&nbsp;                    
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" Font-Size="Small" CssClass="ButtonRC" OnClick="BtnSearch_Click" ToolTip="Enter minimum of four letters of resident name to view a list of residents matching the criteria." />
                                <asp:Button ID="btnScoreboard" runat="server" Text="Snapshot" Font-Size="Small" CssClass="ButtonInfi" OnClick="btnScoreboard_Click" ToolTip="Click here to view the general information." />
                            </asp:Panel>
                        </div>
                        <div class="metro-section">

                            <%--  ----------------------------------------------------------------------%>
                            <a href="ResidentAdd.aspx">
                                <div class="tile tile-double bg-color-orange">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Residents
                                            <asp:Label ID="Label25" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/RESIDENT.png" title="Click here to view detailed resident's profile." />

                                            <asp:Label ID="Label26" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="FoodMenu.aspx">
                                <div class="tile tile-double bg-color-green">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Kitchen Planner
                                            <asp:Label ID="Label29" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/KPlanner.jpg" title="Click here to plan a food schedule." />
                                            <asp:Label ID="Label30" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="TransactionLevelInd.aspx">
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Billing & Receipts
                                            <asp:Label ID="Label31" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                                            <img src="Images/MonthlyStatement.jpeg" title="Click here to post a transaction or view a bill. " />

                                            <asp:Label ID="Label32" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                    post
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="ExitEntry.aspx">
                                <div class="tile tile-double  bg-color-blue">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Care & Safety
                                            <asp:Label ID="Label33" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Care3.jpg" title="Click here for extended care and support." />

                                            <asp:Label ID="Label34" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="DayCalendar.aspx">
                           <%-- <a href="TaskList.aspx?Value=0">--%>
                                <div class="tile tile-double  bg-color-blueDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">ToDo List
                                            <asp:Label ID="Label35" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Task3.jpg" title="Click here to track or assign a work schedule." />

                                            <asp:Label ID="Label36" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="DailyFoodBillReport.aspx">
                                <div class="tile tile-double bg-color-blue">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Reports
                                            <asp:Label ID="Label37" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/reports2.png" title="Click here to view the history of transactions." />

                                            <asp:Label ID="Label38" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="Charts.aspx">
                                <div class="tile tile-double bg-color-orange">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Charts
                                            <asp:Label ID="Label39" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/chart5.jpg" title="Click here to view segregated statistics of the entire community." />

                                            <asp:Label ID="Label40" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                            <a href="Admin.aspx">
                                <div class="tile tile-double  bg-color-green">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Settings
                                            <asp:Label ID="Label1" runat="server" Font-Size="Small" Font-Names="Verdana" ForeColor="White" Visible="true"></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/settings.png" title="Click here to manage the settings." />

                                            <asp:Label ID="Label2" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>
                            <%--  ----------------------------------------------------------------------%>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <br />
        <div style="width: 100%">
            <table border="1" style="width: 100%">
                <tr style="background-color: #F0E68C">
                    <td style="width: 25%; height: 5px; align-items: center">
                       <asp:Label ID="lblResidentCnt" runat="server" ForeColor="Black" CssClass="lblStyle1" ToolTip="Shows count of residents in the community as of now."></asp:Label></td>

                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblVacantCnt" runat="server" ForeColor="Black" Text="" CssClass="lblStyle1"></asp:Label></td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblCheckedOutCnt" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>
                        <asp:Label ID="Label4" Text="/" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>
                        <asp:LinkButton ID="lblAlerts" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblAlerts_Click" ToolTip=" Shows no. of residents who are away from the community for more than four hours. Check if they need any assistance." Font-Underline="false"></asp:LinkButton>
                    </td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblLivingAloneCnt" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>
                </tr>
                <tr style="background-color: #FFFFF0">
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblBilled" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>

                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblOutstanding" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>

                    </td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblUnBilled" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>
                    <td style="width: 25%; height: 5px">
                        <asp:LinkButton ID="lblTasks" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblTasks_Click" ToolTip="Shows count of tasks which are still to be completed." Font-Underline="false"></asp:LinkButton>
                        <asp:Label ID="Label5" Text="/" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>

                        <asp:LinkButton ID="lblOverduetasks" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblTasks_Click" ToolTip="Shows count of tasks which are in Overdue." Font-Underline="false"></asp:LinkButton>

                    </td>
                </tr>
            </table>
        </div>
        <%-- <br />--%>
        <div class="metro-section" style="width: 100%">
            <asp:Panel ID="Panel2" runat="server" Width="100%" HorizontalAlign="left" BorderColor="Wheat" BorderStyle="Inset" BorderWidth=".5px">
                <table>
                    <tr>
                        <%--<td style="width: 45px"></td>--%>
                        <td>
                            <asp:Label ID="lblRecentCr" Height="10px" Font-Size="X-Small" ForeColor="Gray" runat="server"></asp:Label>
                            <asp:Label ID="lblRecentDr" Height="10px" Font-Size="X-Small" ForeColor="Gray" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div>


            <asp:Panel ID="Panel4" runat="server" Width="100%" HorizontalAlign="Center" BackColor="White">
                <marquee>
                         <asp:Label ID="lblDayMsg" Height="10px" Font-Size="Medium"  ForeColor="Red" runat="server"  Text="" Font-Names="Calibri" ></asp:Label>
                </marquee>
            </asp:Panel>

        </div>



    </body>
    </html>



</asp:Content>


