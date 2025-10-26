using System;
using System.IO;
using System.Web.UI.WebControls;
using Uno.Files.Options;
using Uno.Files.Viewer;

namespace UnoViewer_WebForms.Samples
{
    public partial class Pdf_Export_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    bool extValid = false;
                    bool isWordFile = false;

                    string ext = Path.GetExtension(fileUpload.FileName);
                    switch (ext.ToLower())
                    {
                        case ".doc":
                        case ".docx":
                            extValid = true;
                            isWordFile = true;
                            break;
                        case ".ppt":
                        case ".pptx":
                        case ".pps":
                            extValid = true;
                            break;
                    }

                    if (extValid && fileUpload.PostedFile.ContentLength < 6 * 1024 * 1024)
                    {
                        // Define the server path where the file will be saved
                        string uploadFolderPath = Server.MapPath("~/files/uploads/");

                        // Create the directory if it doesn't exist
                        if (!Directory.Exists(uploadFolderPath))
                        {
                            Directory.CreateDirectory(uploadFolderPath);
                        }

                        // Get the file name
                        string fileName = Guid.NewGuid().ToString().Split('-')[0] + "-" + Path.GetFileName(fileUpload.FileName);

                        // Combine the path and file name to get the full save path
                        string filePath = Path.Combine(uploadFolderPath, fileName);

                        // Save the file to the server
                        fileUpload.SaveAs(filePath);

                        // Pdf file
                        string pdfFileName = fileName + ".pdf";
                        string pdfFilePath = Path.Combine(uploadFolderPath, pdfFileName);

                        var exportDone = ExportToPdf(filePath, pdfFilePath, isWordFile);

                        if (exportDone)
                        {
                            ViewState["pdf_file"] = pdfFileName;

                            /*
                            var pdfbytes = File.ReadAllBytes(pdfFilePath);

                            Response.ContentType = "application/pdf";
                            Response.AppendHeader("Content-Length", pdfbytes.Length.ToString());

                            Response.BinaryWrite(pdfbytes);

                            Response.Flush();
                            Response.End();
                            */
                        }
                        else
                        {
                            Response.Write("Export to PDF failed, please contact support");
                        }
                    }
                    else
                    {
                        Response.Write("Invalid file or size limit exceeded");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error uploading file: " + ex.Message);
                }
            }

        }

        protected bool ExportToPdf(string inputFilePath, string pdfFilePath, bool isWordFile)
        {
            var unoViewer = new UnoViewer();

            BaseOptions fileOptions;

            if(isWordFile)
            {
                fileOptions = new WordOptions
                {
                    ShowUI = false,
                    ConvertPdf = true
                };
            }
            else
            {
                fileOptions = new PptOptions
                {
                    ShowUI = false,
                    ConvertPdf = true
                };
            }
             
            var fileToken = unoViewer.ViewFile(inputFilePath, fileOptions);

            if (!string.IsNullOrEmpty(fileToken))
            {
                unoViewer.ExportToPdf(pdfFilePath);
                return true;
            }

            return false;
        }

    }
}