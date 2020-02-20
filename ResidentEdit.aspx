<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ResidentEdit.aspx.cs" Inherits="ResidentEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .lblStyle {
            color: darkblue;
            font-family: Verdana;
            font-size: 13px;
            font-weight: bold;
        }

        .lblRStyle {
            color: darkblue;
            font-family: Verdana;
            font-size: 13px;
        }

        .ButtonInfi {
            background-color: #38ACEC;
            width: 50px;
            height: 25px;
            padding: 5px;
            color: white;
            cursor: pointer;
            text-align: center;
            align-self: flex-start;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            behavior: url(/border-radius.htc);
            border-radius: 5px;
        }



        .TableBorder {
            border-bottom-style: ridge;
            border-bottom-color: Gray;
            border-bottom-width: thin;
            border-top-style: ridge;
            border-top-color: Gray;
            border-top-width: thin;
            border-left-style: ridge;
            border-left-color: Gray;
            border-left-width: thin;
            border-right-style: ridge;
            border-right-color: Gray;
            border-right-width: thin;
        }

        .bgimage {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .txtbox {
            padding: 4px 2px;
            border: solid 1px #AAA;
            display: inline-block;
            border-radius: 8px;
        }



        .tablejs {
            border-collapse: collapse;
            border-style: inset;
        }

            .tablejs td, table th {
                border: 1px solid black;
                border-top-color: lightgray;
                border-bottom-color: lightgray;
                border-right-color: lightgray;
                border-left-color: lightgray;
            }
    </style>


    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>

            <table>
                <tr>
                    <td>
                        <telerik:RadWindow ID="rwPopup" Width="350" Height="195" VisibleOnPageLoad="false" runat="server" Title="Billing rules for regular diners" Modal="true" BackColor="White" VisibleStatusbar="false">
                            <ContentTemplate>
                                <table style="width: 100%; background-color: #ffffcc">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label16" runat="Server" Text="Rate per meal:" Font-Names="verdana" ForeColor="Brown" ToolTip="This is the rate applied per meal if a person consumes atleast the minimum no.of meals in the month."></asp:Label>
                                            <asp:Label ID="lblMealRate" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label25" runat="Server" Text="No. of meals per day:" Font-Names="verdana" ForeColor="Brown" ToolTip="Sessions with codes 10,20,30 , 40  are termed as main sessions and these are considered to count the no.of meals in a day.  (Typically Breakfast, Lunch, Dinner are considered as main sessions / meals , while sessions for Tea, Evening Tiffin are not so)."></asp:Label>
                                            <asp:Label ID="lblNoMeals" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label29" runat="Server" Text="Minimum no. of meals:" Font-Names="verdana" ForeColor="Brown" ToolTip=" These many meals are to be consumed in a month as otherwise the exception rate will be charged."></asp:Label>
                                            <asp:Label ID="lblMinMeals" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="Label32" runat="Server" Text="Rate Exception:" Font-Names="verdana" ForeColor="Brown" ToolTip="This rate is applied per meal if the no.of meals in a month goes below the minimum value."></asp:Label>
                                                <asp:Label ID="lblRateExcep" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </tr>
                                </table>
                                <table style="width: 100%; background-color: #ffffcc">
                                    <tr>
                                        <td align="lef">
                                            <asp:Label ID="Label34" runat="Server" Text="This data is maintained in the Settings." Font-Size="X-Small" Font-Names="verdana" ForeColor="DarkGray"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>

                        </telerik:RadWindow>

                        <telerik:RadWindow ID="rwPopup2" Width="700" Height="300" VisibleOnPageLoad="false" runat="server" Title="Billing rules for regular diners" Modal="true" BackColor="White" VisibleStatusbar="false">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td style="width: 60%; vertical-align: top">
                                            <telerik:RadGrid ID="grdBillingDays" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="300px" Width="700px" AllowFilteringByColumn="true" AllowPaging="false">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                </ClientSettings>
                                                <MasterTableView AllowFilteringByColumn="true">
                                                    <Columns>
                                                       
                                                        <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="100px" DataField="RSN" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Resident" HeaderStyle-Width="120px" DataField="Resident" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" FilterControlWidth="60px" DataField="Status" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Billing Month" HeaderStyle-Width="80px" FilterControlWidth="60px" ItemStyle-Width="80px" DataField="BillingMonth" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="From" HeaderStyle-Width="80px" FilterControlWidth="50px" DataField="FromDt" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Till" HeaderStyle-Width="80px" FilterControlWidth="50px" DataField="TillDt" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Days" HeaderStyle-Width="80px" FilterControlWidth="50px" ItemStyle-Width="80px" DataField="DNNoDays" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="150px" DataField="Remarks" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>

                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>

                        </telerik:RadWindow>

                    </td>
                </tr>
            </table>

            <div>
                <table style="width: 100%;">
                    <tr style="height: 10px"></tr>
                    <tr>
                        <td style="width: 100%" align="center">
                            <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Text="Profile Snapshot"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>

            <div>
                <telerik:RadWindow ID="rwDoorNoDet" runat="server" VisibleOnPageLoad="false" Width="480px" Height="500px"
                    Font-Names="Arial" Font-Size="Small" ForeColor="Black" Animation="FlyIn" BackColor="Beige">
                    <ContentTemplate>
                        <div style="padding-top: 5px; background-color: SkyBlue; height: 25px; vertical-align: middle;">
                            <h3 style="font-family: Arial; font-size: small; color: Black;" align="center"></h3>
                            <br />
                        </div>
                        <div>
                            <table>
                                <tr style="height: 20px"></tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label6" runat="Server" Text="Door No." CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtDoorNo" runat="Server" Width="165px" Height="25px" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label17" runat="Server" Text="Type" CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtType" runat="Server" Width="165px" Height="25px" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label27" runat="Server" Text="Floor" CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtFloor" runat="Server" Width="165px" Height="25px" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label31" runat="Server" Text="Block" CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtBlock" runat="Server" Width="165px" Height="25px" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label33" runat="Server" Text="Construction" CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtConstruction" runat="Server" Width="165px" Height="25px" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; padding: 3px;">
                                        <asp:Label ID="Label35" runat="Server" Text="Description" CssClass="lblStyle"></asp:Label>
                                    </td>
                                    <td style="padding: 3px;">
                                        <asp:TextBox ID="txtDescription" runat="Server" MaxLength="8" ToolTip="" Width="300px" Height="130px" TextMode="MultiLine" CssClass="lblRStyle" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </ContentTemplate>
                </telerik:RadWindow>
            </div>

            <div style="width: 100%; min-height: 700px; max-height: 900px">
                <table>
                    <tr style="height: 10px"></tr>
                    <tr>
                        <td style="width: 15px"></td>
                        <td id="tdTab" style="width: 1100px; height: 500px; vertical-align: top; background-color: white" visible="true" runat="server">
                            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="MPResidentView"
                                Skin="Sunset" BorderColor="LightGray" BorderStyle="Ridge" BorderWidth="0px" SelectedIndex="3" Style="margin-bottom: 0">
                                <Tabs>
                                    <telerik:RadTab runat="server" Text="Profile" PageViewID="VProfile" CssClass="lblStyle" Font-Bold="true"
                                        ToolTip="Click to view particulars of the resident" Selected="true">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" Text="KeyInfo" PageViewID="KeyInfo" CssClass="lblStyle" Font-Bold="true"
                                        ToolTip="Click to view priority information of the resident">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" Text="Additional Info" PageViewID="AddInfo" CssClass="lblStyle" Font-Bold="true"
                                        ToolTip="Click to view additional information of the resident">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>


                            <telerik:RadMultiPage ID="MPResidentView" runat="server" SelectedIndex="6" Width="1100px"
                                Height="100%" Visible="true" BorderColor="#E3E4FA" BorderStyle="Ridge" BorderWidth="1">

                                <telerik:RadPageView ID="VProfile" runat="server" ForeColor="Black" Height="500px" Width="1100px" Selected="true">
                                    <table style="width: 100%;">
                                        <tr style="background-color: white">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblProfile" Text="Profile" CssClass="lblStyle" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label1" Text="Door no." CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <%--<asp:Label runat="server" ID="lblDoorNo" CssClass="lblRStyle"></asp:Label>--%>
                                                <asp:LinkButton runat="server" ID="lblDoorNo" CssClass="lblRStyle" OnClick="lbtnAdd_Click" ToolTip="Click to view the house details."></asp:LinkButton>

                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label5" Text="Internal ID" CssClass="lblStyle" ForeColor="LightGray" Font-Bold="false"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblInternalID" CssClass="lblRStyle" ForeColor="LightGray" Font-Size="X-Small" ToolTip="Unique resident ID used internally"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label2" Text="Name" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblName" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label7" Text="Occupants" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblOccupants" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                               
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label8" Text="Type" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblResidentType" CssClass="lblRStyle" ToolTip="Shows type of the resident"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label3" Text="Phone" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblPhone" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="lblHDoorNoStatus" Text="Status" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDoorNoStatus" CssClass="lblRStyle"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label4" Text="Mobile no." CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblMobileNo" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblHEmailID" Text="Email id" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblEmailID" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                               
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblEmailID2" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblHWhatsApp" Text="WhatsApp" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblWhatsApp" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="lblBloodGroup" CssClass="lblRStyle" ToolTip="Blood Group"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblGender" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblHFaceBook" Text="Facebook" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblFaceBook" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label10" Text="D.O.B" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDOB" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblHSkype" Text="Skype" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblSkype" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label11" Text="M.Status" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblMStatus" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label9" Text="Address" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblAddress1" CssClass="lblRStyle" ToolTip="Shows permanent address"></asp:Label>
                                            </td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>

                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                       
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblAddress2" CssClass="lblRStyle" ToolTip="Shows permanent address"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label12" Text="For dining" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblForDining" CssClass="lblRStyle"></asp:Label>
                                               <%-- &nbsp;&nbsp;
                                                <asp:ImageButton runat="server" ID="ImgBtnHelp" Height="20px" ImageUrl="~/Images/Help.png" ToolTip="Click here to view the billing rules for regular diners." OnClick="ImgBtnHelp_Click" />
                                                 &nbsp;&nbsp;
                                                <asp:ImageButton runat="server" ID="ImgBtnHelp2" Height="20px" ImageUrl="~/Images/Help.png" ToolTip="Click here to view non dining day." OnClick="ImgBtnHelp2_Click" />--%>

                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                       
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblCity" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label13" Text="For housekeeping" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblForHousKeeping" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                       
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblPinCode" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                       
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblCountry" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label14" Text="Remarks" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblRemarks" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>



                                    </table>
                                </telerik:RadPageView>

                                <telerik:RadPageView ID="KeyInfo" runat="server" ForeColor="Black" Height="475px" Width="1100px" Selected="false">
                                    <table style="width: 100%;">
                                        <tr style="background-color: white">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblKeyInfo" Text="Key info" CssClass="lblStyle" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label18" Text="Door no." CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDoorNo2" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label19" Text="Internal ID" CssClass="lblStyle" ForeColor="LightGray" Font-Bold="false"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblInternalID2" CssClass="lblRStyle" ForeColor="LightGray" ToolTip="Unique resident ID used internally"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label21" Text="Name" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblName2" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label23" Text="Status" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDoorNoStatus2" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label20" Text="Type" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblResidentType2" CssClass="lblRStyle" ToolTip="Shows type of the resident"></asp:Label>
                                            </td>
                                        </tr>

                                    </table>

                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <telerik:RadGrid ID="gvKeyInfo" OnPreRender="gvKeyInfo_PreRender" ShowFooter="true" MasterTableView-FooterStyle-HorizontalAlign="Center" GroupingSettings-CaseSensitive="false" Skin="WebBlue" BorderStyle="Inset" BorderColor="DarkGray" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px" Width="100%">
                                                    <MasterTableView FooterStyle-ForeColor="DarkBlue" AlternatingItemStyle-BackColor="#f0f5f5">

                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Group" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="80px" DataField="GRP" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Description" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="120px" DataField="Code" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Details" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="120px" DataField="Details" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Contact No." AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="80px" DataField="ContactNo" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Email ID" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="80px" DataField="EmailID" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="DOB" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="70px" DataField="DOB" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Date" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="70px" DataField="Date" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Remarks" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" />
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadPageView>

                                <telerik:RadPageView ID="AddInfo" runat="server" ForeColor="Black" Height="475px" Width="1100px" Selected="false">
                                    <table style="width: 100%;">
                                        <tr style="background-color: white">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="lblAddInfo" Text="Additional info" CssClass="lblStyle" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 35%"></td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label22" Text="Door no." CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDoorNo3" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label24" Text="Internal ID" CssClass="lblStyle" ForeColor="LightGray" Font-Bold="false"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblInternalID3" CssClass="lblRStyle" ForeColor="LightGray" ToolTip="Unique resident ID used internally"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;
                                                <asp:Label runat="server" ID="Label26" Text="Name" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblName3" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label28" Text="Status" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblDoorNoStatus3" CssClass="lblRStyle"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="tablejs">
                                            <td style="width: 15%;">&nbsp;&nbsp;                                                
                                            </td>
                                            <td style="width: 35%"></td>
                                            <td style="width: 15%">
                                                <asp:Label runat="server" ID="Label30" Text="Type" CssClass="lblStyle"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <asp:Label runat="server" ID="lblResidentType3" CssClass="lblRStyle" ToolTip="Shows type of the resident"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <telerik:RadGrid ID="gvAddInfo" OnPreRender="gvAddInfo_PreRender" ShowFooter="true" MasterTableView-FooterStyle-HorizontalAlign="Center" GroupingSettings-CaseSensitive="false" Skin="WebBlue" BorderStyle="Inset" BorderColor="DarkGray" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px" Width="100%">
                                                    <MasterTableView FooterStyle-ForeColor="DarkBlue" AlternatingItemStyle-BackColor="#f0f5f5">
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Group" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="70px" DataField="GRP" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Description" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="130px" DataField="Code" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Details" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="140px" DataField="Details" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Contact No." AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="80px" DataField="ContactNo" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Email ID" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="80px" DataField="EmailID" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="DOB" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="60px" DataField="DOB" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Date" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="60px" DataField="Date" ReadOnly="true"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Remarks" AllowFiltering="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" ItemStyle-Width="130px" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" />
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>

                            </telerik:RadMultiPage>
                        </td>
                        <td style="width: 10px"></td>
                        <td valign="top">
                            <table>

                                <tr>
                                    <td>
                                        <asp:Button ID="btnReturn" runat="Server" Width="100px" Text="Return" ToolTip="Click here to return to the resident's profile." ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btnReturn_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Image ID="Custrimage" runat="server" Height="100px" Width="100px" />
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                </table>
                <table style="width: 80%">
                    <tr>
                        <td valign="top">
                            <table runat="server" id="tblOtherResident">
                                <tr style="height: 30px"></tr>
                                <tr>
                                    <td style="width: 15px"></td>
                                    <td>
                                        <asp:Label runat="server" ID="lblStat1" CssClass="lblStyle" Visible="false"></asp:Label>
                                    </td>
                                    <td style="width: 15px"></td>
                                    <td>
                                        <asp:Label runat="server" ID="Label15" Text="Enter door no. to view another profile" CssClass="lblRStyle" ForeColor="Brown"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 15px"></td>
                                    <td valign="top">
                                        <telerik:RadGrid ID="rdgResidentView" FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="600px" Height="150px" Font-Names="Verdana" AllowFilteringByColumn="false" runat="server" Skin="WebBlue" Visible="false" MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="false">
                                            <ClientSettings>
                                                <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridBoundColumn HeaderText="RSN" DataField="RSN" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="70px" Display="false"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Age" DataField="Age" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="150px"></telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkView" runat="server" ToolTip="Click here to view the resident details." Text="View" Font-Bold="false" Font-Size="Small" ForeColor="Blue" Font-Names="Calibri" OnClick="Lnkbtnview_Click"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="width: 15px"></td>
                                    <td valign="top">
                                        <telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="250px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                            EmptyMessage="" ToolTip="" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                            <TextSettings SelectionMode="Single" />
                                        </telerik:RadAutoCompleteBox>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select RTVILLANO +', '+ RTName+', '+convert(nvarchar(10),RTRSN)  as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>

                                    </td>
                                    <td valign="top">
                                        <asp:Button runat="server" ID="btnShowDet" Text="GO" ToolTip="Click here to view the resident details" CssClass="ButtonInfi" OnClick="btnShowDet_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <asp:Label runat="server" ID="lblErrorMsg" CssClass="lblRStyle" ForeColor="Red" Visible="false"></asp:Label>
                                    </td>

                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <table>
                                <tr style="height: 30px"></tr>
                                <tr>
                                    <td style="width: 15px"></td>

                                </tr>
                                <tr style="width: 100%">
                                    <td style="width: 15px"></td>

                                </tr>

                            </table>
                        </td>
                    </tr>
                </table>



            </div>
        </ContentTemplate>
        <Triggers>
            <%-- <asp:PostBackTrigger ControlID="btnRefresh" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

