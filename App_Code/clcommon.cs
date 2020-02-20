using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
/// <summary>
/// Summary description for clcommon
/// </summary>
public class clcommon
{
    DataSet ds = new DataSet();

    int intcnt = 0;

    public clcommon()
    {
    }

    public string databasetype()
    {
        string databasetype = System.Configuration.ConfigurationSettings.AppSettings["Database"];
        return databasetype;
    }
    public string HdrWidth()
    {
        string HdrWidth = System.Configuration.ConfigurationSettings.AppSettings["HdrWidth"];
        return HdrWidth;
    }
    public string HdrHeight()
    {
        string HdrHeight = System.Configuration.ConfigurationSettings.AppSettings["HdrHeight"];
        return HdrHeight;
    }
    public string FtrWidth()
    {
        string FtrWidth = System.Configuration.ConfigurationSettings.AppSettings["FtrWidth"];
        return FtrWidth;
    }
    public string FtrHeight()
    {
        string FtrHeight = System.Configuration.ConfigurationSettings.AppSettings["FtrHeight"];
        return FtrHeight;
    }
    public string RsWidth()
    {
        string RsWidth = System.Configuration.ConfigurationSettings.AppSettings["RsWidth"];
        return RsWidth;
    }
    public string RsHeight()
    {
        string RsHeight = System.Configuration.ConfigurationSettings.AppSettings["RsHeight"];
        return RsHeight;
    }
    public string LsWidth()
    {
        string LsWidth = System.Configuration.ConfigurationSettings.AppSettings["LsWidth"];
        return LsWidth;
    }
    public string LsHeight()
    {
        string LsHeight = System.Configuration.ConfigurationSettings.AppSettings["LsHeight"];
        return LsHeight;
    }


}
