<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="WorkTasksMaster.aspx.cs" Inherits="WorkTasksMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>

     <script  type="text/javascript">


         function SaveValidate()
         {
             var vali = "";

             vali += Title();
             vali += Category();
             vali += Estimatemins();
             //vali += Sitevali();
             vali += Priorityvali();
             vali += Typevali();

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

             vali += Title();
             vali += Category();
             vali += Estimatemins();
             //vali += Sitevali();
             vali += Priorityvali();
             vali += Typevali();

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


         function Title()
         {
             var Title = document.getElementById('<%= txtTitle.ClientID  %>').value;


             if (Title == "")
             {
                 return "Please enter the Title" + "\n";
             }
             else {
                 return "";
             }
         }

         function Category()
         {
             var Category = document.getElementById('<%= ddlCategory.ClientID %>').value;


             if (Category == "--Select--")
             {
                 return "Please select a Category" + "\n";
             }
             else {
                 return "";
             }
         }

         function Estimatemins()
         {
             var Estimate = document.getElementById('<%= txtUsualTimeMins.ClientID %>').value;

             if (Estimate == "")
             {
                 return "Please enter the estimated mins" + "\n";
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

         function Priorityvali()
         {
             var Priority = document.getElementById('<%= ddlPriority.ClientID %>').value;

             if (Priority == "0")
             {
                 return "Please select the Priority" + "\n";
             }
             else {
                 return "";
             }
         }


         function Typevali() {
             var Type = document.getElementById('<%= ddlType.ClientID %>').value;

             if (Type == "--Select--") {
                 return "Please select the Type";
             }
             else {
                 return "";
             }
         }

         </script>
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
                                                 <asp:Label ID="Label20" runat="Server" Text="Title" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label7" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-controlForResidentAdd" Width="175px" MaxLength="20" ToolTip="Please enter the house keeping task title.ML20."></asp:TextBox>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Description" ForeColor="Black" Font-Names="verdana"></asp:Label>                                      
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdesc" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Describe the task and also mention about any consumable to be used / special attention etc." TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label2" runat="Server" Text="Category" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCategory" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Choose the category concerned with the task." Width="175px" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label14" runat="Server" Text="Department" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label15" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDepartment" runat="server" ToolTip="Choose the department concerned with the task." CssClass="form-controlForResidentAdd" Width="175px" Enabled="false">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                        <tr>

                                            <td>
                                                 <asp:Label ID="Label3" runat="Server" Text="Estimate(mins)" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label9" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUsualTimeMins" runat="server" CssClass="form-controlForResidentAdd" Width="175px" MaxLength="20" ToolTip="Enter the time in mins required for the task."></asp:TextBox>
                                            </td>

                                        </tr>
                                        <%--<tr>
                                            <td>
                                                <asp:Label ID="Label4" runat="Server" Text="Site" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label10" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlSite" runat="server" Height="23px" Width="175px" ToolTip="Where is this task supposed to be carried out?">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label5" runat="Server" Text="Priority" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label11" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-controlForResidentAdd" Width="175px" ToolTip="High means important tasks to be done quickly.">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="High" Value="H"></asp:ListItem>
                                                    <asp:ListItem Text="Medium" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Low" Value="L"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td> 
                                                <asp:Label ID="Label6" runat="Server" Text="Type" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label13" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-controlForResidentAdd" Width="175px" ToolTip="Routine tasks are done every day regularly. One off tasks are performed only when needed.">
                                                    
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                        
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the house keeping task details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn"/>
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit."  runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn" OnClick="btnReturn_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align:top;">
                                    
                                    <table>

                                        <tr>

                                            <td align="right">

                                    <asp:Button ID="BtnExcelExport" CssClass="btn" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel."  />
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
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the house keeping task details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="100px" DataField="Category" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="100px" DataField="Department" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Title" HeaderStyle-Width="100px" DataField="Title" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Estimate(mins)" HeaderStyle-Width="100px" DataField="UsualTime" ReadOnly="true" ItemStyle-HorizontalAlign ="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Priority" HeaderStyle-Width="100px" DataField="Priority" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="100px" DataField="Type" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                                </td>
                                   </tr>
                                        <tr>

                                            <td>
                                    <asp:Label ID="Label12" runat="Server" Text="Here you set the master list for all standard tasks.
                                      These are the tasks that you can assign to the staff (workforce) on a regular basis.
                                         The usual time taken can also be mentioned, to plan a day more effectively.  If you are looking for service requests from residents, these are maintained seperately." ForeColor="DarkGray" Font-Size="Small" Font-Names="verdana"></asp:Label>
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
