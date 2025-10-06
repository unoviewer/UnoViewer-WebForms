<%@ Page Title="Multiple Viewer Instances - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Multiple.aspx.cs" Inherits="UnoViewer_WebForms.Samples.Multiple" %>
<%@ Register Assembly="Uno.Files.Viewer" Namespace="Uno.Files.Viewer" TagPrefix="asp" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer sample that shows how to include multiple document viewer instances on a single page.">
    <meta name="keywords" content="webforms viewer multiple instances,asp.net 4.8 webforms document viewer multiple instances,asp.net 4.8 C# document viewer multiple instances">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/bootstrap-modal.aspx" />

    <meta property="og:title" content="Multiple Viewer Instances - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer sample that shows how to include multiple document viewer instances on a single page.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/multiple.aspx">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
         .divUnoViewer {
            margin-top: 20px;
         }
    </style>


        <div class="row">

            <div class="col-sm-12 col-md-6 col-lg-6 divUnoViewer">
                <asp:UnoViewer ID="ctlUnoOne" runat="server" IncludeJQuery="false" TimeOut="10" />
            </div>

            <div class="col-sm-12 col-md-6 col-lg-6 divUnoViewer">
                <asp:UnoViewer ID="ctlUnoTwo" runat="server" IncludeJQuery="false" TimeOut="10" />
            </div>

        </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
        <script>

        // MAIN UNOVIEWER JS OBJECT 
        var objUnoOne = null;
        var objUnoTwo = null;

        var resizing = false;

        $(document).ready(function () {

            $("#imgWait").hide();

            if (typeof (<%= ctlUnoOne.JsObject %>) !== 'undefined') {

                objUnoOne = <%= ctlUnoOne.JsObject %>;
                objUnoTwo = <%= ctlUnoTwo.JsObject %>;

                objUnoOne.on('viewerReady', function () {
                    $("#imgWait").hide();
                });

                objUnoOne.on('pinchEnd', function (e) {

                    objUnoOne.ZoomStep(20);

                    if (e.zoomMode == "ZoomIn") {
                        objUnoOne.Zoom(true);
                    }
                    else {
                        objUnoOne.Zoom(false);
                    }

                    objUnoOne.ZoomStep(10);
                });

                objUnoTwo.on('pinchEnd', function (e) {

                    objUnoTwo.ZoomStep(20);

                    if (e.zoomMode == "ZoomIn") {
                        objUnoTwo.Zoom(true);
                    }
                    else {
                        objUnoTwo.Zoom(false);
                    }

                    objUnoTwo.ZoomStep(10);
                });

            }

            // Attach Resize Event
            $(window).on("load resize orientationchange", function () {
                SetViewerHeight();
            });

            SetViewerHeight();

        });


        function SetViewerHeight() {
            if (resizing === true) { return; }

            resizing = true;

            setTimeout(function () {

                var h = "innerHeight" in window ? window.innerHeight : document.documentElement.offsetHeight;

                $(".divUnoViewer").each(function () {
                    $(this).height(h - 180)
                });

                // Adjust as required on your page

                resizing = false;

            }, 500);
        }

        </script>
</asp:Content>
