<%@ Page Title="Pdf Export Print - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pdf-Export-Print.aspx.cs" Inherits="UnoViewer_WebForms.Samples.Pdf_Export_Print" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer sample that shows how to export Word, PowerPoint and Excel files to PDF and also print them from browser.">
    <meta name="keywords" content="word to pdf,powerpoint to pdf,excel to pdf,web based pdf file printer,office to pdf export online">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/pdf-export-print.aspx" />

    <meta property="og:title" content="Pdf Export Print - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer sample that shows how to export Word, PowerPoint and Excel files to PDF and also print them from browser.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/pdf-export-print.aspx">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        #MainContent_fileUpload {
            width: 80%;
        }
    </style>

    <div class="row">
        <div class="p-5">
            <label for="fileUpload" class="form-label">Upload a <strong>Word or PowerPoint</strong> file. The file size should be <strong>less than 5 mb</strong>.</label>
            <asp:FileUpload CssClass="form-control form-control-lg" ID="fileUpload" runat="server" accept=".doc, .docx, .ppt, .pptx, .pps" />
            <br />
            <asp:Button ID="btnUpload" CssClass="btn btn-primary" runat="server" OnClick="btnUpload_Click" Text="Pdf Export" OnClientClick="return ValidateUpload(true);" />
        </div>

        <%if (ViewState["pdf_file"] != null)
            {  %>
        <div id="pdfContainer" class="p-5">
            <input type="button" class="btn btn-primary mb-2" value="Print" onclick="printIframePdf();" />
            <iframe id="pdfFrame" name="pdfFrame" src="/files/uploads/<%= ViewState["pdf_file"]%>" width="100%" height="500px" style="border: none;"></iframe>
        </div>
        <% }  %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script>

        var fileSize = 0;

        $(document).ready(function () {
            ShowWait(false);

            $('#MainContent_fileUpload').on('change', function () {

                fileSize = Math.ceil(this.files[0].size / 1024 / 1024);

            });

        });

        function ShowWait(show) {
            if (show) {
                $("#imgWait").show();
            }
            else {
                $("#imgWait").hide();
            }
        }

        function ValidateUpload() {

            if (fileSize < 6) {
                ShowWait(true);
            }
            else {
                return false;
            }
        }

        function printIframePdf() {
            const iframe = document.getElementById("pdfFrame");

            // Ensure the iframe exists and its content is loaded
            if (iframe && iframe.contentWindow) {
                // Focus the iframe's content window to ensure the print dialog targets it
                iframe.contentWindow.focus();
                // Call the print method on the iframe's content window
                iframe.contentWindow.print();
            } else {
                console.error('Iframe not found or content not loaded.');
            }
        }

    </script>
</asp:Content>
