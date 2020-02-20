<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="InternalTasksMaster.aspx.cs" Inherits="InternalTasksMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>--%>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
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

             vali += TaskCode();
             vali += TaskTitle();
             vali += Description();
             

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

             vali += TaskCode();
             vali += TaskTitle();
             vali += Description();

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


         function TaskCode() {
             var Title = document.getElementById('<%= txtTaskCode.ClientID  %>').value;


             if (Title == "") {
                 return "Please enter the task code" + "\n";
             }
             else {
                 return "";
             }
         }


         function TaskTitle()
         {
             var Title = document.getElementById('<%= txtTaskTitle.ClientID  %>').value;


             if (Title == "")
             {
                 return "Please enter the task Title" + "\n";
             }
             else {
                 return "";
             }
         }

        

         function Description() {
             var Estimate = document.getElementById('<%= txtTaskDescription.ClientID %>').value;

             if (Estimate == "") {
                 return "Please enter the estimated mins" + "\n";
             }
             else {
                 return "";
             }
         }
         
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
                            <tr >
                                <td style="width: 40%;">
                                    <table cellspacing="10" cellpadding="10">

                                        <tr>

                                            <td>
                                                 <asp:Label ID="Label20" runat="Server" Text="Task Code" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label7" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTaskCode" runat="server" CssClass="form-controlForResidentAdd" Width="175px" MaxLength="8" ToolTip="Please enter the house keeping task title.ML20."></asp:TextBox>
                                            </td>

                                        </tr>
                                        <tr>

                                            <td>
                                                 <asp:Label ID="Label4" runat="Server" Text="Task Title" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label10" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTaskTitle" runat="server" CssClass="form-controlForResidentAdd" Width="175px" MaxLength="80" ToolTip="Please enter the house keeping task title.ML20."></asp:TextBox>
                                            </td>

                                        </tr>
                                       
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label2" runat="Server" Text="Task Frequency" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                               
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlTaskFrequency" runat="server" ToolTip="Choose the category concerned with the task." CssClass="form-controlForResidentAdd" Width="175px" >
                                                    <asp:ListItem Text ="Daily" Value="D"></asp:ListItem>
                                                    <asp:ListItem Text ="Monthly" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text ="Weekly" Value="W"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        
                                       <tr>
                                            <td> 
                                                <asp:Label ID="Label5" runat="Server" Text="Task Priority" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                               
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-controlForResidentAdd" Width="175px" ToolTip="High means important tasks to be done quickly.">
                                                   
                                                    <asp:ListItem Text="Very High" Value="VH"></asp:ListItem>
                                                    <asp:ListItem Text="High" Value="H"></asp:ListItem>
                                                    <asp:ListItem Text="Medium" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Low" Value="L"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                        
                                        
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label6" runat="Server" Text="Task Status" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                               
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlTaskStatus" runat="server" CssClass="form-controlForResidentAdd" Width="175px" ToolTip="Routine tasks are done every day regularly. One off tasks are performed only when needed.">
                                                    <asp:ListItem Text ="Active" Value ="Active"></asp:ListItem>
                                                    <asp:ListItem Text ="InActive" Value ="InActive"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Task Description" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                 <asp:Label ID="Label3" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>                                      
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTaskDescription" runat="server" ToolTip="Describe the task and also mention about any consumable to be used / special attention etc." CssClass="form-controlForResidentAdd" TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the house keeping task details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn"  OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit."  runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" OnClick="btnReturn_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align:top;">
                                    
                                    <table>

                                        <tr>

                                            <td align="right">

                                    <asp:Button ID="BtnExcelExport" CssClass="form-controlForResidentAdd" Font-Bold="true" Text="Export Excel" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel."  />
                                                </td>
                                  </tr>

                                        <tr>

                                            <td>

                                    <telerik:RadGrid ID="gvInternalTasksMaster" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvInternalTasksMaster_ItemCommand" Width="700px"  
                                        AllowFilteringByColumn="true" AllowPaging="false"  OnInit="gvInternalTasksMaster_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true"  />
                                            
                                        </ClientSettings>
                                        <MasterTableView>
                                            
                                            <CommandItemSettings  ShowExportToCsvButton="true"  />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the house keeping task details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("ITRSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("ITRSN") %>' CommandArgument='<%# Eval("ITRSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn HeaderText="Task Code" HeaderStyle-Width="100px" DataField="ITaskCode" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Task Title" HeaderStyle-Width="100px" DataField="ITaskTitle" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Task Description" HeaderStyle-Width="100px" DataField="ITaskDescription" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Task Frequency" HeaderStyle-Width="100px" DataField="ITaskFrequency" ReadOnly="true" ItemStyle-HorizontalAlign ="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Task Priority" HeaderStyle-Width="100px" DataField="ITaskPriority" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Task Status" HeaderStyle-Width="100px" DataField="ITaskStatus" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                
                                                
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
   <%-- <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>


</asp:Content>

