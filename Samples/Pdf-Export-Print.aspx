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
            <input type="button" class="btn btn-primary mb-2" value="Print" onclick="printEmbedPdf();" />
            <embed id="pdfEmbed" name="pdfEmbed" src="/files/uploads/<%= ViewState["pdf_file"]%>" type="application/pdf" width="100%" height="500px" title="Embedded PDF Document">
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

        function printEmbedPdf() {
            const pdfEmbed = document.getElementById('pdfEmbed');
            if (pdfEmbed && pdfEmbed.src) {
                const pdfUrl = pdfEmbed.src;
                const printWindow = window.open(pdfUrl, '_blank');
                if (printWindow) {
                    printWindow.onload = function () {
                        printWindow.print();
                    };
                }
            }
        }

    </script>
</asp:Content>
