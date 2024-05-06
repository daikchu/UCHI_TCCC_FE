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

<spring:url value="/certificate/update" var="updateUrl"/>
<spring:url value="/certificate/list-${type}" var="backUrl"/>
<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var type = ${type};

</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/temporary/temporary.add.js" type="text/javascript"></script>--%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<%--<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/demo.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chỉnh sửa chứng thực ${title}</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="certEditController">
    <div id="uchi-status">
        <c:if test="${item.success == false}">
            <div class="status-error"><img class="status-img"
                                           src="<%=request.getContextPath()%>/static/image/error.png">Chỉnh sửa thông
                tin không thành công!
            </div>
        </c:if>
    </div>
    <div class="panel-group" id="accordion">
        <div class="form-horizontal">
            <form name="myForm" action="${updateUrl}" method="post" class="panel panel-default" id="formAdd">
                <input id="attestation_template_code" type="text" name="attestation_template_code"
                       value="${item.attestation_template_code}" hidden>
                <input id="kind_html" type="text" name="kind_html" value="" hidden>

                <input type="hidden" name="id" value="${item.id}">
                <div class="panel-heading col-md-12">
                    <div class="col-md-12" style="padding-left: 0px;">
                        <h4 class="panel-title col-md-9" style="padding-left: 0px;">Thông tin chứng thực ${title}</h4>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="panel-body col-md-12">
                        <input type="hidden" name="type" value="${type}">

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai required"
                                           id="label_cert_number">${label_cert_number}</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input maxlength="50" id="cert_number" type="text" class="form-control"
                                               name="cert_number" value="${item.cert_number}" ng-model="cert.cert_number">
                                        <span class="truong-text-colorred">${item.cert_number_}</span>
                                    </div>
                                    <label class="col-md-3 control-label label-bam-phai required"
                                           id="label_cert_date">${label_cert_date}</label>
                                    <div class="col-md-3 control-label label-bam-trai">
                                        <input type="text" class="form-control"
                                               name="cert_date" ng-minlength="10" maxlength="10" id="cert_date"
                                               value="${item.cert_date}"
                                               ng-model="cert.cert_date"
                                               ng-change="changeCertDate(cert.cert_date)"
                                               onkeypress="return restrictCharacters(this, event, forDate);">
                                        <span class="truong-text-colorred">${item.cert_date_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required">${label_notary_book}</label>
                                    <div class="col-md-3">
                                        <select ng-model="cert.notary_book" id="notary_book" name="notary_book"
                                                class="selectpicker select2 col-md-12 no-padding" value="{{item.notary_book}}">
                                            <option ng-repeat="item in notaryBook" value="{{item.notary_book}}" >
                                                {{item.notary_book}}
                                            </option>
                                        </select>
                                        <span class="truong-text-colorred">${item.notary_book_}</span>
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
                                        <%-- <textarea maxlength="500" id="cert_request_user" class="form-control"
                                                   name="cert_request_user">${item.cert_request_user}</textarea>--%>
                                        <input maxlength="500" id="cert_request_user" type="text" class="form-control"
                                               name="cert_request_user" value="${item.cert_request_user}" ng-model="cert.cert_request_user">
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
                                        <input maxlength="255" id="cert_request_doc" type="text" class="form-control"
                                               name="cert_request_doc" value="${item.cert_request_doc}" ng-model="cert.cert_request_doc">
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
                                        <%--<textarea maxlength="500" id="cert_sign_user" class="form-control"
                                                  name="cert_sign_user">${item.cert_sign_user}</textarea>--%>
                                        <input maxlength="500" id="cert_sign_user" type="text" class="form-control"
                                               name="cert_sign_user" value="${item.cert_sign_user}" ng-model="cert.cert_sign_user">
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
                                               ng-model="cert.cert_doc_number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);" disabled>
                                        <span class="truong-text-colorred">${item.cert_doc_number_}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required"
                                           id="label_cert_fee">${label_cert_fee}</label>
                                    <div class="col-md-3">
                                        <input maxlength="50" name="cert_fee" id="cert_fee" type="text"
                                               class="form-control ng-valid ng-touched ng-dirty ng-valid-parse ng-empty"
                                               value="${item.cert_fee}" ng-change="changeCertFee()"
                                               ng-model="cert.cert_fee"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                               <%--format="number"--%> disabled>

                                    </div>
                                    <%--<div class="col-md-1">
                                        <a data-toggle="modal" ng-click="getCertFee()"
                                           class="btn btn-s-md btn-info" style="height: 30px">Lấy gợi ý</a>
                                    </div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai"
                                           id="label_note">${label_note}</label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" name="note">${item.note}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai">Lời chứng</label>
                                    <div class="col-md-4">
                                        <select name="template" ng-model="cert.attestation_template_code_parent"
                                                class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changeTemplateParent(cert.attestation_template_code_parent)"
                                        <%--ng-init="changeTemplateParent(cert.attestation_template_code_parent)"--%>>
                                            <%--<option value="">--Chọn loại lời chứng--</option>--%>
                                            <option ng-repeat="item in listAttestationTempParent" value="{{item.code}}">
                                                {{item.name}}
                                            </option>
                                        </select>
                                    </div>

                                    <div class="col-md-4" ng-show="listAttestationTemp.length>0">
                                        <select name="template" ng-model="cert.attestation_template_code"
                                                class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changeTemplate(cert.attestation_template_code)">
                                            <option value="">--Chọn mẫu lời chứng--</option>
                                            <option ng-repeat="item in listAttestationTemp" value="{{item.code}}">
                                                {{item.name}}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-3"></div>
                                <div class="col-md-7">

                                    <div id="editor" class="form-control"
                                         style="margin:auto;font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">
                                        <div dynamic="cert.kind_html" id="contentKindHtml"></div>
                                    </div>
                                    <textarea hidden="true" name="contentText" id="contentText"></textarea>

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
                    <a id="exportword" class="word-export btn btn-primary btn-sm" title="Xuất file word">Xuất
                        lời chứng</a>
                    <a id="xemonline" class="view-online btn btn-primary btn-sm" title="Xem code online">Xem
                        online</a>
                    <a data-toggle="modal" data-target="#add"
                       class="btn btn-s-md btn-success">Lưu</a>
                    <%
                        }
                    %>
                    <a href="${backUrl}" class="btn btn-s-md btn-default">Hủy
                        bỏ</a>

                </div>
                <div class="modal fade" id="add" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Chỉnh sửa thông tin chứng thực</h4>
                            </div>
                            <div class="modal-body">
                                <p>Xác nhận chỉnh sửa thông tin chứng thực? </p>
                            </div>
                            <div class="modal-footer">

                                <input ng-click="submitForm()" type="button" class="btn btn-success" name=""
                                       value="Đồng ý">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                            </div>
                        </div>

                    </div>
                </div>

            </form>

        </div>
    </div>

    <div class="modal fade" id="view-online-modal" role="dialog" style="width:auto;">
        <div class="modal-dialog">
            <div class="modal-content"
                 style="margin:auto!important;align-content:center;width:810px;background: #fff;height:100%;min-height:500px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div style="float: right">
                        <div class="advanPrint nut-in"><img
                                src="<%=request.getContextPath()%>/static/image/btn-print.gif"
                                alt="Them moi"></div>
                    </div>

                    <div id="view-online" style="width: 595px;margin-left: 2.5cm;margin-right: 1.5cm;">
                    </div>
                </div>

            </div>
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

    /* var editor = CKEDITOR.replace('editor', {
         placeholder: 'some value',

         fullPage: true,
         // extraPlugins: 'docprops',
         // // Disable content filtering because if you use full page mode, you probably
         // // want to  freely enter any HTML content in source mode without any limitations.
         // allowedContent: true,
         width: '742px',
         height: '842px',
         resize_enabled: true
     });*/

    jQuery(document).ready(function ($) {
        $("a.word-export").click(function (event) {
            var htmlEditor = $('#contentKindHtml').html();
            /*$("#sourcecontract").html(CKEDITOR.instances['editor'].getData());*/
            $("#sourcecontract").html(htmlEditor);
            $("#sourcecontract").wordExport();
        });

        $("a.view-online").click(function (event) {
            /*var htmlEditor = CKEDITOR.instances['editor'].getData();*/
            var htmlEditor = $('#contentKindHtml').html();
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
    myApp.controller('certEditController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {
        $scope.changeCertDate = function(value){
            if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
                var dateArray = value.split("/");
                var date = dateArray[0];
                var month = dateArray[1];
                var year = dateArray[2];
                $scope.cert.cert_date_date = date;
                $scope.cert.cert_date_month = month;
                $scope.cert.cert_date_year = year;
                var ngay = $scope.cert.cert_date_date + "/" + $scope.cert.cert_date_month + "/" + $scope.cert.cert_date_year;
                $scope.cert.convert_cert_date = docngaythang(ngay);

            }
        };



        $scope.cert = {
            id: ${item.id},
            cert_number: '${item.cert_number}',
            cert_date: '${item.cert_date}',
            cert_request_user: '${item.cert_request_user}',
            cert_request_doc: '${item.cert_request_doc}',
            cert_sign_user: '${item.cert_sign_user}',
            cert_doc_number: '${item.cert_doc_number}',
            cert_fee: '${item.cert_fee}',
            note: "",
            attestation_template_code: '${item.attestation_template_code}',
            kind_html: '${item.kind_html}',
            notary_book:'${item.notary_book}',
            attestation_template_code_parent: "",
            cert_date_date : "",
            cert_date_month : "",
            cert_date_year : "",
            convert_cert_date:""
        };
        $scope.listAttestationTempParent = [];
        $scope.listAttestationTemp = [];
        $scope.changeCertDate($scope.cert.cert_date);

        $scope.changeCertFee = function() {
            var cert_fee = $('#cert_fee').val();
            if (cert_fee == null || cert_fee == '' || typeof cert_fee == 'undefined') $('#cert_fee').val(0);
        };

        $scope.changeCertFee();


        $scope.getCertFee = function () {
            /*if(!isNullOrEmpty($scope.cert.cert_fee)) return;*/
            var type = ${type};
            var typeFee = '${Constants.FEE_CERT_CHU_KY}';
            if (type == '${Constants.CERTIFICATE_TYPE_SIGNATURE}') typeFee = '${Constants.FEE_CERT_CHU_KY}';
            else if (type == '${Constants.CERTIFICATE_TYPE_COPY}') typeFee = '${Constants.FEE_CERT_BAN_SAO}';
            var soBan = $('#cert_doc_number').val();
            if (isNullOrEmpty(soBan)) soBan = 1;
            $http.get(contextPath + "/certificate/suggestCertFee", {
                params: {
                    type: typeFee,
                    soBan: soBan
                }
            })
                .then(function (response) {
                    $scope.certFee = response.data;
                    console.log("cong thuc" + $scope.certFee.formula_fee);
                    // $scope.contract.cost_tt91 = $scope.certFee.notaryFeeNumber;
                    $('#cert_fee').val($scope.certFee.feeNumber);
                });

        };


        $scope.submitForm = function () {
            $('#kind_html').val($('#contentKindHtml').html());
            if (isNullOrEmpty($scope.cert.attestation_template_code)) {
                $scope.cert.attestation_template_code = $scope.cert.attestation_template_code_parent;
            }
            $('#attestation_template_code').val($scope.cert.attestation_template_code);

            $('#formAdd').submit();

        };

        //lấy danh sách template cha
        $http.get(url + '/api-attestation/search', {
            params: {
                parent_code: '000'
            }
        }).then(function (response) {
            $scope.listAttestationTempParent = response.data;
            getTemplateByCode();
        });





        $scope.getTemplateByParentCode = function (parent_code) {
            $http.get(url + '/api-attestation/search', {
                params: {
                    parent_code: parent_code
                }
            }).then(function (response) {
                $scope.listAttestationTemp = response.data;
            });
        };

        $scope.changeTemplateParent = function (parent_code) {
            $scope.listAttestationTemp = [];
            if (parent_code == '' || parent_code == '000') {
                $scope.cert.kind_html = '';
                /*CKEDITOR.instances.editor.setData('');*/
                $("#contentKindHtml").html('');
                $('#kind_html').val('');
                $('#attestation_template_code').val('');
                return;
            }
            $scope.changeTemplate(parent_code);
            // $http.get(url + "/api-attestation/search", {params: {code: parent_code}})
            //     .then(function (response) {
            //         var templates = response.data;
            //         if (templates != null && templates.length > 0) {
            //             var template = templates[0];
            //             $scope.cert.kind_html = template.kind_html;
            //             //   CKEDITOR.instances.editor.setData(template.kind_html);
            //             $('#kind_html').val(template.kind_html);
            //             $("#contentKindHtml").html(template.kind_html);
            //             $('#attestation_template_code').val(template.code);
            //         }
            //
            //     });

            $http.get(url + "/api-attestation/search", {params: {parent_code: parent_code}})
                .then(function (response) {
                    $scope.listAttestationTemp = response.data;
                    if ($scope.listAttestationTemp == null || $scope.listAttestationTemp.length == 0) {
                        $scope.cert.attestation_template_code = $scope.cert.attestation_template_code_parent;
                        $scope.changeTemplate($scope.cert.attestation_template_code);
                    }

                });
        };

        function getTemplateByCode(){
            $http.get(url + '/api-attestation/search', {
                params: {
                    code: $scope.cert.attestation_template_code
                }
            }).then(function (response) {
                var template = response.data[0];
                if(!isNullOrEmpty(template.parent_code) && template.parent_code!='000'){
                    $scope.cert.attestation_template_code_parent = template.parent_code;
                    $scope.getTemplateByParentCode($scope.cert.attestation_template_code_parent);

                }
            });
        }

        $scope.changeTemplate = function (code) {
            $http.get(url + "/api-attestation/search", {params: {code: code}})
                .then(function (response) {
                    var templates = response.data;
                    if (templates != null && templates.length > 0) {
                        var template = templates[0];
                        $scope.cert.kind_html = template.kind_html;
                        //   CKEDITOR.instances.editor.setData(template.kind_html);
                        $('#kind_html').val(template.kind_html);
                        $("#contentKindHtml").html(template.kind_html);
                        $('#attestation_template_code').val(template.code);
                    }

                });

        };

        /*danh sách sổ công chứng*/
        $http.get(url + "/notaryBook/list", {
            params: {
                type: type
            }
        })
            .then(function (response) {
                $scope.notaryBook = response.data;
            });


    }]);
</script>