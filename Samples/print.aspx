<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="print.aspx.cs" Inherits="UnoViewer_WebForms.Samples.print" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Print PDF with PDF.js</title>
     <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <style>
        /* Styles for the canvas and print media */
        #pdf-viewer {
            display: none; /* Hide the main canvas during normal viewing if not needed */
        }

        #print-container {
            display: none;
        }

        @media print {
            body > *:not(#print-container) {
                display: none; /* Hide everything except the print container during printing */
            }

            #print-container {
                display: block;
            }

            canvas {
                page-break-after: always; /* Ensure each canvas renders on a new page */
            }

                canvas:last-child {
                    page-break-after: avoid; /* Prevent an extra blank page at the end */
                }
        }
    </style>
</head>
<body>
    <div class="m-3"><button id="print-button" class="btn btn-primary">Print PDF</button><button class="btn btn-info ms-2" onclick="history.back()">Back</button>
       <div id="div-log" class="mt-2"></div>
    </div>
    <div id="print-container"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.min.mjs" type="module"></script>
    <script type="module">
        import * as pdfjsLib from 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.min.mjs';

        const pdfUrl = '/files/uploads/<%= Request.QueryString["pdf_file"]%>'; // Replace with your PDF file path
        const printButton = document.getElementById('print-button');
        const printContainer = document.getElementById('print-container');

        pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.worker.min.mjs';

        printButton.addEventListener('click', async () => {
            const loadingTask = pdfjsLib.getDocument(pdfUrl);
            const pdf = await loadingTask.promise;

            // Clear previous canvases if any
            printContainer.innerHTML = '';

            var divLog = document.getElementById("div-log");

            for (let i = 1; i <= pdf.numPages; i++) {

                divLog.innerHTML = 'Loading ' + i + " of " + pdf.numPages;

                const page = await pdf.getPage(i);
                const viewport = page.getViewport({ scale: 1.5 }); // Adjust scale as needed for print quality

                const canvas = document.createElement('canvas');
                const context = canvas.getContext('2d');
                canvas.height = viewport.height;
                canvas.width = viewport.width;

                printContainer.appendChild(canvas);

                const renderContext = {
                    canvasContext: context,
                    viewport: viewport
                };
                await page.render(renderContext).promise;
            }

            try {
                if (!document.execCommand('print', false, null)) {
                    window.print()
                }
            } catch {
                window.print()
            }
        });
    </script>
</body>
</html>
