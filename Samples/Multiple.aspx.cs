using System;
using System.Drawing;
using System.IO;
using System.Web.UI;
using Uno.Files.Options;
using Uno.Files.Viewer;

namespace UnoViewer_WebForms.Samples
{
    public partial class Multiple : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ctlUnoOne.ViewerSettings.ThumbSettings.ThumbWidth = 70;
                ctlUnoOne.ViewerSettings.MenuSettings.Search = false;  // ConvertPdf = false
                ctlUnoOne.ViewerSettings.MenuSettings.File = false;

                ctlUnoTwo.ViewerSettings.ThumbSettings.ThumbWidth = 70;
                ctlUnoTwo.ViewerSettings.MenuSettings.Search = false;  // ConvertPdf = false
                ctlUnoTwo.ViewerSettings.MenuSettings.File = false;

                var fileNameOne = "Sample.ppt";
                var fileNameTwo = "Sample.docx";

                var waterMarkOne = new WaterMark
                {
                    TextMark = "One PPT",
                    Color = Color.Red,
                    Font = new Font("Verdana", 18),
                    Opacity = 75,
                    Angle = -45,
                    ShowOnCorners = true
                };

                ctlUnoOne.ApplyWatermark(waterMarkOne);

                var waterMarkTwo = new WaterMark
                {
                    TextMark = "Two DOC",
                    Color = Color.Blue,
                    Font = new Font("Verdana", 18),
                    Opacity = 75,
                    Angle = -45,
                    ShowOnCorners = true
                };

                ctlUnoTwo.ApplyWatermark(waterMarkTwo);

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
