using System;
using System.Drawing;
using System.IO;
using System.Web.UI;
using Uno.Files.Options;
using Uno.Files.Viewer;

namespace UnoViewer_WebForms.Samples
{
    public partial class Menu_Items : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var fileName = "Sample.ppt";
                var viewFileFormat = ViewFileFormat.Ppt;


                BaseOptions fileOptions = new PptOptions
                {
                    ConvertPdf = false
                };


                var filePath = Path.Combine(Server.MapPath("~/files/"), fileName);

                if (File.Exists(filePath))
                {
                    var bytes = File.ReadAllBytes(filePath);

                    // Specify which menu items to hide

                    ctlUno.ViewerSettings.MenuSettings.File = false;
                    ctlUno.ViewerSettings.MenuSettings.PageMode = false;
                    ctlUno.ViewerSettings.MenuSettings.Search = false; // Removing search, as ConvertPdf is false
                    ctlUno.ViewerSettings.MenuSettings.FullScreen = false;
                    ctlUno.ViewerSettings.MenuSettings.Flip = false;
                    ctlUno.ViewerSettings.MenuSettings.Rotate = false;
                    ctlUno.ViewerSettings.MenuSettings.Language = false;

                    ctlUno.ViewerSettings.ShowToolTip = true;
                    ctlUno.ViewerSettings.LangFile = "en.json";

                    ctlUno.ViewerSettings.PageSettings.PageMode = PageModeEnum.pan.ToString();
                    ctlUno.ViewerSettings.PageSettings.FitType = FitTypeEnum.height.ToString();

                    ctlUno.ViewerSettings.PageSettings.AutoCopyText = true;
                    ctlUno.ViewerSettings.PageSettings.SelectTextColor = "skyblue";
                    ctlUno.ViewerSettings.PageSettings.CopyTextColor = "yellow";

                    ctlUno.ViewerSettings.PageSettings.ShowPageStatus = true;
                    ctlUno.ViewerSettings.PageSettings.PageStatusLocation = PageStatusLocationEnum.bottom_right.ToString();
                    ctlUno.ViewerSettings.PageSettings.PageLayout = PageLayoutEnum.multiplePages.ToString();

                    ctlUno.ViewerSettings.ZoomSettings.PageZoom = 75;

                    ctlUno.ViewerSettings.SearchSettings.ActiveColor = "gray";
                    ctlUno.ViewerSettings.SearchSettings.BorderStyle = "2px dashed black";
                    ctlUno.ViewerSettings.SearchSettings.BackColor = "lime";

                    ctlUno.ViewerSettings.ThumbSettings.ShowThumbsLabel = true;
                    ctlUno.ViewerSettings.ThumbSettings.ThumbImageQuality = 25;

                    var waterMark = new WaterMark
                    {
                        TextMark = "Menu Items",
                        Color = Color.Black,
                        Font = new Font("Verdana", 12),
                        Opacity = 50,
                        Angle = -45,
                        ShowOnCorners = true
                    };

                    ctlUno.ApplyWatermark(waterMark);


                    var viewToken = ctlUno.ViewFile(bytes, viewFileFormat, fileOptions);

                    if (viewToken.Length == 0)
                    {
                        throw new Exception(ctlUno.InternalException);
                    }

                }
                else
                {
                    throw new Exception("File not found " + filePath);
                }
            }
        }
    }
}