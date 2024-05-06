if (typeof jQuery !== "undefined" && typeof saveAs !== "undefined") {
    (function($) {
        $.fn.wordExport = function(fileName) {
            fileName = typeof fileName !== 'undefined' ? fileName : "Hop dong cong chung";
            var static = {
                mhtml: {
                    top: "<html>\n_html_</html>",
                    head: "<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n" +
                    "<style>\n_styles_\n</style>\n</head>\n",
                    body: "<body>_body_</body>"
                }
            };
            var options = {
                maxWidth: 624
            };
            // Clone selected element before manipulating it
            var markup = $(this).clone();

            // Remove hidden elements from the output
            markup.each(function() {
                var self = $(this);
                if (self.is(':hidden'))
                    self.remove();
            });

            // Embed all images using Data URLs
            var images = Array();
            var img = markup.find('img');
            for (var i = 0; i < img.length; i++) {
                // Calculate dimensions of output image
                var w = Math.min(img[i].width, options.maxWidth);
                var h = img[i].height * (w / img[i].width);
                // Create canvas for converting image to data URL
                $('<canvas>').attr("id", "jQuery-Word-export_img_" + i).width(w).height(h).insertAfter(img[i]);
                var canvas = document.getElementById("jQuery-Word-export_img_" + i);
                canvas.width = w;
                canvas.height = h;
                // Draw image to canvas
                var context = canvas.getContext('2d');
                context.drawImage(img[i], 0, 0, w, h);
                // Get data URL encoding of image
                var uri = canvas.toDataURL();
                $(img[i]).attr("src", img[i].src);
                img[i].width = w;
                img[i].height = h;
                // Save encoded image to array
                images[i] = {
                    type: uri.substring(uri.indexOf(":") + 1, uri.indexOf(";")),
                    encoding: uri.substring(uri.indexOf(";") + 1, uri.indexOf(",")),
                    location: $(img[i]).attr("src"),
                    data: uri.substring(uri.indexOf(",") + 1)
                };
                // Remove canvas now that we no longer need it
                canvas.parentNode.removeChild(canvas);
            }

            // Prepare bottom of mhtml file with image data
            var mhtmlBottom = "\n";
            for (var i = 0; i < images.length; i++) {
                // mhtmlBottom += "--NEXT.ITEM-BOUNDARY\n";
                mhtmlBottom += "Content-Location: " + images[i].contentLocation + "\n";
                mhtmlBottom += "Content-Type: " + images[i].contentType + "\n";
                mhtmlBottom += "Content-Transfer-Encoding: " + images[i].contentEncoding + "\n\n";
                mhtmlBottom += images[i].contentData + "\n\n";
            }
            // mhtmlBottom += "--NEXT.ITEM-BOUNDARY--";

            //TODO: load css from included stylesheet
            var xmls="";
               /* "" +
                " <w:WordDocument>\n" +
                "  <w:View>Print</w:View>\n" +
                "  <w:ValidateAgainstSchemas/>\n" +
                "  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>\n" +
                "  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>\n" +
                "  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>\n" +
                "  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>\n" +
                " </w:WordDocument>\n" +
                "</xml><![endif]-->";*/
            var styles = "" +
                "<!--\n" +
                  " /!* Style Definitions *!/\n" +
                  " /!* Page Definitions *!/\n" +
                " @page\n" +
                "\t{mso-footnote-separator:url(\"header.htm\") fs;\n" +
                "\tmso-footnote-continuation-separator:url(\"header.htm\") fcs;\n" +
                "\tmso-endnote-separator:url(\"header.htm\") es;\n" +
                "\tmso-endnote-continuation-separator:url(\"header.htm\") ecs;}\n" +
                "@page Section1\n" +
                "\t{size:21cm 29.5cm;\n" +
                "\tmargin:2cm 2cm 2cm 3cm;\n" +
                "\tmso-header-margin:.5in;\n" +
                "\tmso-footer-margin:.5in;\n" +
                "\tmso-even-footer:url(\"header.htm\") ef1;\n" +
                "\tmso-footer:url(\"header.htm\") f1;\n" +
                "\tmso-paper-source:0;}\n" +
                "div.Section1\n" +
                "\t{page:Section1;}\n" +

                "-->"+

            ".break { page-break-before: always; }";

            // Aggregate parts of the file together 
            var fileContent = static.mhtml.top.replace("_html_", static.mhtml.head.replace("_styles_", styles) + static.mhtml.body.replace("_body_", markup.html())) + mhtmlBottom;
console.log(fileContent);
            fileContent=fileContent.replace("<style>",xmls+"<style>");
            fileContent=fileContent.replace("<body>","<body><div class=Section1>");

           // fileContent=fileContent.replace(new RegExp("line-height: 150%;", 'g'),"margin-top:1.0pt;margin-right:0pt;margin-bottom:1.0pt;margin-left:0pt;text-indent:1cm;line-height: 150%;");

            fileContent= fileContent.replace("</body>","</div></body>");
            // Create a Blob with the file contents
            var blob = new Blob([fileContent], { type: "application/msword;charset=utf-8"});

          //  var blob =htmlDocx.asBlob(fileContent, {orientation: 'portrait', margins: {top: 1133,right:850,bottom:1133,left:1400}});
            saveAs(blob, fileName + ".doc");

            var fileContentHtm="<html xmlns:v=\"urn:schemas-microsoft-com:vml\"\n" +
                "xmlns:o=\"urn:schemas-microsoft-com:office:office\"\n" +
                "xmlns:w=\"urn:schemas-microsoft-com:office:word\"\n" +
                "xmlns=\"http://www.w3.org/TR/REC-html40\">\n" +
                "\n" +
                "<head>\n" +
                "<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">\n" +
                "<meta name=ProgId content=Word.Document>\n" +
                "<meta name=Generator content=\"Microsoft Word 11\">\n" +
                "<meta name=Originator content=\"Microsoft Word 11\">\n" +
                "<link id=Main-File rel=Main-File href=\"\">\n" +
                "</head>\n" +
                "\n" +
                "<body lang=EN-US>\n" +
                "\n" +
                "<div style='mso-element:footnote-separator' id=fs>\n" +
                "\n" +
                "<p class=MsoNormal><span style='mso-special-character:footnote-separator'><![if !supportFootnotes]>\n" +
                "\n" +
                "<hr align=left size=1 width=\"33%\">\n" +
                "\n" +
                "<![endif]></span></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<div style='mso-element:footnote-continuation-separator' id=fcs>\n" +
                "\n" +
                "<p class=MsoNormal><span style='mso-special-character:footnote-continuation-separator'><![if !supportFootnotes]>\n" +
                "\n" +
                "<hr align=left size=1>\n" +
                "\n" +
                "<![endif]></span></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<div style='mso-element:endnote-separator' id=es>\n" +
                "\n" +
                "<p class=MsoNormal><span style='mso-special-character:footnote-separator'><![if !supportFootnotes]>\n" +
                "\n" +
                "<hr align=left size=1 width=\"33%\">\n" +
                "\n" +
                "<![endif]></span></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<div style='mso-element:endnote-continuation-separator' id=ecs>\n" +
                "\n" +
                "<p class=MsoNormal><span style='mso-special-character:footnote-continuation-separator'><![if !supportFootnotes]>\n" +
                "\n" +
                "<hr align=left size=1>\n" +
                "\n" +
                "<![endif]></span></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<div style='mso-element:footer' id=ef1>\n" +
                "\n" +
                "<div style='mso-element:frame;mso-element-wrap:around;mso-element-anchor-vertical:\n" +
                "paragraph;mso-element-anchor-horizontal:margin;mso-element-left:right;\n" +
                "mso-element-top:.05pt;mso-height-rule:exactly'>\n" +
                "\n" +
                "<table cellspacing=0 cellpadding=0 hspace=0 vspace=0 align=right>\n" +
                " <tr>\n" +
                "  <td valign=top align=left style='padding-top:0in;padding-right:0in;\n" +
                "  padding-bottom:0in;padding-left:0in'>\n" +
                "  <p class=MsoFooter style='mso-element:frame;mso-element-wrap:around;\n" +
                "  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;\n" +
                "  mso-element-left:right;mso-element-top:.05pt;mso-height-rule:exactly'><!--[if supportFields]><span\n" +
                "  class=MsoPageNumber><span style='mso-element:field-begin'></span>PAGE<span\n" +
                "  style='mso-spacerun:yes'>  </span></span><![endif]--><!--[if supportFields]><span\n" +
                "  class=MsoPageNumber><span style='mso-element:field-end'></span></span><![endif]--><span\n" +
                "  class=MsoPageNumber><o:p></o:p></span></p>\n" +
                "  </td>\n" +
                " </tr>\n" +
                "</table>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<p class=MsoFooter style='margin-right:.25in'><o:p>&nbsp;</o:p></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<div style='mso-element:footer' id=f1>\n" +
                "\n" +
                "<div style='mso-element:frame;mso-element-wrap:around;mso-element-anchor-vertical:\n" +
                "paragraph;mso-element-anchor-horizontal:margin;mso-element-left:right;\n" +
                "mso-element-top:.05pt;mso-height-rule:exactly'>\n" +
                "\n" +
                "<table cellspacing=0 cellpadding=0 hspace=0 vspace=0 align=right>\n" +
                " <tr>\n" +
                "  <td valign=top align=left style='padding-top:0in;padding-right:0in;\n" +
                "  padding-bottom:0in;padding-left:0in'>\n" +
                "  <p class=MsoFooter style='mso-element:frame;mso-element-wrap:around;\n" +
                "  mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:margin;\n" +
                "  mso-element-left:right;mso-element-top:.05pt;mso-height-rule:exactly'><!--[if supportFields]>\n" +
                "  <span\n" +
                "  class=MsoPageNumber><span style='mso-element:field-begin'></span>PAGE<span\n" +
                "  style='mso-spacerun:yes'>  </span><span style='mso-element:field-separator'></span></span><![endif]-->\n" +
                "  <span\n" +
                "  class=MsoPageNumber><span style='mso-no-proof:yes'>1</span></span><!--[if supportFields]>\n" +
                "  <span\n" +
                "  class=MsoPageNumber><span style='mso-element:field-end'></span></span><![endif]-->\n" +
                "  <span\n" +
                "  class=MsoPageNumber><o:p></o:p></span></p>\n" +
                "  </td>\n" +
                " </tr>\n" +
                "</table>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "<p class=MsoFooter style='margin-right:.25in'><o:p>&nbsp;</o:p></p>\n" +
                "\n" +
                "</div>\n" +
                "\n" +
                "</body>\n" +
                "\n" +
                "</html>\n";
            var blobHtm = new Blob([fileContentHtm], { type: "text/html;charset=utf-8"});

           // saveAs(blobHtm, "header.htm");
        };
    })(jQuery);
} else {
    if (typeof jQuery === "undefined") {
        console.error("jQuery Word Export: missing dependency (jQuery)");
    }
    if (typeof saveAs === "undefined") {
        console.error("jQuery Word Export: missing dependency (FileSaver.js)");
    };
}
