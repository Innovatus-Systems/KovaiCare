using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string filePath = Server.MapPath("~/Uploads/") + Request.QueryString["pdf"];
            this.Response.ContentType = "application/pdf";
            this.Response.AppendHeader("Content-Disposition;", "attachment;filename=" + Request.QueryString["pdf"]);
            this.Response.WriteFile(filePath);
            this.Response.End();
        }
    }
}