<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SearchMenu.aspx.cs" Inherits="SearchMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.10.0.min.js" type="text/javascript"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/themes/blitzer/jquery-ui.css"
    rel="Stylesheet" type="text/css" />
<script type="text/javascript">
    $(function () {
        $("[id$=txtsearch]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '<%=ResolveUrl("~/SearchMenu.aspx/GetMenu") %>',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[1],
                                val: item.split('-')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$=txtsearch]").val(i.item.label);
                <%-- $.ajax({
                    url: '<%=ResolveUrl("~/SearchMenu.aspx/GetMenu") %>',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });--%>

            },
            minLength: 5
        });
    });  
</script>
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

        .centerdiv {
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

            .centerdiv img {
                height: 128px;
                width: 128px;
            }
    </style>
     <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color:maroon;
            color: white;
            font-weight: bolder;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpPanel">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                              <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <asp:UpdatePanel ID="UpPanel" runat="server">
                <ContentTemplate>

                    <br />
                    <table style="width: 100%">
                        <tr>
                            <td style="text-align: center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Text="Search By Text" Font-Bold="true"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                    <table style="width: 100%">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label59" runat="server" Text="Search by?" ForeColor="Black" CssClass="style3" Font-Names="verdana" Font-Size="Medium" Font-Bold="true"></asp:Label><br />                             
                              
                            </td>
                        </tr>
                         <tr>
                            <td  style="width: 50%">
                                <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control" Width="600px" placeholder="Search Text......"></asp:TextBox>
                                </td>
                                <td align="left"><asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Text="search" OnClick="btnSearch_Click" />
                            </td>
                        </tr>
                    </table>

                    <table>
                        <tr>
                            <td style="width: 80%">
                                 <telerik:RadGrid ID="gvMenu"  GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                AutoGenerateColumns="false" OnItemCommand="gvMenu_ItemCommand" Width="75%" AllowFilteringByColumn="true" OnInit="gvMenu_Init" >
                                   <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <%--<telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the Prog menu details" runat="server" Text="Edit" 
                                                    CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                         <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="100px" DataField="Group" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Title" HeaderStyle-Width="100px" DataField="Title" ReadOnly="true"></telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="150px" DataField="Department" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="400px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>


</asp:Content>

