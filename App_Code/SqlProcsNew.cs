using System;
using System.Data;
using System.Configuration;

using System.Data.Common;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;

/// <summary>
/// Summary description for SqlProcs
/// </summary>
public class SqlProcsNew
{
    clcommon objclcommon;
    Dictionary<String, DbParameter> InOutParameters;
    private string conn = ConfigurationManager.ConnectionStrings["CovaiSoft"].ToString();

    //ClsIPMACAddress IpMac = new ClsIPMACAddress();

    public Dictionary<string, DbParameter> InOutParams
    {
        get
        {
            return InOutParameters;
        }
    }

    public SqlProcsNew()
    {
        //
        // TODO: Add constructor logic here
        //


    }
    public int ExecuteSQLNonQuery(string query, params SqlParameter[] sqlParams)
    {
        SqlConnection con = new SqlConnection(conn);
        SqlCommand cmd = new SqlCommand();
        try
        {
            con.Open();
            cmd.Connection = con;
            foreach (SqlParameter param in sqlParams)
            {
                cmd.Parameters.Add(param);
            }
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = query;
            return cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {
            con.Close();
            con.Dispose();
            cmd.Dispose();
        }
    }
    public DataSet ExecuteSP(string spName)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        DbCommand dbCommand = null;

        try
        {

            if (objclcommon.databasetype().Trim() == "ORACLE")
            {
                dbCommand = db.GetStoredProcCommand(spName, 1000);
                DS = db.ExecuteDataSet(dbCommand);
            }
            else if (objclcommon.databasetype().Trim() == "SQL")
            {
                
                dbCommand = db.GetStoredProcCommand(spName);
                dbCommand.CommandTimeout = 120;
                DS = db.ExecuteDataSet(dbCommand);
            }

            dbCommand.Parameters.Clear();
            return DS;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return null;
        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            dbCommand.Dispose();
        }
    }
    public DataSet ExecuteSP(string spName, DbTransaction dbTran, params DbParameter[] arguments)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        DbCommand dbCommand = null;
        InOutParameters = new Dictionary<string, DbParameter>();
        try
        {
            if (objclcommon.databasetype().Trim() == "SQL")
            {
                dbCommand = db.GetStoredProcCommand(spName);
                for (int i = 0; i < arguments.Length; i++)
                {
                    dbCommand.Parameters.Add(arguments[i]);
                }
                DS = db.ExecuteDataSet(dbCommand, dbTran);

            }
            foreach (DbParameter para in dbCommand.Parameters)
            {
                if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
                {
                    InOutParameters.Add(para.ParameterName, para);
                }
            }


            return DS;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return null;
        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            dbCommand.Dispose();

        }
    }

    public int ExecuteNonQuery(string strQueryText)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        DbCommand dbCommand = null;
        int returnval = 0;
        try
        {

            if (objclcommon.databasetype().Trim() == "SQL")
            {
                dbCommand = db.GetSqlStringCommand(strQueryText);
                returnval = db.ExecuteNonQuery(dbCommand);


            }

            dbCommand.Parameters.Clear();
            return returnval;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return 0;
        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            dbCommand.Dispose();

        }
    }

    public DataSet ExecuteQuery(string strQuery)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        DbCommand dbCommand = null;

        try
        {

            if (objclcommon.databasetype().Trim() == "SQL")
            {
                dbCommand = db.GetSqlStringCommand(strQuery);
                DS = db.ExecuteDataSet(dbCommand);
            }

            dbCommand.Parameters.Clear();
            return DS;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return null;
        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            dbCommand.Dispose();

        }
    }


    public DataSet ExecuteSP(string spName, params DbParameter[] arguments)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        DbCommand dbCommand = null;

        InOutParameters = new Dictionary<string, DbParameter>();

        try
        {


            if (objclcommon.databasetype().Trim() == "SQL")
            {
                dbCommand = db.GetStoredProcCommand(spName);
                for (int i = 0; i < arguments.Length; i++)
                {
                    dbCommand.Parameters.Add(arguments[i]);
                }
                dbCommand.CommandTimeout = 0;
                DS = db.ExecuteDataSet(dbCommand);

            }
            foreach (DbParameter para in dbCommand.Parameters)
            {
                if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
                {
                    InOutParameters.Add(para.ParameterName, para);
                }
            }


            return DS;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return null;
        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            dbCommand.Dispose();

        }
    }

    public int ExecuteNonQuery(string spName, DbTransaction dbTran, params DbParameter[] arguments)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DbCommand dbCommand = null;
        InOutParameters = new Dictionary<string, DbParameter>();
        try
        {
            int returnValue = 0;
            dbCommand = db.GetStoredProcCommand(spName);
            for (int i = 0; i < arguments.Length; i++)
            {
                dbCommand.Parameters.Add(arguments[i]);
            }
            returnValue = db.ExecuteNonQuery(dbCommand, dbTran);
            foreach (DbParameter para in dbCommand.Parameters)
            {
                if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
                {
                    InOutParameters.Add(para.ParameterName, para);
                }
            }
            dbCommand.Parameters.Clear();
            return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            objclcommon = null;
            db = null;
            dbCommand.Dispose();

        }
    }


    public object ExecuteSP(int DataType, string spName, params DbParameter[] arguments)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DataSet DS = new DataSet();
        System.Data.IDataReader DR = null;
        DbCommand dbCommand = null;
        InOutParameters = new Dictionary<string, DbParameter>();

        try
        {


            if (objclcommon.databasetype().Trim() == "SQL")
            {
                dbCommand = db.GetStoredProcCommand(spName);
                for (int i = 0; i < arguments.Length; i++)
                {
                    dbCommand.Parameters.Add(arguments[i]);
                }
                if (DataType == 1) // Dataset
                {
                    DS = db.ExecuteDataSet(dbCommand);
                }
                else // DataReader
                {
                    DR = db.ExecuteReader(dbCommand);
                    DR.Read();
                }


            }
            foreach (DbParameter para in dbCommand.Parameters)
            {
                if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
                {
                    InOutParameters.Add(para.ParameterName, para);
                }
            }

            dbCommand.Parameters.Clear();
            if (DataType == 1)
            {

                return DS;
            }
            else
            {
                return DR;
            }
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());

        }
        finally
        {
            objclcommon = null;
            db = null;
            DS.Dispose();
            if (DR != null)
            {
                DR = null;
            }
            dbCommand.Dispose();

        }
    }

    public int ExecuteNonQuery(string spName, params DbParameter[] arguments)
    {
        clcommon objclcommon = new clcommon();
        Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
        DbCommand dbCommand = null;
        InOutParameters = new Dictionary<string, DbParameter>();

        try
        {
            int returnValue = 0;
            dbCommand = db.GetStoredProcCommand(spName);
            for (int i = 0; i < arguments.Length; i++)
            {
                dbCommand.Parameters.Add(arguments[i]);
            }
            returnValue = db.ExecuteNonQuery(dbCommand);

            foreach (DbParameter para in dbCommand.Parameters)
            {
                if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
                {
                    InOutParameters.Add(para.ParameterName, para);
                }
            }
            dbCommand.Parameters.Clear();
            return returnValue;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            objclcommon = null;
            db = null;
            dbCommand.Dispose();

        }
    }

    // To get lookup value
    public DataSet ExecuteSPLookup(string spName)
    {
        try
        {
            clcommon objclcommon = new clcommon();
            Database db = DatabaseFactory.CreateDatabase("CovaiSoft");
            DataSet DS = new DataSet();
            if (objclcommon.databasetype().Trim() == "ORACLE")
            {
                DbCommand dbCommand = db.GetStoredProcCommand(spName, 1000);
                DS = db.ExecuteDataSet(dbCommand);
            }
            else if (objclcommon.databasetype().Trim() == "SQL")
            {
                string[] spDetails = spName.Split(',');

                DbCommand dbCommand = db.GetStoredProcCommand(spDetails[0]);
                db.AddInParameter(dbCommand, "@CODEID", DbType.String, spDetails[1]);
                DS = db.ExecuteDataSet(dbCommand);

            }


            return DS;
        }
        catch (Exception sqe)
        {
            throw new Exception(sqe.Message.ToString());
            return null;
        }
    }

    public String GetSQLServerDate()
    {
        String strConnection = ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString;
        SqlConnection connection = new SqlConnection(strConnection);
        connection.Open();
        SqlCommand com = new SqlCommand();
        com.CommandText = "select dbo.GetCurrentDate()";
        com.CommandType = CommandType.Text;
        com.Connection = connection;
        try
        {
            var result = com.ExecuteScalar(); // should properly get your value
            return (String)result;
        }
        catch (Exception e)
        {
            // either put some exception-handling code here or remove the catch 
            //   block and let the exception bubble out 
        }
        return String.Empty;
    }
    public object ConvertToDbReadyString(string value)
    {
        if (value == "Select")
            return DBNull.Value;
        else
            return value;
    }
}