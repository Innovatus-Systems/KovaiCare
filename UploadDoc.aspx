<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="UploadDoc.aspx.cs" Inherits="UploadDoc" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
   
   <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {

            
            $(".allow_numeric").on("input", function (evt) {
                var self = $(this);
                self.val(self.val().replace(/[^\d].+/, ""));
                if ((evt.which < 48 || evt.which > 57)) {
                    evt.preventDefault();
                }
            });

            $(".allow_decimal").on("input", function (evt) {
                var self = $(this);
                self.val(self.val().replace(/[^0-9\.]/g, ''));
                if ((evt.which != 46 || self.val().indexOf('.') != -1) && (evt.which < 48 || evt.which > 57)) {
                    evt.preventDefault();
                }
            });

        });
        function ConfirmMsg() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {


                return true;
            }
            else {

                return false;
            }

        }
        function DeleteConfirmMsg() {

            var result = confirm('Are you sure, you want to delete this record?');
            if (result) {
                var result1 = confirm('Confirm?');
                if (result1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }

        }
    </script>   
    <script type="text/javascript">
        function AddEvent() {
            var summ = "";
            summ += Group();
            summ += Code();
            summ += Doc();
            summ += Remarks();

            if (summ == "") {
                var result = confirm('Do you want to add New Document?');
                if (result) {                   
                    return true;
                }
                else {                   
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }

        function Group() {
            var Title = document.getElementById('<%= drpNewDocGroup.ClientID %>').value;
            if (Title == "" || Title == null || Title == "0") {
                return "Please Select Group." + "\n";
            } else {
                return "";
            }
        }

        function Code() {
            var Title = document.getElementById('<%= drpNewDocCode.ClientID %>').value;
            if (Title == "" || Title == null || Title == "0") {
                return "Please Select Code." + "\n";
             } else {
                 return "";
             }
         }
         function Doc() {
            var Title = document.getElementById('<%=FileUpload2.ClientID %>').value;
            if (Title == "" || Title == null || Title == "0") {
                return "Please Select Document." + "\n";
             } else {
                 return "";
             }
         }
        function Remarks() {
            var Title = document.getElementById('<%= txtRemarks.ClientID %>').value;
            if (Title == "" || Title == null || Title == "0") {
                return "Please enter Remarks." + "\n";
             } else {
                 return "";
             }
         }

         function UpdateEvent() {
             var summ = "";
             summ += Group();
             summ += Code();
             summ += Doc();
             summ += Remarks();
             if (summ == "") {
                 var result = confirm('Do you want to Update?');
                 if (result) {                    
                     return true;
                 }
                 else {                    
                     return false;
                 }
             } else {
                 alert(summ);
                 return false;
             }
         }
       
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
    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
             <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpPanel">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                              <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="loading3.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
          <%--  <asp:UpdatePanel ID="UpPanel" runat="server">
                <ContentTemplate>--%>
                    <div runat="server" style="width: 100%">
                                <table align="center" style="width: 100%">
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lblHeader" runat="server" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" Text="Upload New Document" ></asp:Label>
                                    </td>
                                </tr>
                            </table>
                                  
                         <table align="center" style="width: 100%">
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lblResident" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Maroon" Font-Bold="true" Text="-" ></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        <table align="center" style="width: 100%"><tr>
                            <td style="width: 70%">
                                <table style="padding: 10px;" cellspacing="3px" align="center" >
                                <tr>
                                    
                                    <td>
                                        <asp:Label ID="lblNewDocGroup" runat="server"   Text="Group" ></asp:Label>
                                    </td>
                                     <td>
                                        <asp:DropDownList ID="drpNewDocGroup" CssClass="form-controlForResidentAdd" Width="200px"  runat="server" ToolTip="Select Group." 
                                        Font-Names="Calibri" Font-Size="Medium" OnSelectedIndexChanged="drpNewDocGroup_SelectedIndexChanged" AutoPostBack="true">  
                                             <asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                                            <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                            <asp:ListItem Text="Identity" Value="Identity"></asp:ListItem>
                                            <asp:ListItem Text="Interest" Value="Interest"></asp:ListItem>
                                            <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                                            <asp:ListItem Text="HWatch" Value="HWatch"></asp:ListItem>
                                            <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                                            <asp:ListItem Text="Special" Value="Special"></asp:ListItem>                                     
                                    </asp:DropDownList>
                                    </td>
                                      </tr> 
                                <tr>
                                     <td>
                                        <asp:Label ID="lblNewDocCode" runat="server"  Text="Code"></asp:Label>
                                    </td>
                                     <td>
                                         <asp:DropDownList ID="drpNewDocCode" Width="200px" CssClass="form-controlForResidentAdd"  runat="server" ToolTip="Select Code."
                                        Font-Names="Calibri" Font-Size="Medium">                                       
                                    </asp:DropDownList>
                                    </td>
                                </tr> 
                                <tr>
                                        <td>
                                            <asp:Label ID="lblImages" runat="Server" Text="Document" ></asp:Label>
                                        </td>
                                        <td>
                                            <asp:FileUpload ID="FileUpload2" runat="server" />
                                           <asp:Label ID="lblFile" runat="Server" Text="" Font-Bold="true" ForeColor="Blue" ></asp:Label>
                                        </td>                                        
                                    </tr>
                                 <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="Server" Text="Date Of Upload" Visible="false"></asp:Label>
                                        </td>
                                        <td>                                           
                                           <asp:Label ID="lblDOU" runat="Server" Text="" Visible="false" Font-Bold="true" ForeColor="Blue" ></asp:Label>
                                        </td>                                        
                                    </tr>    
                                 <tr>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblRemarks" runat="server" CssClass="Font_lbl2" Text="Remarks"></asp:Label>                                              
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" CssClass="form-controlForResidentAdd" runat="server" Height="50px" TextMode="MultiLine" ToolTip=" A brief description of the transaction" Width="350px"></asp:TextBox>
                                            </td>
                                        </tr>    
                                <tr>
                                        <td></td>
                                        <td style="font-family: Verdana; font-size: small; font-weight: bold;">
                                            <asp:Button ID="btnAdd" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" Font-Bold="true" ToolTip="Click here to Upload New Doc." runat="server" Text="Add" Width="100px" OnClientClick="javascript:return AddEvent()" OnClick="btnAdd_Click"  />
                                            <asp:Button ID="btnUpdate" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" Font-Bold="true" runat="server" Text="Update" Width="110px" OnClientClick="javascript:return UpdateEvent();" OnClick="btnUpdate_Click" Visible="false" ToolTip="Click here to update the details." />
                                            <asp:Button ID="btnClear" ForeColor="White" BackColor="DarkOrange" CssClass="btn btn-default" Font-Bold="true" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" Width="100px" OnClick="btnClear_Click" />
                                            <%--OnClientClick="Clear();"--%>
                                            <asp:Button ID="btnReturn" ForeColor="White" BackColor="DarkBlue" CssClass="btn btn-default" OnClick="btnReturn_Click" Font-Bold="true" runat="server" Text="Return" Width="100px" ToolTip="Click here to go back to the P++." />

                                            <%-- OnClientClick="Refresh();" --%>
                                        </td>
                                    </tr>  
                                       
                             
                            </table>
                            </td><td style="width: 30%;vertical-align:top;">
                                <asp:Label ID="lblMsg" runat="server" Text="**Please click on File Name to download the file." Font-Bold="true"></asp:Label>

                                 </td>
                               </tr></table>
                            
                        <table align="Center">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdDoc" runat="server" AllowPaging="false" PageSize="500"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                            CellSpacing="0" AllowFilteringByColumn="true" Height="350px" Width="95%"
                                            MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rdDoc_ItemCommand" >
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" />
                                            </ClientSettings>
                                            <GroupingSettings CaseSensitive="false" />
                                            <HeaderContextMenu CssClass="table table-bordered table-hover">
                                            </HeaderContextMenu>
                                            <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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
                                                     <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="50px" DataField="RSN" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" Display="false"></telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn HeaderText="RTRSN" HeaderStyle-Width="50px" DataField="RTRSN" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  Display="false"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="50px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="Profile++ Group" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="40px" DataField="Code" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip="Profile++ Code" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                  
                                                    <telerik:GridTemplateColumn DataField="URL" HeaderText="File Name" SortExpression="URL" UniqueName="URL" FilterControlAltText="URL" FooterStyle-ForeColor="DarkBlue" HeaderTooltip="File Location">
                                                        <ItemTemplate>    
                                                                             
                                                            <asp:LinkButton ID="lnkDownload" Text='<%# Eval("URL") %>' CommandArgument='<%# Eval("URL") %>' ForeColor="DarkBlue" UniqueName="file_name" runat="server" CommandName="download_file"></asp:LinkButton>
                                                    
                                                                </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <%--<telerik:GridBoundColumn HeaderText="URL" HeaderStyle-Width="150px" DataField="URL" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="" ></telerik:GridBoundColumn>--%>
                                                     <telerik:GridBoundColumn HeaderText="DOU" HeaderStyle-Width="60px" DataField="DOU" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="Date of Upload" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="160px" DataField="Remarks" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="Remarks if any." ></telerik:GridBoundColumn>

                                                     <%--<telerik:GridButtonColumn Text="Download" CommandName="download_file"></telerik:GridButtonColumn>--%>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LnkDocEdit" runat="server" ToolTip="Click here to Edit" Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClick="LnkDocEdit_Click">Edit</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Deleteresident" SortExpression="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LnkDocDelete" runat="server" ToolTip="Click here to Delete" Text="Edit" Font-Bold="false" Font-Size="Small" ForeColor="Blue" OnClientClick="javascript:return DeleteConfirmMsg()" OnClick="LnkDocDelete_Click" CommandName='<%# Eval("RSN") %>'>Delete</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

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
                                    </td>
                                </tr>
                            </table>

                    </div>
                   <%-- </ContentTemplate>
                        <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="drpNewDocGroup" EventName="SelectedIndexChanged" />
                    <asp:PostBackTrigger ControlID="btnAdd" />
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                </Triggers>
                </asp:UpdatePanel>--%>
            </div>
        </div>
</asp:Content>

