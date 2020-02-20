<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintReceipt.aspx.cs" Inherits="PrintReceipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scpt1" runat="server"></asp:ScriptManager>
       
        <style type="text/css">
            .divstle

         {
 width:90%;
 height:400px;
 padding:10px;
 margin-left:5%; 
 margin-top:20px;
 font-family:Verdana;
 font-size:small;
  -webkit-border-radius: 10px;
 -moz-border-radius: 10px;
 border-radius: 10px;

 background:rgba(239,237,245,0.8);
 /*-webkit-box-shadow: #B3B3B3 3px 3px 3px;
 -moz-box-shadow: #B3B3B3 3px 3px 3px;
  box-shadow: #B3B3B3 3px 3px 3px;*/
            }    
            .topdiv{
                width:99%;
                height:99%;

            }      
        </style>
        <asp:UpdatePanel ID="upreceipt" runat="server">
            <ContentTemplate>
                  <div class="topdiv">
             <div class="divstle">
                  <table style="width:75%;margin-left:10%; border-spacing:5px;">
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblstrcname" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium" Font-Bold="true"></asp:Label><br />
                            <asp:Label ID="lblstrphone" runat="Server" ForeColor="Black" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                            <asp:Label ID="lblstremail" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                            <asp:Label ID="lblcashreceipt" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium" Text ="Receipt" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                      <tr>
                          <td>
                              <asp:Label ID="Label2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"  Text ="Receipt No :"></asp:Label>
                              <asp:Label ID="lblstrreceiptno" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                          </td>
                          <td align="right">
                              <asp:Label ID="Label1" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"  Text ="Receipt Date :"></asp:Label>
                              <asp:Label ID="lblstrreceiptdate" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                          </td>
                      </tr>
                </table>
        <br />
        <table style="width: 75%;margin-left:10%; border-spacing:5px; border-collapse:collapse;" cellpadding="2" cellspacing="0" border="1">
            <tr>
                         
                        <td>
                            <asp:Label ID="lblReceiptNo" runat="Server" Text="Received with thanks from" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrname" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>


                </tr>
                <tr>
                        <td>
                            <asp:Label ID="lblDate" runat="Server" Text="Door No" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrdoorno" runat="Server" ForeColor="Black" Font-Names="Verdana" Text="" Font-Size="Small "></asp:Label>
                        </td>
                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblFUHID" runat="Server" Text="Amount" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstramount" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>

                    </tr>
                    <tr> 
                        <td>
                            <asp:Label ID="lblpaymentmode" runat="Server" Text="Payment Mode " ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrpaymode" runat="Server" ForeColor="Black" Font-Names="Verdana" Text="" Font-Size="Small "></asp:Label>
                        </td>
                        
                    </tr>
                   
                    <tr>
                       
                       <td>
                            <asp:Label ID="Label3" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrnarration" runat="Server" Text="" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                     </tr>
                       
                   
                </table>
        <br />

        <table style="width: 75%;margin-left:10%;">
            <tr>                
                <td> 
                       <asp:Label ID="lblstramtinwords" runat="server" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                   
                </td>
            </tr>
        </table>

                 <br />

         <table style="width: 75%;margin-left:10%;">
            <tr>                
                <td align="right"> 
                       <asp:Label ID="lblfor" runat="server" Text="Signed By" Font-Bold="false" Font-Italic="true" Font-Size="Small" ></asp:Label>
                   
                </td>
            </tr>
        </table>

        <br />
      
        <div style="margin-left:10%;text-align:left;margin-top:8%" >
            <asp:Label ID="bPrintedBy" runat="server" Text="Printed By :" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="bPrintedByVal" runat="server" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="lblbPrintedOn" runat="server" Text="Printed On :" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="lblPrintedOnDate" runat="server"  Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
           
        </div>
    </div>
       <div style="width:75%;margin-left:2%;text-align:center;">
      <asp:Label ID="line" runat="server" >
          -------------------------------------------------------------------------------------------------------------
      </asp:Label>
            </div>

          <div class="divstle">
      <table style="width: 75%;margin-left:10%;">
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblstrcname2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium" Font-Bold="true"></asp:Label><br />
                            <asp:Label ID="lblstrphone2" runat="Server" ForeColor="Black" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                            <asp:Label ID="lblstremail2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                            <asp:Label ID="lblcashreceipt2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium" Text ="Receipt" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                      <tr>
                          <td>
                              <asp:Label ID="Label8" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"  Text ="Receipt No :"></asp:Label>
                              <asp:Label ID="lblstrreceiptno2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                          </td>
                          <td align="right">
                              <asp:Label ID="Label10" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"  Text ="Receipt Date :"></asp:Label>
                              <asp:Label ID="lblstrreceiptdate2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                          </td>
                      </tr>
                </table>
        <br />
        <table style="width: 75%;margin-left:10%; border-spacing:5px; border-collapse:collapse;" cellpadding="2" cellspacing="0" border="1">
            <tr>
                         
                        <td>
                            <asp:Label ID="Label12" runat="Server" Text="Received with thanks from" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrname2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>


                </tr>
                <tr>
                        <td>
                            <asp:Label ID="Label14" runat="Server" Text="Door No" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrdoorno2" runat="Server" ForeColor="Black" Font-Names="Verdana" Text="" Font-Size="Small "></asp:Label>
                        </td>
                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label16" runat="Server" Text="Amount" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstramount2" runat="Server"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>

                    </tr>
                    <tr> 
                        <td>
                            <asp:Label ID="Label18" runat="Server" Text="Payment Mode " ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrpaymode2" runat="Server" ForeColor="Black" Font-Names="Verdana" Text="" Font-Size="Small "></asp:Label>
                        </td>
                        
                    </tr>
                   
                    <tr>
                       
                       <td>
                            <asp:Label ID="Label20" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblstrnarration2" runat="Server" Text="" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                        </td>
                     </tr>
                       
                   
                </table>
        <br />

        <table style="width: 75%;margin-left:10%;">
            <tr>                
                <td> 
                       <asp:Label ID="lblstramtinwords2" runat="server" ForeColor="Black" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                   
                </td>
            </tr>
        </table>

              <br />

       <table style="width: 75%;margin-left:10%;">
            <tr>                
                <td align="right"> 
                       <asp:Label ID="lblfor2" runat="server" Text="Signed By" Font-Bold="false"  Font-Italic="true" Font-Size="Small" ></asp:Label>
                   
                </td>
            </tr>
        </table>

        <br />
      
        <div style="margin-left:10%;text-align:left;margin-top:8%" >
            <asp:Label ID="bPrintedBy2" runat="server" Text="Printed By :" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="bPrintedByVal2" runat="server" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="lblbPrintedOn2" runat="server" Text="Printed On :" Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
            <asp:Label ID="lblPrintedOnDate2" runat="server"  Font-Bold="false" Font-Italic="true" Font-Size="X-Small" ></asp:Label>
           
        </div>
    </div>
            
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
      
    </form>
</body>
</html>
