<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="TxnPosting.aspx.cs" Inherits="TxnPosting" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <link href="CSS/bootstrap.css" rel="stylesheet"/>
   
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
     <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("[id$=txtCAmount]").keypress(function (event) {
                $('#txtCAmount').text(value.toFixed(2));
                return isDecimal(event, this);

            });
        });
    </script>
   <script type="text/javascript">
       function isDecimal(evt, element) {
           var charcode = (evt.which) ? evt.which : evt.keycode
           if ((charcode != 46 || $(element).val().indexOf('.') != -1) && (charcode < 48 || charcode > 57)) {
             
               return false;
           }
       }
   </script>
    <script type="text/javascript" language="javascript">
        function HideUpdateProgress() {
            var updateProgress = document.getElementById("<%=UpdateProgress1.ClientID%>");
            updateProgress.style.display = 'none';
            Sys.Application.remove_load(HideUpdateProgress);
        }
         </script>
        <script type="text/javascript" language="javascript">
        function ConfirmMsg() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {


                return true;
            }
            else {

                return false;
            }

        }
    </script>

    
    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
    <style type="text/css">
        .RadGrid th.rgHeader
    {
        background-image: none;
        background-color: #196F3D;
        color:white;
        font-weight:bold;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">     

    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div>

                             <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 62%;">
                                    <table style="width: 100%;">
                                         <tr>
                                            <td>
                                                <asp:Label ID="lblTransType" runat="server" Text="Transaction Type" CssClass="Font_lbl2"></asp:Label> 
                                            </td>

                                            <td>
                                                 
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="ddlTransType" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true" runat="server" ToolTip="All debit txns. will go to unbilled transaction table and credit txns. will go to resident ledger"    OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged">                                                   
                                                                <asp:ListItem Text="Debit" Value="DR" />
                                                                <asp:ListItem Text="Credit" Value="CR" />
                                                            </asp:DropDownList>
                                                        </td>
                                                         

                                                        </tr>
                                                    </table>
                                                
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text="Transaction" CssClass="Font_lbl2"></asp:Label>
                                                <asp:Label ID="Label4" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td>

                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="drpTxn" CssClass="form-control"  AutoPostBack="true" runat="server" OnSelectedIndexChanged="drpTxn_SelectedIndexChanged"></asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="LabelCGST1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="CGST:Rs. "></asp:Label>
                                                            <asp:Label ID="lblCgst1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="lblCGST"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="LabelSGST1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - SGST:Rs. "></asp:Label>
                                                            <asp:Label ID="lblSgst1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="lblSGST"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Block" CssClass="Font_lbl2"></asp:Label>                                                
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                <asp:DropDownList ID="ddlPhase" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true" runat="server" ToolTip="Select one of the blocks"    OnSelectedIndexChanged="ddlPhase_SelectedIndexChanged">
                                                    <asp:ListItem Text="Phase II" Value="Phase II" />
                                                    <asp:ListItem Text="SDM" Value="SDM" />
                                                    <asp:ListItem Text="STM" Value="STM" />
                                                    <asp:ListItem Text="STM EXTN" Value="STM EXTN" />
                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td></td>

                                            <td colspan="3">

                                                <asp:Label ID="Label59" runat="server" Text="For which Resident Account?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />
                                                <%--<telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                                                        EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" AutoPostBack="true" TextSettings-SelectionMode="Single" on>
                                                                                        <TextSettings SelectionMode="Single" />
                                                                                    </telerik:RadAutoCompleteBox>
                                                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident where rtstatus in ('OR','T','RS','OA','TS') order by RTName asc"></asp:SqlDataSource>--%>

                                                <telerik:RadComboBox ID="cmbResident" CssClass="form-control" runat="server" ForeColor="DarkBlue" AllowCustomText="true" AutoPostBack="true"
                                                    Font-Names="Arial" Font-Size="Small" Width="350px" ToolTip="Residents with Owner,OwnerAway and Tenant statuses are shown by default. Tick 'Show All' to list residents of all statuses."
                                                    RenderMode="Lightweight" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                </telerik:RadComboBox>
                                                &nbsp;&nbsp;
                                                <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true" Text="Show All" OnCheckedChanged="chkAll_CheckedChanged" 
                                                    ToolTip="Residents with Owner,OwnerAway and Tenant statuses are shown by default. Tick 'Show All' to list residents of all statuses."/>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%-- <asp:Label ID="LabelName" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="Resident:"></asp:Label>--%>
                                                            <asp:Label ID="lblDrNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                            <asp:Label ID="lblSpace" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - "></asp:Label>
                                                            <asp:Label ID="lblnm" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                            <%-- <asp:Label ID="LabelDrNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - Dr. No:"></asp:Label>--%>
                                                            <asp:Label ID="LabelAccNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="Acc. Code:"></asp:Label>
                                                            <asp:Label ID="lblAccNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>

                                                            <asp:Label ID="LabelOutSt" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - Balance:- Rs. "></asp:Label>
                                                            <asp:Label ID="lblOtSt" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblCAmount" runat="server" CssClass="Font_lbl2" Text="Amount"></asp:Label>
                                                <asp:Label ID="Label8" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td colspan="4">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtCAmount" CssClass="form-control" runat="server" AutoPostBack="true" Height="25px" onkeypress="return isDecimal(event);" ToolTip="The transaction amount either entered manually or calculated as Rate * Count and displayed (Cannot be edited)." Width="200px" OnTextChanged="txtCAmount_TextChanged"></asp:TextBox>
                                                        </td>

                                                        <td>
                                                            <asp:Label ID="LabelCGST" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="CGST:Rs. "></asp:Label>
                                                            <asp:Label ID="lblCGST2" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="LabelSGST" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - SGST:Rs. "></asp:Label>
                                                            <asp:Label ID="lblSGST2" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>
                                       <%-- <tr>
                                            <td>
                                                <asp:Label ID="LabelSTNaration" runat="server" CssClass="Font_lbl2" Text="Std. Narration"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblstdnar" runat="server" CssClass="Font_lbl2" Text="-"></asp:Label>
                                            </td>
                                        </tr>--%>

                                        <tr>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblCNarration" runat="server" CssClass="Font_lbl2" Text="Narration"></asp:Label>
                                                <asp:Label ID="Label78" runat="server" CssClass="TextBox" ForeColor="Red" Text="*"></asp:Label>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                <asp:TextBox ID="txtRemarks" CssClass="form-control" runat="server" Height="50px" TextMode="MultiLine" ToolTip=" A brief description of the transaction upto 80 characters." Width="350px" MaxLength="80"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="LabelOutSt2" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="Bal.Before:Rs. "></asp:Label>
                                                <asp:Label ID="lbloutstd2" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                <asp:Label ID="LabelNewBal" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" New Balance:Rs. "></asp:Label>
                                                <asp:Label ID="lblNewBal" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                    <table>
                                        <tr>
                                            <td style="width: 150px;"></td>
                                            <td>
                                                <asp:Button ID="btnTransSave" runat="server" AutoPostBack="true" CssClass="btn btn-success" OnClientClick="ConfirmMsg()" Text="Save" ToolTip="Click here to save the details" Visible="true" OnClick="btnTransSave_Click" />&nbsp;&nbsp;
                                            <asp:Button ID="btnCClear" runat="server" AutoPostBack="true" CssClass="btn btn-info" Text="Clear" ToolTip="Click here to clear entered details" Visible="true" OnClick="btnCClear_Click" />&nbsp;&nbsp;
                                            <%--<asp:Button ID="btnTransExit" runat="server" CssClass="btn btn-info" Text="Exit" ToolTip="" Visible="true" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table>
                                        <tr align="Center">
                                            <td>
                                                <asp:RadioButton ID="rdbResident" AutoPostBack="true" runat="server" Text="Resident"  GroupName="G1" Checked="true" OnCheckedChanged="rdbResident_CheckedChanged" ToolTip="T" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          <asp:RadioButton ID="rdbAll" AutoPostBack="true" runat="server" Text="All" GroupName="G1" OnCheckedChanged="rdbAll_CheckedChanged" />
                                            </td>

                                        </tr>

                                    </table>
                                </td>
                                <td style="width: 38%; vertical-align: top">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp" Visible="false" runat="server" Text="Help" Font-Names="verdana" Font-Size="Medium" ForeColor="#cc0000" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b><asp:Label ID="lblnarration" Visible="false" runat="server" CssClass="Font_lbl2" Text="Std. Narration :- "></asp:Label>                                           
                                                <asp:Label ID="lblstdnarr" Visible="false" runat="server" CssClass="Font_lbl2" Text="-"></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMsg" runat="server" Text="-" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp1" Visible="false" runat="server" Text="-" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gvTransactions" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                                        Width="1050px" AllowFilteringByColumn="false" AllowPaging="false" AutoPostBack="true">
                                        <ClientSettings>
                                            <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                            <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                No Record Found..
                                            </NoRecordsTemplate>
                                            <Columns>
                                                <%-- <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="100px" DataField="Name" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="100px" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="80px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Sorted by ascending order of date."></telerik:GridBoundColumn>
                                               
                                                  <telerik:GridTemplateColumn  HeaderText="RefNo" HeaderStyle-Width="100px" DataField="BillNo" ReadOnly="true"   FilterControlWidth="60px"  AllowFiltering="true" UniqueName="BillNo" SortExpression="BillNo" HeaderTooltip="Digits 1 to 14 – Batch ref.no,  Last two digits – Sequence no. within the batch , Last but one digit – No.of txns in the batch.">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnview" runat="server"  Text='<%# Eval("BillNo") %>' Font-Bold="true" Font-Size="X-Small"  ForeColor="DarkBlue" OnClick="Lnkbtnview_Click">View</asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>                                                
                                                <telerik:GridBoundColumn HeaderText="Account Code" HeaderStyle-Width="80px" DataField="accountcode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Txn.Code" HeaderStyle-Width="50px" DataField="TxnCode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="30px" HeaderTooltip="This links to the transaction posting rules."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="350px" DataField="Narration" ReadOnly="true" AllowFiltering="true" HeaderTooltip="Standard narration as set for the transaction code # additional remarks"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Dr./Cr." HeaderStyle-Width="50px" DataField="DrCr" ReadOnly="true" AllowFiltering="true" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DR.Amount" HeaderStyle-Width="80px" DataField="DR" ReadOnly="true" AllowFiltering="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CR.Amount" HeaderStyle-Width="80px" DataField="CR" ReadOnly="true" AllowFiltering="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip=""></telerik:GridBoundColumn>

                                                <%--<telerik:GridBoundColumn HeaderText="Amount" HeaderStyle-Width="80px" DataField="Amount" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>--%>
                                                <%--<telerik:GridBoundColumn HeaderText="Closing" HeaderStyle-Width="80px" DataField="Closing" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>--%>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnTransSave" />
                    <asp:PostBackTrigger ControlID="btnCClear" />
                    <asp:AsyncPostBackTrigger ControlID="drptxn" />
                    <asp:AsyncPostBackTrigger ControlID="ddlTransType" />
                    <asp:AsyncPostBackTrigger ControlID="txtCAmount" />
                    <asp:AsyncPostBackTrigger ControlID="cmbResident" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="rdbResident" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="rdbAll" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel>

            <%-- <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                         <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                        <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="~/Images/Loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
           
            <%--    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>
        </div>
    </div>


</asp:Content>

