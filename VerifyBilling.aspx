<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VerifyBilling.aspx.cs" Inherits="VerifyBilling" MasterPageFile="~/CovaiSoft.master"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
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
    

    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
      <style type="text/css">
        .form-controlForResidentAdd {
  /*display: block;*/
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

        .roundedcorner {
            background: #fff;
            font-family: Times New Roman, Times, serif;
            font-size: 11pt;
            margin-left: auto;
            margin-right: auto;
            margin-top: 1px;
            margin-bottom: 1px;
            padding: 3px;
            border-top: 1px solid #CCCCCC;
            border-left: 1px solid #CCCCCC;
            border-right: 1px solid #999999;
            border-bottom: 1px solid #999999;
            -moz-border-radius: 8px;
            -webkit-border-radius: 8px;
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
                       <table style="width:75%" align="center">  
                           <tr>
                               <td align="center" style="width:68%">
                                     <asp:Label ID="lnkToday" runat="server" Font-Names="verdana" Text="Billing Month : " ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
                                   <asp:DropDownList ID="drpBMonth" runat="server" CssClass="form-controlForResidentAdd">
                                   </asp:DropDownList>
                                   
                                   <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSearch_Click" />
                                   <asp:Label ID="Label1" runat="server" Text="Selected Month : " ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
                                   <asp:Label ID="lblBMonth" runat="server" Text="-" ForeColor="Maroon" Font-Bold="true"></asp:Label>

                               </td>
                           </tr>
                                        <tr>                                         
                                            <td align="center" style="width:68%">
                                                <telerik:RadGrid ID="gvAccountMaster" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                    AutoGenerateColumns="false" OnItemCommand="gvAccountMaster_ItemCommand" 
                                                    AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvAccountMaster_Init" Width="90%">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <MasterTableView>
                                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                                        <Columns>   
                                                             <%--<telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="40px">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkRSN" runat="server" Text="Din.Count" CommandName="View"  Font-Bold="true" ForeColor="Blue"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>    --%>                                                                                                       
                                                           <telerik:GridBoundColumn HeaderText="DoorNo/Name" HeaderStyle-Width="130px" DataField="Name" ReadOnly="true" FilterControlWidth="90px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>                                                           
                                                           <telerik:GridBoundColumn HeaderText="Account Code" HeaderStyle-Width="70px" DataField="AccountCode" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                             <telerik:GridTemplateColumn HeaderText="Dining"  HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkDinChr" runat="server" Text='<%# Eval("DININGCHR")%>' CommandName="View" Font-Underline="true" ForeColor="Maroon" Font-Bold="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn> 
                                                            <%--<telerik:GridBoundColumn HeaderText="Dining" HeaderStyle-Width="70px" DataField="DININGCHR" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>--%>  
                                                           <telerik:GridBoundColumn HeaderText="Cab" HeaderStyle-Width="70px" DataField="CabChr" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>    
                                                           <telerik:GridBoundColumn HeaderText="Service" HeaderStyle-Width="70px" DataField="SrvcChr" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>                                                               

                                                           <%--<telerik:GridBoundColumn HeaderText="Reg." HeaderStyle-Width="150px" DataField="Reg" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn HeaderText="Csl." HeaderStyle-Width="150px" DataField="Csl" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn HeaderText="HmDly." HeaderStyle-Width="150px" DataField="HmDly" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>              --%>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                                </td>                                        
                                                
                                        </tr>                           
                                     <tr>       
                                         <td>
                                             <table align="center" style="width:90%">
                                                
                                                 <tr>
                                                        <td style="vertical-align:top;">
                                                         <table>
                                                             <tr>
                                                                   <td style="vertical-align:top;">
                                                                        <asp:Label ID="lblRes" runat="server" Text="Resident : " Font-Bold="true" Visible="false" ></asp:Label>
                                                                        <asp:Label ID="lblResName" runat="server" Text="-" ForeColor="DarkBlue" Font-Bold="true" Visible="false" ></asp:Label>
                                                                        
                                                                       <%--<asp:Button ID="btnReturn" runat="server" CssClass="btn btn-danger" Text="Return" OnClick="btnReturn_Click" Visible="false" />--%>
                                                                    </td>
                                                             </tr>
                                                             <tr>
                                                                 <td>
                                                                     <asp:Label ID="lblDinAmt" runat="server" Text="" Font-Bold="true" Visible="false" ForeColor="Maroon"></asp:Label> 
                                                                 </td>
                                                             </tr>
                                                             <tr>
                                                                 <td>
                                                                 <asp:Label ID="lblMsg" runat="server" Text=" ** KHOC and MMC Will be added in month end billing. AlaCarte also added within Dining charges." Visible="false"></asp:Label>
                                                                </td> 
                                                             </tr>
                                                         </table>
                                                         </td> 
                                                     <td align="center" style="width:50%">
                                                <telerik:RadGrid ID="rdDinCount" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                    AutoGenerateColumns="false" Visible="false" OnItemDataBound="rdDinCount_ItemDataBound"
                                                    AllowFilteringByColumn="true" AllowPaging="false" Height="300px" width="98%" >
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <MasterTableView>
                                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                                        <Columns>                                                                                                                                                                    
                                                           <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="70px" DataField="Session" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Regular" HeaderStyle-Width="70px" DataField="Reg" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>  
                                                           <telerik:GridBoundColumn HeaderText="Casual/Guest" HeaderStyle-Width="70px" DataField="Csl" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>    
                                                           <telerik:GridBoundColumn HeaderText="HmDly" HeaderStyle-Width="70px" DataField="HmDly" ReadOnly="true" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>                                                               

                                                           <%--<telerik:GridBoundColumn HeaderText="Reg." HeaderStyle-Width="150px" DataField="Reg" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn HeaderText="Csl." HeaderStyle-Width="150px" DataField="Csl" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn HeaderText="HmDly." HeaderStyle-Width="150px" DataField="HmDly" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>              --%>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>                                               
                                                </td>                                                    
                                                                                                      
                                                 </tr>
                                             </table>
                                         </td>                                                            
                                        </tr>                                   
                                    </table>
                    </div>                   
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="btnReturn" />--%>
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
