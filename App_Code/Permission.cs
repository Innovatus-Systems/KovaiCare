using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient; 


/// <summary>
/// Summary description for Permission
/// </summary>
public class Permission
{
    SqlProcsNew sqlobj = new SqlProcsNew();

	public Permission()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string GetPermission(string userid, string module)
    {

        //try
        //{
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsFetchAT = new DataSet();

        string result = "";

        dsFetchAT = sqlobj.ExecuteSP("SP_GetUserPrivillage",
             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = userid.ToString() },
             new SqlParameter() { ParameterName = "@Module", SqlDbType = SqlDbType.NVarChar, Value = module.ToString() }
             );


        if (dsFetchAT.Tables[0].Rows.Count > 0)
        {
            result = dsFetchAT.Tables[0].Rows[0]["Result"].ToString();
        }

        return result;


        //}
        //catch(Exception ex)
        //{
        //    WebMsgBox.Show(ex.Message);
        //}
    }


}