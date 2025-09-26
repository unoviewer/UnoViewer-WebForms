using System;
using System.IO;
using System.Web.UI;
using Uno.Files.Options;

namespace UnoViewer_WebForms.Samples
{
    public partial class Multiple : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ctlUnoOne.ViewerSettings.LangFile = "en.json";
                ctlUnoTwo.ViewerSettings.LangFile = "en.json";

                ctlUnoOne.ViewerSettings.ThumbSettings.ThumbWidth = 70;
                ctlUnoTwo.ViewerSettings.ThumbSettings.ThumbWidth = 70;

                var fileNameOne = "Sample.ppt";
                var fileNameTwo = "Sample.docx";

                BaseOptions fileOptionsOne = new PptOptions
                {
                    ConvertPdf = false
                };

                BaseOptions fileOptionsTwo = new WordOptions
                {
                    ConvertPdf = false
                };

                var filePath = Path.Combine(Server.MapPath("~/files/"), fileNameOne);

                if (File.Exists(filePath))
                {
                    ctlUnoOne.ViewFile(filePath, fileOptionsOne);
                }

                filePath = Path.Combine(Server.MapPath("~/files/"), fileNameTwo);

                if (File.Exists(filePath))
                {
                  ctlUnoTwo.ViewFile(filePath, fileOptionsTwo);
                }
            }
        }
    }
}
