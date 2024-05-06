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

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
</script>
<%--
    Thông tin chi tiết mẫu lời chứng
--%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<script src="<%=request.getContextPath()%>/static/js/system/synContract.js" type="text/javascript"></script>

<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>

<spring:url value="/attestation-template/list" var="backUrl"/>
<spring:url value="/attestation-template/edit-view/${item.id}" var="editUrl"/>
<spring:url value="/attestation-template/delete/${item.id}" var="deleteUrl"/>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết thông tin mẫu lời chứng</span>
</div>


<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="attestationTempDetailController">

    <div class="panel-group" id="accordion">
        <form class="form-horizontal" action="${editUrl}" method="post">
            <%--<input type="hidden" name="id" value="${contractTempList.contractTempDetail.sid}">--%>

            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">

                        THÔNG TIN MẪU LỜI CHỨNG

                    </h4>

                </div>
                <div class="panel-body">
                    <div class="form-group">

                        <label class="col-md-2 control-label required label-bam-trai">Tên mẫu lời chứng</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" name="name" value="${item.name}" disabled>
                            <div class="error_tooltip"></div>
                        </div>


                        <c:if test="${itemParent!=null}">
                            <label class="col-md-2 control-label required label-bam-trai">Loại lời chứng</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="name" value="${itemParent.name}"
                                       disabled>
                                <div class="error_tooltip"></div>
                            </div>
                        </c:if>

                    </div>


                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Trạng thái </label>
                        <div class="col-md-5 control-label label-bam-trai">
                            <input class="truong-check-fix" type="radio" name="active_flg"
                                   value="1" ${item.active_flg==1?"checked":""} disabled> Đang hoạt động
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            <input class="truong-check-fix" type="radio" name="active_flg"
                                   value="0" ${item.active_flg==0?"checked":""} disabled> Ngừng hoạt động
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả</label>

                        <div class="col-md-10">
                            <textarea name="description" rows="4" class="form-control" value="${item.description}"
                                      disabled>${item.description}</textarea>
                            <div class="error_tooltip"></div>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Nội dung mẫu lời chứng</label>

                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor">
                                <div class="form-group" style="margin-top: 10px">
                                    <div id="textboxofp"></div>
                                </div>
                                <div id="editor" <%--contenteditable="true"--%> class="form-control"
                                     style="font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"
                                     disabled="disabled">
                                </div>
                            </div>

                            <div id="sourcecontract" contenteditable="true"
                                 style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>

                        </div>

                        <%--<textarea hidden  class="col-md-12"  id="giatriKindHtml"  name="kind_html"  rows="4" value="${item.kind_html}" ></textarea>--%>
                    </div>


                </div>
            </div>

            <div class="truong-prevent-btb" style="padding-bottom: 10px;">

                <div class="col-md-12" style="text-align: center;">
                    <%
                        if (ValidationPool.checkRoleDetail(request, "29", Constants.AUTHORITY_SUA)) {
                    %>
                    <a href="${editUrl}" class="btn btn-info btn-default btn-primary">Sửa</a>
                    <%
                        }
                    %>
                    <%
                        if (ValidationPool.checkRoleDetail(request, "29", Constants.AUTHORITY_XOA)) {
                    %>
                    <a data-target="#deleteContractTemp" data-toggle="modal"
                       class="btn btn-info btn-default btn-danger">Xóa</a>
                    <%
                        }
                    %>
                    <a href="${backUrl}" class="btn btn-default btn-warning">Quay lại danh sách</a>

                </div>

            </div>
        </form>
    </div>


    <div class="modal fade" id="deleteContractTemp" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa thông tin.</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc muốn xóa ! </p>
                </div>
                <div class="modal-footer">
                    <%
                        if (ValidationPool.checkRoleDetail(request, "29", Constants.AUTHORITY_SUA)) {
                    %>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            ng-click="checkAndDeleteTemplate(${item.id}, '${item.code}')">Xóa
                    </button>
                    <%--<a href="${deleteUrl}" class="btn btn-info btn-default" style="background-color: #5bdec0;">Xóa</a>--%>
                    <%
                        }
                    %>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="errorDelete" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa mẫu lời chứng không thành công!</h4>
                </div>
                <div class="modal-body">
                    <p>Mẫu lời chứng này đang được sử dụng. Bạn không thể xóa! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>


</div>


<%--<div class="modal fade" id="_deleteContract" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Xóa Hợp đồng</h4>
            </div>
            <div class="modal-body">
                <p>Bạn chắc chắn xóa hợp đồng này ? </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="_deleteContract(contract.id)">Xóa</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
            </div>
        </div>
    </div>
</div>--%>


<!-- Modal -->

<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />--%>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>--%>
<%--End Modal--%>
<script>
    $(window).on('resize', function () {
        var win = $(this);
        if (win.width() < 1300) {
            $('.truong-rs-bt3os').removeClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3os').addClass('col-md-4');
            $('.truong-rs-bt3').removeClass('col-md-2');
            $('.truong-rs-bt3').addClass('col-md-4');
        } else {
            $('.truong-rs-bt3os').removeClass('col-md-4');
            $('.truong-rs-bt3os').addClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3').removeClass('col-md-4');
            $('.truong-rs-bt3').addClass('col-md-2');

        }
    });
</script>

<script>

    var editor = CKEDITOR.replace('editor', {
        placeholder: 'some value',

        fullPage: true,
        // extraPlugins: 'docprops',
        // // Disable content filtering because if you use full page mode, you probably
        // // want to  freely enter any HTML content in source mode without any limitations.
        // allowedContent: true,
        width: '742px',
        height: '842px',
        resize_enabled: true
    });


    $(function () {
        $('#birthday').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#mau-loi-chung").addClass("child-menu");
    });
</script>

<%--angularjs--%>
<script>
    myApp.controller('attestationTempDetailController', ['$scope', '$http', '$window', function ($scope, $http, $window) {
        $http.get(url + "/api-attestation/get", {params: {id: ${item.id}}})
            .then(function (response) {
                var template = response.data;
                // $scope.cert.kind_html = template.kind_html;
                CKEDITOR.instances.editor.setData(template.kind_html);
            });

        $scope.getTemplate = function (id) {
            $http.get(url + "/api-attestation/get", {params: {id: id}})
                .then(function (response) {
                    var template = response.data;
                    CKEDITOR.instances.editor.setData(template.kind_html);
                });
        };


        $scope.checkAndDeleteTemplate = function (template_id, code_template) {
            console.log('delete');

            $http.get(url + "/certificate/count", {params: {attestation_template_code: code_template}})
                .then(function (response) {
                    $scope.count = response.data;
                    if (response.status == 200 && $scope.count > 0) {
                        $("#errorDelete").modal('show');
                    } else {
                        excuteDeleteContractTemplate(template_id);
                    }
                });

        };


        function excuteDeleteContractTemplate(template_id) {


            $window.location.href = contextPath + '/attestation-template/delete/' + template_id;
        }

    }]);
</script>


