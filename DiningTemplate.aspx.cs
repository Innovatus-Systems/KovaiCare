
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;




public partial class DiningTemplate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblHeading.Text = "Download Dining Register for the Month of " + DateTime.Now.ToString("MMMM") + " " + DateTime.Now.Year;

            lblHeading2.Text = "The template can be downloaded on the first of every month for that month before 12 noon.";

            txtMonthYear.Text = DateTime.Now.ToString("MMM") + DateTime.Now.Year;
        }
    }

    protected void ddlsession_Change(object sender,EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("SP_FecthVillaNO", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
        DataSet dsGrid = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dsGrid);
        lblCount.Text = "Number of records selected : " + dsGrid.Tables[0].Rows.Count.ToString();
    }

    protected void butDownload_Click(object sender, EventArgs e)
    {
        if (ddlsession.SelectedValue == "0")
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select the session.');", true);
            return;
        }

       

        SqlCommand cmd = new SqlCommand("SP_FecthVillaNO", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
        DataSet dsGrid = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dsGrid);        
        ExcelExport(dsGrid.Tables[0]);

        //LoadLbl();


        //string filename = Server.MapPath("~/DiningTemplate/DiningRegisterTemplate_July.xslt");
        //FileInfo fileInfo = new FileInfo(filename);

        //if (fileInfo.Exists)
        //{
        //    Response.Clear();
        //    Response.AddHeader("Content-Disposition", "attachment; filename=" + Path.GetFileNameWithoutExtension(fileInfo.FullName) + "_" + ddlsession.SelectedItem.Text + Path.GetExtension(fileInfo.FullName));
        //    Response.AddHeader("Content-Length", fileInfo.Length.ToString());
        //    Response.ContentType = "application/octet-stream";
        //    Response.Flush();
        //    Response.TransmitFile(fileInfo.FullName);
        //    Response.End();
        //}



    }



    protected void ExcelExport(DataTable dt)

    {

        try

        {

            SqlProcsNew sqlp = new SqlProcsNew();
            DataSet dsH = new DataSet();
            DataSet dsFetch = new DataSet();

            int LineNumber = 0;
            int ColCount = 0;

            LineNumber = 5;
            ColCount = 6;

            //string FileName = "DiningRegister_July"+ "_" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + "_" + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + ".xls";
            //string FileName = "DiningRegister_" + DateTime.Now.ToString("MMMM") + "_" + DateTime.Now.Year  + ".xlsx";

            string TFileName = "DiningRegisterTemplate_" + txtMonthYear.Text.ToString() + ".xslt";
	    //string TFileName = "DiningRegisterTemplate_" + txtMonthYear.Text.ToString() + ".xltx";
            string FileName = "DiningRegister_" + txtMonthYear.Text.ToString() + ".xlsx";


            string templateFilePath = Server.MapPath("~/DiningTemplate/"+TFileName);
            string newFilePath = Server.MapPath("~/DiningDownload/" + FileName);
           
            FileInfo newFile = new FileInfo(newFilePath);
            FileInfo template = new FileInfo(templateFilePath);
            using (ExcelPackage xlPackage = new ExcelPackage(newFile, template))

            {
                foreach (ExcelWorksheet aworksheet in xlPackage.Workbook.Worksheets)
                {
                    //aworksheet.Cell(1, 1).Value = aworksheet.Cell(1, 1).Value;
                    aworksheet.Cell(1, 2).Value = ddlsession.SelectedItem.ToString();
                    
                }

                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets[1];
                int startrow = LineNumber;
                int row = 0;
                int col = 0;

                


                try
                {
                    for (int j = 0; j < ColCount; j++)
                    {
                        col++;
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            row = startrow + i;
                            ExcelCell cell = worksheet.Cell(row, col);
                            cell.Value = dt.Rows[i][j].ToString();
                            //row.Cells[i].Attributes.Add("style", "textmode");
                        }
                    }

                   
                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.ToString());
                }

                for (int iCol = 1; iCol <= ColCount; iCol++)
                {
                    ExcelCell cell = worksheet.Cell(startrow - 2, iCol);
                    for (int iRow = startrow; iRow <= row; iRow++)
                    {
                        worksheet.Cell(iRow, iCol).StyleID = cell.StyleID;
                    }
                }
                xlPackage.Save();
            } 

            string attachment = "attachment; filename=" + newFilePath;
            HttpContext.Current.Response.Clear(); 
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + FileName + ";");
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.TransmitFile(newFilePath);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
            
        }

        catch (Exception ex)

        {
            WebMsgBox.Show(ex.ToString());
        }

    }

    protected void LoadLbl()
    {
        SqlCommand cmd = new SqlCommand("SP_FecthVillaNO", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
        DataSet dsGrid = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dsGrid);
        lblCount.Text = "Number of records selected :" + dsGrid.Tables[0].Rows.Count.ToString();
    }





    protected void btnUpload_Click(object sender, EventArgs e)
    {
        //string strfiletype = Path.GetExtension(fu_Dining.FileName).ToLower();
        //string strPath = string.Concat(Server.MapPath("~/DiningUpload/" + fu_Dining.FileName));
        //FileInfo filepath = new FileInfo(strPath);
        ////filepath.Delete();
        //fu_Dining.PostedFile.SaveAs(strPath);
    }
}
 