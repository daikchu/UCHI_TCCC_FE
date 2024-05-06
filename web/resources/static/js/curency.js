//hungnn chuyen so sang chu
var ngay = ["", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín", "mười", "mười một", "mười hai", "mười ba", "mười bốn",
"mười lăm", "mười sáu", "mười bảy", "mười tám", "mười chín", "hai mươi", "hai mươi mốt",
"hai mươi hai", "hai mươi ba", "hai mươi tư", "hai mươi lăm", "hai mươi sáu", "hai mươi bảy",
"hai mươi tám", "hai mươi chín", "ba mươi", "ba mươi mốt"];
var thang = ["", "tháng một", "tháng hai", "tháng ba", "tháng tư", "tháng năm", "tháng sáu", "tháng bảy",
"tháng tám", "tháng chín", "tháng mười", "tháng mười một", "tháng mười hai"];

var mangso = ['không','một','hai','ba','bốn','năm','sáu','bảy','tám','chín'];

function docngaythang(date){
    var dates=date.split('/');
    var ngay1=parseInt(dates[0], 10);
    var thang1=parseInt(dates[1], 10);
    var ngaythang ="";
    if(ngay1>0)ngaythang="ngày " + ngay[ngay1] + " " + thang[thang1] + " năm " +docso(dates[2]) ;
    return ngaythang;
}
function dochangchuc(so,daydu) {
    var chuoi = "";
    chuc = Math.floor(so/10); donvi = so%10;
    if (chuc>1) { chuoi = " " + mangso[chuc] + " mươi";
        if (donvi==1) { chuoi += " mốt"; }
    } else if (chuc==1) {
        chuoi = " mười"; if (donvi==1) { chuoi += " một";
        }
    } else if (daydu && donvi>0) {
        chuoi = " lẻ";
    }
    if (donvi==5 && chuc>1) { chuoi += " lăm"; }
    else if (donvi>1||(donvi==1&&chuc==0)) {
        chuoi += " " + mangso[ donvi ];
    }
    return chuoi;
}
function docblock(so,daydu) {
    var chuoi = ""; tram = Math.floor(so/100); so = so%100;
    if (daydu || tram>0) { chuoi = " " + mangso[tram] + " trăm"; chuoi += dochangchuc(so,true);
    } else {
        chuoi = dochangchuc(so,false);
    }
    return chuoi;
}
function dochangtrieu(so,daydu) {
    var chuoi = ""; trieu = Math.floor(so/1000000); so = so%1000000;
    if (trieu>0) {
        chuoi = docblock(trieu,daydu) + " triệu"; daydu = true;
    } nghin = Math.floor(so/1000); so = so%1000;
    if (nghin>0) { chuoi += docblock(nghin,daydu) + " nghìn"; daydu = true; }
    if (so>0) { chuoi += docblock(so,daydu); } return chuoi;
}
/*function docso(so) {
    if (so==0) return mangso[0];
    var chuoi = "", hauto = "";
    do { ty = so%1000000000; so = Math.floor(so/1000000000);
        if (so>0) { chuoi = dochangtrieu(ty,true) + hauto + chuoi;
        } else {
            chuoi = dochangtrieu(ty,false) + hauto + chuoi;
        } hauto = " tỷ";
    } while (so>0);
    chuoi=chuoi.trim();
    return chuoi.charAt(0).toUpperCase() + chuoi.slice(1);
}*/
function docso(so){
    if (so==0) return mangso[0];
    var chuoi = "", hauto = "", tiento = ' ', phancach = ' ';
    var list = [];
    if((so+'').split('.').length>1){
        phancach = ' phẩy';
        return docso((so+'').split('.')[0]) + phancach + docso((so+'').split('.')[1]);
    }else if((so+'').split('-').length>1){
        tiento = 'Âm';
        return tiento + docso((so+'').split('-')[1]);
    }else{
        do {
            ty = so%1000000000;
            so = Math.floor(so/1000000000);
            if (so>0) {
                chuoi = dochangtrieu(ty,true) + hauto + chuoi;
            } else {
                chuoi = dochangtrieu(ty,false) + hauto + chuoi;
            }
            hauto = " tỷ";
        } while (so>0);
        return chuoi;
    }
    return chuoi;
}