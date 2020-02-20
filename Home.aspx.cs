using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.ComponentModel.Design;
using System.Collections.Generic;

public partial class HomePage : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {


       
        if (!IsPostBack)
        {

            FetchOutCount();
            LoadBirthdayGrid();
            FetchAdmin();


        }
        LoadRecentCrDr();
    }

    protected void FetchAdmin()
    {
        SqlProcsNew proc=new SqlProcsNew();

        DataSet  dsAdmin = proc.ExecuteSP("[SP_FetchAdmin]", new SqlParameter()
            {
                 ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 1
            });

        if (dsAdmin.Tables[0].Rows.Count >0)
        {
            lblDayMsg.Text = dsAdmin.Tables[0].Rows[0]["scrollmsg"].ToString();
        }

        dsAdmin.Dispose();
    }

    protected void FetchOutCount()
    {
        try
        {
            SqlProcsNew proc = new SqlProcsNew();

            DataSet dsOutCount = new DataSet();
            DataSet dsResidCnt = new DataSet();
            DataSet dsStayAlone = new DataSet();
            DataSet dsOwnersAway = new DataSet();
            DataSet dsStaffList = new DataSet();
            DataSet dsOutCountMF = new DataSet();
            DataSet dsTasks = new DataSet();
            DataSet dsBillUnBill = new DataSet();

            dsOutCount = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });

            if (dsOutCount.Tables[0].Rows.Count > 0)
            {                
                lblCheckedOutCnt.Text = "Checked Out (" + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString() + ")";
            }
            else
            {
                lblCheckedOutCnt.Text = "Checked Out ( - )";
            }

            dsResidCnt = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int, 
                Value = 13
            });

            if (dsResidCnt.Tables[0].Rows.Count > 0)
            {                
                lblResidentCnt.Text = "Residents  (" + dsResidCnt.Tables[0].Rows[0]["ResCnt"].ToString()+")";               
            }
            else
            {
                lblResidentCnt.Text = "Residents  ( - )";
            }
            if (dsResidCnt.Tables[1].Rows.Count > 0)
            {
                lblVacantCnt.Text = "Vacant  (" + dsResidCnt.Tables[1].Rows[0]["Vacant"].ToString() + ")";
            }
            else
            {
                lblVacantCnt.Text = "Vacant  ( - )";
            }

            dsStayAlone = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 14
            });

            if (dsStayAlone.Tables[0].Rows.Count > 0)
            {
                lblLivingAloneCnt.Text = "Living alone (" + dsStayAlone.Tables[0].Rows[0]["StayAlone"].ToString() + ")";
            }
            else
            {
                lblLivingAloneCnt.Text = "Living alone ( - )";
            }

            dsOutCountMF = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });
            if (dsOutCountMF.Tables[1].Rows.Count > 0)
            {
                //lblAlerts.Text = "Checked Out (" + dsOutCountMF.Tables[0].Rows[0]["InOutCount"].ToString() +") / Alerts (" + dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() + ")";
                if (dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() == "0")
                {
                    lblAlerts.Text = " No Alerts";
                    lblAlerts.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    lblAlerts.Text = "Alerts (" + dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() + ")";
                    lblAlerts.ForeColor = System.Drawing.Color.Red;
                }
               
            }
            else
            { 
                
                lblAlerts.Text="Alerts (-)";
            }

            dsTasks = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 18
            });

            if (dsTasks.Tables[0].Rows.Count > 0)
            {
                lblTasks.Text = "Open Tasks (" + dsTasks.Tables[0].Rows[0]["TaskCnt"].ToString() + ")";
            }
            else
            {
                lblTasks.Text = "Open Tasks (-)";
            }

            if (dsTasks.Tables[1].Rows.Count > 0)
            {
                lblOverduetasks.Text = "Overdue Tasks (" + dsTasks.Tables[1].Rows[0]["OverDueTaskCnt"].ToString() + ")";
            }
            else
            {
                lblOverduetasks.Text = "Overdue Tasks (-)";
            }

            dsBillUnBill = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 19
            });

            if (dsBillUnBill.Tables[0].Rows.Count > 0)
            {
                lblBilled.Text = "Billed Rs." + dsBillUnBill.Tables[0].Rows[0]["BTotal"].ToString() + " for " + dsBillUnBill.Tables[0].Rows[0]["BName"].ToString();
            }
            else
            {
                lblBilled.Text = "Billed (-) ";
            }

            if (dsBillUnBill.Tables[1].Rows.Count > 0)
            {
                lblUnBilled.Text = "Unbilled Rs." + dsBillUnBill.Tables[1].Rows[0]["UBTotal"].ToString() + " for " + dsBillUnBill.Tables[1].Rows[0]["UBName"].ToString(); ;
            }
            else
            {
                lblUnBilled.Text = "Unbilled (-) ";
            }


           DataSet  dsOutstanding = proc.ExecuteSP("SP_TotalOutstanding");

            if (dsOutstanding.Tables[0].Rows.Count >0 )
            {
                lblOutstanding.Text = "Outstanding Rs." + dsOutstanding.Tables[0].Rows[0]["Outstanding"].ToString();
            }

            dsOutstanding.Dispose();

            
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void LoadRecentCrDr()
    {

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsRecentCD = new DataSet();
        dsRecentCD = proc.ExecuteSP("SP_GetRecentCrDr");
        lblRecentCr.Text = dsRecentCD.Tables[0].Rows[0]["CR"].ToString();
        lblRecentDr.Text = dsRecentCD.Tables[1].Rows[0]["DR"].ToString();
    }
    protected void LoadBirthdayGrid()
    {
        SqlCommand Cmd = new SqlCommand("SP_General", con);
        Cmd.CommandType = CommandType.StoredProcedure;
        Cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 4;
        DataSet dsGrid = new DataSet();
        //BirthdaygrdView.DataBind();    
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            //lbldispbirthdays.Text = "Upcoming birthdays  :" + dsGrid.Tables[0].Rows.Count;
            //lblBirthdays.Text = "Birthdays (" + dsGrid.Tables[0].Rows.Count + ")";
        }

        else
        {
           // lblBirthdays.Text = "Birthdays (-)";
            //lbldispbirthdays.Text = "No upcoming birthdays ";

        }

    }

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dschkRName = new DataSet();

        if (txtNSearch.Text.Length >= 4)
        {
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir2();", true);       
            string HRName = txtNSearch.Text.ToString();
            dschkRName = proc.ExecuteSP("SP_CheckRName", new SqlParameter()
            {
                ParameterName = "@RName",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = txtNSearch.Text.ToString()
            });

            if (dschkRName.Tables[0].Rows.Count > 0)
            {
                Response.Redirect("ResidentAdd.aspx?HRName=" + HRName, true);
            }
            else 
            {
                WebMsgBox.Show("Sorry ! Could not locate any resident name matching what you entered. Check if you have spelt the name right?");
            }
            txtNSearch.Text = string.Empty;
        }
        else
        {
            WebMsgBox.Show("Please enter minimum four characters");
            txtNSearch.Text = string.Empty;
        }
    }

    protected void lblAlerts_Click(object sender, EventArgs e)
    {
        Response.Redirect("ExitEntry.aspx");
    
    }

    protected void lblTasks_Click(object sender, EventArgs e)
    {
        Response.Redirect("TaskList.aspx");
    
    }





    protected void btnScoreboard_Click(object sender, EventArgs e)
    {
       

        string url = "Information_Board.aspx?Value=1";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }
}