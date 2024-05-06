<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />

<script type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath='<%=request.getContextPath()%>';
</script>
<%--
    Thông tin chi tiết mẫu lời chứng
--%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<script src="<%=request.getContextPath()%>/static/js/system/synContract.js" type="text/javascript"></script>

<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>

<spring:url value="/attestation-template/list" var="backUrl" />
<spring:url value="/attestation-template/update" var="updateUrl" />
<spring:url value="/attestation-template/delete/${item.id}" var="deleteUrl" />
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chỉnh sửa thông tin mẫu lời chứng</span>
</div>


<div class="truong-form-chinhbtt"  ng-app="osp" ng-controller="attestationTempEditController">

    <div class="panel-group" id="accordion">
        <form id="formEdit" class="form-horizontal" action="${updateUrl}" method="post">
            <input type="hidden" name="id" value="${item.id}">

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
                            <input id="temp_name" type="text" class="form-control" name="name" value="${item.name}">
                            <div class="error_tooltip">{{invalid.name}}</div>
                        </div>


                        <c:if test="${itemParent!=null}">
                            <label class="col-md-2 control-label required label-bam-trai">Loại lời chứng</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="name" value="${itemParent.name}" disabled>
                                <div class="error_tooltip"></div>
                            </div>
                        </c:if>

                    </div>


                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Trạng thái </label>
                        <div class="col-md-5 control-label label-bam-trai">
                            <input class="truong-check-fix" type="radio" name="active_flg" value="1" ${item.active_flg==1?"checked":""} > Đang hoạt động &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            <input class="truong-check-fix" type="radio" name="active_flg" value="0" ${item.active_flg==0?"checked":""} > Ngừng hoạt động
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả</label>

                        <div class="col-md-10">
                            <textarea name="description" rows="4" class="form-control" value="${item.description}" >${item.description}</textarea>
                            <div class="error_tooltip"></div>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Nội dung mẫu lời chứng</label>
                        <div class="error_tooltip">{{invalid.kind_html}}</div>

                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor">
                                <div class="btn btn-success btn-sm " id="cke_inputcontract" title="Thêm text để gán đối tượng" ><i class="fa fa-plus"></i>Text Item</div>
                                <%--<div class="btn btn-success btn-sm" id="viewsource" title="Thêm text để gán đối tượng" ><i class="fa fa-plus"></i>ViewSource</div>--%>
                                <div class="btn btn-success btn-sm " id="addTextBoxSimple" title="Thêm text trống không liên kết đối tượng" ><i class="fa fa-plus"></i>Add text</div>
                                <div class="form-group" style="margin-top: 10px">
                                    <div id="textboxofp"></div>
                                </div>
                                <div id="editor" <%--contenteditable="true"--%> class="form-control"
                                     style="font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;" >
                                </div>
                            </div>

                            <div id="sourcecontract" contenteditable="true"
                                 style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>

                        </div>

                        <textarea hidden  class="col-md-12"  id="giatriKindHtml"  name="kind_html"  rows="4" value="${item.kind_html}" ></textarea>
                    </div>


                </div>
            </div>

            <div class="truong-prevent-btb" style="padding-bottom: 10px;">

                <div class="col-md-12" style="text-align: center;">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_SUA)){
                    %>
                    <a class="btn btn-primary" style="min-width:130px;" id="submitform"
                       ng-click="BeforeSubmit();">Lưu</a>
                    <%
                        }
                    %>
                    <a href="${backUrl}" class="btn btn-default btn-warning">Quay lại danh sách</a>

                </div>

            </div>
        </form>
    </div>

</div>

<!-- Modal -->

<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />--%>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>--%>
<%--End Modal--%>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />

<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#mau-loi-chung").addClass("child-menu");
    });

    $(window).on('resize',function(){
        var win = $(this);
        if(win.width() < 1300){
            $('.truong-rs-bt3os').removeClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3os').addClass('col-md-4');
            $('.truong-rs-bt3').removeClass('col-md-2');
            $('.truong-rs-bt3').addClass('col-md-4');
        }else {
            $('.truong-rs-bt3os').removeClass('col-md-4');
            $('.truong-rs-bt3os').addClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3').removeClass('col-md-4');
            $('.truong-rs-bt3').addClass('col-md-2');

        }
    });

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
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>

<script>

    var listFieldMap = "";

    $(document).ready(function() {
        $.ajax({
            type: "GET",
            url: url+"/api-attestation/getListCertTemplateFieldMap",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                listFieldMap = response;
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    });

    //Add span chỉ để hiển thị mà không liên quan editable
    $("#addTextBoxSimple").click(function(){
        var sel;
        sel = window.getSelection();
        if(typeof(sel.focusNode.data) !='undefined'){
//            $("#spantext").text(sel.focusNode.data);
            //Vì ckeditor k nhận css qua class nên phải add csss trực tiếp (không được bỏ attr class vì cần dùng để check biến)
            pasteHtmlAtCaret('<span class="simple" placeholder="" >&nbsp;</span> ');
        }
        else
            pasteHtmlAtCaret('<span class="simple" placeholder="" >&nbsp;</span> ');

    });

    //Add span để mapping với editable
    $("#cke_inputcontract").click(function(){
        var sel;
        sel = window.getSelection();
        if(typeof(sel.focusNode.data) !='undefined'){
            //Vì ckeditor k nhận css qua class nên phải add csss trực tiếp (không được bỏ attr class vì cần dùng để check biến)
            pasteHtmlAtCaret('<span class="inputcontract" editspan="newtextbox" ng-model="" ' +
                'placeholder="..." >[Giá trị]</span>');
        }
        else
            pasteHtmlAtCaret('<span class="inputcontract" editspan="newtextbox" ng-model="" ' +
                'placeholder="..." >[Giá trị]</span>');

    });

    function pasteHtmlAtCaret(html) {
        /*DaiCQ add html vào ckeditor*/
        var editor = CKEDITOR.instances.editor;
        var domHTML = CKEDITOR.dom.element.createFromHtml(html);
        //editor.setAttribute("placeholder","...");
        editor.insertElement(domHTML);
        //  CKEDITOR.instances.editor.insertElement(domHTML);
        /*END DaiCQ add html vào ckeditor*/
        /*$("#giatriKindHtml").html($("#editor").html());
        $("#giatriKindHtml").val($("#editor").html());*/
    }

    //Bắt sự kiện onclick trên ckeditor (vì ckeditor không cho phép bắt sự kiện bên ngoài nên dùng cách này)
    editor.on( 'contentDom', function() {
        var editable = editor.editable();

        editable.attachListener( editable, 'click', function(ev) {
            var domEvent = ev.data/*.getTarget()*/;
            var target = domEvent.getTarget();
            //get tag name
            var tagName= target.$.tagName;
            //get class name of tag
            var className = target.$.className;
            //Nếu thẻ là SPAN
            if (tagName == "SPAN") {
                if (className == "inputcontract" || className == "inputcontract textforcus") {
                    /*$("#editor *").removeClass("spanactive");
                    $("#editor *").removeClass("textforcus");*/
                    target.addClass("textforcus");
                    $("#textboxofp").html("");
                    $("#textboxofp").css("display", "block");
                    /*comment daicq 05/09/2019*/
                    /*                $("#textboxofp").append('editspan : <input class="idoftextbox" value="'+$(e.target).attr("editspan")+'">' +
                                        '</input>    Mặc định :<input class="placeholdertext" value="'+$(e.target).attr("placeholder")+'">' +
                                        '</input> <a class="deleteiteminput btn btn-danger btn-xs" style="float:none;" href="javascript:void(0)">Xóa</a>');*/
                    var html = '';
                    for (var i = 0; i < listFieldMap.length; i++) {
                        var key = listFieldMap[i].key;
                        var name = listFieldMap[i].name;
                        if (key == null || key == "") continue;
                        if (key == target.getAttribute("editspan")) {
                            html += '<option value ="' + key + '" selected>' + name + '</option>';
                        } else {
                            html += '<option value ="' + key + '">' + name + '</option>';
                        }
                    }

                    $("#textboxofp").append(' <label class="col-md-2 control-label required label-bam-trai">Chọn biến liên kết</label>' +
                        '<div class="col-md-5">' +
                        '<select class="idoftextbox form-control selectpicker select2" value="' + target.getAttribute("editspan") + '">' +
                        '<option value="">--Chọn--</option>' + html +
                        /* '<option ng-repeat="thisField in listField" value="thisField.key">{{thisField.name}}</option>' +
                         '<option value="contract.contract_value_vnd">Giá trị hợp đồng (bằng số)</option>' +*/
                        '</select> </div>' +
                        '    Mặc định: <input class="placeholdertext" value="' + target.getAttribute("placeholder") + '">' +
                        '</input> <a class="deleteiteminput btn btn-danger btn-xs" style="float:none;" href="javascript:void(0)">Xóa</a>');


                    $('.idoftextbox').change(function () {

                        target.setAttribute("editspan", $(this).val());
                        target.setAttribute("ng-model", $(this).val());

                    });

                    $('.placeholdertext').keyup(function () {
                        target.attr("placeholder", $(this).val());

                    });
                    $('.deleteiteminput').click(function () {
                        var r = confirm("Bạn có chắc chắn muốn xóa!");
                        if (r == true) {
                            target.remove();
                            $("#textboxofp").html("");
                        } else {
                            return false;
                        }

                    });


                }
                //for span simple
                if (className== "simple" || className == "simple textforcus") {
                    /*$("#editor *").removeClass("spanactive");
                    $("#editor *").removeClass("textforcus");*/
                    target.addClass("textforcus");
                    $("#textboxofp").html("");

                }
            } else {
                /*$("#editor *").removeClass("spanactive");
                /!*domEvent.getTarget().setAttribute("contenteditable", "true");*!/
                $("#editor *").removeClass("textforcus");*/
            }
            $("#giatriKindHtml").html(CKEDITOR.instances['editor'].getData());
            $("#giatriKindHtml").val(CKEDITOR.instances['editor'].getData());

            /*target.removeAttribute('contenteditable','true')*/;

            // $(e.target).attr("editspan")
            //var domEvent = ev.data.target.nodeName;
            console.log( 'The editable was clicked.' );
        });
    });


</script>


<%--angularjs--%>
<script>
    myApp.controller('attestationTempEditController', ['$scope', '$http', '$window', function ($scope, $http, $window) {
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
                    // $scope.cert.kind_html = template.kind_html;
                    CKEDITOR.instances.editor.setData(template.kind_html);
                    /* $('#kind_html').val(template.kind_html);
                     $('#attestation_template_code').val(template.code);*/
                });
        }

        $scope.checkAndDeleteTemplate = function (template_id, code_template) {
            console.log('delete');

            $http.get(url + "/certificate/count", {params: {code_template: code_template}})
                .then(function (response) {
                    $scope.count = response.data;
                    if(response.status == 200 && $scope.count > 0){
                        $("#errorDelete").modal('show');
                    }
                    else{
                        excuteDeleteContractTemplate(template_id);
                    }
                });

        };


        function excuteDeleteContractTemplate(template_id){


            $window.location.href = contextPath + '/attestation-template/delete/'+template_id;
        }

        $scope.invalid={
            name:"",
            kind_html:""
        };
        var htmlEditor;
        $scope.BeforeSubmit = function(){
            if(checkValid()==false) return;
            $('#giatriKindHtml').val(htmlEditor);
            $('#formEdit').submit();
        }
        function checkValid(){
            htmlEditor = CKEDITOR.instances['editor'].getData();
            $scope.invalid.name = "";
            $scope.invalid.kind_html = "";
            var check = true;
            /*if(isNullOrEmpty(htmlEditor)) {
                $scope.invalid.kind_html = "Trường không được để trống!";
                check = false;
            }*/
            if(isNullOrEmpty($('#temp_name').val())){
                $scope.invalid.name = "Trường không được để trống!";
                check = false;
            }
            return check;
        }

    }]);
</script>


