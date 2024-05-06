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

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<script src="<%=request.getContextPath()%>/static/js/notarybook/list.js" type="text/javascript"></script>

<%--
    Quản lý sổ công chứng
--%>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1")?"chứng thực":"công chứng";
%>
<spring:url value="/notarybook/add-view" var="addUrl"/>
<spring:url value="/notarybook/edit-view" var="editUrl"/>
<spring:url value="/notarybook/detail-view" var="detailUrl"/>
<spring:url value="/notarybook/delete" var="deleteUrl"/>
<spring:url value="/notarybook/list" var="listUrl"/>
<spring:url value="{{item.type}}" var="type"/>
<%--<spring:url value="${Constants.SO_CT_HD_GIAO_DICH}" var="SO_CT_HD_GIAO_DICH"/>--%>
<%--<spring:url value="${Constants.SO_CT_BAN_SAO}" var="SO_CT_BAN_SAO"/>--%>
<%--<spring:url value="${Constants.SO_CT_CHU_KY}" var="SO_CT_CHU_KY"/>--%>

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';

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

    .panel {
        webkit-box-shadow: none;
        box-shadow: none;
    }

    .popover-content {
        height: 200px;
        overflow-y: auto;
    }

</style>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Quản lý sổ <%=congchung%></span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="NotaryBookController">
    <div id="uchi-status" class="padding-default">
        <c:if test="${status != null}">
            <div class="status-success">
                <img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">${status}
            </div>
        </c:if>
    </div>
    <div class="form-horizontal" id="search-frm">
        <div class="panel-body ">
            <div class="form-group">
                <div class="col-md-3">
                    Sổ công chứng
                    <input id="search_NataryBook" type="text" class="form-control" ng-model="searchCondition.notary_book"
                           my-enter="search()"/>
                </div>
                <div class="panel-body" style="float: left; padding: 17px 15px 0">
                    <div class="report-contact" class="col-md-6">
                        <a class="btn btn-success btn-sm" ng-click="search()" style="width:120px;">Tìm kiếm</a>
                        <a class="btn btn-sm huybo" ng-click="clearCondition()" style="width:120px;">Xóa điều kiện</a>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <div class="panel-body truong-margin-footer0px">
        <ul class="nav nav-tabs" style="border-bottom:2px solid #ddd;">
            <div class="export-button" style="float: right">
                <a href="${addUrl}" class="btn btn-sm btn-success">Thêm mới</a>
            </div>
        </ul>
        <table class="table" style="margin-bottom:0%" ng-switch on="listData.rowCount">
            <tr class="border-table">
                <th class=" ann-title border-table table-giua">STT</th>
                <th class=" ann-title border-table table-giua">Sổ <%=congchung%></th>
                <% if (checkcongchung.equals("1")) {%>
                    <th class=" ann-title border-table table-giua">Loại sổ</th>
                <%}%>
                <th class=" ann-title border-table table-giua">Ngày mở</th>
                <th class=" ann-title border-table table-giua">Trạng thái</th>
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
                    <a class="link_a"
                       href="${detailUrl}/{{item.id}}">{{item.notary_book}}</a>
                </td>
                <% if (checkcongchung.equals("1")) {%>
                    <td class="border-table truong-text-verticel" style="color: black;">
                        <div ng-show="{{item.type == SO_CT_HD_GIAO_DICH}}">
                            <span>Sổ <%=congchung%> hợp đồng, giao dịch</span>
                        </div>
                        <div ng-show="{{item.type == SO_CT_BAN_SAO}}">
                            <span>Sổ <%=congchung%> bản sao</span>
                        </div>
                        <div ng-show="{{item.type == SO_CT_CHU_KY}}">
                            <span>Sổ <%=congchung%> chữ ký</span>
                        </div>
                    </td>
                <%}%>
                <td class="border-table truong-text-verticel" style="color: black;">
                    {{item.create_date}}
                </td>
                <td class="border-table truong-text-verticel" style="color: black;">
                    <div ng-show="{{item.status == STATUS_OPEN }}">
                        <span>Mở sổ</span>
                    </div>
                    <div ng-show="{{item.status == STATUS_LOCK_UP }}">
                        <span>Khóa sổ</span>
                    </div>
                </td>

                <td class="border-table align-giua breakAll">
                    <span ng-bind-html="item.note | limitTo:200"></span>{{
                    item.note.length > 200 ? '...' : ''}}

                    <a ng-if="item.note.length>200" data-trigger="click"
                       data-toggle="popover" data-html="true" data-placement="top"
                       data-content=" {{item.note}}" title=""
                       data-original-title=''></a>
                </td>
            </tr>

            <tr ng-switch-default class="table-tr-xam">
                <th colspan="9">
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
        $("#quan-ly-so-chung-thuc").addClass("father-menu");
    });
</script>
<script>
    var SO_CT_HD_GIAO_DICHS = ${Constants.CERTIFICATE_TYPE_CONTRACT};
    var SO_CT_BAN_SAOS = ${Constants.CERTIFICATE_TYPE_COPY};
    var SO_CT_CHU_KYS = ${Constants.CERTIFICATE_TYPE_SIGNATURE};
    var STATUS_LOCK_UP = ${Constants.STATUS_NOTARY_BOOK_LOCK_UP};
    var STATUS_OPEN = ${Constants.STATUS_NOTARY_BOOK_OPEN};
</script>
