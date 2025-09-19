<%@ Page Title="Bootstrap Modal Dialog - UnoViewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bootstrap-Modal.aspx.cs" Inherits="UnoViewer_WebForms.Samples.Bootstrap_Modal" %>

<%@ Register Assembly="Uno.Files.Viewer" Namespace="Uno.Files.Viewer" TagPrefix="asp" %>

<asp:Content ID="PageSeo" ContentPlaceHolderID="SeoContent" runat="server">

    <meta name="description" content="UnoViewer sample that shows how to use bootstrap modal dialog to show a document preview.">
    <meta name="keywords" content="webforms viewer bootstrap modal,asp.net 4.8 webforms document viewer in bootstrap dialog,asp.net 4.8 C# document viewer using bootstrap">
    <link rel="canonical" href="https://webforms.unoviewer.com/samples/bootstrap-modal.aspx" />

    <meta property="og:title" content="Bootstrap Modal Dialog - UnoViewer">
    <meta property="og:type" content="article" />
    <meta property="og:description" content="UnoViewer sample that shows how to use bootstrap modal dialog to show a document preview.">
    <meta property="og:url" content="https://webforms.unoviewer.com/samples/bootstrap-modal.aspx">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
         #divUnoViewer {
             height: 95vh;
             width: 97vw;
         }
    </style>

    <button type="button" id="btnModal" data-token="" class="btn btn-primary mt-3 ms-3" onclick="LoadDocument()">
       PowerPoint Modal
    </button>

    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">PowerPoint Viewer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div id="divUnoViewer" class="col-sm-12">
                        <asp:UnoViewer ID="ctlUno" runat="server" IncludeJQuery="false" TimeOut="10" />
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script>

        // MAIN UNOVIEWER JS OBJECT 
        var objUno = null;
        var resizing = false;

        $(document).ready(function () {
            $("#imgWait").hide();

            if (typeof (<%= ctlUno.JsObject %>) !== 'undefined') {

                objUno = <%= ctlUno.JsObject %>;

                objUno.on('viewerReady', function () {
                    $("#imgWait").hide();
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
                $("#divUnoViewer").height(h - 180); // Adjust as required on your page

                resizing = false;

            }, 500);
        }

        //  Please set this in RouteConfig.cs for LoadDocument to work
        //  settings.AutoRedirectMode = RedirectMode.Off;
        function LoadDocument() {

            const myModal = new bootstrap.Modal(document.getElementById('myModal'));
          
            var existingToken = $("#btnModal").data("token");

            if (existingToken.length == 0) {

                $("#imgWait").show();

                $("#btnModal").prop('disabled', true);

                $.ajax({
                    url: '/Samples/Bootstrap-Modal.aspx/LoadDocument',
                    async: true,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        $("#btnModal").data("token", response.d);

                        myModal.show();

                        objUno.Loading(true);
                        objUno.View(response.d);

                    },
                    failure: function (response) {
                        alert("Error :" + response);
                    }
                }).done(function (response) {
                    $("#imgWait").hide();
                    $("#btnModal").prop('disabled', false);
                });
            }
            else {
                myModal.show();
            }
        }

    </script>

</asp:Content>
