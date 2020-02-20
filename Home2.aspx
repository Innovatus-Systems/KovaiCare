<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home2.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

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



</head>
<body>
    <form id="form1" runat="server">

        <div id="Header-Main">

            <center>
                <h1>ORIS</h1>
                <asp:Label ID="lbloris" runat="server">Owner and Residents Information System for Senior Citizen's Gated Communities</asp:Label>                    
            </center>


            -
        </div>
        <div class="topbar1">
            <marquee behavior="scroll" scrollamount="2" direction="left" width="90%">
                <asp:Label ID="lbldispScollTopTXT" runat="server" Text=""></asp:Label>
            </marquee>
        </div>
        <div id="cnt">

            <div id="demo">

                <div class="metro">
                    <div class="metro-sections unselectable">
                        <div class="metro-section">

                            <a href="ResidentAdd.aspx">
                                <div class="tile tile-double tile-multi-content">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Residents
                                            <asp:Label ID="lblT1Desc3" runat="server" Text=" "></asp:Label></span>
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
                            <div class="tile tile-double  bg-color-green">
                                <div class="tile-content-main">
                                    <span class="tile-label">Owner Away  
                                        <asp:Label ID="Label1" runat="server" Text=" "></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <img src="Images/oa1.png" />

                                        <asp:Label ID="Label2" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-blueDark">
                                </div>
                            </div>



                            <%--  ----------------------------------------------------------------------%>
                            <div class="tile tile-double  bg-color-darken">
                                <div class="tile-content-main">
                                    <span class="tile-label">Staff  
                                        <asp:Label ID="Label3" runat="server" Text=" "></asp:Label></span>
                                    <div class="tile-icon-large">
                                        <img src="Images/Picture2.png" />

                                        <asp:Label ID="Label4" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                                <div class="tile-content-sub bg-color-darken">
                                </div>
                            </div>

                            <%--  ----------------------------------------------------------------------%>
                            <%--  <div class="tile bg-color-red">
                        <div class="tile-icon-large">
                            <img src="img/addons.jpg" />
                            <asp:Label ID="lbldipT1" runat="server" Text=""></asp:Label>
                            </div>
                        <span class="tile-label"> Add On's<asp:Label ID="lblT1Desc1" runat="server" Text=""></asp:Label></span>
                    </div>--%>
                            <a href="DailyFoodBillReport.aspx">
                                <div class="tile tile-double  bg-color-pink">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Reports  
                                            <asp:Label ID="Label13" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/reports2.png" />

                                            <asp:Label ID="Label14" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>










                            <a href="FoodBillPosting.aspx">
                                <div class="tile tile-double bg-color-purple">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Food Bill  
                                            <asp:Label ID="Label5" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/Picture1.png" />

                                            <asp:Label ID="Label6" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>

                            <%--  ----------------------------------------------------------------------%>
                            <a href="ExitEntry.aspx">
                                <div class="tile tile-double  bg-color-pink">
                                    <div class="tile-content-main">
                                        <asp:Label ID="lblRCHOUT" runat="server" Font-Size="X-Small" Font-Names="Verdana" ForeColor="White"></asp:Label>
                                        <span class="tile-label">CheckIn/CheckOut   
                                            <asp:Label ID="Label7" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/exitentry.png" />

                                            <asp:Label ID="Label8" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-blueDark">
                                    </div>
                                </div>
                            </a>


                            <%--  ----------------------------------------------------------------------%>
                            <div class="tile tile-double  bg-color-blueDark">
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
                            </div>

                            <%--  ----------------------------------------------------------------------%>
                            <a href="Charts.aspx">
                                <div class="tile tile-double  bg-color-blue">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Charts 
                                            <asp:Label ID="Label11" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/charts.png" />

                                            <asp:Label ID="Label12" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>




                            <div class="tile tile-double  bg-color-orange">
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


                            <%--<a href="BirthdayGrid.aspx">
                     <div class="tile tile-double  bg-color-red">
                        <div class="tile-content-main">
                            <span class="tile-label"> More  <asp:Label ID="Label17" runat="server" Text=" "></asp:Label></span>
                        <div class="tile-icon-large">
                             <img src="Images/more.png" />
                        
                            <asp:Label ID="Label18" runat="server" Text=" "></asp:Label>
                            </div>
                        </div>
                        <div class="tile-content-sub bg-color-darken">
                           
                        </div>
                    </div>
    </a>--%>


                            <a href="BirthdayGrid.aspx">
                                <div class="tile tile-double  bg-color-greenDark">
                                    <div class="tile-content-main">
                                        <span class="tile-label">Staying alone 
                                            <asp:Label ID="Label20" runat="server" Text=" "></asp:Label></span>
                                        <div class="tile-icon-large">
                                            <img src="Images/more.png" />

                                            <asp:Label ID="Label21" runat="server" Text=" "></asp:Label>
                                        </div>
                                    </div>
                                    <div class="tile-content-sub bg-color-darken">
                                    </div>
                                </div>
                            </a>
                            <%-- <div class="tile bg-color-greenDark">
                        <div class="tile-icon-large">
                            <img src="img/charts.png" />
                            <asp:Label ID="Label11" runat="server" Text=""></asp:Label>
                            </div>
                        <span class="tile-label">Charts <asp:Label ID="Label12" runat="server" Text=""></asp:Label></span>
                    </div>--%>











                            <%--                    <div class="tile bg-color-pink">
                        <div class="tile-icon-large">
                          <asp:Label ID="lbldipT2" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label" > <asp:Label ID="lblT1Desc2" runat="server" Text=" "></asp:Label></span>
                    </div>--%>




                            <%--                      <div class="tile bg-color-darken">
                        <div class="tile-icon-large">
                            <asp:Label ID="lbldipT4" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"> <asp:Label ID="lblT1Desc4" runat="server" Text=" "></asp:Label></span>
                    </div>

                  <div class="tile bg-color-purple">
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT5" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"> <asp:Label ID="lblT1Desc5" runat="server" Text=" "></asp:Label></span>
                    </div>

               

                     <div class="tile bg-color-green">
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT6" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc6" runat="server" Text=" "></asp:Label></span>
                    </div>--%>






                            <%--                      <div class="tile bg-color-darken">
                        <div class="tile-icon-large">
                            <asp:Label ID="lbldipT8" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc8" runat="server" Text=" "></asp:Label></span>
                    </div>
                    <div class="tile">
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT9" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc9" runat="server" Text=" "></asp:Label></span>
                    </div>
                  

                        <div class="tile bg-color-pink">
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT10" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc10" runat="server" Text=" "></asp:Label></span>
                    </div>--%>

                            <%-- <div class="tile tile-triple bg-color-purple">
                        <div class="tile-icon-large">
                            <asp:Label ID="lbldipT12" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc12" runat="server" Text=" "></asp:Label></span>
                    </div>--%>
                            <%--  <div class="tile bg-color-green">
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT13" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc13" runat="server" Text=" "></asp:Label></span>
                    </div>--%>

                            <%--     
                    <div class="tile">
                        <div class="tile-icon-large">
                            <asp:Label ID="lbldipT14" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc14" runat="server" Text=" "></asp:Label></span>
                    </div>

                 

                <div class="tile bg-color-darken">

                    
                        <div class="tile-icon-large">
                           <asp:Label ID="lbldipT15" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc15" runat="server" Text=" "></asp:Label></span>
                    </div>--%>

                            <%-- <div class="tile tile-triple-vertical bg-color-yellow">
                        <div class="tile-icon-large">
                            <img src="img/Music.png" />
                        </div>
                        <span class="tile-label">Music</span>
                    </div>
                    <div class="tile tile-quadro tile-triple-vertical bg-color-red">
                    </div>

                   <div class="tile bg-color-orange">Note
                         <div class="tile-icon-large">
                           <asp:Label ID="lbldipT16" runat="server" Text=" "></asp:Label></div>
                        <span class="tile-label"><asp:Label ID="lblT1Desc16" runat="server" Text=" "></asp:Label></span></div>--%>
                        </div>

                    </div>
                </div>
            </div>
            <div class="topbar1">
            </div>

        </div>
        <div class="footer">
            <asp:Label ID="Label19" runat="server">Innovatus Systems.All rights Reserved.</asp:Label>
        </div>
        <%--  <div class="showhim">
           <div class="showme">Hai</div>
           <div class="hideme">bye</div>
       
        <div class="">bye bye</div>--%>
        <%--     </div>--%>
    </form>

</body>

</html>
