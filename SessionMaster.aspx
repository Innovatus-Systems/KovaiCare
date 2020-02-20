<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SessionMaster.aspx.cs" Inherits="SessionMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Calendar/jquery-1.10.2.js"></script>
    <script src="Calendar/jquery.validate.js" type="text/javascript"></script>
    <script src="Calendar/moment.js" type="text/javascript"></script>

    <script src="Calendar/jquery.timepicker.js" type="text/javascript"></script>
    <link href="Calendar/jquery.timepicker.css" rel="Stylesheet" />

    <script src="Calendar/lib/site.js" type="text/javascript"></script>
    <link href="Calendar/lib/site.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            $("[id*='txtFromTime']").timepicker({                
                });
            $("[id*='txtTilltime']").timepicker({                           
            });           
        });
        //Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
        //    //  $(document).ready(function () {
        //        $("[id*='txtFromTime']").timepicker({ });
        //        $("[id*='txtTilltime']").timepicker({ });
        //   });            
    </script>
    <script type="text/javascript">
        function Validate() {
            var summ = "";

            summ += CodeVal();
            summ += NameVal();

            if (summ == "") {
                var x = confirm('Do you want to save?');
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
        function CodeVal() {
            var door = document.getElementById('<%= txtSessioncode.ClientID %>').value;
            if (door == "") {
                return "Please enter the session code." + "\n";
            } else {
                return "";
            }
        }
        function NameVal() {
            var door = document.getElementById('<%= txtSessionname.ClientID %>').value;
            if (door == "") {
                return "Please enter the session name." + "\n";
            } else {
                return "";
            }
        }
        function ConfirmUpdate() {
            var x = confirm('Do you want to Update?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
        function ConfirmDelete() {
            var x = confirm('Do you want to Delete?');
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
     <style>
        .rightAlign { text-align:right; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />

                        <table style="width:100%">

                            <tr align="center">
                                <td align="center" >
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>

                                </td>

                            </tr>
                        </table>
                         <table style="width: 100%;">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gvSession" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvSession_ItemCommand" Width="100%" AllowFilteringByColumn="true" AllowPaging="true" 
                                        PageSize="10" OnInit="gvSession_Init">
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the session details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Session Group" FilterControlWidth="60px" Visible="true" HeaderStyle-Width="70px" DataField="Group" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session Code" FilterControlWidth="60px" Visible="true" HeaderStyle-Width="70px" DataField="SessionCode" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session Name" FilterControlWidth="70px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" DataField="Sessionname" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="From Time (Hrs.)" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="40px" HeaderStyle-Width="70px" DataField="Fromtime" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Till Time (Hrs.)" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="40px" HeaderStyle-Width="70px" DataField="Tilltime" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular Rate(Rs.)" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" DataField="Regularrate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Casual Rate(Rs.)" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" DataField="Casualrate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Guest Rate(Rs.)" HeaderStyle-Width="70px" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataField="Guestrate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Home Service(Rs.)" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" DataField="Homeservice" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="100px" DataField="Fintxndescription" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="5" cellspacing="5">

                            <tr>

                                <td>
                                  <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="Server" Text="Session Group :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                                </td>
                                <td>
                                     <asp:DropDownList ID="ddlSessionGroup" CssClass="form-control" runat="server" ToolTip="Please choose Vila No's are enabled for SiteName.">
                                            <asp:ListItem Text="Meal" Value="Meal"></asp:ListItem>
                                            <asp:ListItem Text="TCM" Value="TCM"></asp:ListItem>
                                         <asp:ListItem Text="SPL" Value="SPL"></asp:ListItem>
                                         <asp:ListItem Text="OTHR" Value="OTHR"></asp:ListItem>
                                     </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="lblSessioncode" runat="Server" Text="Session code :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                                    <text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSessioncode" runat="Server" MaxLength="2"  Width="150px" ToolTip="Enter a numeric value in such a way that the session names appear in a proper order in which they occur in a day.ML.2." CssClass="form-control" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSessionname" runat="Server" Text="Session name :" ForeColor=" Black " Font-Names="Verdana"></asp:Label>
                                    <text style="color: red;">*</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSessionname" runat="Server" MaxLength="12" ToolTip="Name of the session.Ex Lunch,Dinner. ML12."  CssClass="form-control" Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblFromTime" runat="Server" Text="From Time :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                                    <text style="color: gray;">(Hrs.)</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFromTime" runat="Server" MaxLength="7" ToolTip="What is the start time for the session.ML7."  CssClass="form-control" Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTilltime" runat="Server" Text="Till time :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                                    <text style="color: gray;">(Hrs.)</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTilltime" runat="Server" MaxLength="7" ToolTip="What is the closing time for the session. ML7."  CssClass="form-control" Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblRegularrate" runat="Server" Text="Regular rate :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                                    <text style="color: gray;">(Rs.)</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRegularrate" runat="Server" MaxLength="7" Text="0.00" ToolTip="What is the standard tariff for this session for a resident? ML7." CssClass="form-control rightAlign" Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                        <td>
                            <asp:Label ID="lblCasualrate" runat="Server" Text="Casual Rate :" ForeColor="Black" Font-Names="Verdana"></asp:Label>
                            <text style="color: gray;">(Rs.)</text>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCasualrate" runat="Server" MaxLength="7" Text="0.00" ToolTip="Casual rate for the session.ML7."  CssClass="form-control rightAlign" Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                        </td>
                    </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblGuestrate" runat="Server" Text="Guest rate :" ForeColor=" Black " Font-Names="Verdana"></asp:Label>
                                    <text style="color: gray;">(Rs.)</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGuestrate" runat="Server" MaxLength="7" Text="0.00" ToolTip="What is the tariff to be applied for a guest dining in this session?.ML7."  CssClass="form-control rightAlign" Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblHomeservice" runat="Server" Text="Home service :" ForeColor=" Black " Font-Names="Verdana"></asp:Label>
                                    <text style="color: gray;">(Rs.)</text>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtHomeservice" runat="Server" MaxLength="7" Text="0.00"  CssClass="form-control rightAlign" ToolTip="What is the tariff to be applied for home service (Delivery of food at home)? ML7." Width="150px" ForeColor="DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblFintxnDescription" runat="Server" Text="Description :" ForeColor=" Black " Font-Names="Verdana"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFintxnDescription" runat="Server" TextMode="MultiLine"  CssClass="form-control" MaxLength="240" ToolTip="Write financial transaction description details. ML40." Height="40px" Width="250px" ForeColor="DarkBlue" Font-Names="Verdana"></asp:TextBox>
                                </td>
                            </tr>

                                      </table>
                                </td>
                                <td style="vertical-align:top">
                                    <asp:Label ID="Label1" ForeColor="DarkGray" Font-Names="verdana"  runat="server" Text="Set the dining sessions at the time of implementation. You can add new sessions at any time."></asp:Label><br />
                                    <asp:Label ID="Label2" ForeColor="DarkGray" Font-Names="verdana"  runat="server" Text="This is an important step before setting up  Menu for a session and to raise bills for dining."></asp:Label><br />
                                    <asp:Label ID="Label3" ForeColor="DarkGray" Font-Names="verdana"  runat="server" Text="Rates per session are optional and to be used if session based billing is followed."></asp:Label><br />
                                    <asp:Label ID="Label4" ForeColor="DarkGray" Font-Names="verdana"  runat="server" Text="If A La Carte billing is being followed, set rate per food menu item."></asp:Label><br />
                                    <asp:Label ID="Label5" ForeColor="DarkGray" Font-Names="verdana"  runat="server" Text="If Session code is 10 or 20 or 30 or 40 it is a main session."></asp:Label>
                                </td>

                                </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSave" OnClientClick="return Validate();" OnClick="btnSave_Click" runat="Server"  CssClass="btn btn-success" Text="Save" ToolTip="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" />
                                    <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the details" OnClick="btnUpdate_Click" CssClass="btn btn-success" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" />
                                </td>
                                <td>
                                    <asp:Button ID="btnClear" OnClick="btnClear_Click" runat="Server" CssClass="btn btn-success" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="White" BackColor="DarkOrange" BorderColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" />
                                </td>
                                <td>
                                    <asp:Button ID="btnExit" OnClick="btnExit_Click" runat="Server" CssClass="btn btn-success" Text="Exit" ToolTip="Clik here to exit" ForeColor="White" BackColor=" DarkBlue" BorderColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" />
                                
                                </td>
                            </tr>
                        </table>

                       
                    </div>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

