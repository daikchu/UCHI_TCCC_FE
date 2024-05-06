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

<spring:url value="/notarybook/add" var="addUrl" />
<spring:url value="/notarybook/list" var="backUrl" />
<%
    String checkcongchung=SystemProperties.getProperty("org_type");
    String congchung=checkcongchung.equals("1")?"chứng thực":"công chứng";
%>
<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var org_type = <%=SystemProperties.getProperty("org_type")%>;

</script>

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
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>

<script src="<%=request.getContextPath()%>/static/js/notarybook/add.js" type="text/javascript"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Thêm mới sổ <%=congchung%></span>
</div>
<div class="truong-form-chinhbtt" id="NotaryBookController" ng-app="osp" ng-controller="NotaryBookController">
    <div id="uchi-status">
        <c:if test="${item.success == false}">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Tạo mới thông tin không thành công!</div>
        </c:if>
    </div>
    <div class="panel-group" id="accordion">
        <div class="form-horizontal">
            <form name="myForm" action="${addUrl}" method="post" class="panel panel-default" id="panel1">
                <input type="hidden" name="lock_day" id="lock_day"
                       value="${item.lock_day}" >
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
                                               name="notary_book" value="${item.notary_book}">
                                        <span class="truong-text-colorred">${item.notary_book_}</span>
                                        <div style="margin-top: 5px;color: red;"
                                             class="error_tooltip">{{message.notary_book}}
                                        </div>
                                    </div>

                                    <label class="col-md-2 control-label label-bam-phai required">Loại sổ</label>
                                    <div class="col-md-4 control-label label-bam-trai">
                                        <select class="form-control truong-selectbox-padding select2"
                                                id="type" name="type"
                                                 value="${item.type}">
                                            <option value="">-- Chọn --</option>
                                            <option value="${Constants.CERTIFICATE_TYPE_CONTRACT}" ${item.type == Constants.CERTIFICATE_TYPE_CONTRACT?"selected":""}>Sổ <%=congchung%> hợp đồng giao dịch</option>
                                            <% if (checkcongchung.equals("1")) {%>
                                            <option value="${Constants.CERTIFICATE_TYPE_COPY}" ${item.type == Constants.CERTIFICATE_TYPE_COPY?"selected":""}>Sổ chứng thực bản sao</option>
                                            <option value="${Constants.CERTIFICATE_TYPE_SIGNATURE}" ${item.type == Constants.CERTIFICATE_TYPE_SIGNATURE?"selected":""}>Sổ chứng thực chữ ký</option>
                                            <%}%>
                                        </select>
                                        <div style="margin-top: 5px;color: red;"
                                             class="error_tooltip">{{message.type}}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-2 control-label label-bam-trai required">Mở ngày</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input type="text" class="form-control" autocomplete="off" placeholder="dd/mm/yyyy"
                                               name="create_date" ng-minlength="10" maxlength="10" id="create_date" ng-model="addCondition.create_date"
                                               value="${item.create_date}" onkeypress="return restrictCharacters(this, event, forDate);" >
                                        <span class="truong-text-colorred">${item.create_date_}</span>
                                        <div style="margin-top: 5px;color: red;"
                                             class="error_tooltip">{{message.create_date}}
                                        </div>

                                    </div>
                                    <label class="col-md-2 control-label label-bam-phai">Trạng thái</label>
                                    <div class="col-md-4 control-label label-bam-trai">
                                        <%--<input type="text" class="form-control" autocomplete="off" placeholder="dd/mm/yyyy"--%>
                                               <%--name="lock_day" ng-minlength="10" maxlength="10" id="lock_day" ng-model="addCondition.lock_day"--%>
                                               <%--value="${item.lock_day}" onkeypress="return restrictCharacters(this, event, forDate);" >--%>
                                        <%--<div style="margin-top: 5px;color: red;"--%>
                                             <%--class="error_tooltip">{{message.lock_day}}--%>
                                        <%--</div>--%>
                                        <select class="form-control truong-selectbox-padding select2"
                                                id="status" name="status"
                                                value="${item.status}">
                                            <option value="${Constants.STATUS_NOTARY_BOOK_OPEN}" >Mở sổ</option>
                                            <option value="${Constants.STATUS_NOTARY_BOOK_LOCK_UP}" >Khóa sổ</option>
                                        </select>
                                        <div style="margin-top: 5px;color: red;"
                                        class="error_tooltip">{{message.status}}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-2 control-label label-bam-trai">Ghi chú</label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" name="note">${item.note}</textarea>
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
                    <a data-toggle="modal" data-target="#add"
                       class="btn btn-s-md btn-danger">Lưu</a>
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/notarybook/list" class="btn btn-s-md btn-default">Hủy bỏ</a>

                </div>

                <div class="modal fade" id="add" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Thêm thông tin sổ <%=congchung%></h4>
                            </div>
                            <div class="modal-body">
                                <p>Xác nhận thêm thông tin sổ <%=congchung%>? </p>
                            </div>
                            <div class="modal-footer">
                                <input id="submits" type="button" class="btn btn-success" data-dismiss="modal" name="" value="Đồng ý" ng-click="check_add()">
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

        $("#notary_book").on("focus", function() {
            var dest = $(this);
            dest.val(dest.val().trim());
        });

    });

</script>
<%--<script>--%>
    <%--var SO_CT_HD_GIAO_DICHS = ${Constants.CERTIFICATE_TYPE_CONTRACT};--%>
    <%--var SO_CT_BAN_SAOS = ${Constants.CERTIFICATE_TYPE_COPY};--%>
    <%--var SO_CT_CHU_KYS = ${Constants.CERTIFICATE_TYPE_SIGNATURE};--%>
<%--</script>--%>