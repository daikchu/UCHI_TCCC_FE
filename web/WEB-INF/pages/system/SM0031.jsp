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
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<script src="<%=request.getContextPath()%>/static/js/template/contractTemplate/edit.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/currency-autocomplete.js"></script>

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/jquery.hotkeys.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/bootstrap-wysiwyg.js"></script>--%>

<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/static/chosen2/chosen.css"/>--%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>


<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
</script>

<spring:url value="/system/osp/contracttemplate-list" var="backUrl"/>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Sửa thông tin mẫu tên hợp đồng</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="contractTemplateEditController">
    <div id="uchi-status">

    </div>
    <div class="panel-group" id="accordion">
        <form class="form-horizontal" action="<%=request.getContextPath()%>/system/osp/contracttemplate-edit"
              id="formSubmit" method="post">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse">
                            THÔNG TIN MẪU GIAO DIỆN
                        </a>
                    </h4>

                </div>
                <div class="panel-body">
                    <input type="hidden" class="form-control " name="id" value="${item.id}">
                    <%--<input type="hidden" name="entry_user_id"
                           value="<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>">
                    <input type="hidden" name="entry_user_name"
                           value="<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>">
                    <input type="hidden" name="update_user_id"
                           value="<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>">
                    <input type="hidden" name="update_user_name"
                           value="<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>">--%>
                    <input type="hidden" class="form-control " name="kind_id_tt08" value="0">
                    <input type="hidden" class="form-control " name="relate_object_number" value="0">
                    <input type="hidden" class="form-control " name="sync_option" value="0">
                    <input type="hidden" class="form-control " name="office_code" value="0">
                    <input type="hidden" class="form-control " name="code_template" value="${item.code_template}">
                    <input type="hidden" class="form-control " name="code" value="" id="copy_code">
                    <input type="hidden" class="form-control " name="kind_id" value="" id="copy_kind_id">

                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Loại Hợp đồng</label>
                        <div class="col-md-3">
                            <select name="code" id="nhomHD" class="form-control truong-selectbox-padding select2"
                                    onchange="loadContractTemplate()" disabled="true">
                            </select>
                            <span id="code_valid" class="truong-text-colorred"></span>
                        </div>
                        <div id="display_tenHD">
                            <label class="col-md-2 control-label label-bam-phai">Tên hợp đồng</label>
                            <div class="col-md-5">
                                <select name="kind_id" id="tenHD" class="form-control truong-selectbox-padding select2"
                                        disabled="true">
                                </select>
                                <span id="kind_id_valid" class="truong-text-colorred"></span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">${(item.kind_id == 0 || item.kind_id == null) ? "Tên hợp đồng":"Tên mẫu hợp đồng"}</label>
                        <div class="col-md-3">
                            <input id="_name_" type="text" class="form-control" name="name" value="${item.name}">
                            <span id="name_valid" class="truong-text-colorred"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên A</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="relate_object_a_display"
                                   value="${item.relate_object_a_display}">
                        </div>

                        <label class="col-md-2 control-label label-bam-phai">Mô tả Bên B</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="relate_object_b_display"
                                   value="${item.relate_object_b_display}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên C</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="relate_object_c_display"
                                   value="${item.relate_object_c_display}">
                        </div>

                        <label class="col-md-2 control-label label-bam-phai required">Trạng thái </label>
                        <div style="padding-top: 0px;" class="col-md-5 control-label label-bam-trai">
                            <label class="radio-inline prevent-type">
                                <input id="active_flg_focus" type="radio" name="active_flg"
                                       value="1" ${item.active_flg == 1 ?"checked":""}>Đang hoạt động
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="active_flg" value="0" ${item.active_flg == 0 ?"checked":""}>Ngừng
                                hoạt động
                            </label>
                            <br>
                            <span id="active_flg_valid" class="truong-text-colorred"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả</label>

                        <div class="col-md-10">
                            <textarea name="description" rows="4" class="form-control"
                                      value="${item.description}">${item.description}</textarea>
                            <div class="error_tooltip"></div>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai"></label>
                        <div class="col-md-6">

                            <c:choose>
                                <c:when test="${item.mortage_cancel_func== 1}">
                                    <input type="checkbox" class="truong-margin-left15" name="mortage_cancel_func"
                                           value="1" checked="checked"><span class="truong-font-chu"
                                                                             style="vertical-align: 2px;">Giải chấp</span>
                                    <input type="hidden" name="mortage_cancel_func" value="0">
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" class="truong-margin-left15" name="mortage_cancel_func"
                                           value="1"><span class="truong-font-chu" style="vertical-align: 2px;">Giải chấp</span>
                                    <input type="hidden" name="mortage_cancel_func" value="0">
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${item.period_flag== 1}">
                                    <input type="checkbox" class="truong-margin-left15" name="period_flag" value="1"
                                           checked="checked"><span class="truong-font-chu" style="vertical-align: 2px;">Thời hạn hợp đồng</span>
                                    <input type="hidden" name="period_flag" value="0">
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" class="truong-margin-left15" name="period_flag"
                                           value="1"><span class="truong-font-chu" style="vertical-align: 2px;">Thời hạn hợp đồng</span>
                                    <input type="hidden" name="period_flag" value="0">
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai"></label>

                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor1">

                                <button type='button' id="cke_inputcontract" class="btn btn-success btn-sm "
                                        title="Thêm text để gán đối tượng"><i class="fa fa-plus"></i>Text Item
                                </button>
                                <%--<button type='button' id="viewsource" class="btn btn-success btn-sm"
                                        title="Xem code dạng HTML"><i class="fa fa-plus"></i>ViewSource
                                </button>--%>
                                <div class="btn btn-success btn-sm " id="addTextBoxSimple"
                                     title="Thêm text trống không liên kết đối tượng"><i class="fa fa-plus"></i>Add text
                                </div>
                                <div class="btn btn-success btn-sm " id="addDuongSu"
                                     title="Khu vực hiển thị đương sự trên văn bản"><i class="fa fa-plus"></i>Đương sự
                                </div>
                                <button type='button' id="addDuongSuBenA" class="btn btn-success btn-sm "
                                        title="Khu vực hiển thị đương sự bên A trên văn bản"><i class="fa fa-plus">Đương
                                    sự bên A</i></button>
                                <button type='button' id="addDuongSuBenB" class="btn btn-success btn-sm "
                                        title="Khu vực hiển thị đương sự bên B trên văn bản"><i class="fa fa-plus">Đương
                                    sự bên B</i></button>
                                <button type='button' id="addDuongSuBenC" class="btn btn-success btn-sm "
                                        title="Khu vực hiển thị đương sự bên C trên văn bản"><i class="fa fa-plus">Đương
                                    sự bên C</i></button>
                                <div class="btn btn-success btn-sm " id="addTaiSan"
                                     title="Khu vực hiển thị tài sản trên văn bản"><i class="fa fa-plus"></i>Tài sản
                                </div>
                                <div class="panel-body" style="padding-top: 0px; padding-left: 5px; ">
                                    <div class="list-buttons col-md-12" style="text-align: center;padding: 0px; margin-bottom: 5px">
                                        <a id="xemonline" class="view-online btn btn-primary btn-sm" style="margin-right: 5px;" title="Xem code online">Xem
                                            online</a>
                                        <a id="exportword" class="word-export btn btn-primary btn-sm" title="Xuất file word">Xuất
                                            file word</a>
                                    </div>

                                    <div class="list-buttons col-md-12" style="text-align: center;padding: 0px;">
                                        <input type="file" file-model="fileTemplateImport"
                                               class="btn btn-s-md btn-info col-md-4 pull-left"
                                               style="max-height: 34px;">
                                        <input type=button class="btn btn-s-md btn-info pull-left col-md-2"
                                               ng-click="importFileWord()" value="Upload" style="margin-left: 5px;">
                                        <span class="col-md-12"
                                              style="text-align: left;opacity: 0.5;margin-left: 0px;padding-left:0px;">Upload file mẫu trực tiếp từ máy để giữ nguyên định dạng gốc của văn bản</span>
                                    </div>
                                </div>

                                <%--<div class="btn-group">
                                    <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"
                                       title="Font Size"><i class="fa fa-text-height"></i>&nbsp;<b
                                            class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a data-edit="fontSize 5"><font size="5">18</font></a></li>
                                        <li><a data-edit="fontSize 4"><font size="4">14</font></a></li>
                                        <li><a data-edit="fontSize 3"><font size="3">12</font></a></li>
                                    </ul>
                                </div>--%>
                                <%--<div class="btn-group"><a class="btn btn-default btn-sm" data-edit="bold"
                                                          title="Bold (Ctrl/Cmd+B)">
                                    <i class="fa fa-bold"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i
                                            class="fa fa-italic"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="strikethrough" title="Strikethrough">
                                        <i class="fa fa-strikethrough"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="underline"
                                       title="Underline (Ctrl/Cmd+U)"> <i class="fa fa-underline"></i></a>
                                </div>
                                <div class="btn-group">
                                    <a class="btn btn-default btn-sm" data-edit="insertunorderedlist"
                                       title="Bullet list">
                                        <i class="fa fa-list-ul"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="Number list">
                                        <i class="fa fa-list-ol"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="outdent"
                                       title="Reduce indent (Shift+Tab)">
                                        <i class="fa fa-dedent"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="indent" title="Indent (Tab)">
                                        <i class="fa fa-indent"></i></a>
                                </div>
                                <div class="btn-group">
                                    <a class="btn btn-default btn-sm" data-edit="justifyleft"
                                       title="Align Left (Ctrl/Cmd+L)">
                                        <i class="fa fa-align-left"></i>
                                    </a>
                                    <a class="btn btn-default btn-sm" data-edit="justifycenter"
                                       title="Center (Ctrl/Cmd+E)"><i
                                            class="fa fa-align-center"></i>
                                    </a>
                                    <a class="btn btn-default btn-sm" data-edit="justifyright"
                                       title="Align Right (Ctrl/Cmd+R)"><i
                                            class="fa fa-align-right"></i>
                                    </a>
                                    <a class="btn btn-default btn-sm" data-edit="justifyfull"
                                       title="Justify (Ctrl/Cmd+J)"><i class="fa fa-align-justify"></i>
                                    </a>
                                </div>

                                <div class="btn-group"><a class="btn btn-default btn-sm"
                                                          data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
                                        class="fa fa-undo"></i></a> <a class="btn btn-default btn-sm"
                                                                       data-edit="redo"
                                                                        title="Redo (Ctrl/Cmd+Y)"><i
                                        class="fa fa-repeat"></i></a>
                                    <a class="btn btn-default btn-sm"
                                       style="background-image:url('http://localhost:8383/uchi_vpcc_Web_exploded/static/ckeditor/plugins/icons.png?t=K24B');background-position:0 -22704px;background-size:auto;"
                                       data-edit="indent" title="Thụt đầu dòng">
                                        &lt;%&ndash;<i class="fa fa-text-indent"></i>&ndash;%&gt;</a></div>

                                <br><br>--%>

                                <div class="form-group">
                                    <div id="textboxofp" class="col-md-12" style="padding-left: 5px"></div>
                                </div>
                                <span id="HTML_valid" class="truong-text-colorred"></span>
                                <div id="editor" class="form-control editor"
                                     style="/*font-size:14pt!important;*/max-width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">

                                </div>
                            </div>


                            <div id="sourcecontract" contenteditable="true"
                                 style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>

                        </div>

                        <textarea hidden style="display: none !important;" class="col-md-12" id="giatriKindHtml"
                                  name="kind_html" rows="4" value="${item.kind_html}"></textarea>

                    </div>

                </div>


            </div>

            <div class="form-group" style="text-align: center;margin:20px 0px;">
                <%
                    if (ValidationPool.checkRoleDetail(request, "29", Constants.AUTHORITY_SUA)) {
                %>
                <a class="btn btn-primary" style="min-width:130px;" id="submitform"
                   onclick="return BeforeSubmit();">Lưu</a>
                <%
                    }
                %>
                <a class="btn btn-default" style="min-width:130px;" href="${backUrl}">Quay lại danh sách</a>
            </div>
        </form>
    </div>
</div>

<div class="modal fade  bs-example-modal-lg" id="view-online-modal" role="dialog" style="width:auto;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content"
             style="margin:auto;align-content:center;width:800px !important;background: #fff;height:100%;min-height:500px;overflow: auto; font-size: 14pt;line-height:1.5;font-family: times new roman;">
            <div class="modal-body">
                <div id="view-online">

                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="checkValidate" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Thiếu thông tin</h4>
            </div>
            <div class="modal-body">
                <p>Hãy nhập đủ thông tin vào các trường bắt buộc(có dấu <span class="truong-text-colorred">*</span>)
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
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

</script>

<%--<script>
    $(window).on('resize', function () {
        var win = $(this);
        if (win.width() < 1200) {
            $('.truong-rs-bt2os').removeClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2os').addClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2').removeClass('col-md-2');
            $('.truong-rs-bt2').addClass('col-md-3');
        } else {
            $('.truong-rs-bt2os').removeClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2os').addClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2').removeClass('col-md-3');
            $('.truong-rs-bt2').addClass('col-md-2');
        }
    });
</script>--%>

<script>
    function loadMenu() {
        $(".sidebar-nav > li > #mau-giao-dien").addClass("father-menu");
        $(".sidebar-nav > li > #duongsu").addClass("child-menu");
    }

    function BeforeSubmit() {
        //start DaiCQ
        /*alert('data form ckedtior: '+CKEDITOR.instances['editor'].getData());
        alert($("#editor").html());
*/
        var htmlEditor = CKEDITOR.instances['editor'].getData();
        //end DaiCQ

        var _validate_ = true;

        var code = document.getElementById("nhomHD").value;
        if (code == null || code == "") {
            _validate_ = false;
            $("#code_valid").text("Trường không được bỏ trống. ");
            $("#nhomHD").focus();
        } else {
            $("#code_valid").text("");
        }

        var name = document.getElementById("_name_").value;
        if (name == null || name == "") {
            _validate_ = false;
            $("#name_valid").text("Trường không được bỏ trống. ");
            $("#_name_").focus();
        } else {
            $("#name_valid").text("");
        }

        var active_flg = '${item.active_flg}';
        if (active_flg == null || active_flg == "") {
            _validate_ = false;
            $("#active_flg_valid").text("Trường không được bỏ trống. ");
            $("#active_flg_focus").focus();
        } else {
            $("#active_flg_valid").text("");
        }

        $("#giatriKindHtml").html(htmlEditor);
        $("#giatriKindHtml").val(htmlEditor);
        var kind_html = $("#giatriKindHtml").val();
        if (typeof kind_html == "undefined" || kind_html == null || kind_html == "" || kind_html.trim() == "") {
            _validate_ = false;
            $("#HTML_valid").text("Trường không được bỏ trống. ");
            $("#editor").focus();
        } else {
            $("#HTML_valid").text("");
        }

        if (_validate_ == true) {

            $('.text-duongsu').html('');
            $('.text-taisan').html('');
            $('.text-duongsu-ben-a').html('');
            $('.text-duongsu-ben-b').html('');
            $('.text-duongsu-ben-c').html('');

            $("#giatriKindHtml").html(htmlEditor);
            $('#checkbox').on('change', function () {
                this.value = this.checked ? 0 : 1;
                $('#checkboxValue').val(this.value);
            }).change();

            var copy_kind_id = document.getElementById("tenHD").value;
            document.getElementById("copy_code").value = code;
            document.getElementById("copy_kind_id").value = copy_kind_id;
            $("#formSubmit").submit();
        } else {
            //$("#checkValidate").modal('show');
        }
    }
</script>

<script type="text/javascript">
    /*$(document).ready(function () {
        $('.text-duongsu').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a>');
        $('.text-duongsu-ben-a').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a>');
        $('.text-duongsu-ben-b').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a>');
        $('.text-duongsu-ben-c').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên c<<</a>');
        $('.text-taisan').html('<a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a>');
    });
    CKEDITOR.instances.editor.setData( $("#giatriKindHtml").val() );*/

    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: url + "/ContractTemplate/list-field-map-in-template",
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


    function pasteHtmlAtCaret(html, el) {

        /*DaiCQ add html vào ckeditor*/
        var editor = CKEDITOR.instances.editor;
        var domHTML = CKEDITOR.dom.element.createFromHtml(html);
        //editor.setAttribute("placeholder","...");
        editor.insertElement(domHTML);
        //  CKEDITOR.instances.editor.insertElement(domHTML);
        /*END DaiCQ add html vào ckeditor*/

    }


    var el = document.getElementById("editor");

    //Add span chỉ để hiển thị mà không liên quan editable
    $("#addTextBoxSimple").click(function () {
        var sel;
        sel = window.getSelection();
        if (typeof (sel.focusNode.data) != 'undefined') {
//            $("#spantext").text(sel.focusNode.data);
            //Vì ckeditor k nhận css qua class nên phải add csss trực tiếp (không được bỏ attr class vì cần dùng để check biến)
            pasteHtmlAtCaret('<span class="simple" >&nbsp;</span> ', el);
        } else
            pasteHtmlAtCaret('<span class="simple" >&nbsp;</span> ', el);
//            pasteHtmlAtCaret("<span class='simple' placeholder='' contenteditable='true'></span> ",el);

    });

    //add div duong su
    $("#addDuongSu").click(function () {
        /*var sel;
        sel = window.getSelection();
        if (typeof (sel.focusNode.data) != 'undefined') {
            pasteHtmlAtCaret('<div dynamic="duongsu" class="text-duongsu" style="text-indent: 50px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">Khu vực hiển thị đương sự</a></div>', el);
        } else*/
        pasteHtmlAtCaret('<div dynamic="duongsu" class="text-duongsu" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a></div>', el);
    });
    //add div duong su bên a
    $("#addDuongSuBenA").click(function () {
        pasteHtmlAtCaret('<div dynamic="duongsubena" class="text-duongsu-ben-a" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a></div>', el);
    });
    //add div duong su bên b
    $("#addDuongSuBenB").click(function () {
        pasteHtmlAtCaret('<div dynamic="duongsubenb" class="text-duongsu-ben-b" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a></div>', el);
    });
    //add div duong su bên c
    $("#addDuongSuBenC").click(function () {
        pasteHtmlAtCaret('<div dynamic="duongsubenc" class="text-duongsu-ben-c" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên c<<</a></div>', el);
    });
    //add div tai san
    $("#addTaiSan").click(function () {
        pasteHtmlAtCaret('<div dynamic="taisan" class="text-taisan" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a></div>', el);

    });

    //Add span để mapping với editable
    $("#cke_inputcontract").click(function () {
        var sel;
        sel = window.getSelection();
        if (typeof (sel.focusNode.data) != 'undefined') {
            //Vì ckeditor k nhận css qua class nên phải add csss trực tiếp (không được bỏ attr class vì cần dùng để check biến)
            pasteHtmlAtCaret('<span class="inputcontract"  editspan="newtextbox" ng-model="" ' +
                'placeholder="..." >[Giá trị]</span>', el);
        } else
            pasteHtmlAtCaret('<span class="inputcontract" editspan="newtextbox" ng-model="" ' +
                'placeholder="..." >[Giá trị]</span>', el);

    });


    //Bắt sự kiện onclick trên ckeditor (vì ckeditor không cho phép bắt sự kiện bên ngoài nên dùng cách này)
    editor.on('contentDom', function () {
        var editable = editor.editable();

        editable.attachListener(editable, 'click', function (ev) {
            var domEvent = ev.data/*.getTarget()*/;
            var target = domEvent.getTarget();
            //get tag name
            var tagName = target.$.tagName;
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
                if (className == "simple" || className == "simple textforcus") {
                    /*$("#editor *").removeClass("spanactive");
                    $("#editor *").removeClass("textforcus");*/
                    target.addClass("textforcus");
                    $("#textboxofp").html("");

                }
            } else {
                /*domEvent.getTarget().setAttribute("contenteditable", "true");*/
                /*$("#editor *").removeClass("textforcus");*/
            }

            //domEvent.getTarget().removeAttributes("contenteditable");
            /*domEvent.getTarget().removeAttribute('contenteditable', 'true');*/

            // $(e.target).attr("editspan")
            //var domEvent = ev.data.target.nodeName;
            console.log('The editable was clicked.');
        });
    });


    //for wysiwyg
    /*$('#editor').wysiwyg();*/
</script>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    function loadMenu() {
        var parentItem = $("#mau-giao-dien");
        $(parentItem).click();
        $("#tenhopdong").addClass("child-menu");
    }

    jQuery(document).ready(function ($) {
        $("a.word-export").click(function (event) {

            /*var htmlEditor = CKEDITOR.instances['editor'].getData();
            var fileName = "Mau-hop-dong-cong-chung.doc";
            exportHTMLToWord(htmlEditor, fileName);*/
            $("#sourcecontract").html(CKEDITOR.instances['editor'].getData());
            $("#sourcecontract").wordExport();
            // $("#editor").wordExport();
        });

        $("a.view-online").click(function (event) {
            var htmlEditor = CKEDITOR.instances['editor'].getData();
            $("#view-online").html(htmlEditor);
            $("#view-online-modal").modal('show');
        });

    });
    $(document).ready(function () {
        var parentItem = $("#mau-giao-dien");
        $(parentItem).click();
        $("#tenhopdong").addClass("child-menu");
    });

    //load onchange
    function loadContractTemplate() {
        var loadContractTemplate = document.getElementById("nhomHD").value;
        console.log("id nhóm" + loadContractTemplate);
        $.ajax({
            type: "GET",
            url: url + "/contract/list-contract-template-by-contract-kind-code",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                code: loadContractTemplate + ""
            },
            success: function (response) {
                var listVpcc = response;
                var htmlContent1 = '<select name="kind_id" class="form-control truong-selectbox-padding select2" disabled="true"><option value="">--Chọn--</option>';
                for (var i = 0; i < listVpcc.length; i++) {
                    var nameVPCC = listVpcc[i];
                    var idVPCC = nameVPCC.code_template;
                    var tenVPCC = nameVPCC.name;

                    htmlContent1 += '<option value ="' + idVPCC + '">' + tenVPCC + '</option>';
                }
                htmlContent1 += '</select>';
                $('#tenHD').html(htmlContent1);


            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    }

    //tên
    function loadContractKind() {
        $.ajax({
            type: "GET",
            url: url + "/contract/get-contract-template-by-code-template",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                code_temp: '${item.kind_id}'
            },
            success: function (response) {
                var listVpcc = [response];
                console.log("kind_id", '${item.kind_id}', listVpcc);
                var htmlContent1 = '<select name="kind_id" class="form-control truong-selectbox-padding select2" disabled="true"><option value="0">--Chọn--</option>';
                for (var i = 0; i < listVpcc.length; i++) {
                    var nameVPCC = listVpcc[i];
                    var idVPCC = nameVPCC.code_template;
                    var tenVPCC = nameVPCC.name;
                    if (idVPCC == null || idVPCC == "") continue;
                    if (idVPCC == '${item.kind_id}') {
                        htmlContent1 += '<option value ="' + idVPCC + '" selected>' + tenVPCC + '</option>';
                    } else {
                        htmlContent1 += '<option value ="' + idVPCC + '">' + tenVPCC + '</option>';
                    }
                }
                htmlContent1 += '</select>';
                $('#tenHD').html(htmlContent1);


            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    }

    loadContractKind();

    //nhóm
    function loadContractKind__() {
        $.ajax({
            type: "GET",
            url: url + "/contract/list-contract-kind",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                var listVpcc = response;
                console.log(response);
                var htmlContent1 = '<select name="code" class="form-control truong-selectbox-padding select2" onchange="loadContractTemplate()" disabled="true"><option value="">--Chọn--</option>';
                for (var i = 0; i < listVpcc.length; i++) {
                    var nameVPCC = listVpcc[i];
                    var idVPCC = nameVPCC.contract_kind_code;
                    var tenVPCC = nameVPCC.name;
                    if (idVPCC == ${item.code}) {
                        htmlContent1 += '<option value ="' + idVPCC + '" selected>' + tenVPCC + '</option>';
                    } else {
                        htmlContent1 += '<option value ="' + idVPCC + '">' + tenVPCC + '</option>';
                    }
                }
                htmlContent1 += '</select>';
                $('#nhomHD').html(htmlContent1);


            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    }

    loadContractKind__();

    var kind_id = '${item.kind_id}';
    if (kind_id == 0) {
        $("#display_tenHD").css("display", "none");
        $("#tenHD").val("0");
        document.getElementById("tenHD").value = "0";
    }
</script>
<script>
    $(document).ready(function () {
        loadMenu();
        CKEDITOR.instances.editor.setData('${item.kind_html}');
        /*document.getElementsByClassName('text-duongsu').html;
        $(editor.document.find('text-duongsu'));
        $( $('.your_selector').ckeditor().editor.window.getFrame().$).contents().find('text-duongsu');*/

        /*replaceOnload();


        function replaceOnload(){
            $('.text-duongsu').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a>');
            $('.text-duongsu-ben-a').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a>');
            $('.text-duongsu-ben-b').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a>');
            $('.text-duongsu-ben-c').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên c<<</a>');
            $('.text-taisan').html('<a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a>');
        }*/
    });
</script>


