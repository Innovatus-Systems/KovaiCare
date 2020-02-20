<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleMaster.aspx.cs" Inherits="VehicleMaster" MasterPageFile="~/CovaiSoft.master" %>


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
     <script  type="text/javascript">


         function SaveValidate()
         {
             var vali = "";

             vali += VehicleCode();
             vali += VehicleNo();
          

             if (vali == "")
             {
                 var result = confirm('Do you want to save?');

                 if (result) {

                     document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                     return true;
                 }
                 else {
                     document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                     return false;
                 }
             }
             else {
                 alert(vali);
                 return false;
             }
         }

         function UpdateValidate() {
             var vali = "";

             
             vali += VehicleCode();
             vali += VehicleNo();
                
             
             if (vali == "") {

                 var result = confirm('Do you want to update?');

                 if (result) {

                     document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                     return true;
                 }
                 else {
                     document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                     return false;
                 }
             }
             else {
                 alert(vali);
                 return false;
             }
         }


        

         function VehicleCode()
         {
             var Estimate = document.getElementById('<%= txtVehicleCode.ClientID %>').value;

             if (Estimate == "")
             {
                 return "Please enter the vehicle name" + "\n";
             }
             else
             {
                 return "";
             }
         }

         function VehicleNo() {
             var Estimate = document.getElementById('<%= txtVehicleNo.ClientID %>').value;

             if (Estimate == "") {
                 return "Please enter the vehicle number" + "\n";
             }
             else {
                 return "";
             }
         }


         

        <%-- function Sitevali()
         {
             var Site = document.getElementById('<%= ddlSite.ClientID %>').value;

             console.log(Site);

             if (Site == "0")
             {
                 return "Please select the site" + "\n";
             }
             else {
                 return "";
             }
         }--%>

        
         </script> 

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt" >
                <div class="first_cnt" style="min-height:450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                        <asp:HiddenField ID="CnfResult" runat="server" />
                        <table style="width: 100%;">
                            <tr>

                                <td align="center">
                                     <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                            
                            </table>
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                       <telerik:RadWindow ID="rwVehicleType" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnShowVehicleType.ClientID  %>" Title="Update Schedule" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="Server" Text="Type:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtType" runat="server"  CssClass="form-control"   Width="220px" MaxLength="20" ToolTip="Enter the type of vehicle"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                          
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Button ID="btnTypeSave" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to add facility group." OnClick="btnTypeSave_Click" runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                                                     <asp:Button ID="btnTypeClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn btn-default" OnClick="btnTypeClear_Click" />
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="2">
                                                                     <telerik:RadGrid ID="rgVehicleType" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                         AutoGenerateColumns="false"  Width="100%"  
                                        AllowFilteringByColumn="true" AllowPaging="false"   >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true"  />
                                            
                                            
                                        </ClientSettings>
                                        <MasterTableView>
                                            
                                              <CommandItemSettings  ShowExportToCsvButton="true"  />
                                            <Columns>
                                               <%-- <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the booking lookup deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                             
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="100px" DataField="Type" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnTypeSave" />
                                                    <asp:PostBackTrigger ControlID="btnTypeClear" />
                                                </Triggers>
                                            </asp:UpdatePanel>


                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                    </td>
                                </tr>
                            <tr >
                                <td style="width: 50%; vertical-align:top ">
                                    <table cellspacing="5" cellpadding="5">

                                       <tr>
                                           <td>
                                                <asp:Label ID="Label5" runat="Server" Text="Vehicle Name" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label6" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                           </td>
                                           <td>
                                               <asp:TextBox ID="txtVehicleCode"  CssClass="form-control" runat="server" ToolTip=""   Width="250px" MaxLength="8"></asp:TextBox>
                                           </td>
                                       </tr>
                                        <tr>
                                           <td>
                                                <asp:Label ID="Label7" runat="Server" Text="Vehicle No" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label9" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                           </td>
                                           <td>
                                               <asp:TextBox ID="txtVehicleNo" runat="server" ToolTip=""   CssClass="form-control"  Width="250px" MaxLength="20"></asp:TextBox>
                                           </td>
                                       </tr>
                                        
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label2" runat="Server" Text="Vehicle Type" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlVehicleType" runat="server" ToolTip="Choose the vehicle type."  CssClass="form-control" Width="125px"  AutoPostBack="true">
                                                </asp:DropDownList>
                                                 <asp:Button ID="btnShowVehicleType" ToolTip="Click here to add a new facility major group."  runat="server" Text="+" ForeColor="White" BackColor="DarkBlue" Width="30px" Height="25px" OnClick="btnShowVehicleType_Click" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Vehicle Status" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>                                        
                                            </td>
                                            <td>
                                                 <asp:DropDownList ID="ddlVehicleStatus" runat="server" ToolTip="Choose the vehicle status."  CssClass="form-control" Width="175px"  AutoPostBack="true">
                                                 <asp:ListItem Text ="Active" Value="A"></asp:ListItem>
                                                 <asp:ListItem Text="InActive" Value="I"></asp:ListItem>
                                                 </asp:DropDownList>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="verdana"></asp:Label>                                      
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" ToolTip="" TextMode="MultiLine"  CssClass="form-control" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the house keeping task details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn btn-default" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit."  runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn btn-default" OnClick="btnReturn_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align:top;">
                                    
                                    <table>

                                        <tr>

                                            <td align="right">

                                    <asp:Button ID="BtnExcelExport" Width="150PX" CssClass="btn btn-default" Font-Bold="true" Text="Export to Excel"  BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel."  />
                                                </td>
                                  </tr>

                                        <tr>

                                            <td>

                                    <telerik:RadGrid ID="gvVehicleMaster" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvVehicleMaster_ItemCommand" Width="700px"  
                                        AllowFilteringByColumn="true" AllowPaging="false"  OnInit="gvVehicleMaster_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true"  />
                                            
                                            
                                        </ClientSettings>
                                        <MasterTableView>
                                            
                                              <CommandItemSettings  ShowExportToCsvButton="true"  />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the booking lookup deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Vehicle Code" HeaderStyle-Width="100px" DataField="VehicleCode" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Vehicle No" HeaderStyle-Width="100px" DataField="VehicleNo" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Vehicle Type" HeaderStyle-Width="100px" DataField="VehicleType" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" DataField="VStatus" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="100px" DataField="Remarks" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                
                                                
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
            <asp:PostBackTrigger  ControlID="BtnExcelExport" />
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

