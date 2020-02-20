<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Healthchart.aspx.cs" Inherits="Healthchart" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <script type="text/javascript">
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();
            var navigateUrl = item.get_navigateUrl();
            //alert(navigateUrl);
            if (navigateUrl == "#") {
                NavigateNewComplaints();
            }
            //if (navigateUrl && navigateUrl != "#") {
            //    var proceed = confirm("Click yes to proceed to" + navigateUrl);
            //}
            //if (!proceed) {
            //    eventArgs.set_cancel(true);
            //}
            //else {
            //    eventArgs.set_cancel(false);
            //}
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .btn {
            color: white;
            background-color: darkblue;
        }

        .Grid {
            width: 350PX;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Calibri;
            color: #474747;
        }

            .Grid td {
                padding: 2px;
                border: solid 1px #c1c1c1;
            }

            .Grid th {
                padding: 4px 2px;
                color: #fff;
                text-align:left;
                background: darkblue url(Images/grid-header.png) repeat-x top;
                border-left: solid 1px #525252;
                font-size: 0.9em;
            }

            .Grid .alt {
                background: #fcfcfc url(Images/grid-alt.png) repeat-x top;
            }

            .Grid .pgr {
                background: #363670 url(Images/grid-pgr.png) repeat-x top;
            }

                .Grid .pgr table {
                    margin: 3px 0;
                }

                .Grid .pgr td {
                    border-width: 0;
                    padding: 0 6px;
                    border-left: solid 1px #666;
                    font-weight: bold;
                    color: #fff;
                    line-height: 12px;
                }

                .Grid .pgr a {
                    color: Gray;
                    text-decoration: none;
                }

                    .Grid .pgr a:hover {
                        color: #000;
                        text-decoration: none;
                    }
    </style>
    <div>

        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
             <table>
              <tr>
                <td style="padding-left:1220px">
                     <telerik:RadMenu Font-Names="verdana" Width="110px" OnClientItemClicking="onClicking" ForeColor="Green" ID="rmenuQuick" runat="server" ShowToggleHandle="false"  EnableRoundedCorners="true" EnableShadows="true" ClickToOpen="false" ExpandAnimation-Type="OutBounce" Flow="Vertical" DefaultGroupSettings-Flow="Horizontal"> 
                            <Items>
                                <telerik:RadMenuItem Font-Names="Verdana" PostBack="false" Text="Quick Links" ExpandMode="ClientSide" ToolTip="Click here to view quick links" Width="110px">
                                    <Items>
                                        <telerik:RadMenuItem Width="75px" Font-Bold="false" Text="Age Chart" NavigateUrl="Age.aspx" ToolTip="Click here to view the Age Chart" PostBack="false"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black"  BackColor="Transparent" Text="Health Chart" NavigateUrl="Healthchart.aspx" ToolTip="Click here to view the Age Chart"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="120px" Font-Bold="false" ForeColor="Black"  BackColor="Transparent" Text="Residence Chart" NavigateUrl="ResidentChart.aspx" ToolTip="Click here to view the Age Chart"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="90px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="P++ Chart" NavigateUrl="PPlucsChart.aspx" ToolTip="Click here to view the Age Chart"></telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenuItem>                               
                            </Items>      
                        </telerik:RadMenu>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td style="width: 50%;">
                    <asp:GridView ID="grdview" runat="server" CssClass="Grid"></asp:GridView>
                </td>
                <td style="width: 50%;">
                    <asp:Literal ID="ltrscr" runat="server"></asp:Literal>
                    <div id="chart_div" style="width: 1000px; height: 550px;">
                    </div>
                </td>
            </tr>

            <tr>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
            </tr>
        </table>

    </div>
</asp:Content>

