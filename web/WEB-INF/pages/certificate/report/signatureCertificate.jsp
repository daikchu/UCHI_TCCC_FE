<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<script src="<%=request.getContextPath()%>/static/js/certificate/signatureCertificate/report.js"
        type="text/javascript"></script>

<%--
    Báo cáo chứng thực chữ ký
--%>
<spring:url value="/certificate/list" var="listUrl"/>
<spring:url value="/certificate/export-signature-cert" var="exportUrl"/>

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var exportUrl = "/certificate/export-signature-cert";
    var userId = ${userId};
    var type = ${type};

    $("#uchi-status").show();
    setTimeout(function () {
        $("#uchi-status").hide();
        $('#status-success-3').css("display", "none");
    }, 3000);
</script>

<style>
    .panel-heading a:after {
        background-image: none;
    }

    .nav-tabs.nav-justified > .active {
        border-top: 3px solid #2ca9e0;
    }

</style>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Sổ chứng thực chữ ký</span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="signCertReportController">
    <div class="form-horizontal" id="search-frm">

        <div class="panel-body ">
            <div class="form-group">

                <div class="row">
                    <div class="col-md-3">
                        Sổ chứng thực
                        <select ng-model="cert.notary_book" id="notary_book" name="notary_book"
                                class="selectpicker select2 col-md-12 no-padding">
                            <option value="" selected="selected">Chọn sổ chứng thực</option>
                            <option ng-repeat="item in notaryBook" value="{{item.notary_book}}">
                                {{item.notary_book}}
                            </option>
                        </select>
                        <span class="truong-text-colorred">${item.notary_book_}</span>
                        <div style="margin-top: 5px;color: red;"
                             class="error_tooltip">{{message.notary_book}}
                        </div>
                    </div>
                    <div class="col-md-3">
                        Ngày chứng thực
                        <select class="form-control truong-selectbox-padding select2"
                                id="timeType" ng-change="timeTypeChange(searchCondition.timeType)"
                                ng-model="searchCondition.timeType">
                            <option ng-value="01" selected>Trong ngày hôm nay</option>
                            <option ng-value="02">Trong tuần này</option>
                            <option ng-value="03">Trong tháng này</option>
                            <option ng-value="04">Trong năm nay</option>
                            <option ng-value="05">Trong khoảng thời gian</option>
                        </select>

                    </div>
                    <div ng-show="showTime">

                        <div class="col-md-3">
                            Từ ngày
                            <input type="text" ng-model="searchCondition.dateFrom"
                                   class="form-control date-time" id="dateFrom"
                                   onkeypress="return restrictCharacters(this, event, forDate);">
                            <div style="margin-top: 5px;color: red;"
                                 class="error_tooltip">{{message.dateFrom}}
                            </div>
                        </div>

                        <div class="col-md-3">
                            Đến ngày
                            <input type="text" ng-model="searchCondition.dateTo"
                                   class="form-control date-time" id="dateTo"
                                   onkeypress="return restrictCharacters(this, event, forDate);">
                            <div style="margin-top: 5px;color: red;"
                                 class="error_tooltip">{{message.dateTo}}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" style="text-align:center;margin-top:20px;">
                        <input type="button" ng-click="search()" value="Thống kê" class="btn btn-sm btn-success"
                               style="width: 120px !important;">

                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="report-contact" class="col-md-12">
                    <p id="report-title">SỔ CHỨNG THỰC CHỮ KÝ</p>
                    <p>Từ ngày {{searchCondition.dateFrom}} đến ngày {{searchCondition.dateTo}}</p>
                </div>
            </div>

        </div>

    </div>

    <div class="panel-body truong-margin-footer0px">
        <div class="export-button" style="float: right">
            <input type="button" ng-click="export()" value="Tải file báo cáo" class="btn btn-sm btn-success">
        </div>

        <table class="table" style="margin-bottom:0%" ng-switch on="listData.rowCount">

            <tr class="border-table">
                <th class=" ann-title border-table table-giua">STT</th>
                <th class=" ann-title border-table table-giua">Số thứ tự/số chứng thực</th>
                <th class=" ann-title border-table table-giua">Ngày, tháng, năm chứng thực
                </th>
                <th class=" ann-title border-table table-giua">Họ tên, số giấy CMND/Hộ chiếu
                    của người yêu cầu chứng thực
                </th>
                <th class=" ann-title border-table table-giua">Tên của giấy tờ, văn bản
                    chứng thực chữ ký/điểm chỉ
                </th>
                <th class=" ann-title border-table table-giua">Họ tên, chức danh người ký
                    chứng thực
                </th>
                <th class=" ann-title border-table table-giua">Số lượng giấy tờ, văn bản đã
                    được chứng thực chữ ký/điểm chỉ
                </th>
                <th class=" ann-title border-table table-giua">Lệ phí/phí chứng thực</th>
                <th class=" ann-title border-table table-giua">Ghi chú</th>
            </tr>
            <tr ng-switch-when="0">
                <td colspan="9"
                    style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                    Không có dữ liệu
                </td>
            </tr>

            <tr ng-switch-default class="highlight-content"
                ng-repeat="item in listData.items track by $index"
                style="height:50px!important;">
                <td class="border-table align-giua" style="width:20px!important;">
                    {{(listData.pageNumber-1)*listData.numberPerPage + $index+1}}
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    {{item.cert_number}}
                </td>
                <td class="border-table truong-text-verticel" style="color: black;">
                    {{item.cert_date}}
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_request_user | limitTo:100"></span>{{
                    item.cert_request_user.length > 100 ? '...' : ''}}

                    <a ng-if="item.cert_request_user.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.cert_request_user}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_request_doc | limitTo:100"></span>{{
                    item.cert_request_doc.length > 100 ? '...' : ''}}

                    <a ng-if="item.cert_request_doc.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.cert_request_doc}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_sign_user | limitTo:100"></span>{{
                    item.cert_sign_user.length > 100 ? '...' : ''}}

                    <a ng-if="item.cert_sign_user.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.cert_sign_user}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>

                <td class="border-table align-giua breakAll">
                    {{item.cert_doc_number}}
                </td>

                <td class="border-table align-giua breakAll">
                    {{item.cert_fee}}
                </td>

                <td class="border-table align-giua breakAll">
                    <span ng-bind-html="item.note | limitTo:100"></span>{{
                    item.note.length > 100 ? '...' : ''}}

                    <a ng-if="item.note.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.note}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>
            </tr>

            <tr ng-switch-default class="table-tr-xam">
                <th colspan="10">
                    <div class="truong-padding-foot-table">Tổng số <span
                            style="color: red;">{{listData.rowCount}}</span> dữ liệu
                    </div>
                    <div class="align-phai">
                        <ul class="pagination pagination-sm m-t-none m-b-none">
                            <li ng-if="listData.pageNumber>1"><a
                                    ng-click="loadPageData(1)">«</a>
                            </li>
                            <li ng-repeat="item in listData.pageList">
                                <a ng-if="item==listData.pageNumber"
                                   style="color:mediumvioletred;"> {{item}}</a>
                                <a ng-if="item!=listData.pageNumber"
                                   ng-click="loadPageData(item)"> {{item}}</a>
                            </li>
                            <li ng-if="listData.pageNumber<listData.pageCount"><a
                                    ng-click="loadPageData(listData.pageCount)">»</a></li>
                        </ul>
                    </div>
                </th>
            </tr>

        </table>

    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $(function () {
        $('body').on('click', function (e) {
            //did not click a popover toggle, or icon in popover toggle, or popover
            if ($(e.target).data('toggle') !== 'popover'
                && $(e.target).parents('[data-toggle="popover"]').length === 0
                && $(e.target).parents('.popover.in').length === 0) {
                $('[data-toggle="popover"]').popover('hide');
            }
        });
    });
    $(function () {
        $('#dateFrom').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#dateTo').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
    $("#notary_book").on("focus", function() {
        var dest = $(this);
        dest.val(dest.val().trim());
    });
</script>
<script>
    $(document).ready(function () {
        var parentItem = $("#bao-cao-thong-ke");
        $(parentItem).click();
        $("#bao-cao-chung-thuc-chu-ky").addClass("child-menu");
    });

</script>
