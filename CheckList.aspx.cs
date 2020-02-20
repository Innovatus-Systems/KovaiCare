using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Drawing;
using Telerik.Web.UI;
using System.IO;
using System.Text;


public partial class CheckList : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadTitle();
                LoadCheckList();

            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 81 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadCheckList()
    {
        try
        {

            DataSet dsCheckList = sqlobj.ExecuteSP("SP_CheckList");


            if (dsCheckList.Tables[0].Rows.Count >0)
            {
                int i = Convert.ToInt32(dsCheckList.Tables[0].Rows[0]["SysAdminSettings"].ToString());
 
                if (i >0)
                {
                    lnkStatus1.Text = "Yes";
                }
                else
                {
                    lnkStatus1.Text = "No";
                }
            }

            if (dsCheckList.Tables[1].Rows.Count > 0)
            {
                 lnkStatus2.Text = dsCheckList.Tables[1].Rows[0]["TotalUsers"].ToString();

            }

            if (dsCheckList.Tables[2].Rows.Count > 0)
            {
                lnkStatus3.Text = dsCheckList.Tables[2].Rows[0]["TotalDwellingUnits"].ToString();

            }

            if (dsCheckList.Tables[3].Rows.Count > 0)
            {
                int i = Convert.ToInt32(dsCheckList.Tables[3].Rows[0]["SpecialDoorNos"].ToString());

                if (i > 0)
                {
                    lnkStatus4.Text = "Yes";
                }
                else
                {
                    lnkStatus4.Text = "No";
                }

            }

            if (dsCheckList.Tables[4].Rows.Count > 0)
            {
                lnkStatus5.Text = dsCheckList.Tables[4].Rows[0]["TotalTasksMasterList"].ToString();

            }

            if (dsCheckList.Tables[5].Rows.Count > 0)
            {
                lnkStatus6.Text = dsCheckList.Tables[5].Rows[0]["StatffList"].ToString();

            }

            if (dsCheckList.Tables[6].Rows.Count > 0)
            {
                lnkStatus7.Text = dsCheckList.Tables[6].Rows[0]["ServiceList"].ToString();

            }

            if (dsCheckList.Tables[7].Rows.Count > 0)
            {
                lnkStatus8.Text = dsCheckList.Tables[7].Rows[0]["TotalDiningSessions"].ToString();

            }

            if (dsCheckList.Tables[8].Rows.Count > 0)
            {
                lnkStatus9.Text = dsCheckList.Tables[8].Rows[0]["BillingType"].ToString();
            }

            if (dsCheckList.Tables[9].Rows.Count > 0)
            {
                 int i = Convert.ToInt32(dsCheckList.Tables[9].Rows[0]["DiningMonthlyCharge"].ToString());

                 if (i>0)
                 {

                 lnkStatus10.Text = "Yes"; 
                 
                 }
                 else
                 {
                     lnkStatus10.Text  = "No";
                 }
            }

            if (dsCheckList.Tables[10].Rows.Count > 0)
            {
                 int i = Convert.ToInt32(dsCheckList.Tables[10].Rows[0]["ServiceMonthlyCharge"].ToString());

                 if (i>0)
                 {

                 lnkStatus11.Text = "Yes"; 
                 
                 }
                 else
                 {
                     lnkStatus11.Text  = "No";
                 }
            }

            if (dsCheckList.Tables[11].Rows.Count > 0)
            {
                 lnkStatus12.Text = dsCheckList.Tables[11].Rows[0]["MenuItems"].ToString();
            }

            if (dsCheckList.Tables[12].Rows.Count > 0)
            {
                 lnkStatus13.Text = dsCheckList.Tables[12].Rows[0]["MenuIngridents"].ToString();
            }

            if (dsCheckList.Tables[13].Rows.Count > 0)
            {
                 lnkStatus14.Text = dsCheckList.Tables[13].Rows[0]["HouseKeepingMonthlyCharge"].ToString();
            }

            if (dsCheckList.Tables[14].Rows.Count > 0)
            {
                 lnkStatus15.Text = dsCheckList.Tables[14].Rows[0]["DiningMonthlyCharge"].ToString();
            }

            if (dsCheckList.Tables[15].Rows.Count > 0)
            {
                 lnkStatus16.Text = dsCheckList.Tables[15].Rows[0]["TotalCalendar"].ToString();
            }

            

            if (dsCheckList.Tables[16].Rows.Count > 0)
            {
                 lnkStatus19.Text = dsCheckList.Tables[16].Rows[0]["ProfileCodes"].ToString();
            }

            if (dsCheckList.Tables[17].Rows.Count > 0)
            {
                 lnkStatus20.Text = dsCheckList.Tables[17].Rows[0]["TotalAssets"].ToString();
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

}