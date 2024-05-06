/**
 * Created by tranv on 11/29/2016.
 */
//Check font
/*if(!doesFontExist("UTM-Neo-Sans-Intel")) {
    addFont("UTM-Neo-Sans-Intel", "./static/font/UTM-Neo-Sans-Intel.ttf");
}
 */
function addFont(fontName,fontURL){
    var newStyle = document.createElement('style');
    newStyle.appendChild(document.createTextNode("\
	@font-face {\
	    font-family: '" + fontName + "';\
	    src: url('" + fontURL + "') format('truetype');\
	}\
	"));
    var head = document.getElementsByTagName("head")[0];
    head.appendChild(newStyle);
}


function doesFontExist(fontName) {
    try{
        // creating our in-memory Canvas element where the magic happens
        var canvas = document.createElement("canvas");
        var context = canvas.getContext("2d");

        // the text whose final pixel size I want to measure
        var text = "abcdefghijklmnopqrstuvwxyz0123456789";

        // specifying the baseline font
        context.font = "72px monospace";

        // checking the size of the baseline text
        var baselineSize = context.measureText(text).width;

        // specifying the font whose existence we want to check
        context.font = "72px '" + fontName + "', monospace";

        // checking the size of the font we want to check
        var newSize = context.measureText(text).width;

        // removing the Canvas element we created
        delete canvas;

        //
        // If the size of the two text instances is the same, the font does not exist because it is being rendered
        // using the default sans-serif font
        //
        if (newSize == baselineSize) {
            return false;
        } else {
            return true;
        }
    }catch (e) {
        return true;
    }
}

//output: dd/mm/yyy HH:MM:SS
function convertIntToDateTime(timestampStr) {
    console.log('convertIntToDateTime ====== ', timestampStr);
    if(!Number(timestampStr)) return '';
    var timestamp = Number(timestampStr);
    var date = new Date(timestamp);

    var day = date.getDate();
    var month = date.getMonth() + 1; // Lưu ý: Tháng trong đối tượng Date bắt đầu từ 0
    var year = date.getFullYear();

    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();

    // Đảm bảo định dạng dd/mm/yyyy hh:MM:ss
    var formattedDate = ('0' + day).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
    var formattedTime = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2) + ':' + ('0' + seconds).slice(-2);
    var formattedDateTime = formattedDate + ' ' + formattedTime;

    return formattedDateTime;
}

//output: HH:MM:SS dd/mm/yyy
function convertIntToDateTimeHourBeforeDate(timestampStr) {
    console.log('convertIntToDateTime ====== ', timestampStr);
    if(!Number(timestampStr)) return '';
    var timestamp = Number(timestampStr);
    var date = new Date(timestamp);

    var day = date.getDate();
    var month = date.getMonth() + 1; // Lưu ý: Tháng trong đối tượng Date bắt đầu từ 0
    var year = date.getFullYear();

    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();

    // Đảm bảo định dạng dd/mm/yyyy hh:MM:ss
    var formattedDate = ('0' + day).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
    var formattedTime = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2) + ':' + ('0' + seconds).slice(-2);
    var formattedDateTime =  formattedTime + ' ' + formattedDate;

    return formattedDateTime;
}

function resetSelectOption(idTag) {
    $("#"+idTag).val("");
    $("#"+idTag+" option").prop("selected", false); // Hủy chọn tất cả các option
    $("#"+idTag+" option:first").prop("selected", true); // Chọn option mặc định (ví dụ: option đầu tiên)
    $("#"+idTag).trigger("change"); // Cập nhật giao diện
}

//Kiểm tra định dạng dd/mm/yyyy
function isValidDateFormat(dateString) {
    // Kiểm tra định dạng dd/mm/yyyy
    var pattern = /^\d{2}\/\d{2}\/\d{4}$/;

    if (!pattern.test(dateString)) {
        return false; // Không khớp với định dạng
    }

    // Kiểm tra tính hợp lệ của ngày/tháng/năm
    var parts = dateString.split('/');
    var day = parseInt(parts[0], 10);
    var month = parseInt(parts[1], 10);
    var year = parseInt(parts[2], 10);

    if (isNaN(day) || isNaN(month) || isNaN(year)) {
        return false; // Ngày/tháng/năm không hợp lệ
    }

    if (day < 1 || day > 31 || month < 1 || month > 12) {
        return false; // Ngày/tháng không nằm trong khoảng hợp lệ
    }

    // Kiểm tra năm nhuận (nếu cần)
    if (month === 2) {
        if ((year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0)) {
            if (day > 29) {
                return false; // Năm nhuận tháng 2 không vượt quá 29 ngày
            }
        } else {
            if (day > 28) {
                return false; // Tháng 2 không nhuận không vượt quá 28 ngày
            }
        }
    }

    // Trường hợp khác, trả về true
    return true;
}

function copyText(idTag) {
    var textToCopy = $("#"+idTag).text();
    navigator.clipboard.writeText(textToCopy)
        .then(function() {
            // alert("Đã sao chép nội dung: " + textToCopy);
        })
        .catch(function(error) {
            console.error("Lỗi sao chép nội dung: ", error);
        });
}

//param format dd/mm/yyyy
function getDateObjectFromDateStr(dateStr) {
    var parts = dateStr.split('/');
    return new Date(parts[2], parts[1] - 1, parts[0]);
}

var digitsOnly = /[1234567890]/g;
var forDate=/[1234567890/]/g;

function restrictCharacters(myfield, e, restrictionType) {
    if (!e) var e = window.event
    if (e.keyCode) code = e.keyCode;
    else if (e.which) code = e.which;
    var character = String.fromCharCode(code);

    // if they pressed esc... remove focus from field...
    if (code==27) { this.blur(); return false; }

    // ignore if they are press other keys
    // strange because code: 39 is the down key AND ' key...
    // and DEL also equals .
    if (!e.ctrlKey && code!=9 && code!=8 && code!=36 && code!=37 && code!=38 && (code!=39 || (code==39 && character=="'")) && code!=40) {
        if (character.match(restrictionType)) {
            return true;
        } else {
            return false;
        }

    }
}

function formatNumber(value) {
    if(!value) return '';
    // Xóa tất cả các ký tự không phải số
    value = value.replace(/\D/g, '');

    // Định dạng lại số với dấu '.' sau mỗi 3 chữ số
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

    // Trả về giá trị đã định dạng lại
    return value;
}

function getNumberFromText(value) {
    if(!value) return null;
    // Xóa tất cả các ký tự không phải số
    return Number(value.replace(/\D/g, ''));
}

function formatNumber1(input) {
    // Xóa dấu '.' trong giá trị nhập vào
    var value = String(input).replace(/\./g, '');

    // Định dạng lại số với dấu '.' sau mỗi 3 chữ số
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

    // value = value.replace(',', '.');

    // Gán giá trị đã định dạng lại vào ô input
    input.value = value;
}

function formatNumberReturn(number) {
    if(!number) return '';
    // Chuyển đổi số thành chuỗi và xóa dấu '.'
    var value = String(number).replace(/\./g, '');

    // Định dạng lại số với dấu '.' sau mỗi 3 chữ số
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

    // Trả về giá trị đã định dạng lại
    return value;
}

$(document).ready(function(){
    var firstTarget = $('.form-horizontal').find('input[type=text],textarea,select').filter(':visible:enabled:first');
    firstTarget.focus();
    $(".error_input:first").focus();

});



