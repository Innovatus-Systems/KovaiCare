<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="PayDetails.aspx.cs" Inherits="PayDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
    
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function checkAmount() {
            var amt = document.getElementById('<%= TxtAmt.ClientID%>').value;
            if (amt == "") {
                alert("Please enter the amount!");
                return false;
            }
            else {
                return true;
            }
        }

        function calTax(e) {

            
            var stax = 0, sbcess = 0, famt = 0, amt = 0; var str;
            var ServiceTax = '<% = HttpContext.Current.Session["STax"] %>';
            var SwaachBhCess = ('<% = HttpContext.Current.Session["SBCess"] %>');
            var key = (window.event) ? e.keyCode : e.which;
            if ((key < 48 || key > 57) & (key != 8) & (key != 190) & (key < 96 || key > 105)) {
                str = document.getElementById('<%= TxtAmt.ClientID%>').value;
                str = str.slice(0, -1);
                document.getElementById('<%= TxtAmt.ClientID%>').value = str;
                event.returnValue = false;
                return false;
            }
            else {
                amt = document.getElementById('<%= TxtAmt.ClientID%>').value;
                if (amt > 0) {
                    //stax = Math.round(amt * (ServiceTax / 100));
                    //sbcess = Math.round(amt * (SwaachBhCess / 100));
                    stax = Math.round((amt / 115) * ServiceTax);
                    sbcess = Math.round((amt / 115) * SwaachBhCess);
                    famt = Math.round(amt - (stax + sbcess));
                }
            }
        
            document.getElementById('<%= TxtServiceTax.ClientID %>').value = stax+'.00';
            document.getElementById('<%= TxtSBCess.ClientID %>').value = sbcess + '.00';
            document.getElementById('<%= TxtFinalAmt.ClientID %>').value = famt + '.00';
       }
    </script>
    
    <div class="divBtns" align="center">
        
        <asp:Button ID="BtnPayDetails" runat="server" Text="Recharge" CssClass="btn" ToolTip="Click here to make your recharge" Visible="false" OnClick="BtnPayDetails_Click" />
        <asp:Button ID="BtnHistory" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge history" OnClick="BtnHistory_Click" Visible="False"/>
        
    </div>

     <table style="width: 100%;">
         
        <tr>
            <td style="width:50%" align="left">
                <asp:Label ID="Label2" runat="server" Style="color:green; font-family: Verdana; font-weight:bold; font-size:medium;" Text="Recharge  your account here."></asp:Label>
            </td>
            <td style="width:50%" align="right">
                <asp:Button ID="BtnStatement" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge Statement" OnClick="BtnStatement_Click" Visible="false"/>
            </td>
        </tr>
     
     </table>
    <table style="width: 100%;">
        
        <tr>

            <td style="width:50%">

                <table>
        
        <tr>
            <td>
               
                    <div class="divCenter">
                        
                         <table cellpadding="5px;">
                          
                            <tr style="color: darkblue;">
                                <td>Recharge Date
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="LblTxnDate" ToolTip="When the debit or credit" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td>Amount you are paying now<span style="color: red;"> *</span>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="TxtAmt" runat="server"  CssClass="txtBoxRight" Placeholder="" 
                                        ToolTip="This is the amount that will be deducted from you" onkeyup="calTax(event);"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td>Service Tax<span style="color: red;"> *</span>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="TxtServiceTax" Enabled="true" runat="server" CssClass="txtBoxRight"  Placeholder="" ToolTip="The tax is for the government. 14.0 % of the amount"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td>Other Taxes<span style="color: red;"> *</span>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="TxtSBCess" Enabled="true"  runat="server" CssClass="txtBoxRight" Placeholder="" ToolTip="This tax is also for the government. 0.5% of the amount "></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td>Amount re-charged <span style="color: red;"> *</span>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="TxtFinalAmt" Enabled="true" runat="server" CssClass="txtBoxRight" Placeholder="" ToolTip="This is the amount that will be actually re-charged  to your account"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td>Description
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:TextBox ID="TxtDesc" Enabled="true" runat="server" CssClass="txtBox" TextMode="MultiLine" Placeholder="" ToolTip="Enter any narration" Style="width: 250px;"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: darkblue;">
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Button CssClass="btn" ID="BtnPay" runat="server" Text="Make Payment" OnClientClick="return checkAmount();" Style="width: auto;" OnClick="BtnPay_Click" ToolTip="Click here to initiate the Payment gateway process." />
                                    <asp:Button CssClass="btn" ID="BtnCancel" runat="server" Text="Cancel" OnClick="BtnCancel_Click"  Tooltip="Click here to cancel the recharge"/>
                                    <asp:Button ID="BtnHome" runat="server" Text="Return" CssClass="btn" ToolTip="Click here to return back to the home page." OnClick="BtnHome_Click" />
                                   
                                </td>
                            </tr>
                           
                        </table>
                    </div>
        
            </td>
        </tr>
                    </table>

                </td>
                
                <td style="vertical-align:top;width:50%">
                     <asp:Label ID="Label3" runat="server" Style="color:darkgray; font-family: Verdana; font-size:small;" Text="When you press the ‘Make Payment’ button you will be redirected to the secure Payment Gateway page.
Further instructions are available in the Payment Gateway page."></asp:Label>
                    <asp:Label ID="Label4" runat="server" Style="color:darkgray; font-family: Verdana; font-size:small;" Text="The Software or the Payment Gateway interface do not store any debit/credit card/net banking data of yours."></asp:Label>
                </td>

            </tr>
        <tr>
            <td align="center" colspan="2">
                                        <telerik:RadGrid ID="rdgTxns" runat="server" AllowSorting="true"
                                        AllowPaging="True" AutoGenerateColumns="False" GridLines="Both" Skin="Vista"
                                        AlternatingItemStyle-BackColor="Beige"
                                       
                                        SelectedItemStyle-BackColor="#99ccff"
                                        OnItemCommand="rdgTxns_ItemCommand"
                                        Font-Names="Verdana" Font-Size="Small"  >
                                        <HeaderContextMenu></HeaderContextMenu>
                                        <HeaderStyle Font-Names="Verdana" Font-Size="9" Font-Bold="false" ForeColor="darkBlue" />
                                        <GroupingSettings CaseSensitive="false" />
                                        
                                       
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                <span style="font-family: Verdana; font-size: small; background-color: yellow;">No Records Found.</span>
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                 <telerik:GridBoundColumn HeaderText="RSN" DataField="RSN" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Transaction ID" DataField="InvoiceNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="TxnDate" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                     <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Recharge Amount" DataField="RechargeAmount" Display="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                     <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Service Tax" DataField="ServiceTax" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                     <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Other Taxes" DataField="SwtchBharatTax" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Amount Credited" DataField="FinalAmount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                     <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Descriptioin" DataField="Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                     <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="0" SaveScrollPosition="true" />
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <FilterMenu EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                    </telerik:RadGrid>
            </td>
        </tr>

      

    </table>
   
</asp:Content>

