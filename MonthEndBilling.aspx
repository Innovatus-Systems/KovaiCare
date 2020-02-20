<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MonthEndBilling.aspx.cs" Inherits="MonthEndBilling"  %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

  
    
    <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}

.centerdiv
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 128px;
}

    </style>

    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function OnClientItemsRequestedHandler(sender, eventArgs) {
            //set the max allowed height of the combo  
            var MAX_ALLOWED_HEIGHT = 220;
            //this is the single item's height  
            var SINGLE_ITEM_HEIGHT = 22;

            var calculatedHeight = sender.get_items().get_count() * SINGLE_ITEM_HEIGHT;

            var dropDownDiv = sender.get_dropDownElement();

            if (calculatedHeight > MAX_ALLOWED_HEIGHT) {
                setTimeout(
                    function () {
                        dropDownDiv.firstChild.style.height = MAX_ALLOWED_HEIGHT + "px";
                    }, 20
                );
            }
            else {
                setTimeout(
                    function () {
                        dropDownDiv.firstChild.style.height = calculatedHeight + "px";
                    }, 20
                );
            }
        }
    </script>

    <script type="text/javascript">


        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }

        
        function Validate1() {



            var result = confirm('Do you Process the data for month end bill?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }


        }
        function Validate() {



            var result = confirm('Do you want to generate the month end bill?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }


        }





    </script>
     <script type="text/javascript" language="javascript">
        function HideUpdateProgress() {
            var updateProgress = document.getElementById("<%=UpdateProgress1.ClientID%>");
            updateProgress.style.display = 'none';
            Sys.Application.remove_load(HideUpdateProgress);
        }
         </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
            <div class="main_cnt">
                <div class="first_cnt">
                      <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlUpdate">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="loading3.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
    <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
                    <div style="width: 100%; min-height: 500px;">
                        <table style="width: 100%;">

                            <tr>
                                <td align="center">
                                    <asp:HiddenField ID="hbtnRSN" runat="server" />
                                    <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                               
                            </tr>

                        </table>
                        <table style="width:80%" align="center">

                            <tr>
                                <td align="left">
                                     <asp:Label ID="Label1" Visible="true" Text="Billing for:" Font-Names="Verdana" ForeColor="Black" Font-Size="Smaller" runat="server" />
                                    <asp:Label ID="lblCurrentBillingMonth" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Smaller" runat="server" />
                                -
                                    <asp:Label ID="Label2" Visible="true" Text="Today :" Font-Names="Verdana"  ForeColor="Black" Font-Size="Smaller" runat="server" />
                                    <asp:Label ID="lbltodayis" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Smaller" runat="server" />

                                </td>

                            </tr>
                           <%-- <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label3" Visible="true" Text="Month end billing" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Smaller" runat="server" />
                                    <asp:RadioButton ID="rdobtnTrial" runat="server" Text="Trial" AutoPostBack="true" OnCheckedChanged="rdobtnTrial_CheckedChanged" ToolTip="You can execute this option as many times as possible to ensure all is well before the proper month end biling job is carried out." />
                                    <asp:RadioButton ID="rdobtnLive" runat="server" Text="Live" AutoPostBack="true" OnCheckedChanged="rdobtnLive_CheckedChanged" ToolTip="Caution!!!   Once you do the Live run, financial transactions will be generated for the residents for the billing month.  If you have missed any, only way is to post the missing entries manually. Hence be sure before you choose this option." />
                                </td>
                            </tr>--%>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label4" Visible="true" Text="Live Billing is only possible on:" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Smaller" runat="server" />
                                    <asp:Label ID="lblpossibleon" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Smaller" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                 <td>
                                    <asp:Button ID="btnPro" Font-Names="Verdana" CssClass="btn btn-success" ToolTip=" Click here to process all services." runat="server" Text="Process Txn.(s)" AutoPostBack="true"   BackColor="DarkGreen" Font-Bold="true" OnClick="btnPro_Click" />
                                
                                    <asp:Button ID="btnDashboard" Font-Names="Verdana" CssClass="btn btn-success" ToolTip=" Click here to get dashboard" runat="server" Text="Get Dashboard" AutoPostBack="true" Visible="true"   BackColor="DarkGreen" Font-Bold="true" OnClick="btnDashboard_Click" />
                                </td>
                            </tr>
                                    </table>
                                  
                      <table>
                          <tr>
                              <td align="center">
                                  <telerik:RadGrid ID="rgMonthEndBillDashboard" runat="server" AutoPostBack="true" OnItemCommand="rgMonthEndBillDashboard_ItemCommand"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true" AllowFilteringByColumn="true"
                                        CellSpacing="5" Width="80%" OnInit="rgMonthEndBillDashboard_Init" OnItemDataBound="rgMonthEndBillDashboard_ItemDataBound">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True"  SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                       
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            
                                            <Columns>
                                                 <telerik:GridBoundColumn HeaderText="Door No." DataField="DoorNo" HeaderStyle-Wrap="false" Display="true"
                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1" FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                  <telerik:GridBoundColumn HeaderText="" DataField="rtrsn" HeaderStyle-Wrap="false" Display="false"
                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px" 
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="" DataField="AccountCode" HeaderStyle-Wrap="false" Display="false"
                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px" 
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                               
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false" Display="true"
                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1"  FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" DataField="Status" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                                    ItemStyle-CssClass="Row1"  FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Mtce.Charges" DataField="MaintenanceCharge" HeaderStyle-Wrap="false" ItemStyle-Width="50px" 
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Monthly maintenance charges"  FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle> 
                                                     </telerik:GridBoundColumn> 
                                                <telerik:GridBoundColumn HeaderText="KOHD" DataField="KitchenOverheadCharges" HeaderStyle-Wrap="false" ItemStyle-Width="50px" 
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Kitchen Overhead charges"  FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Dining" DataField="Meals" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Sum of all A La Carte dining bills if any and regular dining."  FilterControlWidth ="50%">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="Service" DataField="Service" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Amount charged for various services. "  FilterControlWidth ="50%" >
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                      </telerik:GridBoundColumn>
                                             
                                                 <telerik:GridBoundColumn HeaderText="Nursing" DataField="NCCharges" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Amount charged for caregiver and nursing services. "  FilterControlWidth ="50%" >
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                      </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Water" DataField="WCCharges" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Amount charged for caregiver and nursing services. "  FilterControlWidth ="50%" >
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                      </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Telephone" DataField="TLCharges" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1" HeaderTooltip="Amount charged for caregiver and nursing services. "  FilterControlWidth ="50%" >
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                      </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Credits" DataField="Credits" HeaderStyle-Wrap="false" ItemStyle-Width="50px" Display="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" 
                                                    HeaderTooltip="All credits and payments made by the resident."  FilterControlWidth ="50%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                  <telerik:GridBoundColumn HeaderText="Outstanding" DataField="Outstand" HeaderStyle-Wrap="false" ItemStyle-Width="50px" Display="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" 
                                                    HeaderTooltip="Amount outstanding from the previous month bill"  FilterControlWidth ="50%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                               
                                            </Columns>
                                            
                                        </MasterTableView>
                                       
                                    </telerik:RadGrid>
                              </td>
                          </tr>
                      </table>
                        <%--<table>
                            <tr>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                     <asp:Button ID="BtnExcelExport" CssClass="btn btn-success" Width="125PX" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here to export grid details to excel." Visible="false" />
                                </td>
                            </tr>
                            
                        </table>--%>

                      

                        <table style="width:70%" align="center">
                            <tr>
                                <td align="right">
                                  <%--  <text style="font-family: Verdana; font-weight: bold; font-size: small;"> Billing Peroid :</text>
                                    &nbsp;
                                <asp:DropDownList ID="ddlBilling" ToolTip="Current billing period" runat="server" Width="150px" Height="25px" AutoPostBack="true" Enabled="false"></asp:DropDownList>
                                    &nbsp;&nbsp;&nbsp;--%>
                                     <asp:Button ID="btnProcess" Font-Names="Verdana" CssClass="btn btn-success" ToolTip=" Process the unbilled transactions" runat="server" Text="Process Unbilled"   BackColor="DarkGreen" Font-Bold="true" OnClick="btnProcess_Click" OnClientClick="javascript:return Validate1()"/>
                                    <asp:Button ID="btnSearch" Font-Names="Verdana" CssClass="btn btn-success" ToolTip="Click to raise the invoices and calculate the outstanding for the month" runat="server" Text="Raise Invoices" ForeColor="White" BackColor="DarkGreen" BorderColor="DarkGreen" Font-Bold="true" OnClick="btnSearch_Click" OnClientClick="javascript:return Validate()" />
                                    <asp:Button ID="btnStatus" Font-Names="Verdana" CssClass="btn btn-success" ToolTip="Click here to set previous month closing balance to current month opening balance and update billing period status." runat="server" Text="Next Billing Month" ForeColor="White" BorderColor="DarkGreen" BackColor="DarkGreen" Font-Bold="true" OnClick="btnStatus_Click" />                       
                                    <asp:Button ID="btnExit" Font-Names="Verdana" CssClass="btn btn-success" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="OrangeRed" BorderColor="OrangeRed" Font-Bold="true" OnClick="btnExit_Click"/>
           
                                </td>
                            </tr>
                            <tr style="height: 30px">
                            </tr>
                        </table>
                          



                       <%-- <table border="1" style="border-collapse: collapse; width: 100%; padding: 2px;display:block;" >--%>
                            <table  >
                            <tr>
                                <td style="width:10%">
                                    <asp:Label ID="Label5" Visible="false" Text="Residents" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="Total No.of Residents(OR,ORD,T,TD,OA,OAD)" />

                                </td>
                                <td style="width:60%">
                                    <asp:Label ID="lbltotalnoofresidents" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                                 <td style="width:10%">
                                    <asp:Label ID="Label10" Visible="false" Text="KOHD" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="This is only an alert msg. but will not stop month end billing" />

                                </td>
                                <td style="width:20%" >
                                    <asp:Label ID="lblkitchenoverheadcharges" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" Visible="false" Text="Bills(Invoices)" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="Bills are generated for OR,T,OA"  />

                                </td>
                                <td>
                                    <asp:Label ID="lbltotalnoofbills" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="Label11" Visible="false" Text="Service requests" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="This is only an alert msg. but will not stop month end billing" />

                                </td>
                                <td>
                                    <asp:Label ID="lblservicerequests" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label7" Visible="false" Text="Meals confirmation" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="Month end billing can be done only if all sessions in all days in the billing period are confirmed." />

                                </td>
                                <td>
                                    <asp:Label ID="lblmealsconfirmation" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server"  />
                                </td>
                                <td>
                                    <asp:Label ID="Label12" Visible="false" Text="Waivers" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="This is only an alert msg. but will not stop month end billing" />

                                </td>
                                <td>
                                    <asp:Label ID="lblwaivers" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label8" Visible="false" Text="Beverages confirmation" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="Month end billing can be done only if all sessions in all days in the billing period are confirmed." />

                                </td>
                                <td>
                                    <asp:Label ID="lblBeveragesconfirmation" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                                 <td>
                                    <asp:Label ID="Label13" Visible="false" Text="Credit balances" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="This is only an alert msg. but will not stop month end billing" />

                                </td>
                                <td>
                                    <asp:Label ID="lblcredietbalances" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label9" Visible="false" Text="Maintenance charges" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" ToolTip="This is only an alert msg. but will not stop month end billing" />

                                </td>
                                <td>
                                    <asp:Label ID="lblmaintenancecharges" Visible="false" Text="" Font-Names="Verdana" ForeColor="DarkBlue" Font-Size="XX-Small" runat="server" />
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            
                        </table>


                    </div>
               
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnProcess" />
             <asp:PostBackTrigger ControlID="btnDashboard" />
            <asp:PostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnExit" /> 
            <asp:PostBackTrigger ControlID="rgMonthEndBillDashboard" />
            <%--<asp:PostBackTrigger ControlID ="BtnExcelExport" />--%>
        </Triggers>
    </asp:UpdatePanel>
                     </div>
            </div>
   
</asp:Content>

