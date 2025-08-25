using System;
using System.Drawing;
using System.IO;
using System.Web.UI;
using Uno.Files.Options;
using Uno.Files.Viewer;

namespace UnoViewer_WebForms
{
    public partial class _default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var fileName = "Sample.docx";
                var viewFileFormat = ViewFileFormat.Doc;

                // Other three file formats
                if(!string.IsNullOrEmpty(Request.QueryString["file"]))
                {
                    fileName = Request.QueryString["file"];

                    if(fileName == "Sample.ppt")
                    {
                        viewFileFormat = ViewFileFormat.Ppt;
                    }
                    else if (fileName == "Sample.xlsx")
                    {
                        viewFileFormat = ViewFileFormat.Xls;
                    }
                    else if (fileName == "Sample.pdf")
                    {
                        viewFileFormat = ViewFileFormat.Pdf;
                    }
                }

                var pdfOptions = new PdfOptions
                {
                    AllowSearch = true,
                    ExtractHyperlinks = true,
                    ExtractTexts = true
                };

                BaseOptions fileOptions = null;

                //  CHANGE THE FILE NAME AND FILE FORMAT HERE

                switch (viewFileFormat)
                {
                    case ViewFileFormat.Pdf:
                        fileOptions = pdfOptions;
                        break;
                    case ViewFileFormat.Doc:
                        fileOptions = new WordOptions
                        {
                            ConvertPdf = true,
                            PdfOptions = pdfOptions
                        };
                        break;
                    case ViewFileFormat.Xls:
                        fileOptions = new ExcelOptions
                        {
                            PdfOptions = pdfOptions,
                            ExportOnePagePerWorkSheet = true,
                            AutoFitContents = true,
                            RemoveEmptyContent = true
                        };
                        break;
                    case ViewFileFormat.Ppt:
                        fileOptions = new PptOptions
                        {
                            ConvertPdf = true,
                            PdfOptions = pdfOptions
                        };
                        break;
                }


                var filePath = Path.Combine(Server.MapPath("~/files/"), fileName);

                if (File.Exists(filePath))
                {

                    var bytes = File.ReadAllBytes(filePath);

                    ctlUno.ViewerSettings.ShowToolTip = true;
                    ctlUno.ViewerSettings.LangFile = "en.json";

                    ctlUno.ViewerSettings.PageSettings.PageMode = PageModeEnum.pan.ToString();
                    ctlUno.ViewerSettings.PageSettings.FitType = FitTypeEnum.width.ToString();

                    ctlUno.ViewerSettings.PageSettings.AutoCopyText = true;
                    ctlUno.ViewerSettings.PageSettings.SelectTextColor = "skyblue";
                    ctlUno.ViewerSettings.PageSettings.CopyTextColor = "yellow";

                    ctlUno.ViewerSettings.PageSettings.ShowPageStatus = true;
                    ctlUno.ViewerSettings.PageSettings.PageStatusLocation = PageStatusLocationEnum.bottom_right.ToString();
                    ctlUno.ViewerSettings.PageSettings.PageLayout = PageLayoutEnum.multiplePages.ToString();

                    ctlUno.ViewerSettings.ZoomSettings.PageZoom = 50;

                    ctlUno.ViewerSettings.SearchSettings.ActiveColor = "gray";
                    ctlUno.ViewerSettings.SearchSettings.BorderStyle = "2px dashed black";
                    ctlUno.ViewerSettings.SearchSettings.BackColor = "lime";

                    ctlUno.ViewerSettings.ThumbSettings.ShowThumbsLabel = true;
                    ctlUno.ViewerSettings.ThumbSettings.ThumbImageQuality = 25;

                    var waterMark = new WaterMark
                    {
                        TextMark = "Hello World",
                        Color = Color.Red,
                        Font = new Font("Verdana", 10),
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