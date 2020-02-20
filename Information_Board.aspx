<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Information_Board.aspx.cs" Inherits="Information_Board" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
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

    </script>

    <div class="main_cnt">

        <div class="first_cnt">

            <div>
                <right>

               
                <table>
                    <tr>
                        <td>
                             <telerik:RadMenu ID="RMResident" runat="server" Skin="" Width="250px" OnItemClick="RMResident_ItemClick" style="z-index:2900"  >
                                    
                                    <Items>
                                       

                                        <telerik:RadMenuItem runat="server"  Text="Residents" CssClass="main_menu">
                                            <Items>
                                                 <telerik:RadMenuItem runat="server" width="240px"  Text="Residents" CssClass="level_menu">
                                                </telerik:RadMenuItem>
                                                   <telerik:RadMenuItem runat="server" width="240px"  Text="Living Alone" CssClass="level_menu ">
                                                </telerik:RadMenuItem>   
                                                 <telerik:RadMenuItem runat="server" width="240px"  Text="Owners Away" CssClass="level_menu">
                                                </telerik:RadMenuItem> 
                                                 <telerik:RadMenuItem runat="server" width="240px"  Text="Information Board" CssClass="level_menu">
                                                </telerik:RadMenuItem>                                            
                                               <%-- <telerik:RadMenuItem runat="server" width="240px"  Text="Vacant" CssClass="level_menu ">
                                                </telerik:RadMenuItem>--%>
                                               
                                                <telerik:RadMenuItem runat="server" width="240px"  Text="Staff & Others" CssClass="level_menu ">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" width="240px"  Text="Previous Tenants" CssClass="level_menu ">
                                                </telerik:RadMenuItem>                                                
                                                <telerik:RadMenuItem runat="server" width="240px"  Text="Profile ++" CssClass="level_menu ">
                                                </telerik:RadMenuItem>                                             
                                            
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                           <%--  <asp:Button ID="btnreturnfromlevelR" runat="server" Text="Return" CssClass="btn btn-info" Visible="false" 
                                                                            OnClick="btnreturnfromlevelR_Click"  ToolTip="Click here to return Resident's." />--%>
                        </td>
                        <td style="width:15px">

                        </td>
                        <td>
                             <asp:Label ID="lblMessage" runat="Server" Text="Right Click and choose Print to print the Snapshot, if needed." ForeColor="red" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                        </td>
                    </tr>
                </table>
                     </right>
            </div>

            <center>
            <div style="width:70% ";>
                
                   <asp:Panel ID="PnlLevelR" Visible="true" runat="server">

            
                    <table class="table table-bordered table-hover" border="1" border-color="#CCCCFE" style="width:90%;">
                       
                        <tr style="background-color:#CCCCFE;">
                            <td colspan="4">                              
                                 <asp:Label ID="lblSDate" runat="Server" Font-Size="18px"  ForeColor=" Black " Font-Names="Calibri" style="font-size: 18px; font-weight: bold; text-align: center; "></asp:Label>
                            </td> 
                        </tr>

                         <tr style="background-color:white;">
                        <td>
                            <asp:Label ID="Label17" Visible="true" Text="Occupancy"
                                Font-Bold="true"  Font-Size="Medium" runat="server" />
                        </td>   
                             <td></td>                              
                        <td>
                            <asp:Label ID="Label1" Visible="true" Text="Billing"
                                Font-Bold="true"  Font-Size="Medium" runat="server" />
                        </td>
                             <td></td>                   
                        </tr>

                         <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label2" runat="Server" Text="Occupied houses" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lblOccupiedHouse" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                                <asp:Label ID="Label4" runat="Server" Text="Billed for" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">                             
                                <asp:Label ID="lblBilledFor" runat="server" Text=""></asp:Label>
                            </td>                         

                        </tr>           
                        
                        
                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label6" runat="Server" Text="Total Residents" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lblTotResidents" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                                <asp:Label ID="Label8" runat="Server" Text="Total billing Rs." ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: right;width:25%; ">                             
                                <asp:Label ID="lblTotBilling" runat="server" Text=""></asp:Label>
                            </td>                         

                        </tr>                   
                        
                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label10" runat="Server" Text="Single occupants" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispResidentslivingalone" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                                <asp:Label ID="Label12" runat="Server" Text="Amount collected" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: right;width:25%; ">                             
                                <asp:Label ID="lblAmountcollected" runat="server" Text=""></asp:Label>
                            </td>                         

                        </tr>        
                        
                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label14" runat="Server" Text="Owners Away" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispOwnersnotresiding" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                                <asp:Label ID="Label16" runat="Server" Text="Outstanding" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: right;width:25%; ">                             
                                <asp:Label ID="lblOutstanding" runat="server" Text=""></asp:Label>
                            </td>                         

                        </tr>                   
                        
                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label22" runat="Server" Text="Vacant" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispVacantresidences" runat="server"  Text=""></asp:Label>
                            </td>

                             <td style="width:25%;">
                                <asp:Label ID="Label3" runat="Server" Text="Yet to be billed " ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: right;width:25%; ">
                                <asp:Label ID="lblYetToBill" runat="server"  Text=""></asp:Label>
                            </td>
                                       

                        </tr>                                     
                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label33" runat="Server" Text="Staff" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispStaffcount" runat="server"  Text=""></asp:Label>
                            </td>

                                           

                        </tr>        

                         <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label35" runat="Server" Text="Above 80" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lblAboveEighty" runat="server"  Text=""></asp:Label>
                            </td>
                        </tr>  


                        
                         <tr style="background-color:white;">
                        <td>
                            <asp:Label ID="Label37" Visible="true" Text="Tasks"
                                Font-Bold="true"  Font-Size="Medium" runat="server" />
                        </td>    
                             <td></td>                         
                        <td>
                           <%-- <asp:Label ID="Label38" Visible="true" Text="Kitchen"
                                Font-Bold="true"  Font-Size="Medium" runat="server" />--%>
                        </td>
                             <td></td>          
                        </tr>      



                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label11" runat="Server" Text="Open" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispopentasks" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                               <%-- <asp:Label ID="Label40" runat="Server" Text="Menu upto" ForeColor=" Black " Font-Names="Calibri"></asp:Label>--%>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">                             
                               <%-- <asp:Label ID="Label41" runat="server" Text=""></asp:Label>--%>
                            </td>                         

                        </tr>                    

                        <tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label42" runat="Server" Text="Over due" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="lbldispOverdueTasks" runat="server"  Text=""></asp:Label>
                            </td>

                                             

                        </tr>         

                       <%-- ****************************--%>


                        <%--<tr style="height:3px">
                            <td style="width:25%;">
                                <asp:Label ID="Label18" runat="Server" Text="Total Residents" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">
                                <asp:Label ID="dfdfb" runat="server"  Text=""></asp:Label>
                            </td>

                            <td style="width:25%;">
                                <asp:Label ID="Label20" runat="Server" Text="Owners residing" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center;width:25%; ">                             
                                <asp:Label ID="lbldispOwnersresiding" runat="server" Text=""></asp:Label>
                            </td>                         

                        </tr>                       
                        <tr style="height:3px">
                            <td>
                                <asp:Label ID="Label21" runat="Server" Text="Tenants residing" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispTenantsresiding" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblORT" runat="Server" Text="Dependents" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">

                                <asp:Label ID="lbldispDependents" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                       
                        <tr style="height:3px">

                            

                            <td>
                                <asp:Label ID="Label23" runat="Server" Text="Last billing month" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                                &nbsp;</td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispLastbillingmonth" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        
                        <tr style="height:3px">
                            <td>
                                <asp:Label ID="Label24" runat="Server" Text="Billed amount for the billing month" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                                &nbsp;</td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispBilledamountforthebillingmonth" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label25" runat="Server" Text="Outstandings as of now" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                                &nbsp;</td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispOutstandingsasofnow" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        
                        <tr style="height:3px">
                            <td>
                                <asp:Label ID="Label26" runat="Server" Text="Unbilled amount for current month" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispUnbilledamountforcurrentmonth" runat="server" Text=""></asp:Label>
                            </td>
                             <td>
                                <asp:Label ID="Label27" runat="Server" Text="Owners Away" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispOwnersnotresiding" runat="server" Text=""></asp:Label>

                            </td>
                           
                        </tr>
                       

                        <tr style="height:3px">
                            <td>
                                <asp:Label ID="Label28" runat="Server" Text="Tenants away for sometime" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispTenantsawayforsometime" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label31" runat="Server" Text="Vacant" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="fgr" runat="server" Text=""></asp:Label>
                            </td>
                        </tr >
                               
                        <tr style="height:3px">
                            <td>
                                <asp:Label ID="Label29" runat="Server" Text="Staff" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="sdf" runat="server" Text=""></asp:Label>
                            </td>
                             <td>
                                <asp:Label ID="Label30" runat="Server" Text="Previous tenants and their dependents" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispPrevioustenantsandtheirdependents" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>

                         <tr style="height:3px">
                            <td>
                                <asp:Label ID="lblOpentasks" runat="Server" Text="No. of Open Tasks" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="cgdf" runat="server" Text=""></asp:Label>
                            </td>
                             <td>
                                <asp:Label ID="lblOverdueTasks" runat="Server" Text="No. of Over due Tasks" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="dsdf" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>--%>
                        
                     <%--   <tr>
                   
                            <td>
                                <asp:Label ID="Label32" runat="Server" Text="Last Billing Period" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispLBP" runat="server" Font-Bold="false" ForeColor="Black" Text=""></asp:Label>
                            </td>
                        </tr>             
                                  
                                             <tr>
                       
                            <td>
                                <asp:Label ID="lblTAON" runat="Server" Text="Total amount outstanding as of now" ForeColor=" blue " Font-Names="Calibri"></asp:Label>
                            </td>
                            <td style=" font-weight: bold; text-align: center; ">
                                <asp:Label ID="lbldispTAON" runat="server" Font-Bold="false" ForeColor="Blue" Text=""></asp:Label>
                            </td>
                        </tr>--%>
                               


                    </table>
                  

            </asp:Panel>
                </div>
                </center>
        </div>
    </div>
</asp:Content>

