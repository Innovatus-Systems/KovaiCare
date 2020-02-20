<%@ Page Title="Door Nos. Master" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="VillaMaster.aspx.cs" Inherits="VillaMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function SaveValidate() {
            var summ = "";
            summ += DoorNoVal();
            summ += Status();


            if (summ == "") {
                var result = confirm('Do you want to save?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }
        function DoorNoVal() {
            var door = document.getElementById('<%= txtDoorno.ClientID %>').value;
            if (door == "") {
                return "Please enter the Door No." + "\n";
            } else {
                return "";
            }
        }

        function Status() {
            var Status = document.getElementById('<%= ddlStatus.ClientID %>').value;
            if (Status == "0") {
                return "Please select the status of the DoorNo." + "\n";
            } else {
                return "";
            }
        }

        function UpdateValidate() {
            var summ = "";
            summ += DoorNoVal();
            summ += UStatus();


            if (summ == "") {

                var result = confirm('Do you want to Update?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }


        function UStatus() {
            var UStatus = document.getElementById('<%= txtcstatus.ClientID %>').value;
            if (UStatus == "") {
                //return "Please ensure status is valid.";
            } else {
                return "";
            }
        }

        function UploadConfirm() {
            var x = confirm('Do you want to import the DoorNos?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }

    </script>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
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
        </style>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="font-family: Verdana; font-size: small;">
                <asp:HiddenField ID="hbtnRSN" runat="server" />

                <table style="width: 100%;">
                    <tr>
                        <td align="left">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                        <td align="right">
                            <asp:LinkButton ID="lnkHelpPopup" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="blue" Text="Help" OnClick="lnkHelpPopup_Click" Font-Underline="true"></asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadWindowManager ID="rwImport" runat="server">
                                <Windows>
                                    <telerik:RadWindow ID="rwImportExcel" Title="Imports DoorNo Details" BackColor="Beige" runat="server" Modal="true" Height="250px" Width="500px">
                                        <ContentTemplate>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnUnload="UpdatePanel_Unload">
                                                <ContentTemplate>
                                                    <table>
                                                        <tr>
                                                            <td colspan="2">
                                                                <%--<asp:Label ID="lblMainTitle" runat="server" Text="Residents" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>--%>
                                                            </td>
                                                            <td align="right">
                                                                <asp:LinkButton ID="lbtnResdownload" OnClick="lbtnResdownload_Click" runat="server" Text="Sample excel file" ToolTip="Click here to download sample for file importing DoorNo details"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Select Excel File: </b>
                                                            </td>
                                                            <td>
                                                                <asp:FileUpload ID="fuExcel" runat="server" ToolTip="Select DoorNos excel file for import." ClientIDMode="Static" />
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnexcelimport" ForeColor="White" BackColor="DarkGreen" Width="120px" ToolTip="Click here to import the residents details." OnClientClick="return UploadConfirm();" OnClick="btnexcelimport_Click" runat="server" Text="Import" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnexcelimport" />
                                                    <asp:PostBackTrigger ControlID="lbtnResdownload" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                            </telerik:RadWindowManager>
                        </td>
                    </tr>

                </table>

                <table style="width: 100%;">
                    <tr>
                        <td>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <asp:Button ID="btnHelp" BackColor="Blue" ToolTip="Click here to view Help about villa master." ForeColor="White" Width="100px" runat="server" Text="Help" Font-Names="Verdana" OnClick="btnHelp_Click" Visible="false" />
                        </td>
                    </tr>
                    <tr style="width: 100%;">
                        <td style="width: 50%; vertical-align: top">

                            <table>

                                <tr>
                                    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <td>Door No
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDoorno" runat="server" CssClass="form-controlForResidentAdd" Width="250px" MaxLength="20" ToolTip="Define the unique door number for each house."></asp:TextBox>
                                                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </tr>
                                <tr>
                                    <td>Type
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" ToolTip="Is the house a 1BHK or 2BHK or any other" CssClass="form-controlForResidentAdd" Width="150px">
                                            <asp:ListItem Text="Studio" Value="Studio"></asp:ListItem>
                                            <asp:ListItem Text="1BHK" Value="1BHK"></asp:ListItem>
                                            <asp:ListItem Text="2BHK" Value="2BHK"></asp:ListItem>
                                            <asp:ListItem Text="3BHK" Value="3BHK"></asp:ListItem>
                                            <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Floor
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlFloors" runat="server" CssClass="form-controlForResidentAdd" Width="150px" ToolTip="Define which floor the house is located">
                                            <asp:ListItem Text="Ground Floor" Value="GF"></asp:ListItem>
                                            <asp:ListItem Text="First Floor" Value="FF"></asp:ListItem>
                                            <asp:ListItem Text="Second Floor" Value="SF"></asp:ListItem>
                                            <asp:ListItem Text="Third Floor" Value="TF"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Construction Year                                       
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtConstructionYear" runat="server" ToolTip="When was the house or the block built Ex: 2014,2015,2016 " Width="100px" CssClass="form-controlForResidentAdd" MaxLength="4"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Block Name                                       
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBlockName" runat="server" ToolTip="Is there any specific name for each block?" MaxLength="80" CssClass="form-controlForResidentAdd" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Status
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlStatus" runat="server" ToolTip="Set the present status of the house. See Help for more details" CssClass="form-controlForResidentAdd" Width="150px" AutoPostBack="false" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtcstatus" runat="server" ToolTip="" CssClass="form-controlForResidentAdd" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblnewstatus" runat="server" Text="New Status"></asp:Label>
                                    </td>
                                    <td>

                                        <asp:TextBox ID="txtNewStatus" runat="server" ToolTip="" Enabled="false" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSqr" runat="server" Text="Sqr. Feet"></asp:Label>
                                    </td>
                                    <td>

                                        <asp:TextBox ID="txtSqure" runat="server" ToolTip="Square feet of Villa." CssClass="form-controlForResidentAdd" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Description                                       
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtdesc" runat="server" ToolTip="Describe the house (Ex: SqFt, Facing side or any other unique factors about the house)" CssClass="form-controlForResidentAdd" TextMode="MultiLine" Height="75px" Width="250px" MaxLength="2400"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="left">
                                        <br />
                                        <asp:Button ID="btnVacant" ToolTip="Indicates a vacant house yet to be allotted to someone." CssClass="btn" OnClick="btnVacant_Click" runat="server" Text="Vacant" ForeColor="White" BackColor="DarkGreen" Width="90px" Visible="false" />
                                        <asp:Button ID="btnOccupied" Enabled="true" ToolTip="Indicates that the resident has returned back." OnClick="btnOccupied_Click" runat="server" CssClass="btn" Text="Occupied" ForeColor="White" BackColor="DarkBlue" Width="90px"  Visible="false" />
                                        <asp:Button ID="btnLocked" Enabled="true" ToolTip="Indicates that the resident has locked the house and has gone on a long vacation." OnClick="btnLocked_Click" CssClass="btn" runat="server" Text="Locked" ForeColor="White" BackColor="DarkCyan" Width="90px"  Visible="false" />
                                        <asp:Button ID="btnBlocked" ToolTip="Indicates this house is either not available for occupancy or reserved by the management for own use." OnClick="btnBlocked_Click" CssClass="btn" runat="server" Text="Blocked" ForeColor="White" BackColor="DarkRed" Width="90px" Visible="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                         <%--<asp:Button ID="btnAdd" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to Add the villa details" OnClick="btnAdd_Click"  runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />--%>
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the villa details" OnClick="btnSave_Click" runat="server" CssClass="btn" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px"  />
                                        <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the villa details" OnClick="btnUpdate_Click" runat="server" CssClass="btn" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" />
                                        <%--<asp:Button ID="btnDelete" Visible ="false" OnClientClick="return ConfirmDelete();" ToolTip="Click here to delete the villa" OnClick="btnDelete_Click" runat="server" Text="Delete" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" />--%>
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn"  OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn"  />
                                        

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnImport" Font-Names="Verdana" OnClick="btnImport_Click" ToolTip="Click here to import residents details from excel sheet." Width="100px" ForeColor="White" CssClass="btn" BackColor="DarkGreen" runat="server" Text="Import" />
                                    </td>
                                </tr>
                            </table>
                        </td>

                        <td style="width: 50%; vertical-align: middle;">


                            <telerik:RadGrid ID="gvVilla" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvVilla_ItemCommand" Height="350px"
                                Width="750px" AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvVilla_Init">
                                <ClientSettings>
                                    <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AllowFilteringByColumn="true">
                                    <NoRecordsTemplate>
                                        No Records Found.
                                    </NoRecordsTemplate>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the Door No details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LbtnHistory" ToolTip="Click here to view Occupancy History" runat="server" Text="History" CommandName="ViewHistory" ForeColor="Blue" CommandArgument='<%# Eval("DoorNo") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="110px" FilterControlWidth="60px" DataField="DoorNo" HeaderStyle-HorizontalAlign="Left" AllowFiltering="true">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnDoorNo" runat="server" Text='<%# Eval("DoorNo") %>' CommandArgument='<%# Eval("DoorNo") %>' CommandName="ViewDetails"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="85px" DataField="Type" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Floor" HeaderStyle-Width="100px" DataField="Floor" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" DataField="status" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Sqr. Ft" HeaderStyle-Width="100px" DataField="sqrFeet" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>

                            <asp:Label ID="Label2" runat="server" Text="Summary" Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkBlue"></asp:Label>

                            <telerik:RadGrid ID="rgvillaSummary" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="false" runat="server" AutoGenerateColumns="false" Width="700px">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="50px" DataField="Type" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Vacant" HeaderStyle-Width="50px" DataField="Vacant" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Blocked" HeaderStyle-Width="50px" DataField="Blocked" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Occupied" HeaderStyle-Width="50px" DataField="Occupied" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Locked" HeaderStyle-Width="50px" DataField="Locked" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>

                    </tr>

                    <tr>
                        <td>
                            <telerik:RadWindowManager ID="rwmgrMain" runat="server">
                                <Windows>
                                    <telerik:RadWindow ID="rwDetailsPopup" runat="server" Modal="true" CenterIfModal="true" Title="Door Nos. Master" VisibleOnPageLoad="false" Visible="false" Height="200px" Width="400px">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="dlDoorno" BackColor="#FFFF99" runat="server" RepeatColumns="1" BorderStyle="None" Width="360px"
                                                            BorderWidth="2px" CellPadding="3" CellSpacing="2" Font-Size="Small" GridLines="Both" RepeatDirection="Vertical">
                                                            <ItemTemplate>
                                                                <text style="font-weight: bold;">Name :</text>
                                                                <asp:Label ID="lblResName" ForeColor="DarkBlue" Font-Names="Verdana" runat="server" Text='<%# Eval("RTName") %>'></asp:Label>
                                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                                <text style="font-weight: bold;">Status :</text>
                                                                <asp:Label ID="Label1" runat="server" Font-Names="Verdana" ForeColor="DarkBlue" Text='<%# Eval("SDescription") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                    <telerik:RadWindow ID="rwHelp" runat="server" BackColor="White" Title="Help" Modal="true" CenterIfModal="true" Height="200px" Width="600px">
                                        <ContentTemplate>
                                            <table style="font-family: Verdana; font-size: smaller; width: 100%;" cellspacing="5" cellpadding="5">
                                                <tr>
                                                    <td>
                                                        <text style="color: gray;">In this place create the inventory of all Door Numbers, in the community. </text>
                                                        <br />

                                                        <text style="color: gray;">This is the step and perhaps an one time activity before adding a resident to a door number/villa/house/dwelling unit. </text>
                                                        <br />

                                                        <text style="color: gray;">Normally an unalloted villa is set as Vacant and it becomes InUse when allotted to a resident/tenant. </text>
                                                        <br />

                                                        <text style="color: gray;"> You can also set other statuses such as Blocked, Sold, Rented etc.</text>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                    <telerik:RadWindow ID="rwHelpmsg" Width="950" Height="550" VisibleOnPageLoad="false" Title="Villas and Apartments - MASTER"
                                        runat="server" Modal="true">
                                        <ContentTemplate>

                                            <div>
                                                <table style="padding: 4px;" cellspacing="2px">
                                                    <tr>
                                                        <td style="vertical-align: top;">
                                                            <table cellpadding="2px" cellspacing="2px">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label8" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="small" Font-Bold="false" runat="server" Text="Before you start adding residents in the community, the door nos. must be defined and it is done here."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label9" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="DoorNo can be a maximum of 8 alphanumeric characters"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label10" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Type  denotes the type of house - 1 bed room / 2 bed room etc."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label11" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="In the Description field,  write more about the house (Ex: Area 1600 Sqft.  Corner plot and so on)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label13" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Entering the year of construction will be useful to determine the age of the building"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label14" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="If the houses are in different blocks (Ex:  Stonebrook Terrace,  RidgeView Ct. ) define them in the 'Block' field"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label15" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Status : This is an important information."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label16" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Occupied - If the door no. is assigned to a resident (Sold or leased or let out)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label3" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Locked - if the resident has taken possession of the house but is not residing at present. Still you may charge him for services."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label4" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Blocked - if the house is reserved for management use or not to be sold or leased out"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label5" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Vacant - if the house is available for sale / lease / letting out"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label17" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Initally set all the houses in Vacant status."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label18" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="When a resident is assigned a door no.in the Resident's profile, the status becomes Occupied here."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label19" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="Should you add all door nos. one by one? "></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label20" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Font-Bold="false" runat="server" Text="You can also define the door nos. in Sheet 1 of a Excel file and import them directly into ORIS."></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr align="Center">
                                                                    <td>
                                                                        <br />
                                                                        <asp:Button ID="btnHelpCancel" runat="server" Text="Close" CssClass="btnAdminSave" Width="74px" Height="26px" BackColor="DarkBlue" ForeColor="White"
                                                                            ToolTip="Click here to close the window." OnClick="btnHelpCancel_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>


                                                    </tr>


                                                </table>

                                            </div>

                                        </ContentTemplate>

                                    </telerik:RadWindow>

                                    <telerik:RadWindow ID="rwOccupancyHistory" runat="server" Modal="true" CenterIfModal="true" Title="Occupancy History" VisibleOnPageLoad="false" Visible="false" Height="370px" Width="850px">
                                        <ContentTemplate>
                                            <div align="center" width="100%;">

                                                <asp:Label runat="server" ID="LblDoorNo" Font-Size="13px" ForeColor="#196F3D" Font-Bold="true"></asp:Label>
                                                <telerik:RadGrid ID="rgOccupancyHistory" runat="server" AllowPaging="false" PageSize="50" AutoPostBack="true" OnItemCommand="rgOccupancyHistory_ItemCommand"
                                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                                    CellSpacing="5" Width="780px" Height="250px"
                                                    MasterTableView-HierarchyDefaultExpanded="true">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                    </HeaderContextMenu>
                                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                                    <MasterTableView AllowCustomPaging="false">
                                                        <NoRecordsTemplate>
                                                            No Records Found.
                                                        </NoRecordsTemplate>
                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>

                                                            <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo" HeaderStyle-Wrap="false"
                                                                ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                                ItemStyle-CssClass="Row1" >
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false" Visible="true"
                                                                ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="10px"
                                                                ItemStyle-CssClass="Row1">
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false"
                                                                ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                                ItemStyle-CssClass="Row1" >
                                                                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="120px"></ItemStyle>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="New Status" DataField="OldStatus" HeaderStyle-Wrap="false" Visible="true"
                                                                ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                                                ItemStyle-CssClass="Row1">
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="New Status Date" DataField="Date" HeaderStyle-Wrap="false"
                                                                ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                                ItemStyle-CssClass="Row1">
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>


                                                            <telerik:GridBoundColumn HeaderText="Old Status" DataField="OldStatus" HeaderStyle-Wrap="false" Visible="true"
                                                                ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                                                ItemStyle-CssClass="Row1">
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="Old Status Date" DataField="OldStatusDate" HeaderStyle-Wrap="false"
                                                                ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                                ItemStyle-CssClass="Row1">
                                                                <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" Width="80px"></ItemStyle>
                                                            </telerik:GridBoundColumn>


                                                        </Columns>
                                                        <EditFormSettings>
                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                            </EditColumn>
                                                        </EditFormSettings>
                                                        <PagerStyle AlwaysVisible="True"></PagerStyle>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="True" />
                                                    </ClientSettings>
                                                    <FilterMenu Skin="WebBlue" EnableTheming="True">
                                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                    </FilterMenu>
                                                </telerik:RadGrid>

                                            </div>
                                            <br />
                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                </Windows>
                            </telerik:RadWindowManager>
                        </td>
                    </tr>


                </table>
            </div>
        </div>
    </div>
</asp:Content>

