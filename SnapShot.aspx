<%@ Page Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SnapShot.aspx.cs" Inherits="SnapShot" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width: 100%;">

                        <table style="width: 100%">
                            <tr>
                                <td style="text-align:left">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                                <td style="text-align:right"">
                                     <asp:Button ID="btnExit" runat="Server"  ToolTip="Return to home page"
                                       ForeColor="White" BackColor="DarkOrange" Font-Bold="true" Text="Return" Width="80px" OnClick="btnCancel_Click"/>
                                </td>
                            </tr>
                        </table>
                       

                        <table style="width: auto; margin-left: auto; margin-right: auto; border-collapse: collapse;" border="1">
                            <tr style="background-color:palegreen">
                                <td rowspan="2" style="vertical-align:top; "  >
                                  <asp:LinkButton ID="lnkcresident" runat="server" Text="Residents" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkNoofResidnts_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label85" runat="server" Text="Total" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label86" runat="server" Text="75+" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label87" runat="server" Text="single" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label88" runat="server" Text="Birthdays" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label89" runat="server" Text="Regular diners" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label90" runat="server" Text="Casual diners" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                               
                                <td style="text-align: center">
                                     <%--<asp:Label ID="lblTotalResidents" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller" ></asp:Label>--%>
                                    <asp:LinkButton ID="lnkTotalResidents" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkNoofResidnts_Click" ></asp:LinkButton>
                                 <td style="text-align: center">
                                     <%--<asp:Label ID="lbl75plus" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                     <asp:LinkButton ID="lnk75plus" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkNoofResidnts_Click" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblsingle" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblBirthdays" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblRegulardiners" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblcasualdiners" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr style="background-color:aliceblue">
                                <td  rowspan="2" style="vertical-align:top; ">
                                <%--<asp:Label ID="Label91" runat="server" Text="Houses" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                <asp:LinkButton ID="lnkchouses" runat="server" Text="Houses" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkDwellingUnits_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label96" runat="server" Text="Total" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label92" runat="server" Text="Occupied" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label93" runat="server" Text="Locked" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label94" runat="server" Text="Blocked" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label95" runat="server" Text="Vacant" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                   
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <%--<asp:Label ID="lbltotalhouse" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                    <asp:LinkButton ID="lnktotalhouse" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                     <%--<asp:Label ID="lbloccupied" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                     <asp:LinkButton ID="lnkoccupied" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                     <%--<asp:Label ID="lbllocked" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                     <asp:LinkButton ID="lnklocked" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                     <%--<asp:Label ID="lblblocked" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                     <asp:LinkButton ID="lnkblocked" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <%-- <asp:Label ID="lblvacant" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>--%>
                                     <asp:LinkButton ID="lnkvacant" runat="server" Font-Names="verdana" Font-Size="Smaller" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr style="background-color:aqua">
                                <td rowspan="2" style="vertical-align:top; ">
                                <asp:Label ID="Label97" runat="server" Text="Special" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label98" runat="server" Text="WALKIN" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label99" runat="server" Text="UNASGND" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label100" runat="server" Text="STAFF" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                   
                                </td>
                                <td style="text-align: center">
                                   
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr>
                              
                                <td style="text-align: center">
                                    <asp:Label ID="lblwalkin" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td >
                                 <td style="text-align: center">
                                     <asp:Label ID="lblunasgnd" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblstaff" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr style="background-color:burlywood">
                                <td rowspan="2" style="vertical-align:top; ">
                                <%--<asp:Label ID="Label101" runat="server" Text="Housekeeping" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                <asp:LinkButton ID="lnkchousekeeping" runat="server" Text="Housekeeping" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkchousekeeping_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label102" runat="server" Text="Schd.Upto" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label103" runat="server" Text="TotalToday" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label104" runat="server" Text="DoneToday" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label105" runat="server" Text="Overdue" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                   <asp:Label ID="Label106" runat="server" Text="Staff" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label107" runat="server" Text="Ave.TAT" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                                
                                <td style="text-align: center">
                                    <asp:Label ID="lblhkscheduledupto" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblhktotaltoday" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblhkdonetoday" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblhkoverdue" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblhkstaff" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblhkavgtt" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label> 
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr style="background-color:lightcyan">
                                <td rowspan="2" style="vertical-align:top; ">
                                <%--<asp:Label ID="Label108" runat="server" Text="Service Requests" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                    <asp:LinkButton ID="lnkcservicerequestss" runat="server" Text="Service Requests" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkcservicerequestss_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label109" runat="server" Text="Pending" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label110" runat="server" Text="DoneToday" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label111" runat="server" Text="Overdue" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label112" runat="server" Text="Priority" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                   
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                                
                                <td style="text-align: center">
                                    <asp:Label ID="lblSRPending" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblSRDoneToday" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblSROverdue" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblSRPriority" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr style="background-color:honeydew">
                                <td rowspan="2" style="vertical-align:top; ">
                                <%--<asp:Label ID="Label113" runat="server" Text="Activities" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                    <asp:LinkButton ID="lnkcactivities" runat="server" Text="Activities" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkcactivities_Click" ForeColor="Black"></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label114" runat="server" Text="Last Month" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label115" runat="server" Text="This Month" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label116" runat="server" Text="Next Month" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label117" runat="server" Text="Next 7 Days" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label118" runat="server" Text="Today" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr>
                               
                                <td style="text-align: center">
                                    <asp:Label ID="lblALastMonth" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblAThisMonth" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblANextMonth" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblANext7days" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                      <asp:Label ID="lblAToday" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td >
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr style="background-color:lightyellow">
                                <td rowspan="2" style="vertical-align:top; ">
                                <asp:Label ID="Label119" runat="server" Text="Dining" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label120" runat="server" Text="Menu upto" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label121" runat="server" Text="Sessions upto" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label122" runat="server" Text="Menu Items    " Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label1" runat="server" Text="Session" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label123" runat="server" Text="Regular diners" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label124" runat="server" Text="Casual diners" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label125" runat="server" Text="Guests" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                              
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <asp:Label ID="lblDMenuupto" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblDSessionupto" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblDMenuitems" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblDsession" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblDRegulardiners" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                      <asp:Label ID="lblDCasualdiners" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                      <asp:Label ID="lblDGuests" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                             
                            </tr>
                            <tr style="background-color:olivedrab">
                                <td style="text-align:left">
                                <%--<asp:Label ID="Label126" runat="server" Text="Kitchen" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                    <asp:LinkButton ID="lnkckitchen" runat="server" Text="Kitchen" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkckitchen_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label127" runat="server" Text="Provisions" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label128" runat="server" Text="Perishables" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label129" runat="server" Text="Consumables" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                           <%-- <tr>
                                <td style="text-align: center">
                                   <asp:Label ID="Label136" runat="server" Text="Count"  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblkiprovisions" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblkiperishables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblkiconsumables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                      
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="text-align: center">
                                   <asp:Label ID="Label130" runat="server" Text="At re-order"  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblROProvisions" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblROPerishables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblROConsumables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                      
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                             <tr>
                                <td style="text-align: center">
                                   <asp:Label ID="Label131" runat="server" Text="Stock Verification"  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblPSVProvisions" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center"> 
                                     <asp:Label ID="lblPSVPerishables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblPSVConsumables" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    
                                </td>
                                 <td style="text-align: center">
                                      
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr style="background-color:orange">
                                <td style="text-align:left">
                                <asp:Label ID="Label132" runat="server" Text="Billing" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label133" runat="server" Text="LBM" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="Last Billing Month"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label134" runat="server" Text="CBM" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="Current Billing Month"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label135" runat="server" Text="NBM" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="Next Billing Month"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label137" runat="server" Text="Definedupto" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                   <asp:Label ID="Label138" runat="server" Text="Month"  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lbllbm" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblcbm" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblnbm" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="lblbmdefinedupto" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                      
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr style="background-color:gray">
                                <td style="text-align:left">
                                <%--<asp:Label ID="Label139" runat="server" Text="Assets" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>--%>
                                    <asp:LinkButton ID="lnkcassets" runat="server" Text="Assets" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" OnClick="lnkcassets_Click" ForeColor="Black" ></asp:LinkButton>
                                </td>
                                 <td style="text-align: center">
                                    <asp:Label ID="Label140" runat="server" Text="Count" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label141" runat="server" Text="W_30days" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="Warranty ends in next 30 days."></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label142" runat="server" Text="AMC_30days" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="AMC ends in next 30 days."></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="Label2" runat="server" Text="Insurance_30days" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ToolTip="Insurance ends in next 30 days."></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                    
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                   
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblassetcount" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblw30days" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                     <asp:Label ID="lblamc30days" runat="server" Text=""  Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                 <td style="text-align: center">
                                   
                                </td>
                                 <td style="text-align: center">
                                      
                                </td>
                                 <td style="text-align: center">
                                     
                                </td>
                                <td style="text-align: center">
                                     
                                </td>
                            </tr>

                        </table>


                        <%--<table style="width: auto; margin-left: auto; margin-right: auto; border-collapse: collapse;" border="1">
                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label27" runat="server" Text="Residents" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>

                                    <asp:Label ID="lblmonthendcoming" runat="server" Text="" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true" ForeColor="Red"></asp:Label>

                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="How many door numbers ?" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkDwellingUnits" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label42" runat="server" Text="Step 1 in implementing ORIS:   Define all the door numbers in the community."></asp:Label>
                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="Label6" runat="server" Text="Houses in Vacant status" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkHouseinVacantStatus" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label43" runat="server" Text="Houses yet to be sold or rented out."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label34" runat="server" Text="Houses in Occupied status" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkHouseinOccupiedStatus" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label44" runat="server" Text="Houses where presently there are residents."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label35" runat="server" Text="Houses in Blocked status" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkHouseinBlokedStatus" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label45" runat="server" Text="Houses that are not available for residents / perhaps reserved for management use."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label36" runat="server" Text="Houses in Locked status" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkhouseinlockedstatus" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label46" runat="server" Text="Use this status if a resident has gone away for a sufficiently long time."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label37" runat="server" Text="Special codes (WALKIN, UNASGND, STAFF)" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkSpecialCodes" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label47" runat="server" Text="If any of these is not defined, message: Make sure you have these special ‘door nos.’ defined. "></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label38" runat="server" Text="No. Of resident profiles" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnknoofresidentprofiles" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label48" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label39" runat="server" Text="Primary residents" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkprimaryresidents" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label49" runat="server" Text="Owners or tenants who pay the bills."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label40" runat="server" Text="Dependents" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkdependents" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label50" runat="server" Text="Those who are staying with the primary residents."></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    <asp:Label ID="Label82" runat="server" Text="Birthdays coming up in next 7 days" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkbirthday" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" ></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="lblmsgbirthday" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label41" runat="server" Text="No.of detailed profiles added" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnknoofdetailedprofilesadded" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" OnClick="lnkDwellingUnits_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label51" runat="server" Text="Ensure you add the Profile++ (additional particulars) of all residents, for servicing them well."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Housekeeping tasks scheduled upto" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkhousekeepingscheduledupto" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" Adding more information about a resident or a dependent, adds value and useful when it matters."></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label52" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label83" runat="server" Text="Events/Activities in next 7 days " Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkeventsactivities" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" "></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="lblmsgeventsactivities" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label28" runat="server" Text="Care & Safety" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Number of resident profiles" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkNoofResidnts" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" Make sure you add the basic profiles all residents / tenants who are staying and also of their dependents" OnClick="lnkNoofResidnts_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label53" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="No.of residents or dependents living alone" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkNoofLivingAlone" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Shows single occupants in a house so that special attention can be provided" OnClick="lnkNoofLivingAlone_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label54" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Residents above 75 years in age" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkResidents75plus" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Shows count of residents aged above 75, so that special care can be given" OnClick="lnkResidents75plus_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label55" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text="Residents needing special attention" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align:center">
                                    <asp:LinkButton ID="lnkSpecialattention" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" All those who need special attention can be categorised in Profile++   using the code CARE . " OnClick="lnkSpecialattention_Click"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label29" runat="server" Text="Dining" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label7" runat="server" Text="Billing Type" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkBillingType" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="If S billing is based on a session  and if M it is based on A la carte menu" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label56" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label8" runat="server" Text="Billing Frequency" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkBillingFrequency" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="It is usually I for A la Carte.  M means bill is raised at month end." Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label57" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Number of Menu items" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkNoofMenuItems" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Define all the dining menu items to include them in the daily menu" OnClick="lnkNoofMenuItems_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label58" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label10" runat="server" Text="Dining sessions" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkDiningsessions" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" Make sure all the dining sessions are defined" OnClick="lnkDiningsessions_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label59" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Kitchen Provisions" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkFoodItems" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Defining provisions and groceries helps to have an estimate and avoid wastage" OnClick="lnkFoodItems_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label60" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label12" runat="server" Text="Resident Dining Sessions defined upto" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkDiningSessionUpto" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip=" Make sure dining sessions are defined for several months in advance" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label61" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label13" runat="server" Text="Menu for a day is defined upto" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkMenufordayDefinedUpto" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label62" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>

                            

                            <tr>
                                <td>
                                    <asp:Label ID="Label76" runat="server" Text="Regular diners" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkRegularResidents" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label77" runat="server" Text="Those who pay monthly."></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label78" runat="server" Text="Casual diners" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkCasualDiners" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label79" runat="server" Text="Those who pay only when they use the dining facilities."></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label30" runat="server" Text="Billing" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label14" runat="server" Text="Billing months defined upto" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkBillingMonthsDefinedUpto" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label63" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label15" runat="server" Text="Current billing month" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkCurrentBillingMonth" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label64" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label16" runat="server" Text="Last billing month" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkLastBillingMonth" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label65" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label17" runat="server" Text="Total amount billed last month" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkbilledlastmonth" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label66" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label18" runat="server" Text="Total amount accrued this month" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkaccruedthismonth" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label67" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label31" runat="server" Text="Service requests" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label19" runat="server" Text="Type of services provided" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkTypeofservices" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Several services can be provided for the residents. " OnClick="lnkTypeofservices_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label68" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label20" runat="server" Text="Services that are charged" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkTypeofserviceswithRate" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Some or all of the services may be charged" OnClick="lnkTypeofserviceswithRate_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label69" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label32" runat="server" Text="Assets" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label21" runat="server" Text="Number of assets defined" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkNoofAssets" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="Define all the physical assets to manage them better" OnClick="lnkNoofAssets_Click"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label70" runat="server" Text="Define the various fixed assets such as DG Set, vehicle,  UPS etc for better control on these items."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label80" runat="server" Text="Warranty" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkWarrentyending" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" ></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="lblmsgWarrentyending" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label81" runat="server" Text="AMC" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkamcending" runat="server" Font-Names="verdana" Font-Size="Smaller" ToolTip="" ></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="lblmsgamcending" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="background-color:palegreen">
                                    <asp:Label ID="Label33" runat="server" Text="System parameters" Font-Names="verdana" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label22" runat="server" Text="Community name" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkCommunityName" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label71" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label23" runat="server" Text="Community code" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkCommunitycode" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label72" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label24" runat="server" Text="Manager" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkManager" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label73" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label25" runat="server" Text="Official Email ID" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkOfficialEmailID" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label74" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label26" runat="server" Text="Official mobile number" Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnkOfficialMobileNo" runat="server" Font-Names="verdana" Font-Size="Smaller" Font-Underline="false"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label75" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>--%>

                         <table style="width: auto; margin-left: auto; margin-right: auto;">

                            <tr>
                                <td>
                                    
                                    <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />
                                    <telerik:RadWindow ID="rwResidents75plus" Width="800" Height="400" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Title="Residents 75 +" Modal="true">
                                        <ContentTemplate>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadGrid ID="rgResidents75plus" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                Height="300px" Width="750px" AllowSorting="true" Skin="WebBlue" ClientSettings-Scrolling-AllowScroll="false">

                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                    <PagerStyle Mode="NumericPages" />
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="DoorNo" HeaderText="DoorNo" UniqueName="DoorNO"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="MobileNo" HeaderText="MobileNo" UniqueName="MobileNo"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Email" HeaderText="Email" UniqueName="Email"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnsa" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />
                                    <telerik:RadWindow ID="rwSpecialattention" Width="800" Height="400" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnsa.ClientID  %>" Title="Special attention" Modal="true">
                                        <ContentTemplate>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadGrid ID="rgSpecialattention" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                Height="300px" Width="750px" AllowSorting="true" Skin="WebBlue" ClientSettings-Scrolling-AllowScroll="false">

                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                    <PagerStyle Mode="NumericPages" />
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="DoorNo" HeaderText="DoorNo" UniqueName="DoorNO"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="MobileNo" HeaderText="MobileNo" UniqueName="MobileNo"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Email" HeaderText="Email" UniqueName="Email"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnsr" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />
                                    <telerik:RadWindow ID="rwServiceRate" Width="800" Height="400" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnsr.ClientID  %>" Title="Service Charges" Modal="true">
                                        <ContentTemplate>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadGrid ID="rgServiceRate" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                Height="300px" Width="750px" AllowSorting="true" Skin="WebBlue" ClientSettings-Scrolling-AllowScroll="false">

                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                    <PagerStyle Mode="NumericPages" />
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="category" HeaderText="Service Category" UniqueName="category"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="servicetype" HeaderText="Service Type" UniqueName="servicetype"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>



                                                                        <telerik:GridBoundColumn DataField="rate" HeaderText="Rate" UniqueName="rate"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                        </table>


                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </div>

</asp:Content>
