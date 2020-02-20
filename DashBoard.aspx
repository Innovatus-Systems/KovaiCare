<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DashBoard.aspx.cs" Inherits="DashBoard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script src="JQuery/jquery-ui.js" type="text/javascript"></script>

    <script src="JQuery/jquery.js" type="text/javascript"></script>--%>
    <script src="js/jquery-1.8.2.js"></script>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <script type="text/javascript">
        function Show(GroupIndex) {
            alert(GroupIndex)
        }
        function NewWindow() {
            window.open("Age.aspx");
        }
       
    </script>

    <style type="text/css">
        .occupiedbutton {border-radius: 10%;}
    </style>
    <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
   
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="first_cnt">
        <asp:UpdatePanel ID="upnlMain" runat="server">
            <ContentTemplate>
                               <div align="center">
                             <telerik:RadWindow ID="rdwOutStanding" Width="400" Height="400" VisibleOnPageLoad="false" Title=""
                    runat="server" Modal="true">
                    <ContentTemplate>

                        <div>
                            <table>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="Label4" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table style="padding: 10px;" cellspacing="3px" align="center" >
                                <tr>
                                    <td align="center" style="padding: 10px;width:300px;" >
                                        <table>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblBilledFor" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblBilledForAmount" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                     <asp:Label ID="lblPayments" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text="Payment's Done : "></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblPaymentsDone" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblUnBilledFor" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblUnBilledForAmount" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblNetOut" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text="Payment's Done : "></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblNetOutAmount" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                           
                                        </table>
                                    </td>
                                </tr>                                
                            </table>
                            <table>
                                 <tr>
                                                <td>
                                                     <asp:Label ID="lblAccount" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblResident" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                            </table>

                        </div>
                    </ContentTemplate>

                </telerik:RadWindow>
                                </div>
                       
                <table>
                    <tr>
                        <td>
                            <div align="center">
                             <telerik:RadWindow ID="RwOccup" Width="400" Height="400" VisibleOnPageLoad="false" Title=""
                    runat="server" Modal="true">
                    <ContentTemplate>

                        <div>
                            <table>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="Label1" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table style="padding: 10px;" cellspacing="3px" align="center" >
                                <tr>
                                    <td align="center">
                                        <telerik:RadGrid ID="rdOccup" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" 
                                             AllowFilteringByColumn="true" AllowPaging="false" MasterTableView-NoDetailRecordsText="true" Width="300px" Height="180px" OnItemDataBound="rdOccup_ItemDataBound">
                                            <ClientSettings>
                                                <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                                <Scrolling AllowScroll="True"  SaveScrollPosition="true" UseStaticHeaders="True" />
                                            </ClientSettings>


                                            <MasterTableView AllowFilteringByColumn="false" Font-Names="Verdana" Font-Size="Small">
                                                <NoRecordsTemplate>
                                                    No Record Found
                                                </NoRecordsTemplate>
                                                <Columns>
                                                      <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="50px" ItemStyle-Width="80px" ReadOnly="true" FilterControlWidth="50px" DataField="Status" UniqueName="Status" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">                                                            
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lknOccpStatus"  runat="server" CausesValidation="false" Text='<%# Eval("Status")%>' Font-Underline="true"
                                                                    ForeColor="DarkBlue" Font-Bold="false" ToolTip="Click to get all details about particular Villa Status."  OnClick="lknOccpStatus_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>                                                   
                                                    <telerik:GridBoundColumn HeaderText="Count" HeaderStyle-Width="30px" DataField="Count" ReadOnly="true" AllowFiltering="true" FilterControlWidth="20px"></telerik:GridBoundColumn>  
                                                      <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="30px" DataField="Status" ReadOnly="true" AllowFiltering="true" FilterControlWidth="20px" Display="false"></telerik:GridBoundColumn>                                                                                              
                                                    
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>                                
                            </table>
                        </div>
                    </ContentTemplate>

                </telerik:RadWindow>
                                </div>
                        </td>
                        <td>
                            
                <telerik:RadWindow ID="rwDetails" Width="450" Height="350" VisibleOnPageLoad="false" Title=""
                    runat="server" Modal="true">
                    <ContentTemplate>

                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table style="padding: 10px;" cellspacing="3px">

                                <tr>
                                    <td style="vertical-align: top; width: 60%">
                                         <tr>
                                            <td>Door No.
                                       
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblDoorNo" runat="server" Text="-"></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Type
                                       
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblType" runat="server" Text="-"></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Floor
                                        
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblFloor" runat="server" Text="-"></asp:Label></b>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Construction Year                                       
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblConsYear" runat="server" Text="-"></asp:Label></b>
                                                <%--<asp:TextBox ID="txtConstructionYear" runat="server" ToolTip="When was the house or the block built Ex: 2014,2015,2016 " Width="250px" MaxLength="4"></asp:TextBox>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Block Name                                       
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblBlockName" runat="server" Text="-"></asp:Label></b>
                                                <%--<asp:TextBox ID="lblBlockName" runat="server" ToolTip="Is there any specific name for each block?" MaxLength="80" Width="250px"></asp:TextBox>--%>
                                            </td>
                                        </tr>                                        

                                        <tr>
                                            <td>
                                               Sqr. Feet
                                            </td>
                                            <td>
                                                <b><asp:Label ID="lblSqre" runat="server" Text="-"></asp:Label></b>
                                                <%--<asp:TextBox ID="txtSqure" runat="server" ToolTip="Square feet of Villa." ></asp:TextBox>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Description                                       
                                            </td>
                                            <td>
                                               <b> <asp:Label ID="lbldesc" runat="server" Text="-"></asp:Label></b>
                                                <%--<asp:TextBox ID="txtdesc" runat="server" ToolTip="Describe the house (Ex: SqFt, Facing side or any other unique factors about the house)" TextMode="MultiLine" Height="75px" Width="350px" MaxLength="2400"></asp:TextBox>--%>
                                            </td>
                                        </tr>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>

                </telerik:RadWindow>
                <telerik:RadWindow ID="rwVilla" Width="820" Height="450" VisibleOnPageLoad="false" Title=""
                    runat="server" Modal="true">
                    <ContentTemplate>

                        <div>
                            <table style="padding: 10px;" cellspacing="3px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl" runat="server" Font-Names="verdana" ForeColor="Black" Font-Size="Medium" Font-Bold="true" Text="Status  - "></asp:Label>
                                        <asp:Label ID="lblshow" runat="server" Font-Names="verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; width: 60%">
                                        <br />
                                        <telerik:RadGrid ID="gvVilla" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                                            Width="770px" AllowFilteringByColumn="true" AllowPaging="false" MasterTableView-NoDetailRecordsText="true" OnItemCommand="gvVilla_ItemCommand" OnInit="gvVilla_Init">
                                            <ClientSettings>
                                                <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                                <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                            </ClientSettings>


                                            <MasterTableView AllowFilteringByColumn="true">
                                                <NoRecordsTemplate>
                                                    No Record Found
                                                </NoRecordsTemplate>
                                                <Columns>
                                                    <telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="100px" DataField="Type" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Floor" HeaderStyle-Width="100px" DataField="Floor" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" DataField="status" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Sqr. Ft." HeaderStyle-Width="100px" DataField="SqrFeet" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>

                </telerik:RadWindow>
                             <telerik:RadWindow ID="RWRenewal" Width="820" Height="450" VisibleOnPageLoad="false" Title="Tenancy Renewal Dates"
                    runat="server" Modal="true">
                    <ContentTemplate>

                        <div>
                            <table style="padding: 10px;" cellspacing="3px">
                                <%--<tr>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Font-Names="verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true" Text="Tenancy Renewal"></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td style="vertical-align: top; width: 60%">                                       
                                        <telerik:RadGrid ID="rgRenewal" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                                            Width="770px" AllowFilteringByColumn="true" AllowPaging="false" ShowFooter="false" MasterTableView-NoDetailRecordsText="true" OnItemCommand="rgRenewal_ItemCommand" OnItemDataBound="rgRenewal_ItemDataBound" OnInit="rgRenewal_Init">
                                            <ClientSettings>
                                                <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                                <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                            </ClientSettings>


                                            <MasterTableView AllowFilteringByColumn="true">
                                                <NoRecordsTemplate>
                                                    No Record Found
                                                </NoRecordsTemplate>
                                                <Columns>
                                                    <telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Name" DataField="Name" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Renewal Due" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  DataField="Renewal" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="This information is stored in Profile++ under the code TRDD for a tenant (Status T)."></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Mobile Number"  DataField="MOBNO" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="ALERT"  DataField="ALERT" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" Display="false"></telerik:GridBoundColumn>
                                                   
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

                <table align="center">
                    <%--<tr>
                                    <td>
                            <marquee direction="Left" runat="server" style=" width:100%;margin-left: 0px; height: 17px; margin-bottom: 0px;" onmouseover="this.stop()" onmouseout="this.start()">
                                <strong>
                                <asp:Label ID="lblmsg" runat="server" Text="This is Marquee Text Moving From Left to Right !" ForeColor="Red" ></asp:Label>
                                </strong>

                            </marquee>
                        </td>
                                        
                                </tr>--%>
                    <tr>
                        <td>
                            <table >
                                
                    <tr>
                        
                        <td>

                            <asp:Panel ID="PnlLevelS" Visible="true" runat="server">

                                <table align="Center" style="width: 100%;">
                                    
                                    <tr>
                                        <td align="left" style="width: 16%;padding-left:20px">
                                            <%--<asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Font-Underline="false"></asp:LinkButton>--%>
                                            <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                        </td>                                       
                                          <td>
                            <marquee direction="Left" runat="server" style=" width:590px;margin-left: 0px; height: 17px; margin-bottom: 0px;" onmouseover="this.stop()" onmouseout="this.start()">
                                <strong>
                                     <asp:Label ID="Label2" runat="server" Text="Up Coming !" ForeColor="Red" ></asp:Label>
                                    <asp:LinkButton ID="lblMsg" runat="server" Text="No events scheduled for now." Font-Underline="false" ForeColor="Blue" OnClick="lblMsg_Click"></asp:LinkButton>
                                <%--<asp:Label ID="lblMsg" runat="server" Text="No events scheduled for now." ForeColor="Blue" ></asp:Label>--%>
                                </strong>

                            </marquee>
                        </td>
                                   <td align="right" >    
                                       <asp:Button ID="btnRenewal" CssClass="btn" Font-Bold="true" runat="server" Text="Tenancy" BackColor="DarkGreen" BorderColor="DarkGreen" Font-Size="Medium" ForeColor="white" ToolTip="Click to get a pop-up of all tenancy renewal dates.Refer to TRDD in Profile++." OnClick="btnRenewal_Click"/>                 
                                            <asp:Button ID="btnOccup" CssClass="btn" Font-Bold="true" runat="server" Text="Occupancy" BorderColor="#ff6600" BackColor="#ff6600" ForeColor="white" Font-Size="Medium" ToolTip="Want to know how many houses are Occupied or Vacant? Click here to find out." OnClick="btnOccup_Click"/>
                                                  
                                            <asp:Button ID="lnkGoogleCharts" CssClass="btn" Font-Bold="true" runat="server" Text="Infographics" BackColor="#0099ff" BorderColor="#0099ff" ForeColor="white" Font-Size="Medium" ToolTip="Please Click Here To Redirect ORIS Charts "  OnClientClick="return NewWindow();" />
                                        </td>
                                    </tr>
                                </table>

                                <table style="padding-left:50px;">
                                    <tr>
                                        <td style="width: 15px"></td>
                                        <td>
                                            <telerik:RadGrid ID="rdgResidentDet" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="500px" Width="1100px" AllowFilteringByColumn="true" 
                                                OnItemCommand="rdgResidentDet_ItemCommand" OnItemDataBound="rdgResidentDet_ItemDataBound" OnPreRender="rdgResidentDet_PreRender" OnItemCreated="RadGrid1_ItemCreated" OnInit="rdgResidentDet_Init" >
                                                <%--HeaderStyle-BackColor="#008b8b"  HeaderStyle-ForeColor="White" FilterItemStyle-BackColor="#008b8b" PagerStyle-BackColor="Wheat" PagerStyle-BorderColor="Yellow" PagerStyle-ForeColor="Black"--%>
                                                <%--Skin="Metro"--%>

                                                <ClientSettings>
                                                    <Scrolling AllowScroll="true" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                </ClientSettings>
                                               
                                                <MasterTableView AllowFilteringByColumn="true" AllowSorting="true" AllowMultiColumnSorting="true">
                                                    <Columns>



                                                        <telerik:GridBoundColumn HeaderText="RTRSN" HeaderStyle-Width="80px" DataField="RTRSN" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>
                                                        <%--  <telerik:GridBoundColumn HeaderText="Door No." HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="RTVillaNo" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip=" If it is a single occupant, the door no. is shown in a different colour."></telerik:GridBoundColumn>--%>
                                                        <telerik:GridTemplateColumn HeaderText="Door No." UniqueName="lnkDoor" HeaderStyle-Width="80px" ItemStyle-Width="80px" ReadOnly="true" FilterControlWidth="50px" DataField="RTVillaNo" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip=" If it is a single occupant, the door no. is shown in a different colour.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblDoorNo"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkDoor" runat="server" CausesValidation="false" Text='<%# Eval("RTVillaNo")%>' Font-Underline="true"
                                                                     Font-Bold="false" ToolTip="Click to get all details about particular Villa No." OnClick="lnkDoor_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn DataField="RTName" HeaderStyle-Width="150px" ItemStyle-Width="150px" FilterControlWidth="80px" Exportable="false" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Name of the resident. Click to view the profile of the particular resident.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblName"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkName" runat="server" CausesValidation="false" Text='<%# Eval("RTName")%>' Font-Underline="false"
                                                                    ForeColor="Black" Font-Bold="false" ToolTip="Click to manage additional particulars such as Emergency Contact Nos.,Health,Next of Kin,Other Personal Info of the profile" OnClick="LnkbtnAddOn_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridBoundColumn HeaderText="DOB" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="DOB" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Date of birth. If the age is 80+ the DOB is shown in a different colour.  If the person’s birthday is coming up in next seven days, the DOB is shown highlighted.  The number in ( ) indicates the no.of residents whose birthday is approaching in the next seven days."></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn DataField="CHK" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Exportable="false" AllowFiltering="true" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Green" HeaderTooltip=" Housekeeping tasks.  If Y it means certain Housekeeping tasks are pending for the particular door no / resident.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblHK"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkHouseKeeping" runat="server" CausesValidation="false" Text='<%# Eval("CHK")%>' Font-Underline="false" ForeColor="Green"
                                                                    Font-Bold="true" ToolTip="Click here to view the housekeeping task(pending) details." OnClick="lnkHouseKeeping_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="CSR" HeaderStyle-Width="60px" ItemStyle-Width="60px" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Exportable="false" AllowFiltering="true" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Green" HeaderTooltip="Service requests pending if any are indicated as Y.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblServices"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkServices" runat="server" CausesValidation="false" Text='<%# Eval("CSR")%>' Font-Underline="false" ForeColor="Green"
                                                                    ToolTip="Click here to view the service request(pending) details." OnClick="lnkServices_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="Events" HeaderStyle-Width="60px" ItemStyle-Width="60px" FilterControlWidth="40px" Display="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Exportable="false" AllowFiltering="true" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Green" HeaderTooltip="If there is an event coming up in the next seven days, and if the person has confirmed, it is shown as Y. If the person is not going to attend, shown as N.  If the person has not confirmed yet,  shown blank.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblEvents"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkevents" runat="server" Text='<%# Eval("EventCount")  %>' Font-Underline="false" ForeColor="Green"
                                                                    ToolTip='<%# Eval("OnComingEvent") %>'></asp:LinkButton>
                                                                <div id="tooltip" style="display: none; height: auto; min-height: 100px; width: 40%; margin-top: 5px; margin-left: 5px; margin-bottom: 5px; background-color: #F8FEBB; color: crimson; float: left; min-width: 30%">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:LinkButton ID="lnklatestevent" runat="server" Text='<%# Eval("OnComingEvent")  %>'></asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <%--<telerik:GridBoundColumn HeaderText="Events" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="Eventcount" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip=" If there is an event coming up in the next seven days, and if the person has confirmed, it is shown as Y. If the person is not going to attend, shown as N.  If the person has not confirmed yet,  shown blank."></telerik:GridBoundColumn>--%>
                                                        <%--<telerik:GridBoundColumn HeaderText="Outstanding" HeaderStyle-Width="100px" ItemStyle-Width="100px" FilterControlWidth="60px" DataField="OutStanding" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Shows the current outstanding of the resident / door no."></telerik:GridBoundColumn>--%>
                                                        <telerik:GridTemplateColumn DataField="OutStanding" HeaderStyle-Width="100px" ItemStyle-Width="100px" FilterControlWidth="60px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Exportable="false" AllowFiltering="true" ItemStyle-Font-Bold="true" HeaderTooltip="Shows the current outstanding of the resident / door no.">
                                                            <HeaderTemplate>
                                                                <asp:Label runat="server" ID="lblOutStanding" Text="OutStanding"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkOutStanding" runat="server" CausesValidation="false" Text='<%# Eval("OutStanding")%>' Font-Underline="false"
                                                                    ForeColor="Black" Font-Bold="false" OnClick="lnkOutStanding_Click" ToolTip="Click to view the Account Summary."></asp:LinkButton>
                                                                <%-- OnClick="lnkOutStanding_Click"--%>
                                                                <%-- ToolTip="Click here to view the statement of account." --%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn HeaderText="Regular Diners" Display="false" HeaderStyle-Width="90px" ItemStyle-Width="90px" FilterControlWidth="60px" DataField="Dining" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="true" HeaderTooltip=" Regular diner means, the person is a regular diner and is charged a fixed amount per month.  If nothing is mentioned, the person could be a casual diner."></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn HeaderText="Age" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="Age" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="LiveAlone" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="LiveAlone" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="CDOB" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="CDOB" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="TCSR" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="TCSR" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                        <%--<telerik:GridBoundColumn HeaderText="NonDining" Visible="false" HeaderTooltip="Non-dining day(s) for current month,all future months." HeaderStyle-Width="53px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="NDD" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" Display="true"></telerik:GridBoundColumn>--%>
                                                        <telerik:GridBoundColumn HeaderText="TCHK" HeaderStyle-Width="50px" ItemStyle-Width="50px" FilterControlWidth="30px" DataField="TCHK" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                        <%-- <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" ItemStyle-Width="100px" FilterControlWidth="60px" DataField="Status" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Shows whether the resident is a owner or a tenant or a dependent."></telerik:GridBoundColumn>--%>

                                                        <telerik:GridTemplateColumn DataField="Status" HeaderStyle-Width="100px" ItemStyle-Width="100px" FilterControlWidth="60px" Exportable="false" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderText="Status" HeaderTooltip="Shows only the resident status is Owner or Owner Away or Tenant and their dependent(s).">

                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkStatus" runat="server" CausesValidation="false" Text='<%# Eval("Status")%>' Font-Underline="false"
                                                                    ForeColor="Black" Font-Bold="false" ToolTip="Click to View Profile Snapshot" OnClick="LnkbtnAddOn_Click2"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>


                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>


                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                                <tr>
                                     <td style="width: 18%;">
                                            <asp:button ID="lnkOccupiedCnt" Visible="false" runat="server" class="button occupiedbutton" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Occupied Villa Details " OnClick="lnkOccupied_Click"></asp:button>

                                            <%--<asp:LinkButton ID="lnkOccupiedCnt" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip=""></asp:LinkButton>--%>

                                            <%--<asp:button  ID="lnkOccupiedCnt" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip=""/>--%>

                                        </td>
                                        <td style="width: 18%;">

                                             <asp:button ID="lnkVacantCnt" Visible="false" runat="server" class="button occupiedbutton" ForeColor="Green" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Vacant Villa Details" OnClick="lnkVacant_Click"></asp:button>


                                          <%--  <asp:LinkButton ID="lnkVacant" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Vacant Villa Details " Text="Vacant - " OnClick="lnkVacant_Click"></asp:LinkButton>

                                            <asp:LinkButton ID="lnkVacantCnt" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip=""></asp:LinkButton>--%>

                                        </td>
                                        <td style="width: 18%;">
                                            
                                             <asp:button ID="lnkBlockedCnt" Visible="false" runat="server" class="button occupiedbutton" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Blocked and Locked Villa Details" OnClick="lnkBlocked_Click"></asp:button>

                                           <%-- 
                                            <asp:LinkButton ID="lnkBlocked" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Blocked and Locked Villa Details " Text="Blocked - " OnClick="lnkBlocked_Click"></asp:LinkButton>

                                            <asp:LinkButton ID="lnkBlockedCnt" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip=""></asp:LinkButton>--%>

                                        </td>
                                        <td style="width: 18%;">

                                               <asp:button ID="lnkLockedCnt" Visible="false" runat="server" class="button occupiedbutton" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true"  ToolTip="Please Click Here To See Blocked and Locked Villa Details" OnClick="lnkLocked_Click"></asp:button>


                                          <%--  <asp:LinkButton ID="lnkLocked" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip="Please Click Here To See Blocked and Locked Villa Details " Text="Locked - " OnClick="lnkLocked_Click"></asp:LinkButton>

                                            <asp:LinkButton ID="lnkLockedCnt" runat="server" ForeColor="SaddleBrown" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ToolTip=""></asp:LinkButton>
                                           --%> <%--<asp:Label ID="Label3" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="SaddleBrown" Font-Bold="true" Text="  |  "></asp:Label>--%>
                                        </td>

                                </tr>
                </table>
                        </td>
                    </tr>
                </table>

                
            </ContentTemplate>
            <Triggers>
                <%-- <asp:PostBackTrigger ControlID="lnkAddnewCustomer" />
                <asp:PostBackTrigger ControlID="rcntgrdView" />
                <asp:PostBackTrigger ControlID="btnSave" />--%>
                 <asp:PostBackTrigger ControlID="lblMsg" />
                <asp:PostBackTrigger ControlID="lnkGoogleCharts" />
                <asp:PostBackTrigger ControlID="lnkOccupiedCnt" />
                <asp:PostBackTrigger ControlID="lnkVacantCnt" />
                <asp:PostBackTrigger ControlID="lnkBlockedCnt" />
                <asp:PostBackTrigger ControlID="lnkLockedCnt" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>

