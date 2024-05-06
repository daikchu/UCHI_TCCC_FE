<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
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
<script src="<%=request.getContextPath()%>/static/js/certificate/signatureCertificate/list.js"
        type="text/javascript"></script>

<%--
    Danh sách chứng thực chữ ký/bản sao
--%>

<spring:url var="type" value="${type}" />
<spring:url var="label_cert_number" value="Số thứ tự/số chứng thực" />
<spring:url var="label_notary_book" value="Sổ chứng thực"/>
<spring:url var="label_cert_date" value="Ngày, tháng, năm chứng thực" />
<spring:url var="label_cert_request_user" value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Họ tên, số giấy CMND/Hộ chiếu của người yêu cầu chứng thực':'Họ tên của người yêu cầu chứng thực'}" />
<spring:url var="label_cert_request_doc" value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Tên của giấy tờ, văn bản chứng thực chữ ký/điểm chỉ':'Tên của bản chính giấy tờ, văn bản'}" />
<spring:url var="label_cert_sign_user" value="Họ tên, chức danh người ký chứng thực" />
<spring:url var="label_cert_doc_number" value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Số lượng giấy tờ, văn bản đã được chứng thực chữ ký/điểm chỉ':'Số bản sao đã được chứng thực'}" />
<spring:url var="label_cert_fee" value="Lệ phí/phí chứng thực (VNĐ)" />
<spring:url var="label_note" value="Ghi chú" />
<spring:url var="title" value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'chữ ký':'bản sao'}" />

<spring:url value="/certificate/add-view-${type}" var="addUrl"/>
<spring:url value="/certificate/edit-view-${type}" var="editUrl"/>
<spring:url value="/certificate/detail-view-${type}" var="detailUrl"/>
<spring:url value="/certificate/delete-${type}" var="deleteUrl"/>
<spring:url value="/certificate/list-${type}" var="listUrl"/>
<%--<spring:url value="/signatureCertificate/export" var="exportUrl"/>--%>

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var userId = ${userId};
    var type = ${type}

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
    <span id="web-map">Danh sách chứng thực ${title}</span>
</div>

<div id="uchi-status" class="padding-default">

    <c:if test="${status != null}">
        <div class="status-success"><img class="status-img"
                                         src="<%=request.getContextPath()%>/static/image/success.png">${status}
        </div>
    </c:if>
    <c:if test="${errorCode != null}">
        <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">${errorCode}</div>
    </c:if>
</div>

<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="certListController">
    <div class="form-horizontal" id="search-frm">

        <div class="form-group">
            <div class="panel-body">
                <form class="bs-example form-horizontal">
                    <div style="border:none;">

                        <div class="col-md-3">
                            ${label_cert_number}
                            <input type="text" class="form-control" ng-model="searchCondition.cert_number"
                                   my-enter="search()" id="search_certNumber"/>
                        </div>

                        <div class="col-md-3">
                            Ngày chứng thực
                            <select class="form-control truong-selectbox-padding select2"
                                    id="timeType" ng-change="timeTypeChange(searchCondition.timeType)"
                                    ng-model="searchCondition.timeType">
                                <option ng-value="00" selected>--Chọn--</option>
                                <option ng-value="01">Trong ngày hôm nay</option>
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

                        <div class="col-md-12 " style="text-align:center;margin-top:20px;"
                             class="form-group">
                            <a class="btn btn-success btn-sm" ng-click="search()"
                               style="width:120px;">Tìm kiếm</a>
                            <a class="btn btn-sm huybo" ng-click="clearCondition()" style="width:120px;">Xóa
                                điều kiện</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <div class="panel-body truong-margin-footer0px">
        <div class="export-button" style="float: right">
            <a href="${addUrl}" class="btn btn-sm btn-success">Thêm mới</a>
        </div>

        <table class="table" style="margin-bottom:0%" ng-switch on="listData.rowCount">

            <tr class="border-table">
                <th class=" ann-title border-table table-giua">STT</th>
                <th class=" ann-title border-table table-giua">${label_cert_number}</th>
                <th class=" ann-title border-table table-giua">${label_notary_book}</th>
                <th class=" ann-title border-table table-giua">${label_cert_date}</th>
                <th class=" ann-title border-table table-giua">${label_cert_request_user}</th>
                <th class=" ann-title border-table table-giua">${label_cert_request_doc}</th>
                <th class=" ann-title border-table table-giua">${label_cert_sign_user}</th>
                <th class=" ann-title border-table table-giua">${label_cert_doc_number}</th>
                <th class=" ann-title border-table table-giua">${label_cert_fee}</th>
                <th class=" ann-title border-table table-giua">${label_note}</th>
            </tr>
            <tr ng-switch-when="0">
                <td colspan="10"
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
                    <a class="link_a"
                       href="${detailUrl}/{{item.id}}">{{item.cert_number}}</a>
                </td>
                <td class="border-table truong-text-verticel" style="color: black;">
                    {{item.notary_book}}
                </td>
                <td class="border-table truong-text-verticel" style="color: black;">
                    {{item.cert_date}}
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_request_user | limitTo:200"></span>{{
                    item.cert_request_user.length > 200 ? '...' : ''}}

                    <a ng-if="item.cert_request_user.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.cert_request_user}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_request_doc | limitTo:200"></span>{{
                    item.cert_request_doc.length > 200 ? '...' : ''}}

                    <a ng-if="item.cert_request_doc.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.cert_request_doc}}" title=""
                       data-original-title=''><img
                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                </td>

                <td class="border-table truong-text-verticel" style="color: black;">
                    <span ng-bind-html="item.cert_sign_user | limitTo:200"></span>{{
                    item.cert_sign_user.length > 200 ? '...' : ''}}

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
                    <span ng-bind-html="item.note | limitTo:200"></span>{{
                    item.note.length > 200 ? '...' : ''}}

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
</script>
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-ly-chung-thuc");
        $(parentItem).click();
        if(${type==Constants.CERTIFICATE_TYPE_SIGNATURE}) $("#quan-ly-chung-thuc-chu-ky").addClass("child-menu");
        else $("#quan-ly-chung-thuc-ban-sao").addClass("child-menu");
    });

</script>
