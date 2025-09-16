<%@ Page Title="Custom Document Viewer Menu - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Custom-Menu.aspx.cs" Inherits="UnoViewer_WebForms.Samples.Custom_Menu" %>

<%@ Register Assembly="Uno.Files.Viewer" Namespace="Uno.Files.Viewer" TagPrefix="asp" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer sample that shows how to have your own document viewer menu instead of the default menu.">
    <meta name="keywords" content="webforms viewer custom menu,asp.net 4.8 webforms document viewer with menu,asp.net 4.8 C# document viewer menu">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/custom-menu.aspx" />

    <meta property="og:title" content="Custom Document Viewer Menu - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer sample that shows how to have your own document viewer menu instead of the default menu.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/custom-menu.aspx">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav class="navbar navbar-expand-lg bg-dark border-bottom border-body" data-bs-theme="dark">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/Samples/">Samples Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="#" onclick="DoNavigate(true);">First Page</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="#" onclick="DoNavigate(false);">Last Page</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Zoom
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="DoZoom(25);">25%</a></li>
                            <li><a class="dropdown-item" href="#" onclick="DoZoom(50);">50%</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#" onclick="DoFit('width');">Fit Width</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="ToggleFullScreen();">Full Screen</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div id="divUnoViewer" class="col-sm-12">
        <!-- JQUERY IS ADDED ON PAGE, HENCE DISABLED IN THE VIEWER -->
        <asp:UnoViewer ID="ctlUno" runat="server" AutoClose="true" IncludeJQuery="false" TimeOut="10" DebugMode="false" />
    </div>

</asp:Content>

<asp:Content ID="JSContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script>

        // MAIN UNOVIEWER JS OBJECT 
        var objUno = null;
        var resizing = false;

        $(document).ready(function () {
            $("#imgWait").hide();

            if (typeof (<%= ctlUno.JsObject %>) !== 'undefined') {
                objUno = <%= ctlUno.JsObject %>;
            }

            // Attach Resize Event
            $(window).on("load resize orientationchange", function () {
                SetViewerHeight();
            });

            SetViewerHeight();
        });

        function ToggleFullScreen() {
            objUno.FullScreen();
        }

        function DoZoom(zoom) {
            objUno.Zoom(zoom);
        }

        function DoFit(fit) {
            objUno.FitType(fit);
        }

        function DoNavigate(firstPage) {
            if (firstPage === true) {
                objUno.GotoPage(1);
            }
            else {
                const lastPage = objUno.TotalPages();
                objUno.GotoPage(parseInt(lastPage));
            }
        }

        function SetViewerHeight() {
            if (resizing === true) { return; }

            resizing = true;

            setTimeout(function () {

                var h = "innerHeight" in window ? window.innerHeight : document.documentElement.offsetHeight;
                $("#divUnoViewer").height(h - 180); // Adjust as required on your page

                resizing = false;

            }, 500);
        }

    </script>

</asp:Content>
