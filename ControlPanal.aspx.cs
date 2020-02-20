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

public partial class ControlPanal : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadTitle();
                LoadData();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 152 });


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
    private void LoadData()
    {
        try
        {
            StringBuilder str = new StringBuilder();
            DataSet ds = sqlobj.ExecuteSP("SP_ControlPanal");
            //Oncoming Events
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    str.Append("" + row["Event"] + ",");
                }
                str.Remove(str.Length - 1, 1);
                lblOnComing.Text = str.ToString();
            }
            else
            {
                lblOnComing.Text = "Nothing scheduled in next seven days";
            }

            //Confirmation Count
            if (ds.Tables[1].Rows.Count > 0)
            {
                lblConfirmation.Text = ds.Tables[1].Rows[0]["Confirmation"].ToString() + ": Confirmation received so far from ";
            }
            //Monthly Billing So far
            if (ds.Tables[2].Rows.Count > 0)
            {
                int count = Convert.ToInt32(ds.Tables[2].Rows[0]["BillingDays"].ToString());
                if (count > 19)
                {
                    lblMEB.Text = "Still " + ds.Tables[2].Rows[0]["BillingDays"].ToString() + " Days more";
                }
                else
                {
                    lblMEB.Text = "Due in next " + ds.Tables[2].Rows[0]["BillingDays"].ToString() + " Days. Ensure all transactions posted in time.";
                    lblMEB.ForeColor = Color.Red;
                }
            }
            //Outstandings 
            if (ds.Tables[3].Rows.Count > 0)
            {
                lblOutstanding.Text = "Resident :" + ds.Tables[3].Rows[0]["Outstanding"].ToString();
            }
            //Warranty ending
            if (ds.Tables[4].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[4].Rows[0]["WarrantyEnd"].ToString());
                if (Count == 0)
                {
                    lblWarrantyEnding.Text = "Nothing due in next 30 days.";
                }
                else
                {
                    lblWarrantyEnding.Text = "Due in next 30 days:" + Count.ToString();
                }
            }
            //AMC Ending
            if (ds.Tables[5].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[5].Rows[0]["AMCEnd"].ToString());
                if (Count == 0)
                {

                    lblAMCEnding.Text = "Nothing due in next 30 days.";
                }
                else
                {
                    lblAMCEnding.Text = "Due in next 30 days:" + Count.ToString();
                }
            }
            ////Insurance ending
            if (ds.Tables[6].Rows.Count > 0)
            {

                int Count = Convert.ToInt32(ds.Tables[6].Rows[0]["InsuranceEnd"].ToString());
                if (Count == 0)
                {
                    lblInsuranceEnding.Text = "Nothing due in next 30 days.";
                }
                else
                {
                    lblInsuranceEnding.Text = "Due in next 30 days:" + Count.ToString();
                }
            }
            ////Resident Count
            if (ds.Tables[7].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[7].Rows[0]["total"].ToString());
                lblRCount.Text = Count.ToString() + " (All OR, T,ORD,TD,RS,RSD)";               
            }
            ////ICE residents do not have emergency contact details
            if (ds.Tables[8].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[8].Rows[0]["ICE"].ToString());
                lblRICE.Text = Count.ToString() + " residents do not have emergency contact details.";
            }
            ////Diner Notes
            StringBuilder strDN = new StringBuilder();
            if (ds.Tables[9].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[9].Rows)
                {
                    strDN.Append("'" + row["Days"] + "',");
                }
                strDN.Remove(strDN.Length - 1, 1);
                lblDinerNotes.Text = strDN.ToString();
            }
            //Menu TimeTable
            StringBuilder strMTT = new StringBuilder();
            if (ds.Tables[10].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[10].Rows)
                {
                    strMTT.Append("'" + row["MenuDays"] + "',");
                }
                strMTT.Remove(strMTT.Length - 1, 1);
                lblMenuTimeTable.Text = strMTT.ToString();
            }
            //House Blocked/ Locked
            if (ds.Tables[11].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[11].Rows[0]["BlockedLocked"].ToString());
                lblBlockedLocked.Text = Count.ToString();
            }
            //House Vacant
            if (ds.Tables[12].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[12].Rows[0]["Vacant"].ToString());
                lblVacant.Text = Count.ToString();
            }
            //Housekeeping Overdue
            if (ds.Tables[13].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[13].Rows[0]["Housekeeping"].ToString());
                lblHOverdue.Text = Count.ToString();
            }
            //Service requests Overdue
            if (ds.Tables[14].Rows.Count > 0)
            {
                int Count = Convert.ToInt32(ds.Tables[14].Rows[0]["ServiceRequests"].ToString());
                lblSOverdue.Text = Count.ToString();
            }
            //Latest Transaction
            if (ds.Tables[15].Rows.Count > 0)
            {
                DateTime TXDATE = Convert.ToDateTime(ds.Tables[15].Rows[0]["TXDATE"].ToString());
                DateTime today = DateTime.Now.Date;
                if(TXDATE!=today)
                {
                    lblLatestTrans.ForeColor = Color.Red;
                }
                string date = TXDATE.ToString("dd-MMM-yyyy") +" " +ds.Tables[15].Rows[0]["TXTime"].ToString()+" Hrs";
                lblLatestTrans.Text = date;
            }
            //Outstanding vs Receipts
            if (ds.Tables[16].Rows.Count > 0)
            {
                lblOSvsRec.Text = "Rs.: " +ds.Tables[17].Rows[0]["Outstanding"].ToString() + " / " + "Rs.: "+ ds.Tables[16].Rows[0]["Receipts"].ToString();
            }
            StringBuilder TR = new StringBuilder();

            if (ds.Tables[18].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[18].Rows)
                {
                    TR.Append("" + row["Tenant"] +  " / ");
                }
                TR.Remove(TR.Length - 2, 2);
                lblTenancyRenewal.Text = TR.ToString();
            }
            else
            {
                lblTenancyRenewal.Text = "No Tenancy Renewal in this month !";
            }
            StringBuilder TRDD = new StringBuilder();

            if (ds.Tables[19].Rows.Count > 0)
            {
                TRDD.Append("Tenancy Renewal code (TRDD) is not Available for the following Resident(s) - ");
                foreach (DataRow row in ds.Tables[19].Rows)
                {
                    TRDD.Append("" + row["Name"] + " / ");
                }
                TRDD.Remove(TRDD.Length - 2, 2);
                lbltenancyNotavl.Text = TRDD.ToString();
            }
            else
            {
                lblTenancyRenewal.Text = "Congrats!!! Tenancy Renewal code (TRDD) Available for all !";
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}