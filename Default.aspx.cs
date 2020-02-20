using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using iTextSharp.text;
using System.IO;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Populate DataTable
            DataTable dt = new DataTable();
            dt.Columns.Add("Name");
            dt.Columns.Add("Age");
            dt.Columns.Add("City");
            dt.Columns.Add("Country");
            dt.Rows.Add();
            dt.Rows[0]["Name"] = "Mudassar Khan";
            dt.Rows[0]["Age"] = "27";
            dt.Rows[0]["City"] = "Mumbai";
            dt.Rows[0]["Country"] = "India";

            //Bind Datatable to Labels
            lblName.Text = dt.Rows[0]["Name"].ToString();
            lblAge.Text = dt.Rows[0]["Age"].ToString();
            lblCity.Text = dt.Rows[0]["City"].ToString();
            lblCountry.Text = dt.Rows[0]["Country"].ToString();
        }
    }


    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        pnlPerson.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();

    }

}