<%@ Page Title="Monthly Statement" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MailBilling.aspx.cs" Inherits="MailBilling" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial;
        }

        .modal {
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

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 75px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 75px;
                width: 75px;                
            }
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt">
                    <div style="width: 100%; min-height: 300px;">
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                   <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <text style="font-family: Verdana; font-weight: bold;font-size:small;"> Billing Peroid :</text>
                                    &nbsp;
                                     <asp:DropDownList ID="ddlBilling" ToolTip="Select the billing period" runat="server" Width="150px" Height="25px"></asp:DropDownList>
                                    &nbsp;
                                    <asp:Button ID="btnSearch" Font-Names="Verdana" Height="30px" ToolTip="Click here to show sample Monthly statement preview." runat="server" Text="Preview" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" OnClick="btnSearch_Click" />
                                </td>
                            </tr>
                        </table>
                        <table style="width:100%">
                            <tr>
                                <td style="width:50%; vertical-align:top">
                                   
                                         <asp:Label ID="Label1" Visible="true" Text="Current billing month:" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" />
                                         <asp:Label ID="lblCurrentBillingMonth" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" /> <br />
                                         <asp:Label ID="Label2" Visible="true" Text="Previous billing month:" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" />
                                         <asp:Label ID="lblPreviousBillingMonth" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" /><br />
                                         <asp:Label ID="Label3" Visible="true" Text="Total number of month end statements for the previous billing month:" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" />
                                         <asp:Label ID="lblTotal" Visible="true" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black" Font-Size="Small" runat="server" /> 
                                 
                                </td>
                                <td style="vertical-align:top;width:50%">
                                    <asp:Label ID="Label4" Visible="true" Text="This is an automated process which is executed at midnight on the last day of a month." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label5" Visible="true" Text="Example: If it is 31st May the month end job will be executed at 23:50 Hours." Font-Names="Verdana" ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label6" Visible="true" Text="The following activities take place:  (Example:  Date is 31st May 2016 or Billing Month is May 2016)" Font-Names="Verdana"   ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label7" Visible="true" Text="1.Outstandings per resident, at that instant are carried forward to next billing month (June 2016)." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label8" Visible="true" Text="2.Current billing month status is changed as ‘Closed’ and June 2016 is set as the current billing month." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label9" Visible="true" Text="3.Future billing month , which is two months from the new current billing month, is added. (Ex: Aug 2016 in our example)." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label10" Visible="true" Text="4.Records per diner per session are inserted in the Diners_Session table for August 2016.
                                        Diners Session table is needed for Diners booking and for maintaining  the ‘actual count’." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" /><br />
                                    <asp:Label ID="Label11" Visible="true" Text="5.The Month end statements in PDF for all residents are generated as PDF Documents and emailed to the residents.
A CC is also made to the official Email ID." Font-Names="Verdana"  ForeColor="Black" Font-Size="X-Small" runat="server" />
                                    <asp:Label ID="Label12" Visible="true" Text="6.Precisely at 00-05 hours, any auto debits set for residents, are posted. Auto debits can be for monthly service charges, monthly dining charges etc.
The amount to be debited is set in the Resident’s profile in advance." Font-Names="Verdana" ForeColor="Black" Font-Size="X-Small" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSearch" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="updprog" runat="server" AssociatedUpdatePanelID="upnlUpdate">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <img alt="" src="loader.gif" />
                    <text>Loading...</text>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>

