<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="GLAccMasterView.aspx.cs" Inherits="GLAccMasterView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("[id$=TxtSGST]").keypress(function (event) {
                return isDecimal(event, this);

            });
            $("[id$=TxtCGST]").keypress(function (event) {
                return isDecimal(event, this);

            });
        });
        function isDecimal(evt, element) {
            var charcode = (evt.which) ? evt.which : evt.keycode
            if ((charcode != 46 || $(element).val().indexOf('.') != -1) && (charcode < 48 || charcode > 57)) {

                return false;
            }
        }
        function chkSave() {
            var saveText = document.getElementById('<%= BtnSave.ClientID %>').value;
            var msg = "Do you want to save new transaction posting rule?";
            if (saveText == "Update") {
                msg = "Do you want to update new transaction posting rule?";
            }

            if (confirm(msg)) {
                //alert('hi');
                var txnCode = document.getElementById('<%= TxtTxnCode.ClientID %>').value;
                //alert(txnCode);
                var stdNarration = document.getElementById('<%= TxtStdNarration.ClientID %>').value;
                //alert(stdNarration);
                var drcr = document.getElementById('<%= DdlDrCr.ClientID %>').value;
                //alert(drcr);
                var ie = document.getElementById('<%= DdlIE.ClientID %>').value;
                //alert(ie);
                var affects = document.getElementById('<%= DdlAffects.ClientID %>').value;
                //alert(affects);
                var SC = document.getElementById('<%= DdlSC.ClientID %>').value;
                //alert(SC);
                var contraAC = document.getElementById('<%= drpContraAcc.ClientID %>').value;
                //alert(contraAC);
                var prog = document.getElementById('<%= DdlProg.ClientID %>').value;
                //alert(prog);
                var help = document.getElementById('<%= TxtHelp.ClientID %>').value;
                //alert(help);
                if (txnCode == '') {
                    alert('Please enter Transaction Code');
                    <%--document.getElementById('<%= TxtTxnCode.ClientID %>').focus();--%>
                    return false;
                }
                else if (stdNarration == '') {
                    alert('Please enter Std Narration');
                    <%--document.getElementById('<%= TxtStdNarration.ClientID %>').focus();--%>
                    return false;
                }

                else if (drcr == '0') {
                    alert('Please select Dr or Cr');
                    <%--getElementById('<%= DdlDrCr.ClientID %>').focus();--%>
                    return false;
                }
                else if (ie == '0') {
                    alert('Please select I or E');
                    <%--getElementById('<%= DdlIE.ClientID %>').focus();--%>
                    return false;
                }
                else if (affects == '0') {
                    alert('Please select Affects');
                    <%--getElementById('<%= DdlAffects.ClientID %>').focus();--%>
                    return false;
                }
                else if (SC == '0') {
                    alert('Please select S or C');
                    <%--getElementById('<%= DdlSC.ClientID %>').focus();--%>
                    return false;
                }
                else if (contraAC == '') {
                    alert('Please enter Contra A/C');
                    <%--getElementById('<%= TxtContraAc.ClientID %>').focus();--%>
                    return false;
                }
                else if (prog == '0') {
                    alert('Please select Program');
                    <%--getElementById('<%= TxtProg.ClientID %>').focus();--%>
                    return false;
                }
                else if (help == '') {
                    alert('Please enter Help');
                    <%--getElementById('<%= TxtHelp.ClientID %>').focus();--%>
                    return false;
                }
                else
                    return true;
}
else {
    return false;
}
}
function chkCancel() {
    if (confirm('Do you want to cancel?'))
        return true;
    else
        return false;
}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="font-family: Verdana; font-size: small;" runat="server" id="DivTPRView">
                <table style="width: 90%;">
                    <tr>
                        <td align="Center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="width: 50%;">
                        <td align="right">
                            <asp:Button ID="BtnAdd" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Add New Rule" OnClick="BtnAdd_Click" ForeColor="White" ToolTip="Click here to add new transaction posting rule." />
                            <asp:Button ID="BtnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="gvGLView" Skin="WebBlue" runat="server" AutoPostBack="true" Height="450PX" Width="1130px"
                                AutoGenerateColumns="False" AllowSorting="True" AllowFilteringByColumn="true" GroupingSettings-CaseSensitive="false" OnInit="gvGLView_Init" OnItemCommand="gvGLView_ItemCommand">
                                <ClientSettings>
                                    <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                    <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <NoRecordsTemplate>
                                        No Record Found...
                                    </NoRecordsTemplate>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="true"
                                            HeaderText="TxnCd" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="14px" DataField="TxnCode" UniqueName="TxnCode"
                                            FilterControlWidth="50px" HeaderTooltip="Two character unique code used in the appropriate ProgMenu. Once set should not be changed. Click on Txn Code to edit transaction posting rule">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" CommandName='<%# Eval("TxnCode") %>' Style="font-family: Verdana; font-size: 12px;"
                                                    runat="server" ForeColor="Blue" Text='<%# Eval("TxnCode") %>' OnClick="lnkEdit_Click" ToolTip="Clicke here to edit transaction posting rule" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="true"
                                            HeaderText="Std.Narration" HeaderStyle-Width="100px" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="12px" DataField="StdNarration" UniqueName="StdNarration"
                                            AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="Std.description that is inserted in the transactions posted with reference to the TxnCd.">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkGSTPopup" CommandName='<%# Eval("TxnCode") %>' Style="font-family: Verdana; font-size: 12px;"
                                                    runat="server" ForeColor='<%# Eval("CGST_PCNT").ToString() == "" ? System.Drawing.Color.Black : System.Drawing.Color.Blue %>' Text='<%# Eval("StdNarration") %>' Enabled='<%# Eval("CGST_PCNT").ToString() == "" ? false: true %>' OnClick="lnkGSTPopup_Click" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridBoundColumn HeaderText="TxnCd" HeaderStyle-Width="80px" DataField="TxnCode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50px" HeaderTooltip="Two character unique code used in the appropriate ProgMenu.  Once set should not be changed."></telerik:GridBoundColumn>--%>
                                        <%--<telerik:GridBoundColumn HeaderText="Std.Narration	" HeaderStyle-Width="100px" DataField="StdNarration" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="Std.description that is inserted in the transactions posted with reference to the TxnCd."></telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Dr/Cr" HeaderStyle-Width="90px" DataField="DrCr" ReadOnly="true" AllowFiltering="true" HeaderTooltip="The primary action is it a Debit or a Credit" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Affects" HeaderStyle-Width="100px" DataField="Affects" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="The primary action as mentioned in the Dr//Cr col.affects which account. R - Resident monthly billing account, D-Resident Deposit account, G - General Ledger A/C"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Contra A/C" HeaderStyle-Width="100px" DataField="ContraAC" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="The other side of the transaction affects which GL accounts.   Ex: If Resident is DEBITED, the Contra A/C and other Acs mentioned are CREDITED"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="CGST%" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px" DataField="CGST_PCNT" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="What is the percentage to be charged towards Central GST"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="CGST GL" HeaderStyle-Width="100px" DataField="CGST_AC" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="What is the GL Account for Central GST"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SGST %" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="80px" DataField="SGST_PCNT" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="What is the percentage to be charged towards State GST"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SGST GL" HeaderStyle-Width="100px" DataField="SGST_AC" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="What is the GL Account for State GST"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="I or E" HeaderStyle-Width="70px" DataField="IorE" ReadOnly="true" AllowFiltering="true" FilterControlWidth="40px" HeaderTooltip="I - The % to be charged is already included in the total amount/ Ex: If resident is debited Rs 1000, the GST is already included in it.   E - Excluded ( Usual value)."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="S or C" HeaderStyle-Width="70px" DataField="SorC" ReadOnly="true" AllowFiltering="true" FilterControlWidth="40px" HeaderTooltip="S - Show each transaction as separate lines in the Statement of Account,  C - Show all Credits as one combined line.  Usually it is 'S'"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Prog" HeaderStyle-Width="100px" DataField="PM" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="Which ProgMenu uses this TxnCd MEB - MonthEndBilling. TP-TxnPosting.,  AC= A LaCarte Billing,  GH -Guest House Txns,  VH=Vehicle billing,  SV= Services"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="HSN CODE" HeaderStyle-Width="100px" DataField="HSNCODE" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderTooltip="HSN CODE FOR MONTH END BILLING."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Help" HeaderStyle-Width="350px" DataField="Help" ReadOnly="true" AllowFiltering="true" FilterControlWidth="250px" HeaderTooltip="Brief description about the purpose of the TxnCd.  New codes can be defined but will need appropriate prog menu options also."></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <telerik:RadWindowManager ID="rwmgrMain" runat="server">
                    <Windows>
                        <telerik:RadWindow ID="rwGSTPopUp" runat="server" Modal="true" CenterIfModal="true" Title="Transaction Posting Rules" VisibleOnPageLoad="false" Visible="false" Height="230px" Width="350px">
                            <ContentTemplate>
                                <div align="center" width="100%;">

                                    <asp:Label runat="server" Font-Size="12px" Font-Bold="true">Example</asp:Label>

                                    <table cellpadding="5" cellspacing="5" width="70%" style="font-family: Verdana; font-size: 12px;" >
                                        <tr>
                                            <td>
                                                <asp:Label runat="server">Txn Code</asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Font-Bold="true" ForeColor="DarkBlue" ID="LblTxnCode"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server">Amount</asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server">&#8377;&nbsp;1000.00</asp:Label>
                                                <asp:Label runat="server" ID="LblIorE" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="LblCGSTPer"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server">&#8377;</asp:Label>
                                                <asp:Label runat="server" ID="LblCGSTAmt"></asp:Label>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="LblSGSTPer"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server">&#8377;</asp:Label>
                                                <asp:Label runat="server" ID="LblSGSTAmt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="font-weight:bold;">
                                            <td>
                                                <asp:Label runat="server" >Total</asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server">&#8377;</asp:Label>
                                                <asp:Label runat="server" ID="LblTotalAmt"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                            </ContentTemplate>
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
            </div>
            <div runat="server" id="DivtPRAddEdit" visible="false">
                <table style="width: 90%; margin-left: 5%;">
                    <tr>
                        <td align="Left">
                            <asp:Label runat="server" ID="LblTitle1" Font-Names="verdana" Font-Size="12px" ForeColor="Green" Font-Bold="true">Add New Rule</asp:Label>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <table style="width: 90%;">
                                <tr>
                                    <td>
                                        <asp:Label runat="server">Txn Code</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtTxnCode" CssClass="form-control" TabIndex="1" Font-Names="Verdana" Font-Size="12px" MaxLength="2" ToolTip="Enter Transaction Code"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label runat="server">SGST %</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtSGST" CssClass="form-control" Font-Names="Verdana" TabIndex="8" Font-Size="12px" MaxLength="4" ToolTip="Enter SGST in Percentage "></asp:TextBox>
                                    </td>


                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">Std.Narration</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtStdNarration" TextMode="MultiLine" Rows="2" TabIndex="2" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" MaxLength="40" ToolTip="Enter Std. Narration "></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label runat="server">SGST GL</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtSGSTGL" CssClass="form-control" Font-Names="Verdana" TabIndex="9" Font-Size="12px" MaxLength="8" ToolTip="Enter SGST GL "></asp:TextBox>
                                    </td>


                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">Dr/Cr</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="DdlDrCr" Font-Names="Verdana" TabIndex="3" Font-Size="12px" ToolTip="Select Transaction Type">
                                            <asp:ListItem Value="0">-- Please Select --</asp:ListItem>
                                            <asp:ListItem Value="CR">CR</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="DR">DR</asp:ListItem>

                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label runat="server">I or E</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="10" ID="DdlIE" ToolTip="Select I or E">
                                            <asp:ListItem Value="0">-- Please Select --</asp:ListItem>
                                            <asp:ListItem Value="E" Selected="True">E</asp:ListItem>
                                            <asp:ListItem Value="I">I</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>


                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">Affects</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="4" ID="DdlAffects" ToolTip="Select Affects">
                                            <asp:ListItem Value="0">-- Please Select --</asp:ListItem>
                                            <asp:ListItem Value="D">D</asp:ListItem>
                                            <asp:ListItem Value="G">G</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="R">R</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label runat="server">S or C</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="11" ID="DdlSC" ToolTip="Select S or C">
                                            <asp:ListItem Value="0">-- Please Select --</asp:ListItem>
                                            <asp:ListItem Value="C">C</asp:ListItem>
                                            <asp:ListItem Value="S" Selected="True">S</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">Contra A/C</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="5" ID="drpContraAcc" ToolTip="Select Contra Account">
                                           
                                        </asp:DropDownList>
                                        <%--<asp:TextBox runat="server" ID="TxtContraAc" CssClass="form-control" Font-Names="Verdana" TabIndex="5" Font-Size="12px" MaxLength="8" ToolTip="Enter Contra Account"></asp:TextBox>--%>
                                    </td>
                                    <td>
                                        <asp:Label runat="server">Prog</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="11" ID="DdlProg" ToolTip="Select Program">
                                            <asp:ListItem Value="0">-- Please Select --</asp:ListItem>
                                            <asp:ListItem Value="AC" Selected="True">AC</asp:ListItem>
                                            <asp:ListItem Value="DG">DG</asp:ListItem>
                                            <asp:ListItem Value="GH">GH</asp:ListItem>
                                            <asp:ListItem Value="MEB">MEB</asp:ListItem>
                                            <asp:ListItem Value="TP">TP</asp:ListItem>
                                             <asp:ListItem Value="SV">SV</asp:ListItem>
                                             
                                        </asp:DropDownList>

                                        <%--<asp:TextBox runat="server" ID="TxtProg" CssClass="form-control" Font-Names="Verdana" Font-Size="12px" TabIndex="12" MaxLength="4" ToolTip="Enter Prog"></asp:TextBox>--%>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">CGST %</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtCGST" CssClass="form-control" Font-Names="Verdana" TabIndex="6" Font-Size="12px" MaxLength="4" ToolTip="Enter CGST in Percentage"></asp:TextBox>
                                    </td>
                                    <td rowspan="2">
                                        <asp:Label runat="server">Help</asp:Label><span style="color: red;"> *</span>
                                    </td>
                                    <td rowspan="2">
                                        <asp:TextBox runat="server" TextMode="MultiLine" Rows="3" ID="TxtHelp" Font-Names="Verdana" Font-Size="12px" TabIndex="13" CssClass="form-control" MaxLength="240" ToolTip="Enter Help"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">CGST GL</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TxtCGSTGL" CssClass="form-control" Font-Names="Verdana" TabIndex="7" Font-Size="12px" MaxLength="8" ToolTip="Enter CGST GL"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server">HSN CODE</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txthsncode" CssClass="form-control" Font-Names="Verdana" TabIndex="8" Font-Size="12px" MaxLength="15" ToolTip="Enter HSN CODE."></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <asp:Button ID="BtnSave" runat="server" CssClass="btn btn-success" Font-Names="Verdana" Font-Size="12px" TabIndex="14" Font-Bold="true" Text="Save" OnClientClick="return chkSave();" OnClick="BtnSave_Click" ForeColor="White" ToolTip="Click here to save/update transaction posting rules" />
                                        <asp:Button ID="BtnCancel" runat="server" CssClass="btn btn-default" Font-Names="Verdana" Font-Size="12px" TabIndex="15" Font-Bold="true" Text="Cancel" OnClientClick="return chkCancel();" OnClick="BtnCancel_Click" ForeColor="Black" ToolTip="Click here to cancel" />
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

