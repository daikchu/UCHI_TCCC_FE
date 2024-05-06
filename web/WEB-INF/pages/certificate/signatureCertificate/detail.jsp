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

<spring:url var="type" value="${type}"/>
<spring:url var="label_cert_number" value="Số thứ tự/số chứng thực"/>
<spring:url var="label_cert_date" value="Ngày, tháng, năm chứng thực"/>
<spring:url var="label_cert_request_user"
            value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Họ tên, số giấy CMND/Hộ chiếu của người yêu cầu chứng thực':'Họ tên của người yêu cầu chứng thực'}"/>
<spring:url var="label_cert_request_doc"
            value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Tên của giấy tờ, văn bản chứng thực chữ ký/điểm chỉ':'Tên của bản chính giấy tờ, văn bản'}"/>
<spring:url var="label_cert_sign_user" value="Họ tên, chức danh người ký chứng thực"/>
<spring:url var="label_cert_doc_number"
            value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'Số lượng giấy tờ, văn bản đã được chứng thực chữ ký/điểm chỉ':'Số bản sao đã được chứng thực'}"/>
<spring:url var="label_notary_book" value="Sổ chứng thực" />
<spring:url var="label_cert_fee" value="Lệ phí/phí chứng thực (VNĐ)"/>
<spring:url var="label_note" value="Ghi chú"/>
<spring:url var="title" value="${type==Constants.CERTIFICATE_TYPE_SIGNATURE?'chữ ký':'bản sao'}"/>

<spring:url value="/certificate/edit-view-${type}" var="editViewUrl"/>
<spring:url value="/certificate/delete-${type}" var="deleteUrl"/>
<spring:url value="/certificate/list-${type}" var="listUrl"/>
<spring:url value="/certificate/list-${type}" var="listUrl"/>

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';

</script>

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết chứng thực ${title}</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="certDetailController">
    <div class="panel-group" id="accordion">
        <div class="form-horizontal">
            <form name="myForm" action="" method="post" class="panel panel-default" id="panel1">
                <div class="panel-heading col-md-12">
                    <div class="col-md-12" style="padding-left: 0px;">
                        <h4 class="panel-title col-md-9" style="padding-left: 0px;">Thông tin chứng thực ${title}</h4>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="panel-body col-md-12">
                        <input type="hidden" name="type" value="${type}">
                        <%--<div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai required">Loại chứng thực</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <select class="form-control truong-selectbox-padding select2" name="type" id="selectTypeCert" disabled>
                                            <option value="${Constants.CERTIFICATE_TYPE_SIGNATURE}" ${item.type == Constants.CERTIFICATE_TYPE_SIGNATURE?'selected':''}>
                                                Chứng thực chữ ký
                                            </option>
                                            <option value="${Constants.CERTIFICATE_TYPE_COPY}" ${item.type == Constants.CERTIFICATE_TYPE_COPY?'selected':''}>
                                                Chứng thực bản sao
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai required"
                                           id="label_cert_number">${label_cert_number}</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input id="cert_number" type="text" class="form-control"
                                               name="cert_number" value="${item.cert_number}" disabled>
                                        <span class="truong-text-colorred">${item.cert_number_}</span>
                                    </div>
                                    <label class="col-md-3 control-label label-bam-phai required"
                                           id="label_cert_date">${label_cert_date}</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input type="text" class="form-control"
                                               name="cert_date" ng-minlength="10" maxlength="10" id="cert_date"
                                               value="${item.cert_date}" disabled>
                                        <span class="truong-text-colorred">${item.cert_date_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">

                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required">${label_notary_book}</label>
                                    <div class="col-md-9">
                                        <input id="notary_book" type="text" class="form-control"
                                               name="notary_book" value="${item.notary_book}" disabled selected>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai required"
                                           id="label_cert_request_user">${label_cert_request_user}</label>
                                    <div class="col-md-9 control-label label-bam-trai">
                                        <textarea id="cert_request_user" class="form-control"
                                                  name="cert_request_user" disabled>${item.cert_request_user}</textarea>
                                        <span class="truong-text-colorred">${item.cert_request_user_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required"
                                           id="label_cert_request_doc">${label_cert_request_doc}</label>
                                    <div class="col-md-9">
                                        <input id="cert_request_doc" type="text" class="form-control"
                                               name="cert_request_doc" value="${item.cert_request_doc}" disabled>
                                        <span class="truong-text-colorred">${item.cert_request_doc_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required"
                                           id="label_cert_sign_user">${label_cert_sign_user}</label>
                                    <div class="col-md-9">
                                        <textarea id="cert_sign_user" class="form-control"
                                                  name="cert_sign_user" disabled>${item.cert_sign_user}</textarea>
                                        <span class="truong-text-colorred">${item.cert_sign_user_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required"
                                           id="label_cert_doc_number">${label_cert_doc_number}</label>
                                    <div class="col-md-3">
                                        <input id="cert_doc_number" type="text" class="form-control"
                                               name="cert_doc_number" value="${item.cert_doc_number}"
                                               format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                               disabled>
                                        <span class="truong-text-colorred">${item.cert_doc_number_}</span>
                                    </div>
                                    <label class="col-md-3 control-label  label-bam-phai"
                                           id="label_cert_fee">${label_cert_fee}</label>
                                    <div class="col-md-3">
                                        <input id="cert_fee" type="text" class="form-control"
                                               name="cert_fee" value="${item.cert_fee}" disabled>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai"
                                           id="label_note">${label_note}</label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" name="note" disabled>${item.note}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group"  ng-show="attestationTempParent!=null">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai">Loại Lời chứng</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control"
                                               name="cert_fee" ng-model="attestationTempParent.name" disabled>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group" ng-show="attestationTemp!=null">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai">Mẫu lời chứng</label>
                                    <div class="col-md-4" >
                                        <input type="text" class="form-control"
                                               name="cert_fee" ng-model="attestationTemp.name" disabled>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-3"></div>
                                <div class="col-md-7">
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

                            </div>
                        </div>


                    </div>
                </div>

                <div class="panel-body" style="text-align: center;">
                    <%
                        if (ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM)) {
                    %>
                    <%--<a id="exportword" class="word-export btn btn-primary btn-sm" title="Xuất file word">Xuất
                        lời chứng</a>--%>
                    <a href="${editViewUrl}/${item.id}"
                       class="btn btn-s-md btn-success">Chỉnh sửa</a>
                    <a data-toggle="modal" data-target="#delete"
                       class="btn btn-s-md btn-danger">Xóa</a>
                    <%
                        }
                    %>
                    <a href="${listUrl}" class="btn btn-s-md btn-default">Quay lại danh sách</a>

                </div>

                <div class="modal fade" id="delete" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Xóa thông tin chứng thực</h4>
                            </div>
                            <div class="modal-body">
                                <p>Xác nhận xóa thông tin chứng thực? </p>
                            </div>
                            <div class="modal-footer">

                                <a href="${deleteUrl}/${item.id}" class="btn btn-danger" style="width: 85px">Xác
                                    nhận</a>
                                <%--<input type="submit" class="btn btn-success" name="" value="Đồng ý">--%>
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
        var parentItem = $("#quan-ly-chung-thuc");
        $(parentItem).click();
        if (${type==Constants.CERTIFICATE_TYPE_SIGNATURE}) $("#quan-ly-chung-thuc-chu-ky").addClass("child-menu");
        else $("#quan-ly-chung-thuc-ban-sao").addClass("child-menu");
    });
</script>

<script>
    $(function () {
        $('#cert_date').datepicker({
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

    jQuery(document).ready(function ($) {
        $("a.word-export").click(function (event) {
            $("#sourcecontract").html(CKEDITOR.instances['editor'].getData());
            $("#sourcecontract").wordExport();
        });

        $("a.view-online").click(function (event) {
            var htmlEditor = CKEDITOR.instances['editor'].getData();
            $("#view-online").html(htmlEditor);
            //$("#view-online") > $("span").removeClass("simple");
            $("#view-online-modal").modal('show');
        });

        /*$("#view-online-modal").on("hidden.bs.modal", function () {
            window.location.reload();
        });*/
    });

    $(function () {
        $(".nut-in").on('click', function () {

            $("#view-online").print({

// Use Global styles
                globalStyles: false,

// Add link with attrbute media=print
                mediaPrint: false,

//Custom stylesheet
                stylesheet: "<%=request.getContextPath()%>/static/css/contract/print/print.css",

//Print in a hidden iframe
                iframe: false,

// Don't print this
                noPrintSelector: ".avoid-this",

// Add this on top
                append: "",

// Add this at bottom
                prepend: "",

// Manually add form values
                manuallyCopyFormValues: true,

// resolves after print and restructure the code for better maintainability
                deferred: $.Deferred(),

// timeout
                timeout: 250,

// Custom title
                title: null,

// Custom document type
                doctype: '<!doctype html>'

            });
        });
    });
</script>

<%--angularjs--%>
<script>
    myApp.controller('certDetailController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {
        $scope.cert = {
            id: "",
            cert_number: '${item.cert_number}',
            cert_date: '${item.cert_date}',
            cert_request_user: "",
            cert_request_doc: "",
            cert_sign_user: '${item.cert_sign_user}',
            cert_doc_number: "",
            cert_fee: '${item.cert_fee}',
            note: "",
            attestation_template_code: '${item.attestation_template_code}',
            kind_html: '${item.kind_html}',
            notary_book:'${item.notary_book}',
            attestation_template_code_parent: ""
        };
        $scope.attestationTempParent = null;
        $scope.attestationTemp = {};

        CKEDITOR.instances.editor.setData('${item.kind_html}');

        if(!isNullOrEmpty($scope.cert.attestation_template_code)){
            //get template by code
            $http.get(url + '/api-attestation/search', {
                params: {
                    code: '${item.attestation_template_code}'
                }
            }).then(function (response) {
                var templates = response.data;
                if(templates != null && templates.length>0){
                    $scope.attestationTemp = templates[0];

                    if(!isNullOrEmpty(templates[0].parent_code) && templates[0].parent_code != '000'){
                        getAttestationTempParent(templates[0].parent_code);
                    }
                    else{
                        $scope.attestationTempParent = $scope.attestationTemp;
                        $scope.attestationTemp = null;
                    }
                }
            });
        }


        function getAttestationTempParent(code){
            if(isNullOrEmpty(code)) return;
            $http.get(url + '/api-attestation/search', {
                params: {
                    code: code
                }
            }).then(function (response) {
                if(response.data==null||response.data.length==0) return;
                $scope.attestationTempParent = response.data[0];

            });
        }

    }]);
</script>