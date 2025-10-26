<%@ Page Title="More Document Viewer Samples - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="UnoViewer_WebForms.Samples._default" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer more .net 4.8 sample code useful for implementing our asp.net document viewer in your projects.">
    <meta name="keywords" content="webforms C# viewer,asp.net 4.8 webforms document viewer,asp.net 4.8 C# document viewer">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/" />

    <meta property="og:title" content="More Document Viewer Samples - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer more .net 4.8 sample code useful for implementing our asp.net document viewer in your projects.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm">
                    <div class="card-header py-3">
                        <h4 class="my-0 fw-normal">Modify Menu</h4>
                    </div>
                    <div class="card-body">
                        <p>Modify the default menu, disable few menu items of the menu.</p>
                        <a href="/Samples/Menu-Items.aspx" class="w-100 btn btn-lg btn-outline-primary" onclick="ShowWait();">Modify Menu Demo</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm">
                    <div class="card-header py-3">
                        <h4 class="my-0 fw-normal">Custom Menu</h4>
                    </div>
                    <div class="card-body">
                        <p>Implement your own external menu instead of the default viewer menu.</p>
                        <a href="/Samples/Custom-Menu.aspx" class="w-100 btn btn-lg btn-outline-primary" onclick="ShowWait();">Custom Menu Demo</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm">
                    <div class="card-header py-3">
                        <h4 class="my-0 fw-normal">Bootstrap Dialog</h4>
                    </div>
                    <div class="card-body">
                        <p>How to use bootstrap modal dialog to show a document preview.</p>
                        <a href="/Samples/Bootstrap-Modal.aspx" class="w-100 btn btn-lg btn-outline-primary" onclick="ShowWait();">Bootstrap Modal Demo</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm">
                    <div class="card-header py-3">
                        <h4 class="my-0 fw-normal">Multiple Documents</h4>
                    </div>
                    <div class="card-body">
                        <p>How to show two documents together on a single page.</p>
                        <a href="/Samples/Multiple.aspx" class="w-100 btn btn-lg btn-outline-primary" onclick="ShowWait();">Multiple Demo</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4 rounded-3 shadow-sm">
                    <div class="card-header py-3">
                        <h4 class="my-0 fw-normal">Pdf Export Print</h4>
                    </div>
                    <div class="card-body">
                        <p>How to export MS Office (doc, ppt) files to PDF and print it.</p>
                        <a href="/Samples/Pdf-Export-Print.aspx" class="w-100 btn btn-lg btn-outline-primary" onclick="ShowWait();">Pdf Export Print Demo</a>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <br />
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">

    <script>

        $(document).ready(function () {
            $("#imgWait").hide();
        });

        function ShowWait() {
            $("#imgWait").show();
        }
    </script>

</asp:Content>
