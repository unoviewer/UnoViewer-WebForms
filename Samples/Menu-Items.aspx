<%@ Page Title="Hide Show Modify Menu Items - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu-Items.aspx.cs" Inherits="UnoViewer_WebForms.Samples.Menu_Items" %>

<%@ Register Assembly="Uno.Files.Viewer" Namespace="Uno.Files.Viewer" TagPrefix="asp" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer sample that shows how to enable, disable, hide or show the viewer menu items.">
    <meta name="keywords" content="webforms viewer modify menu,asp.net 4.8 webforms document viewer modify menu,asp.net 4.8 C# document viewer customize menu">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/menu-items.aspx" />

    <meta property="og:title" content="Hide Show Modify Menu Items - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer sample that shows how to enable, disable, hide or show the viewer menu items.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/menu-items.aspx">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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