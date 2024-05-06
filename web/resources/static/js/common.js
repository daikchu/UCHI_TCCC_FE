//DaiCQ export html to word when use ckeditor
function exportHTMLToWord1(htmlEditor, fileName) {
    var header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' " +
        "xmlns:w='urn:schemas-microsoft-com:office:word' " +
        "xmlns='http://www.w3.org/TR/REC-html40'>" +
        "<head><meta charset='utf-8'><title>Export HTML to Word Document with JavaScript</title></head><body>";
    var footer = "</body></html>";
    //var htmlEditor = CKEDITOR.instances['editor'].getData();
    var html = header + htmlEditor + footer;
    var blob = new Blob(['\ufeff', html], {
        type: 'application/msword'
    });
    // Specify link url
    var url = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(html);

    // Create download link element
    var downloadLink = document.createElement("a");

    document.body.appendChild(downloadLink);

    if(navigator.msSaveOrOpenBlob ){
        navigator.msSaveOrOpenBlob(blob, fileName);
    }else{
        // Create a link to the file
        downloadLink.href = url;

        // Setting the file name
        downloadLink.download = fileName;

        //triggering the function
        downloadLink.click();
    }

    document.body.removeChild(downloadLink);

}

/* HTML to Microsoft Word Export
* This code demonstrates how to export an html element to Microsoft Word
* with CSS styles to set page orientation and paper size.
* Tested with Word 2010, 2013 and FireFox, Chrome, Opera, IE10-11
* Fails in legacy browsers (IE<10) that lack window.Blob object
*/
function exportHTMLToWord(htmlEditor, fileName) {

    if (!window.Blob) {
        alert('Your legacy browser does not support this action.');
        return;
    }

    var html, link, blob, url, css;

    // EU A4 use: size: 841.95pt 595.35pt;
    // US Letter use: size:11.0in 8.5in;

    css = ('\
   <style>\
   @page WordSection1{size: 841.95pt 595.35pt;mso-page-orientation: portrait;}\
   div.WordSection1 {page: WordSection1;}\
   h1 {font-family: "Times New Roman", Georgia, Serif; font-size: 16pt;}\
   p {font-family: "Times New Roman", Georgia, Serif; font-size: 14pt;}\
   </style>\
  ');

    var rightAligned = document.getElementsByClassName("sm-align-right");
    for (var i=0, max=rightAligned.length; i < max; i++) {
        rightAligned[i].style = "text-align: right;"
    }

    var centerAligned = document.getElementsByClassName("sm-align-center");
    for (var i=0, max=centerAligned.length; i < max; i++) {
        centerAligned[i].style = "text-align: center;"
    }

    //html = document.getElementById('text').innerHTML;
    var html = '\
  <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">\
  <head>\
    <title>Document Title</title>\
    <xml>\
      <w:worddocument xmlns:w="#unknown">\
        <w:view>Print</w:view>\
        <w:zoom>90</w:zoom>\
        <w:donotoptimizeforbrowser />\
      </w:worddocument>\
    </xml>\
  </head>\
  <body lang=RU-ru style="tab-interval:.5in">\
    <div class="Section1">' + htmlEditor + '</div>\
  </body>\
  </html>';

    blob = new Blob(['\ufeff', css + html], {
        type: 'application/msword'
    });

    url = URL.createObjectURL(blob);
    link = document.createElement('A');
    link.href = url;


    // Set default file name.
    // Word will append file extension - do not add an extension here.
    link.download = fileName;

    document.body.appendChild(link);

    if (navigator.msSaveOrOpenBlob) {
        navigator.msSaveOrOpenBlob( blob, fileName); // IE10-11
    } else {
        link.click(); // other browsers
    }

    document.body.removeChild(link);
}

//Hàm check giá tri rỗng hoặc null hoặc undefind
function isNullOrEmpty(str) {
    if (typeof str == "undefined" || str == "" || str == null) return true;
    else return false;
}

//Hàm convert string to date
function stringToDate(_date,_format,_delimiter)
{
    var formatLowerCase=_format.toLowerCase();
    var formatItems=formatLowerCase.split(_delimiter);
    var dateItems=_date.split(_delimiter);
    var monthIndex=formatItems.indexOf("mm");
    var dayIndex=formatItems.indexOf("dd");
    var yearIndex=formatItems.indexOf("yyyy");
    var month=parseInt(dateItems[monthIndex]);
    month-=1;
    var formatedDate = new Date(dateItems[yearIndex],month,dateItems[dayIndex]);
    return formatedDate;
}

//Hàm check valid date
function isValidDateDDMMYYYY(_date)
{
    var temp = _date.split('/');
    var d = new Date(temp[2] + '/' + temp[1] + '/' + temp[0]);
    //if(d.getDate()>31 || d.getMonth()>12) return false;
    return (d && (d.getMonth() + 1) == temp[1] && d.getDate() == Number(temp[0]) && d.getFullYear() == Number(temp[2]));
}

//Escape special symbols "'", '"', "<", ">", "&" to character references when outputting.
function escape_html(str) {

    if ((str===null) || (str===''))
        return false;
    else
        str = str.toString();

    var map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };

    return str.replace(/[&<>"']/g, function(m) { return map[m]; });
}

