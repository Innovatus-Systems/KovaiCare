using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CovaiSoftService.Startup))]
namespace CovaiSoftService
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
