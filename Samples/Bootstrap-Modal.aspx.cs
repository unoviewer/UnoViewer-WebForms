using Newtonsoft.Json;
using System;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using Uno.Files.Options;
using Uno.Files.Viewer;

namespace UnoViewer_WebForms.Samples
{
    public partial class Bootstrap_Modal : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                ctlUno.ViewerSettings.ShowToolbar = false;
                ctlUno.ViewerSettings.LangFile = "en.json";

                ctlUno.ShowUI();
            }
        }

        [WebMethod]
        public static string LoadDocument()
        {
            UnoViewer ctlTmp = new UnoViewer();

            var fileName = "Sample.ppt";
            var viewFileFormat = ViewFileFormat.Ppt;


            BaseOptions fileOptions = new PptOptions
            {
                ConvertPdf = false
            };


            var filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/files/"), fileName);

            if (File.Exists(filePath))
            {
                var bytes = File.ReadAllBytes(filePath);


                var waterMark = new WaterMark
                {
                    TextMark = "Bootstrap Modal",
                    Color = Color.Black,
                    Font = new Font("Verdana", 12),
                    Opacity = 50,
                    Angle = -45,
                    ShowOnCorners = true
                };

                ctlTmp.ApplyWatermark(waterMark);


                var viewToken = ctlTmp.ViewFile(bytes, viewFileFormat, fileOptions);

                if (viewToken.Length == 0)
                {
                    throw new Exception(ctlTmp.InternalException);
                }

                return viewToken;

            }
            else
            {
                throw new Exception("File not found " + filePath);
            }

        }
    }
}