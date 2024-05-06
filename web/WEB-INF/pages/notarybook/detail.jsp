<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>

<spring:url value="/notarybook/edit-view" var="editUrl"/>
<spring:url value="/notarybook/delete" var="deleteUrl" />
<spring:url value="/notarybook/list" var="listUrl" />
<spring:url value="/notarybook/update" var="updateUrl" />
<spring:url value="/notarybook/list" var="backUrl" />
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1")?"chứng thực":"công chứng";
%>


<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>--%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>--%>

<script type="text/javascript">

    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var notaryId = ${item.id};
    var type = ${item.type};
    var notary_book = '${item.notary_book}';
    var deleteUrl = '${deleteUrl}';
    $("#uchi-status").show();
    setTimeout(function () {
        $("#uchi-status").hide();
        $('#status-success-3').css("display", "none");
    }, 10000);
</script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết sổ <%=congchung%></span>
</div>
<div class="truong-form-chinhbtt" id="NotaryBookController" ng-app="osp" ng-controller="certDetailController">
    <div id="uchi-status" class="padding-default">
        <c:if test="${status != null}">
            <div class="status-error">
                <img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">${status}
            </div>
        </c:if>
    </div>
    <div class="panel-group" id="accordion">
        <div class="form-horizontal">
            <form name="myForm" action="${deleteUrl}" method="get" class="panel panel-default" id="panel1">
                <input type="hidden" id="idNotary" name="idNotary" value="${item.id}">
                <input type="hidden" id="notaryBook" name="notaryBook" value="${item.notary_book}">
                <input type="hidden" id="typeNotaryBook" name="typeNotaryBook" value="${item.type}">

                <div class="panel-heading col-md-12">
                    <div class="col-md-12" style="padding-left: 0px;">
                        <h4 class="panel-title col-md-9" style="padding-left: 0px;">Thông tin sổ <%=congchung%></h4>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="panel-body col-md-12" style="padding-bottom: 0px;margin-bottom: 0px;">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-2 control-label label-bam-trai required">Sổ <%=congchung%></label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input id="notary_book" type="text" class="form-control"
                                               name="notary_book" value="${item.notary_book}" disabled>
                                        <span class="truong-text-colorred">${item.notary_book_}</span>
                                    </div>
                                    <label class="col-md-2 control-label label-bam-phai required">Loại sổ <%=congchung%></label>
                                    <% if (checkcongchung.equals("1")) {%>
                                    <div class="col-md-4 control-label label-bam-trai">
                                        <c:if test="${item.type == Constants.CERTIFICATE_TYPE_CONTRACT}">
                                            <input type="text" class="form-control" name="type" id="type" value="Sổ <%=congchung%> hợp đồng, giao dịch" disabled>
                                        </c:if>
                                        <c:if test="${item.type == Constants.CERTIFICATE_TYPE_COPY}">
                                            <input type="text" class="form-control" name="type" id="type" value="Sổ <%=congchung%> bản sao" disabled>
                                        </c:if>
                                        <c:if test="${item.type == Constants.CERTIFICATE_TYPE_SIGNATURE}">
                                            <input type="text" class="form-control" name="type" id="type" value="Sổ <%=congchung%> chữ ký" disabled>
                                        </c:if>
                                    </div>
                                    <%}%>
                                    <% if (checkcongchung.equals("0")) {%>
                                    <div class="col-md-4 control-label label-bam-trai">
                                        <c:if test="${item.type == Constants.CERTIFICATE_TYPE_CONTRACT}">
                                            <input type="text" class="form-control" name="type" id="type" value="Sổ <%=congchung%> hợp đồng giao dịch" disabled>
                                        </c:if>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-2 control-label label-bam-trai required">Mở ngày</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input type="text" class="form-control"
                                               name="create_date" ng-minlength="10" maxlength="10" id="create_date"
                                               value="${item.create_date}" onkeypress="return restrictCharacters(this, event, forDate);" disabled>
                                        <span class="truong-text-colorred">${item.create_date_}</span>
                                    </div>
                                    <c:if test="${item.status == Constants.STATUS_NOTARY_BOOK_OPEN}">
                                        <label class="col-md-2 control-label label-bam-phai">Trạng thái</label>
                                        <div class="col-md-4 control-label">
                                            <input type="text" class="form-control"
                                                   name="status" id="status"
                                                   value="Mở sổ" disabled>

                                        </div>
                                    </c:if>
                                    <c:if test="${item.status == Constants.STATUS_NOTARY_BOOK_LOCK_UP}">
                                        <label class="col-md-2 control-label label-bam-phai">Khóa ngày</label>
                                        <div class="col-md-4 control-label label-bam-phai">
                                            <input type="text" class="form-control"
                                               name="lock_day" ng-minlength="10" maxlength="10" id="lock_day"
                                               value="${item.lock_day}" onkeypress="return restrictCharacters(this, event, forDate);"  disabled>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-2 control-label label-bam-trai">Ghi chú</label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" name="note" disabled>${item.note}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-body" style="text-align: center;">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"39", Constants.AUTHORITY_XEM)){
                    %>
                    <c:if test="${item.status == Constants.STATUS_NOTARY_BOOK_OPEN}">
                    <a href="<%=request.getContextPath()%>/notarybook/edit-view/${item.id}"
                       class="btn btn-s-md btn-success">Chỉnh sửa</a>
                    </c:if>
                    <a data-toggle="modal" data-target="#delete"
                       class="btn btn-s-md btn-danger">Xóa</a>
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/notarybook/list" class="btn btn-s-md btn-default">Quay lại danh sách</a>

                </div>
                <%--<input type="hidden" id="successNotaryBook" name="successNotaryBook" value="{{items.successNotaryBook}}" ng-model="myVar" ng-init="myVar = {{items.successNotaryBook}}">--%>
                <div class="modal fade" id="delete" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Xóa thông tin sổ <%=congchung%></h4>
                            </div>
                            <div class="modal-body">
                                <p>Xác nhận chỉnh xóa thông tin sổ <%=congchung%>? </p>
                            </div>
                            <div class="modal-footer">
                                <%--<a href="${deleteUrl}/${item.id}" ng-click="checkDeleteNotaryBook()" class="btn btn-danger" style="width: 85px">Xác nhận</a>--%>
                                <button type="submit" class="btn btn-danger" style="width: 85px">Xác nhận</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                            </div>
                        </div>

                    </div>
                </div>

            </form>

        </div>
    </div>


</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $('body').on('click', function (e) {
        //did not click a popover toggle, or icon in popover toggle, or popover
        if ($(e.target).data('toggle') !== 'popover'
            && $(e.target).parents('[data-toggle="popover"]').length === 0
            && $(e.target).parents('.popover.in').length === 0) {
            $('[data-toggle="popover"]').popover('hide');
        }
    });
    $(document).ready(function () {
        $("#quan-ly-so-chung-thuc").addClass("father-menu");

    });
</script>

<script>
    $(function () {
        $('#create_date').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

        $('#lock_day').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>
<script>
    myApp.controller('certDetailController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

        $scope.checkDeleteNotaryBook = function () {
            $http.get(deleteUrl, {
                params: {
                    id: notaryId,
                    type: type,
                    notary_book: notary_book
                }
            })
                .then(function (response) {
                    $scope.successNotaryBook = response.data;
                });
        }



    }]);
</script>