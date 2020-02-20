<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Slide_Test.aspx.cs" Inherits="Slide_Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

       <link href="themes/1/js-image-slider.css" rel="stylesheet" type="text/css" />
    <script src="themes/1/js-image-slider.js" type="text/javascript"></script>
    <link href="generic.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div id="sliderFrame" style="width:1400px;height:600px">
        <div id="slider" style="width:1400px;height:600px">
            <a href="http://www.menucool.com/javascript-image-slider" target="_blank">
                <img src="NatureHDImages/Nature_1_Converted.jpg" alt="Welcome to ORIS" />
            </a>
            <img src="NatureHDImages/Nature_2_Converted.jpg"  />  <%--alt=""--%>
            <img src="NatureHDImages/Nature_5_Converted.jpg"  /> <%--alt="Pure Javascript. No jQuery. No flash."--%>
            <img src="NatureHDImages/Nature_4_Converted.jpg" />   <%--alt="#htmlcaption" --%>
            <img src="NatureHDImages/Nature_5_Converted.jpg" />
               <%--<img src="NatureHDImages/Nature_6.jpg" />
               <img src="NatureHDImages/Nature_7.jpg" />
               <img src="NatureHDImages/Nature_8.jpg" />
               <img src="NatureHDImages/Nature_9.jpg" />
               <img src="NatureHDImages/Nature_10.jpg" />--%>
   
        </div>
        <%--<div id="htmlcaption" style="display: none;">
            <em>HTML</em> caption. Link to <a href="http://www.google.com/">Google</a>.
        </div>--%>
    </div>
    </div>
    </form>
</body>
</html>
