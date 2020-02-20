<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookingLkup.aspx.cs" Inherits="BookingLkup" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
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
</style>
     <script  type="text/javascript">


         function SaveValidate()
         {
             var vali = "";

             vali += BookingFor();
          

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

             
             vali += BookingFor();
             

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


        

         function BookingFor()
         {
             var Estimate = document.getElementById('<%= txtBookingfor.ClientID %>').value;

             if (Estimate == "")
             {
                 return "Please enter the Booking For" + "\n";
             }
             else
             {
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
                                       <telerik:RadWindow ID="rwFacilityGroup" Width="300" Height="425px" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnShowFacilityGroup.ClientID  %>" Title="" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="Server" Text="Group:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtFacilityGroup" runat="server"   Width="220px" MaxLength="20" ToolTip="Enter the major group for facility"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                          
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Button ID="btnGroupSave" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to add facility group." OnClick="btnGroupSave_Click" runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                                     <asp:Button ID="btnGroupClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px"  OnClick="btnGroupClear_Click" />
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="2">
                                                                     <telerik:RadGrid ID="rgFacilityGroup" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"  AutoGenerateColumns="false"  Width="80%" Height="250px"  
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
                                             
                                                <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="100px" DataField="FacilityGroup" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnGroupSave" />
                                                    <asp:PostBackTrigger ControlID="btnGroupClear" />
                                                </Triggers>
                                            </asp:UpdatePanel>


                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                    </td>
                                </tr>
                            <tr >
                                <td style="width: 40%; vertical-align:top ">
                                    <table cellspacing="10" cellpadding="10">

                                      
                                        
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label2" runat="Server" Text="Facility Type" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlBookingType" runat="server" ToolTip="Choose the booking type." CssClass="form-controlForResidentAdd" Width="175px"  AutoPostBack="true">
                                                </asp:DropDownList>
                                                 <asp:Button ID="btnShowFacilityGroup" ToolTip="Click here to add a new facility major group."  runat="server" Text="+" ForeColor="White" BackColor="DarkBlue" CssClass="btn" OnClick="btnShowFacilityGroup_Click" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Facility" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtBookingfor" runat="server" ToolTip="" CssClass="form-controlForResidentAdd"   Width="250px" MaxLength="20"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="verdana"></asp:Label>                                      
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" ToolTip="" TextMode="MultiLine" CssClass="form-controlForResidentAdd" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the house keeping task details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen"  CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit."  runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" OnClick="btnReturn_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align:top;">
                                    
                                    <table>

                                        <tr>

                                            <td align="right">

                                    <asp:Button ID="BtnExcelExport" CssClass="btn" Font-Bold="true" Text="Export to Excel"  BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel."  />
                                                </td>
                                  </tr>

                                        <tr>

                                            <td>

                                    <telerik:RadGrid ID="gvWorkTasks" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvWorkTasks_ItemCommand" Width="700px"  
                                        AllowFilteringByColumn="true" AllowPaging="false"  OnInit="gvWorkTasks_Init"  >
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
                                                <telerik:GridBoundColumn HeaderText="Facility Type" HeaderStyle-Width="100px" DataField="FacilityGroup" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Facility" HeaderStyle-Width="100px" DataField="BookingFor" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
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
