<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BillingLevel.aspx.cs" Inherits="BillingLevel" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


   
    <div class="main_cnt">
                <div class="first_cnt">
                    <table>
                        <tr>
                            <td style="width: 1200px; height: 40px; vertical-align: top; background-color: bisque;">
                                <table>
                                    <tr>
                            <td>
                          <asp:Label ID ="lblVN" Text="Villa Number: " ForeColor="Black" Font-Names="Calibri" Font-Size="Small" runat="server" Font-Bold="true" ></asp:Label>
                            </td>
                            <td style="width: 75px">
                          <asp:Label ID ="lblVN1" Text="" ForeColor="Blue" Font-Names="Calibri" Font-Size="Small" runat="server" ></asp:Label>
                            </td>
                              <td>
                          <asp:Label ID ="lblST" Text="Status: " ForeColor="Black" Font-Names="Calibri" Font-Size="Small" Font-Bold="true" runat="server" ></asp:Label>
                            </td>
                           <td style="width: 150px">
                          <asp:Label ID ="lblST1" Text="" ForeColor="Blue" Font-Names="Calibri" Font-Size="Small" runat="server" ></asp:Label>
                            </td>
                            <td>
                          <asp:Label ID ="lblNME" Text="Name: " ForeColor="Black" Font-Names="Calibri" Font-Size="Small" Font-Bold="true" runat="server" ></asp:Label>
                            </td>
                            <td style="width: 150px">
                          <asp:Label ID ="lblNME1" Text="" ForeColor="Blue" Font-Names="Calibri" Font-Size="Small" runat="server" ></asp:Label>
                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>


                      
                        <tr>
                            

                             <td style="width: 1200px; height: 405px; vertical-align: top; background-color: Beige;">
                                 <table>
                                     <tr>
                         
                            <td>

                                <asp:Label ID ="lblDate" Text="Date" ForeColor="Blue" Font-Names="Calibri" Font-Size="Small" runat="server" ></asp:Label>
                                   <asp:Label ID ="Label1" Text="*" ForeColor="Red" runat="server" ></asp:Label>


                            </td>
                            <td style="width: 25px;">:</td>
                            <td>
                                 <telerik:RadDatePicker ID="BillingDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Billing Date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                            </DateInput>
                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today">
                                        <ItemStyle BackColor="Pink" />
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>
                            </td>
                            <td style="width: 25px;">
 <asp:Label ID ="lblValue"  Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" Visible="false" runat="server" ></asp:Label>
                            </td>
                            <td>
                                 <asp:Label ID ="lblSession" Text="Session" Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" runat="server" ></asp:Label>
                                   <asp:Label ID ="Label2" Text="*" ForeColor="Red" runat="server" ></asp:Label>
                            </td>
                            <td style="width: 25px;">:</td>
                            <td>
                              <asp:DropDownList ID="ddlSession" ToolTip="Select Session." Width="200px" Height="25px" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Calibri" AutoPostBack="true" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged" Font-Size="Small">
                        </asp:DropDownList>

                            </td>
                        </tr>

                        <tr>

                           
                            <td>
                                 <asp:Label ID ="lblNOR" Text="No of Residents" Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" runat="server" ></asp:Label>
                            </td>
                               <td style="width: 50px;">:</td>
                            <td>
                                <asp:TextBox ID ="TxtNOR" Width="75px" MaxLength="2" ToolTip="*Enter Number of Resident(s)." Height="18px"  runat ="server"></asp:TextBox>
                              

                            </td>
                              <td style="width: 25px;">
                                  <asp:Label ID ="lblGuestRate"  Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" Visible="false" runat="server" ></asp:Label>
                              </td>
                            <td>
                      <asp:Label ID ="lblNOG" Text="No of Guests" Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" runat="server" ></asp:Label>

                            </td>
                               <td style="width: 25px;">:</td>
                            <td>

                     <asp:TextBox ID ="TxtNOG" Width="75px" MaxLength="2" Height="18px" ToolTip="*Enter Number of Guest(s)" runat ="server"></asp:TextBox>
                            </td>
                            <td style="width : 100px">
                                <asp:Label ID ="lblResidentRate"  Font-Names="Calibri" Font-Size="Small" ForeColor="Blue" Visible="false" runat="server" ></asp:Label>
                            </td>
                            <td>                            
                        <asp:Button ID="BtnSave" Width="75PX" Font-Bold="true" Text="Save" OnClick="BtnSave_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" />
                                                           
                            </td>

                           
                            </tr>
                            </table>
                            </td>
              
       
            <td>
                 <telerik:RadGrid ID="BillingListView" runat="server" AllowPaging="True" PageSize="10"
                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true"
                     OnPageIndexChanged="BillingListView_PageIndexChanged"
                    OnPageSizeChanged="BillingListView_PageSizeChanged" OnSortCommand="BillingListView_SortCommand"
                    CellSpacing="20" Width="100%"  
                    MasterTableView-HierarchyDefaultExpanded="true">
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
                            <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RTRSN" HeaderStyle-Wrap="false" Visible="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Villa No" DataField="RTVILLANO" HeaderStyle-Wrap="false"  
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Status" DataField="RTRSTATUS" HeaderStyle-Wrap="false" ItemStyle-Width="300px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="True"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Visible="True"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false" 
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Session" DataField="SessionCode" HeaderStyle-Wrap="false" ItemStyle-Width="300px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="True"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="false" 
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px"
                                ItemStyle-CssClass="Row1">
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Total" DataField="Value" HeaderStyle-Wrap="false" ItemStyle-Width="300px"
                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="True"
                                ItemStyle-CssClass="Row1" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
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
            </td>
        
    

                        </tr>
                                 



                    </table>






           </div>
        </div>




</asp:Content>

