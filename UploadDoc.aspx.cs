using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using Telerik.Web.UI;
using System.Threading;
using System.Web.UI.HtmlControls;

public partial class UploadDoc : System.Web.UI.Page
{
     static string RSN="";
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            FileUpload fileUpload = new FileUpload();
            fileUpload = FileUpload2;
            LoadResidentDet();
            LoadDocUpload();
            string Mode = Request.QueryString["MD"];
            RSN = Request.QueryString["N"];
            if(Mode=="Ed")
            {
                LoadDetails();
            }
        }
    }
    protected void LoadResidentDet()
    {

        try
        {
            if (Session["ResidentRSN"].ToString() != "")
            {
                int RTRSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                DataSet dsGrid = sqlobj.ExecuteSP("PROC_CC_ResDocUpload", 
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 5 },
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN }
                    );              
             
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {
                    lblResident.Text = dsGrid.Tables[0].Rows[0]["DET"].ToString();
                }               
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());

        }              
    }
    protected void LoadCode(string Group)
    {
        try
        {
            if (drpNewDocGroup.SelectedValue != "0" && drpNewDocGroup.SelectedValue != "")
            {
                DataSet dsGrid = sqlobj.ExecuteSP("SP_GetLKUPOne",
                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@GroupCode", SqlDbType = SqlDbType.NVarChar, Value = Group }
                  );
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {
                    drpNewDocCode.DataSource = dsGrid;
                    drpNewDocCode.DataValueField = "RACode";
                    drpNewDocCode.DataTextField = "RACode";
                    drpNewDocCode.DataBind();
                }
                else
                {
                    drpNewDocCode.DataSource = dsGrid;
                    drpNewDocCode.DataValueField = "RACode";
                    drpNewDocCode.DataTextField = "RACode";
                    drpNewDocCode.DataBind();
                }
                drpNewDocCode.Items.Insert(0, new ListItem("-- Select --", "0"));
            }
            else
            {
                drpNewDocCode.DataSource = null;              
                drpNewDocCode.DataBind();
               
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadDetails()
    {
        try
        {
            if (Session["ResidentRSN"].ToString() != "")
            {
                int RTRSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                DataSet dsGrid = sqlobj.ExecuteSP("PROC_CC_ResDocUpload",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN },
                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN }
                    );
                lblDOU.Visible = true;
                Label1.Visible = true;
                lblFile.Visible = true;
                btnAdd.Visible = false;
                btnUpdate.Visible = true;            
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {
                    txtRemarks.Text= dsGrid.Tables[0].Rows[0]["REMARKS"].ToString();
                    drpNewDocGroup.SelectedValue= dsGrid.Tables[0].Rows[0]["GROUP"].ToString();
                    LoadCode(drpNewDocGroup.SelectedValue);
                    drpNewDocCode.SelectedValue = dsGrid.Tables[0].Rows[0]["CODE"].ToString();
                    lblFile.Text= dsGrid.Tables[0].Rows[0]["URL"].ToString();
                    lblDOU.Text= dsGrid.Tables[0].Rows[0]["DOU"].ToString();
                }
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());

        }

    }
    protected void Hide()
    {
        try
        {
            drpNewDocGroup.Enabled = false;
            drpNewDocCode.Enabled = false;
            FileUpload2.Enabled = false;
            txtRemarks.Enabled = false;
            btnUpdate.Visible = false;
            btnAdd.Visible = false;
            btnClear.Visible = false;
            btnReturn.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void clear()
    {
        try
        {
            drpNewDocGroup.SelectedValue = "0";          
            drpNewDocCode.SelectedValue = "0";
            FileUpload2.Attributes.Clear();
            txtRemarks.Text = "";
            lblDOU.Visible = false;
            Label1.Visible = false;
            lblFile.Visible = false;
            btnUpdate.Visible = false;
            btnAdd.Visible = true;
            btnClear.Visible = true;
            btnReturn.Visible = true;
            drpNewDocGroup.Enabled = true;
            drpNewDocCode.Enabled = true;
            FileUpload2.Enabled = true;
            txtRemarks.Enabled = true;
            LoadDocUpload();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
           
            string filename = string.Empty;
            String File = "";
            decimal filesize = 2;
            String ErrorMessage = "";
            //string filename1 = Path.GetFileName(FileUpload2.PostedFile.FileName);
            if (FileUpload2.HasFile)
            {
                if (FileUpload2.PostedFile.FileName.Length > 0)
                {

                    var supportedTypes = new[] { "txt", "doc", "docx", "pdf", "xls", "xlsx", "jpg", "jpeg", "png" };
                    var fileExt = System.IO.Path.GetExtension(FileUpload2.FileName).Substring(1);
                    if (!supportedTypes.Contains(fileExt))
                    {
                        ErrorMessage = "File Extension Is InValid - Only Upload WORD/PDF/EXCEL/TXT/Image File";
                        WebMsgBox.Show(ErrorMessage);
                        return;
                    }
                    else if (FileUpload2.PostedFile.ContentLength > (filesize * 1024 * 1024))
                    {
                        ErrorMessage = "File size Should Be UpTo " + filesize + "MB";
                        WebMsgBox.Show(ErrorMessage);
                        return;
                    }
                    else {
                        filename = Path.GetFileName(FileUpload2.PostedFile.FileName);
                        FileUpload2.SaveAs(Server.MapPath(@"~//ResidentDoc/") + Session["ResidentRSN"].ToString() + "_" + drpNewDocGroup.SelectedValue.ToString() + "_" + "_" + drpNewDocCode.SelectedValue.ToString() + "_" + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);
                        File = (@"~//ResidentDoc/") + Session["ResidentRSN"].ToString() + "_" + drpNewDocGroup.SelectedValue.ToString() + "_" + "_" + drpNewDocCode.SelectedValue.ToString() + "_" + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;

                        sqlobj.ExecuteNonQuery("PROC_CC_ResDocUpload", new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = Session["ResidentRSN"].ToString() },
                           new SqlParameter() { ParameterName = "@GROUP", SqlDbType = SqlDbType.NVarChar, Value = drpNewDocGroup.SelectedValue },
                           new SqlParameter() { ParameterName = "@CODE", SqlDbType = SqlDbType.NVarChar, Value = drpNewDocCode.SelectedValue },
                           new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = File },
                           new SqlParameter() { ParameterName = "@REMARKS", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                           new SqlParameter() { ParameterName = "@DOU", SqlDbType = SqlDbType.NVarChar, Value = "" },
                           new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                           );
                        clear();
                        LoadDocUpload();
                    }                    
                }                 
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            string filename = string.Empty;
            String File = "";
            decimal filesize = 2;
            String ErrorMessage = "";
            if (FileUpload2.HasFile)
            {
                if (FileUpload2.PostedFile.FileName.Length > 0)
                {
                    var supportedTypes = new[] { "txt", "doc", "docx", "pdf", "xls", "xlsx", "jpg", "jpeg", "png" };
                    var fileExt = System.IO.Path.GetExtension(FileUpload2.FileName).Substring(1);
                    if (!supportedTypes.Contains(fileExt))
                    {
                        ErrorMessage = "File Extension Is InValid - Only Upload WORD/PDF/EXCEL/TXT/Image File";
                        WebMsgBox.Show(ErrorMessage);
                        return;
                    }
                    else if (FileUpload2.PostedFile.ContentLength > (filesize * 1024 * 1024))
                    {
                        ErrorMessage = "File size Should Be UpTo " + filesize + "MB";
                        WebMsgBox.Show(ErrorMessage);
                        return;
                    }
                    else
                    {
                        filename = Path.GetFileName(FileUpload2.PostedFile.FileName);
                        FileUpload2.SaveAs(Server.MapPath(@"~//ResidentDoc/") + Session["ResidentRSN"].ToString() + "_" + drpNewDocGroup.SelectedValue.ToString() + "_" + "_" + drpNewDocCode.SelectedValue.ToString() + "_" + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);
                        File = (@"~//ResidentDoc/") + Session["ResidentRSN"].ToString() + "_" + drpNewDocGroup.SelectedValue.ToString() + "_" + "_" + drpNewDocCode.SelectedValue.ToString() + "_" + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;


                        sqlobj.ExecuteNonQuery("PROC_CC_ResDocUpload", new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = Session["ResidentRSN"].ToString() },
                           new SqlParameter() { ParameterName = "@GROUP", SqlDbType = SqlDbType.NVarChar, Value = drpNewDocGroup.SelectedValue },
                           new SqlParameter() { ParameterName = "@CODE", SqlDbType = SqlDbType.NVarChar, Value = drpNewDocCode.SelectedValue },
                           new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = File },
                           new SqlParameter() { ParameterName = "@REMARKS", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                           new SqlParameter() { ParameterName = "@DOU", SqlDbType = SqlDbType.NVarChar, Value = "" },
                           new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@RSN",SqlDbType = SqlDbType.NVarChar,Value =RSN}
                           );
                        clear();
                        LoadDocUpload();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/AttributesAdd.aspx");
    }

    protected void drpNewDocGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadCode(drpNewDocGroup.SelectedValue.ToString());
        }
        catch (Exception ex)
        {

        }
    }
    protected void rdDoc_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "download_file")
        {
            try { 
            var lnk =e.CommandSource as LinkButton;
            GridDataItem ditem = (GridDataItem)e.Item;
            //string filename = ditem["URL"].Text;
            string filename = lnk.Text; // get the filename from the row in which the download button is clicked   
            string path = MapPath(filename);
            System.IO.FileInfo file = new System.IO.FileInfo(path);
            byte[] bts = System.IO.File.ReadAllBytes(path);
            Response.Clear();
            Response.ClearHeaders();
            Response.AddHeader("Content-Type", "Application/octet-stream");
            Response.AddHeader("Content-Length", bts.Length.ToString());
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.BinaryWrite(bts);
            Response.Flush();
            HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch(Exception ex)
            {

            }
        }
       else { LoadDocUpload(); }
        
    }
    protected void LoadDocUpload()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {
                int RTRSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                DataSet dsGrid = sqlobj.ExecuteSP("PROC_CC_ResDocUpload",
                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 6 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN }
                   );               
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {
                    rdDoc.DataSource = dsGrid.Tables[0];
                    rdDoc.DataBind();                   
                }
                else
                {
                    rdDoc.DataSource = new String[] { };
                    rdDoc.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }
    protected void LnkDocEdit_Click(object sender, EventArgs e)
    {        
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
        RSN = row.Cells[2].Text;
        //AdditionalsRSN = Session["RSN"].ToString();
        LoadDetails();       
    }

    protected void LnkDocDelete_Click(object sender, EventArgs e)
    {
        string URSN;
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
        URSN = row.Cells[2].Text;
        string URTRSN = Session["ResidentRSN"].ToString();
        DataSet dsGrid = sqlobj.ExecuteSP("PROC_CC_ResDocUpload",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = URTRSN },
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = URSN }
                 );
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            LoadDocUpload();
            clear();
            btnClear_Click(sender, e);
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + dsGrid.Tables[0].Rows[0]["Msg"].ToString() + "');", true);
        }
    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        try { 
            string filePath = (sender as LinkButton).CommandArgument;
            //Response.ContentType = "image/jpg";;
            ////Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            ////Response.WriteFile(filePath);
            ////Response.End();
            //Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            //Response.TransmitFile(Server.MapPath(filePath));
            //Response.End();

           

            string path = Server.MapPath(filePath);
            System.IO.FileInfo file = new System.IO.FileInfo(path);
            if (file.Exists)
            {
                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                //Response.AddHeader("Content-Length", file.Length.ToString());
                Response.ContentType = ContentType;
                Response.TransmitFile(file.FullName);
                //Response.End();
            }
        }
        catch(ThreadAbortException ex)
        {

        }
    }
   
}