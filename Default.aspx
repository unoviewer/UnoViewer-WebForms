<%@ Page Title="UnoViewer ASP.NET 4.8 WebForms" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="UnoViewer_WebForms._default" %>

<%@ Register Assembly="Uno.Files.Viewer" Namespace="Uno.Files.Viewer" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- menu css-->
    <link href="/unoViewer/css/desktop-menu.css" rel="stylesheet" />
    <link href="/unoViewer/css/mobile-menu.css" rel="stylesheet" />

    <!-- show hide menu-->
    <link href="/unoViewer/css/uno-menu.css" rel="stylesheet" />


    <style>
        /* Container DIV */

        #divUnoViewer {
            height: 95vh;
            width: 98vw;
        }
    </style>

    <div class="row">
        <div id="divUnoViewer" class="col-sm-12">
            <!-- JQUERY IS ADDED BY THE VIEWER, 
                SET IncludeJQuery TO FALSE IF NOT REQUIRED -->
            <asp:UnoViewer ID="ctlUno" runat="server" AutoClose="true" IncludeJQuery="true" TimeOut="10" DebugMode="false" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Script" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        var resizing = false;
        var isMobile = IsMobile();

        // MAIN UNOVIEWER JS OBJECT 
        var objUno = null;

        if (typeof jQuery != 'undefined') {

            $(document).ready(function () {

                if (typeof (<%= ctlUno.JsObject %>) !== 'undefined') {

                        objUno = <%= ctlUno.JsObject %>;


                        objUno.on('linkClicked', function (e) {

                            if (e.url && e.url.length > 0) {
                                window.open(e.url);
                            }
                            else if (e.meta && e.meta.length > 0) {
                                alert(e.meta);
                            }

                        });

                        objUno.on('clipboardCopied', function (e) {

                            navigator.clipboard.writeText(e.clipboard).then(() => {
                                // alert("Successfully copied.");
                            });

                            // Optional call to change page to current
                            // objUno.GotoPage(e.page);

                        });

                        objUno.on('textCopied', function (e) {

                            navigator.clipboard.writeText(e.text).then(() => {
                                // alert("Successfully copied.");
                            });

                        });


                        objUno.on('viewerError', function (e) {
                            alert(e.msg);
                        });

                        objUno.on('pageClicked', function (e) {
                            // alert(e.page);
                        });

                        objUno.on('thumbnailClicked', function (e) {
                            // alert(e.thumb);
                        });


                        objUno.on('fileOpen', function () {
                            window.top.location.href = window.top.location.href;
                        });

                        objUno.on('fileClose', function () {
                            objUno.Close();
                        });

                        objUno.on('splitterResized', function () {

                        });

                        objUno.on('viewerReady', function () {

                        });

                        objUno.on('pinchEnd', function (e) {

                            objUno.ZoomStep(20);

                            if (e.zoomMode == "ZoomIn") {
                                objUno.Zoom(true);
                            }
                            else {
                                objUno.Zoom(false);
                            }

                            objUno.ZoomStep(10);
                        });


                        // Attach Resize Event
                        $(window).on("load resize orientationchange", function () {
                            SetViewerHeight();
                        });


                        // Hide thumbnails when mobile
                        if (isMobile) {
                            objUno.ShowThumbnails(false);
                        }


                        // Prevent postback on enter key

                        $(document).keypress(function (e) {
                            if (e.keyCode === 13) {
                                e.preventDefault();
                                return false;
                            }
                        });

                        // Set height of the viewer
                        SetViewerHeight();

                    }

                });
        }


        function SetViewerHeight() {
            if (resizing === true) { return; }

            resizing = true;

            setTimeout(function () {

                var h = "innerHeight" in window ? window.innerHeight : document.documentElement.offsetHeight;
                $("#divUnoViewer").height(h - 115); // Adjust as required on your page

                resizing = false;

            }, 500);
        }

        function IsMobile() {
            var isMobile = (window.navigator.maxTouchPoints || 'ontouchstart' in document);
            return isMobile;
        }

    </script>

</asp:Content>
