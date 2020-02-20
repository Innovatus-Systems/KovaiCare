<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ServiceConfig.aspx.cs" Inherits="ServiceConfig" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
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
    <script type="text/javascript">
        function ConfirmSave() {
            var category = document.getElementById('<%= ddlCategory.ClientID%>').value;
            var dept = document.getElementById('<%= ddldeptcode.ClientID%>').value;
            var SerType = document.getElementById('<%= txtserType.ClientID%>').value;
            var Desc = document.getElementById('<%= txtdesc.ClientID%>').value; 
            if (category == "Please select")
                {
                alert("Please select service category" + "\n");
                return false;
            }
            if (dept == "-") {
                alert("Please select Department Code" + "\n");
                return false;
            }
            if (SerType == "") {
                alert("Please enter Service type" + "\n");
                return false;
            }
            if (Desc == "") {
                alert("Please enter Description" + "\n");
                return false;
            }
            var summ = "";
            summ += Registered();
            summ += Msg();
            summ += ServiceType();
            if (summ == "") {
                var x = confirm('Do you want to Save?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }

        }
        function Registered() {
            var service = document.getElementById('<%= ddlCategory.ClientID%>').value;
            if (service == 'Please Select') {
                return 'Please select service category' + '\n';
            } else {
                return "";
            }
        }
        function ServiceType() {
            var service = document.getElementById('<%= txtserType.ClientID%>').value;
            if (service == "") {
                return 'Please enter the category type' + '\n';
            } else {
                return "";
            }
        }
       
        function ConfirmUpdate() {
            var category = document.getElementById('<%= ddlCategory.ClientID%>').value;
            var dept = document.getElementById('<%= ddldeptcode.ClientID%>').value;
            var SerType = document.getElementById('<%= txtserType.ClientID%>').value;
            var Desc = document.getElementById('<%= txtdesc.ClientID%>').value;
            if (category == "Please Select") {
                alert("Please select service category" + "\n");
                return false;
            }
            if (dept == "-") {
                alert("Please select Department Code" + "\n");
                return false;
            }
            if (SerType == "") {
                alert("Please enter Service type" + "\n");
                return false;
            }
            if (Desc == "") {
                alert("Please enter Description" + "\n");
                return false;
            }
            var x = confirm('Do you want to Update?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width: 100%;">
                        <asp:HiddenField ID="htbnRSN" runat="server" />
                        
                        
                        <table style="width:100%">
                            <tr>
                                <td align="center">
                                     <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>

                        <table cellspacing="4" cellpadding="4" style="font-family: Verdana; font-size: small; width: 100%;">
                            
                            <tr style="width: 100%;">
                                <td style="width: 20%;">Service Category :
                                    <text style="color: red;">*</text>
                                </td>
                                <td style="width: 30%;">
                                    <asp:DropDownList ID="ddlCategory" Font-Names="verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" ToolTip="Select the major category where the service request is grouped.  If you don't find the Category add it first in Service Category Lookup." runat="server" CssClass="form-controlForResidentAdd" Width="220"></asp:DropDownList>
                                </td>
                                <td style="width: 20%;">Standard text 1 :
                                </td>
                       <td style="width: 30%;">
                                    <asp:TextBox ID="txtstdtext1" ToolTip="Used as drop down text which saves time for entry and also reduces errors" runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Department Code :<text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddldeptcode" Enabled ="false" Font-Names="verdana" ToolTip="Shows the responsible department" runat="server" CssClass="form-controlForResidentAdd" ></asp:DropDownList>
                                </td>
                                
                                <td>Standard text 2 :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtstdtext2" ToolTip="Used as drop down text which saves time for entry and also reduces errors" runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Service Type :<text style="color: red;">*</text>
                                </td>
                                <td>
                                    <%--<asp:DropDownList ID="ddlType" Font-Names="verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" ToolTip="What is the service type being requested?" runat="server" Height="20" Width="150"></asp:DropDownList>--%>
                                    <asp:TextBox ID="txtserType" ToolTip="EX: Plummber,Doctor needed." runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                                <td>Standard text 3 :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtstdtext3" ToolTip="Used as drop down text which saves time for entry and also reduces errors" runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Description :<text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtdesc" Font-Names="verdana" runat="server" MaxLength="2400" ToolTip="Brief description about the request.ML 2400."
                                        TextMode="MultiLine" Height="50" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                                <td>Standard text 4 :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtstdtext4" ToolTip="Used as drop down text which saves time for entry and also reduces errors" runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                 <td>Service Tax :
                                 </td>
                                <td> <asp:DropDownList ID="ddlTax" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150" ToolTip="Different types  of action can take place depending on the priority set.">
                                        <asp:ListItem Text="--Select--" Value="0.00"></asp:ListItem>
                                        <asp:ListItem Text="Tax 6%" Value="6.00" ></asp:ListItem>
                                        <asp:ListItem Text="Tax 15%" Value="15.00"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>Standard text 5 :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtstdtext5" ToolTip="Used as drop down text and saves time for entry and also reduces errors" CssClass="form-controlForResidentAdd" runat="server" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Rate :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRate" runat="server" ToolTip="If this is chargeable, what is the rate?"
                                        TextMode="SingleLine" CssClass="form-controlForResidentAdd" Width="150"></asp:TextBox>
                                </td>
                                
                                <td>Standard text 6 :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtstdtext6" ToolTip="Used as drop down text and saves time for entry and also reduces errors" runat="server" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>
                            <tr> 
                                <td>Priority :
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPriority" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150" ToolTip="Different types  of action can take place depending on the priority set.">
                                        <asp:ListItem Text="Very High" Value="VH"></asp:ListItem>
                                        <asp:ListItem Text="High" Value="HI" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Low" Value="LO"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>     
                                                       
                                <td>Date? &nbsp; 
                                    <asp:DropDownList ID="ddlDate" runat="server" ToolTip="If YES, Target date is enabled in the service request." CssClass="form-controlForResidentAdd" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList> <br /> <br />
                                    Count? &nbsp; 
                                    <asp:DropDownList ID="ddlCount" runat="server" ToolTip="If YES, Count is enabled in the service request." CssClass="form-controlForResidentAdd" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>Time? &nbsp; 
                                    <asp:DropDownList ID="ddlTime" runat="server" ToolTip="If YES, Time is enabled in the service request." CssClass="form-controlForResidentAdd" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList> <br /> <br />
                                    Add To Mob. App.  &nbsp; 
                                    <asp:DropDownList ID="ddlautodebit" runat="server" ToolTip="If YES, Service rate is automatically debited to the resident transactions." CssClass="form-controlForResidentAdd" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Msg when registered :<text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRegnmsg" runat="server" CssClass="form-controlForResidentAdd" MaxLength="2400" ToolTip="Enter a std text that will be sent as SMS/Mail when the request is registered.ML 2400."
                                        TextMode="MultiLine" Enabled ="false" Font-Names="verdana" Height="50" Width="250"></asp:TextBox>
                                </td>   
                              
                                <td>
                                    Manager SMS  &nbsp; 
                                    <asp:DropDownList ID="ddlmsms" runat="server" CssClass="form-controlForResidentAdd" ToolTip="If YES, SMS is sent to the admin mobile number when regd, and when actioned" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList> <br /><br />
                                    Resident SMS  &nbsp; 
                                    <asp:DropDownList ID="ddlrsms" runat="server" CssClass="form-controlForResidentAdd" ToolTip="If YES, SMS is sent to the resident when regd, and when actioned" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>Deprtment SMS  &nbsp; 
                                    <asp:DropDownList ID="ddldsms" runat="server" CssClass="form-controlForResidentAdd" ToolTip="If YES, SMS is sent to the Dept mobileno  when regd, and when actioned" Width="80" Font-Names="Verdana" Font-Size="Smaller">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                 <td>Msg when actioned :<text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtcompmsg" runat="server" MaxLength="2400" CssClass="form-controlForResidentAdd" ToolTip="Enter a std text that will be sent as SMS/Mail when the request is actioned.ML 2400."
                                        TextMode="MultiLine" Enabled ="false" Font-Names="verdana" Height="50" Width="250"></asp:TextBox>
                                </td>
                                
                                 <td>Usage Count :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtoccurrence" ForeColor="Brown" Enabled="false" runat="server" ToolTip="This field is automatically incremented when this request is made. Helps to determine the usage."
                                        TextMode="SingleLine" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>
                            </tr>                            
                            <tr> 
                                <td>Last use by :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtlastuseby" Enabled="false" runat="server" ToolTip="Who made this request"
                                        TextMode="SingleLine" CssClass="form-controlForResidentAdd" Width="250"></asp:TextBox>
                                </td>                               
                                 
                                <td colspan="2" style="vertical-align: top;">
                                    <asp:Button ID="btnSave" OnClientClick="return ConfirmSave();" OnClick="btnSave_Click" runat="Server" CssClass="btn"  Text="Save" ToolTip="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" />
                                    <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" OnClick="btnUpdate_Click" runat="Server" CssClass="btn" Text="Update" ToolTip="Clik here to update the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" />
                                    &nbsp;
                                    <asp:Button ID="btnClear" OnClick="btnClear_Click" runat="Server" CssClass="btn" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" />
                                    &nbsp;
                                    <asp:Button ID="btnExit" OnClick="btnExit_Click" runat="Server" CssClass="btn" Text="Return" ToolTip="Clik here to return back." ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" />
                                </td>
                            </tr>
                            <tr>
                                <td>Last use date :
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="txtlastusedate" Enabled="false" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="When was this request last made"
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" CssClass="form-controlForResidentAdd">
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput4" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                        </DateInput>
                                        <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle BackColor="Pink" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gvServiceConfig" MasterTableView-ShowHeadersWhenNoRecords="true" GroupingSettings-CaseSensitive="false" Skin="WebBlue" 
                                        AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                         OnItemCommand="gvServiceConfig_ItemCommand" Width="100%" 
                                        AllowFilteringByColumn="true" AllowPaging="false" PageSize="10" OnInit="gvServiceConfig_Init">
                                        
                                         <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                          </ClientSettings>
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the service configuration details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="100px" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Service Type" HeaderStyle-Width="150px" DataField="ServiceType" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Department Name" HeaderStyle-Width="100px" DataField="DeptName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="220px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Usage Count" HeaderStyle-Width="50px" DataField="Occurrence" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Service Tax(%)" AllowFiltering="false" HeaderStyle-Width="50px" DataField="Tax" ReadOnly="true" HeaderStyle-HorizontalAlign ="Center" ItemStyle-HorizontalAlign ="Center"></telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="Rate" AllowFiltering="false" HeaderStyle-Width="50px" DataField="Rate" ReadOnly="true" HeaderStyle-HorizontalAlign ="Right" ItemStyle-HorizontalAlign ="Center"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="Msg when Reg." HeaderStyle-Width="100px" DataField="RegnMsg" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Msg when Com." HeaderStyle-Width="100px" DataField="CompletionMsg" ReadOnly="true"></telerik:GridBoundColumn>--%>

                                                <%--<telerik:GridBoundColumn HeaderText="Date" AllowFiltering="false" HeaderStyle-Width="50px" DataField="DateYorN" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Time" AllowFiltering="false" HeaderStyle-Width="50px" DataField="TimeYorN" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Count" AllowFiltering="false" HeaderStyle-Width="50px" DataField="CountYorN" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="MSMS" AllowFiltering="false" HeaderStyle-Width="50px" DataField="MSMS" ReadOnly="true"></telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="RSMS" AllowFiltering="false" HeaderStyle-Width="50px" DataField="RSMS" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DSMS" AllowFiltering="false" HeaderStyle-Width="50px" DataField="DSMS" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="AutoDebit" AllowFiltering="false" HeaderStyle-Width="50px" DataField="AutoDebit" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                        <%--<table style="font-family: Verdana; font-size: small; border: 1px solid black;">
                            <tr>
                                <td>Date
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="chkdate" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>Date
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="YES" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="NO" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>--%>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

