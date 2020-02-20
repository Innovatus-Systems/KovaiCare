using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class SessionMaster : System.Web.UI.Page
{
    //static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadUserGrid();
            btnUpdate.Visible = false;                      
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 66 });


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

    public void LoadUserGrid()
    {
        try
        {
          
            DataSet dsUsers = sqlobj.ExecuteSP("Proc_SessionMaster",
                 new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 }

                );


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvSession.DataSource = dsUsers;
                gvSession.DataBind();
            }
            else
            {
                gvSession.DataSource = new string[] { };
                gvSession.DataBind();
            }
        }
        catch (Exception ex)
        {
            gvSession.DataSource = new string[] { };
            gvSession.DataBind();
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            string strFrom;
            string strTill;

            if (txtFromTime.Text.Contains("Hrs"))
            {
                strFrom = txtFromTime.Text.ToString().Replace(" Hrs.", "");
            }
            else
            {
                strFrom = txtFromTime.Text;
            }

            if (txtTilltime.Text.Contains("Hrs"))
            {
                strTill = txtTilltime.Text.ToString().Replace(" Hrs.", "");
            }
            else
            {
                strTill = txtTilltime.Text;
            }


            

           if (txtGuestrate.Text == "" )
           {
               txtGuestrate.Text = lblCasualrate.Text;
           }

           if (txtHomeservice.Text == "")
           {
               txtHomeservice.Text = lblCasualrate.Text; 
           }

   

          DataSet  dsRes = sqlobj.ExecuteSP("Proc_SessionMaster",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value },
                new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlSessionGroup.SelectedValue },
                new SqlParameter() { ParameterName = "@Sessioncode", SqlDbType = SqlDbType.NVarChar, Value =  txtSessioncode.Text },
                new SqlParameter() { ParameterName = "@Sessionname", SqlDbType = SqlDbType.NVarChar, Value =  txtSessionname.Text },
                new SqlParameter() { ParameterName = "@FromTime", SqlDbType = SqlDbType.DateTime, Value =  strFrom },
                new SqlParameter() { ParameterName = "@Tilltime", SqlDbType = SqlDbType.DateTime, Value =  strTill },
                new SqlParameter() { ParameterName = "@Regularrate", SqlDbType = SqlDbType.Decimal, Value = txtRegularrate.Text },
                new SqlParameter() { ParameterName = "@Casualrate", SqlDbType = SqlDbType.Decimal, Value =  txtCasualrate.Text },
                new SqlParameter() { ParameterName = "@Guestrate", SqlDbType = SqlDbType.Decimal, Value =  txtGuestrate.Text },
                new SqlParameter() { ParameterName = "@Homeservice", SqlDbType = SqlDbType.Decimal, Value = txtHomeservice.Text },
                new SqlParameter() { ParameterName = "@FintxnDescription", SqlDbType = SqlDbType.NVarChar, Value = txtFintxnDescription.Text }
               );
           

            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            //btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Session details updated successfully');", true);
        }
        catch (Exception ex)
        {
          
        }
    }
    public void Clear()
    {
        //txtCasualrate.Text = string.Empty;
        txtFintxnDescription.Text = string.Empty;
        txtFromTime.Text = string.Empty;
        txtGuestrate.Text = string.Empty;
        txtHomeservice.Text = string.Empty;
        txtCasualrate.Text = string.Empty;
        txtRegularrate.Text = string.Empty;
        txtSessioncode.Text = string.Empty;
        txtSessionname.Text = string.Empty;
        txtTilltime.Text = string.Empty;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            
            DataSet dsCheck = sqlobj.ExecuteSP("Proc_SessionMaster",
                  new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 },
                  new SqlParameter() { ParameterName = "@Sessioncode", SqlDbType = SqlDbType.NVarChar, Value = txtSessioncode.Text }
                
                 );


            if (dsCheck.Tables[0].Rows.Count > 0)
            {
                if (dsCheck.Tables[0].Rows[0][0].ToString() == "1")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Session Code already exists');", true);
                    return;
                }
            }

            dsCheck.Dispose();

            string strFrom;
            string strTill;

            if (txtFromTime.Text.Contains("Hrs"))
            {
                strFrom = txtFromTime.Text.ToString().Replace(" Hrs.", "");
            }
            else
            {
                strFrom = txtFromTime.Text;
            }

            if (txtTilltime.Text.Contains("Hrs"))
            {
                strTill = txtTilltime.Text.ToString().Replace(" Hrs.", "");
            }
            else
            {
                strTill = txtTilltime.Text;
            }

            if (txtGuestrate.Text == "")
            {
                txtGuestrate.Text = txtCasualrate.Text;
            }

            if (txtHomeservice.Text == "")
            {
                txtHomeservice.Text = txtCasualrate.Text;
            }

            

            DataSet dsRes = sqlobj.ExecuteSP("Proc_SessionMaster",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
             new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlSessionGroup.SelectedValue },
             new SqlParameter() { ParameterName = "@Sessioncode", SqlDbType = SqlDbType.NVarChar, Value = txtSessioncode.Text },
             new SqlParameter() { ParameterName = "@Sessionname", SqlDbType = SqlDbType.NVarChar, Value = txtSessionname.Text },
             new SqlParameter() { ParameterName = "@FromTime", SqlDbType = SqlDbType.DateTime, Value = strFrom },
             new SqlParameter() { ParameterName = "@Tilltime", SqlDbType = SqlDbType.DateTime, Value = strTill },
             new SqlParameter() { ParameterName = "@Regularrate", SqlDbType = SqlDbType.Decimal, Value = txtRegularrate.Text  },
             new SqlParameter() { ParameterName = "@Casualrate", SqlDbType = SqlDbType.Decimal, Value = txtCasualrate.Text },
             new SqlParameter() { ParameterName = "@Guestrate", SqlDbType = SqlDbType.Decimal, Value = txtGuestrate.Text },
             new SqlParameter() { ParameterName = "@Homeservice", SqlDbType = SqlDbType.Decimal, Value = txtHomeservice.Text },
             new SqlParameter() { ParameterName = "@FintxnDescription", SqlDbType = SqlDbType.NVarChar, Value = txtFintxnDescription.Text }
            );

            dsRes.Dispose();
           
            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Session details added successfully');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('"+ex.Message.ToString()+"');", true);
        }

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnUpdate.Visible = false;
        btnSave.Visible = true;
    }
    protected void gvSession_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {            
            hbtnRSN.Value = e.CommandArgument.ToString();



            DataSet dsGetSession = sqlobj.ExecuteSP("Proc_SessionMaster",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 },
             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = hbtnRSN.Value.ToString() }
             );


            if (dsGetSession.Tables[0].Rows.Count >0)
            {
                txtSessioncode.Text = dsGetSession.Tables[0].Rows[0]["Sessioncode"].ToString();
                txtSessionname.Text = dsGetSession.Tables[0].Rows[0]["Sessionname"].ToString();
                txtFromTime.Text = dsGetSession.Tables[0].Rows[0]["FromTime"].ToString();
                txtTilltime.Text = dsGetSession.Tables[0].Rows[0]["Tilltime"].ToString();
                txtRegularrate.Text = dsGetSession.Tables[0].Rows[0]["Regularrate"].ToString();
                txtCasualrate.Text = dsGetSession.Tables[0].Rows[0]["Casualrate"].ToString();
                txtGuestrate.Text = dsGetSession.Tables[0].Rows[0]["Guestrate"].ToString();
                 txtHomeservice.Text = dsGetSession.Tables[0].Rows[0]["Homeservice"].ToString();
                ddlSessionGroup.SelectedValue = dsGetSession.Tables[0].Rows[0]["Group"].ToString(); 
                //txtFintxnDescription.Text = ditem["Fintxndescription"].Text;
                if (dsGetSession.Tables[0].Rows[0]["Fintxndescription"].ToString() != "&nbsp;")
                {
                    txtFintxnDescription.Text = Convert.ToString(dsGetSession.Tables[0].Rows[0]["Fintxndescription"].ToString());
                }
                else
                {
                    txtFintxnDescription.Text = "";
                }
                btnSave.Visible = false;
                //btnDelete.Visible = true;
                btnUpdate.Visible = true;
            }


            dsGetSession.Dispose();


            
            //if (e.Item is GridDataItem)
            //{
            //    GridDataItem ditem = (GridDataItem)e.Item;
            //    txtSessioncode.Text = ditem["Sessioncode"].Text;
            //    txtSessionname.Text = ditem["Sessionname"].Text;
            //    txtFromTime.Text = ditem["Fromtime"].Text;
            //    txtTilltime.Text = ditem["Tilltime"].Text;
            //    txtCasualrate.Text = ditem["Regularrate"].Text;
                
                
            //    txtGuestrate.Text = ditem["Guestrate"].Text;
            //    txtHomeservice.Text = ditem["Homeservice"].Text;
            //    //txtFintxnDescription.Text = ditem["Fintxndescription"].Text;
            //    if (ditem["Fintxndescription"].Text.ToString() != "&nbsp;")
            //    {
            //        txtFintxnDescription.Text = Convert.ToString(ditem["Fintxndescription"].Text);
            //    }
            //    else
            //    {
            //        txtFintxnDescription.Text = "";
            //    }         
            //    btnSave.Visible = false;
            //    //btnDelete.Visible = true;
            //    btnUpdate.Visible = true;
            //}
        }
        else
        {
            LoadUserGrid();
        }
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void RMKPlanner_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Food Items")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        if (e.Item.Text == "Food Ingredients")
        {
            Response.Redirect("RMMenu.aspx");
        }
        if (e.Item.Text == "Sessions")
        {
            Response.Redirect("SessionMaster.aspx");
        }
        if (e.Item.Text == "Which Item When?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Which Menu When?");
        }
        else if (e.Item.Text == "How many diners?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=How many diners?");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu For Day");
        }
        else if (e.Item.Text == "Menu Items")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu Items");
        }
        
        else if (e.Item.Text == "Help")
        {
            Response.Redirect("FoodMenu.aspx");
        }
        else if (e.Item.Text == "Diners Update")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Diners Update");
        }
        else if (e.Item.Text == "Dining Transactions")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Dining Transactions");
        }
    }
    protected void gvSession_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvSession.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
}