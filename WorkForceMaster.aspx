<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="WorkForceMaster.aspx.cs" Inherits="WorkForceMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
     <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>

     <script language="javascript" type="text/javascript">


         function Savevalidate()
         {
             var vali = "";

             vali += PersonName();
             vali += Gener();
             vali += Category();
             vali += JoinDate();
             vali += selType();

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

         function Updatevalidate() {
             var vali = "";

             vali += PersonName();
             vali += Gener();
             vali += Category();
             vali += JoinDate();
             vali += selType();

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

         function PersonName()
         {
             var PersonName = document.getElementById('<%= txtPersonName.ClientID %>').value;

             if (PersonName == "")
             {
                 return "Please enter the person name" + "\n";
             }
             else {
                 return "";
             }

         }

         function Gener()
         {
             var Gender = document.getElementById('<%= ddlGender.ClientID %>').value;

             if (Gender=="0")
             {
                 return "Please select a gender" + "\n";
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
                 return "Please select a category" + "\n";
             }
             else
             {
                 return "";
             }
         }

         function JoinDate()
         {
             var JoinDate = document.getElementById('<%= dtpJoindate.ClientID %>').value;

             if (JoinDate == "")
             {
                 return "Please select join date" + "\n";
             }
             else
             {
                 return "";
             }
         }

         function selType()
         {
             var Type = document.getElementById('<%= ddlType.ClientID %>').value;

             if (Type == "0")
             {
                 return "Please Select a Type";
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

            <div class="main_cnt">
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
                             <telerik:RadGrid ID="gvWorkForce" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvWorkForce_ItemCommand" Width="900px" AllowFilteringByColumn="true" AllowPaging="false"  >
                                        
                                  <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                 <MasterTableView>
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
                                                <telerik:GridBoundColumn HeaderText="PersonName" HeaderStyle-Width="100px" DataField="PersonName" ReadOnly="true" AllowSorting="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Gender" HeaderStyle-Width="75px" FilterControlWidth="40px"  DataField="Gender" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="100px" DataField="deptname" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="100px" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="JoinDate" HeaderStyle-Width="100px" DataField="JoinDate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" DataField="Status" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="100px" DataField="Type" ReadOnly="true"></telerik:GridBoundColumn>
                                               
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                    </td>
                        </tr>                                                                                               
                            <tr >
                                <td style="width: 40%;">
                                    <table  cellpadding="5">
                                        <tr>
                                             <td colspan="4">
                                                <asp:Label ID="Label3" runat="Server" Text="Add and manage the names of all staff (regular employee), contract workers, daily wages, supervisor etc.  here" ForeColor="Gray"  Font-Size="Small" Font-Names="verdana"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td>
                                                 <asp:Label ID="Label20" runat="Server" Text="Person Name" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPersonName" runat="server" CssClass="form-controlForResidentAdd" Width="220px" MaxLength="40" ToolTip="Please enter the staff name.ML40."></asp:TextBox>
                                            </td>
                                             <td> 
                                                <asp:Label ID="Label7" runat="Server" Text="Gender" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-controlForResidentAdd" Width="150px" ToolTip="Select the gender of the staff">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                                    
                                                </asp:DropDownList>
                                            </td>

                                        </tr>
                                        
                                   
                                         <tr>
                                            <td>
                                                <asp:Label ID="Label6" runat="Server" Text="Birthday Date" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                 <telerik:RadDatePicker ID="dtpBirthday" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the birthday date of the employee." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                              <td>
                                                <asp:Label ID="Label10" runat="Server" Text="Wedding Date" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                 <telerik:RadDatePicker ID="dtpWedding" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the wedding date of the employee." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>

                                      

                                         <tr>
                                            <td> 
                                                <asp:Label ID="Label14" runat="Server" Text="Department" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                <asp:Label ID="Label15" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>  
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDepartment" runat="server" ToolTip="Choose the department concerned with the task." CssClass="form-controlForResidentAdd" Width="175px" Enabled="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                              <td> 
                                                <asp:Label ID="Label2" runat="Server" Text="Category" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCategory" runat="server" ToolTip="More categories defined in the service categories menu option." CssClass="form-controlForResidentAdd" Width="150px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                       
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label8" runat="Server" Text="Join Date" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                 <telerik:RadDatePicker ID="dtpJoindate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the joining date of the employee." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                             <td> 
                                                <asp:Label ID="Label11" runat="Server" Text="Place of stay" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPlaceofstay" runat="server" ToolTip="Place of staff staying." CssClass="form-controlForResidentAdd" Width="150px">
                                                    <asp:ListItem Text ="In Campus" Value="In Campus"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                       
                                       <tr>
                                            <td> 
                                                <asp:Label ID="Label4" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-controlForResidentAdd" Width="150px" ToolTip="Select the status of the staff, default is Active" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
                                                  
                                                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                    <asp:ListItem Text="InActive" Value="InActive"></asp:ListItem>

                                                </asp:DropDownList>
                                            </td>
                                           <td> 
                                                <asp:Label ID="Label5" runat="Server" Text="Type" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-controlForResidentAdd" Width="150px" ToolTip="Select the type of employment">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                                    <asp:ListItem Text="Contractor" Value="Contractor"></asp:ListItem>
                                                    <asp:ListItem Text="Daily Wages" Value="Daily Wages"></asp:ListItem>
                                                    <asp:ListItem Text="Manager" Value="Manager"></asp:ListItem>
                                                     <asp:ListItem Text="Supervisor" Value="Supervisor"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                      

                                        <tr>
                                            <td>
                                                <asp:Label ID="lblexitdate" runat="Server" Text="Exit Date" ForeColor="Black" Font-Names="verdana"></asp:Label>   
                                            </td>
                                            <td>
                                                 <telerik:RadDatePicker ID="dtpExitDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select the relieving date of the employee." AutoPostBack="true" >
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Description" ForeColor="Black" Font-Names="verdana"></asp:Label>                                      
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdesc" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Enter if there is any description.ML240." TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return Savevalidate()" ToolTip="Click here to save the staff record." OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return Updatevalidate()" ToolTip="Click here to update the staff record." OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn"  />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn"  OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit."  runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn"  OnClick="btnReturn_Click" />
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
            <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
            <asp:PostBackTrigger ControlID="gvWorkForce" />
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

