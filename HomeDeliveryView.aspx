<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="HomeDeliveryView.aspx.cs" Inherits="HomeDeliveryView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <script type="text/javascript">
        function Show() {
            alert('fnc');
            document.getElementById('').style.display = '';
            return false;
        };
    </script>
      <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">

                        <table style="width: 100%;">
                            <tr>

                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>

                        </table>
                        <table align="center" style="width: 100%">
                            <tr>
                                <td>
                                    <table>

                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Visible="true" Text="Today: " ID="lbltoday" Font-Bold="true"></asp:Label></td>

                                        </tr>
                                         <tr>
                                                <td style="font-size=9px;"><span style="color: red">*</span>
                                                    Information whether a flask or carrier is delivered to a residence or picked-up from a residence is updated via the mobile APP ORISHK.
                                                </td>
                                            </tr>
                                        <tr>

                                            <td>
                                                <table align="left">
                                                    <tr>
                                                        <td>
                                                              &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnLatest" runat="server" CssClass="btn" Text="Last Action" Font-Names="Verdana"  BackColor="Blue" ForeColor="White" Font-Bold="true" ToolTip="Click Here To Get all latest updates with in two days." OnClick="btnLatest_Click" />
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp;&nbsp;
                                                 <asp:Button ID="btnYesterday" runat="server" CssClass="btn" Text="Yesterday" Font-Names="Verdana" BackColor="DarkOliveGreen" ForeColor="White" Font-Bold="true" ToolTip="Deliveries and Pickups done yesterday. Useful if you have done a delivery at night and the flask is still lying at the residence." OnClick="btnYesterday_Click" />
                                                        </td>
                                                        <td>
                                                              &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnToday" runat="server" Text="Today" CssClass="btn" Font-Names="Verdana"  BackColor="#ff9933" Font-Bold="true" ForeColor="White" ToolTip="Deliveries and Pickups done for today"  OnClick="btnToday_Click" />
                                                        </td>
                                                        <td>
                                                                <table id="tbl1" runat="server" visible="false">
                                                        <tr>
                                                            <td></td>
                                                            <td style="background-color: green; font-family: Verdana; color: white;">D </td>
                                                            <td style="font-family: Verdana; color: black;">/ </td>
                                                            <td style="background-color: brown; font-family: Verdana; color: white;">P </td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>C:</b> </td>
                                                            <td align="center"><b>
                                                                <asp:Label ID="CD" runat="server" Text="-"></asp:Label>
                                                                </b></td>
                                                            <td>
                                                                <asp:Label ID="Label1" runat="server" Text="/"></asp:Label>
                                                            </td>
                                                            <td align="center"><b>
                                                                <asp:Label ID="CP" runat="server" Text="-"></asp:Label>
                                                                </b></td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>F</b> </td>
                                                            <td align="center"><b>
                                                                <asp:Label ID="FD" runat="server" Text="-"></asp:Label>
                                                                </b></td>
                                                            <td>
                                                                <asp:Label ID="Label2" runat="server" Text="/"></asp:Label>
                                                            </td>
                                                            <td align="center"><b>
                                                                <asp:Label ID="FP" runat="server" Text="-"></asp:Label>
                                                                </b></td>
                                                        </tr>
                                                    </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        
                                                          
                                                                    <td colspan="2">
                                                                         &nbsp;&nbsp;&nbsp;
                                                 <asp:Label runat="server" Visible="true" Text="Selected : " ID="lblselect" Font-Bold="true"></asp:Label>
                                                                    </td>
                                                               
                                                             
                                                        
                                                    </tr>
                                                </table>                             
                                                </td>
                                           

                                           
                                            <tr>

                                                <td style="width: 70%">
                                                    <telerik:RadGrid ID="rgHDview" runat="server" AutoPostBack="true"
                                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true" GroupingSettings-CaseSensitive="false"
                                                        CellSpacing="5" OnItemDataBound="rgHDview_ItemDataBound" OnInit="rgHDview_Init" OnItemCommand="rgHDview_ItemCommand">
                                                        <ClientSettings>
                                                            <%-- <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />--%>
                                                        </ClientSettings>

                                                        <MasterTableView ShowHeadersWhenNoRecords="true">
                                                            <NoRecordsTemplate>
                                                                No Records Found.
                                                            </NoRecordsTemplate>

                                                            <Columns>

                                                                <telerik:GridBoundColumn HeaderText="Door No." DataField="DoorNo" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                                                    HeaderTooltip="Door Number Of Resident" HeaderStyle-Width="85px" FilterControlWidth="50px">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Delivery / Pickup Date & Time" DataField="Date"
                                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px"
                                                                    HeaderTooltip="Date and Time Of Delivery / Pickup">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Mode" DataField="Mode"
                                                                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="85px" FilterControlWidth="50px"
                                                                    HeaderTooltip="Status Of Delivery / Pickup" UniqueName="Mode">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn HeaderText="Count" DataField="Count"
                                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="85px" FilterControlWidth="50px"
                                                                    HeaderTooltip="Count Of Carrier / Flask">
                                                                </telerik:GridBoundColumn>


                                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks"
                                                                    AllowFiltering="true" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                                                    HeaderTooltip="Remarks If Any">

                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                            </Columns>

                                                        </MasterTableView>

                                                    </telerik:RadGrid>
                                                </td>

                                                <td>
                                                    <%-- <table style="width:210px">
                                                    <tr>
                                                        <td>
                                                          <b><asp:Label ID="lbldefinations" runat="server" Text="Mode Definition:" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label></b>                                                             
                                                        </td>
                                                    </tr>
                                                    <tr >
                                                        <td colspan="4">
                                                            <b> <asp:Label ID="Label1" runat="server" Text="CD:-" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue" Font-Bold="true"></asp:Label></b>            
                                                       &nbsp;  &nbsp;
                                                             <asp:Label ID="Label2" runat="server" Text="Carrier Delivered" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr style="width:100px">
                                                        <td colspan="4">
                                                            <b> <asp:Label ID="Label3" runat="server" Text="CP:-" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue" Font-Bold="true"></asp:Label></b>            
                                                       &nbsp;  &nbsp;
                                                             <asp:Label ID="Label4" runat="server" Text="Carrier Picked Up" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr style="width:100px">
                                                        <td colspan="4">
                                                            <b> <asp:Label ID="Label5" runat="server" Text="FD:-" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue" Font-Bold="true"></asp:Label></b>            
                                                       &nbsp;  &nbsp;
                                                             <asp:Label ID="Label6" runat="server" Text="Flask Delivered" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue"></asp:Label>
                                                        </td>
                                                    </tr>
                                                     <tr style="width:100px">
                                                        <td colspan="4">
                                                            <b> <asp:Label ID="Label7" runat="server" Text="FP:-" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue" Font-Bold="true"></asp:Label></b>            
                                                       &nbsp;  &nbsp;
                                                             <asp:Label ID="Label8" runat="server" Text="Flask Picked Up" Font-Names="verdana" Font-Size="Medium" ForeColor="DarkBlue"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>--%>

                                                 

                                                

                                                 

                                                </td>
                                            </tr>
                                    </table>
                                    <br />
                                    <br />



                                </td>
                                <td>                                    
                                   

                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                    </div>
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnToday" />
            <asp:PostBackTrigger ControlID="btnYesterday" />
            <asp:PostBackTrigger ControlID="btnLatest" />
           
            <%-- <asp:PostBackTrigger ControlID="rdbtnAll" EventName="OnCheckedChanged" />--%>
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">

        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


</asp:Content>

