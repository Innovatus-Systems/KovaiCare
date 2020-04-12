<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="PreviewInvoice.aspx.cs" Inherits="PreviewInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 118px;
        }
        .auto-style2 {
            width: 724px;
        }
        .auto-style3 {
            float: left;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align: center;" class="auto-style3">
        <label id="lblPreviewInvoice"  runat="server">Preview Ivoice</label>
        <asp:Panel ID="pnlPDF" runat="server">
        </asp:Panel>
    </div>
  <%--  <iframe src="http://docs.google.com/gview?url=http://localhost:59678/uploads/Sample.pdf" style="width:600px; height:500px;" frameborder="0"></iframe>--%>
</asp:Content>

