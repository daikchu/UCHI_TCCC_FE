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

<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/chosen2/chosen.css"/>

<script src="<%=request.getContextPath()%>/static/js/masterConvert/configDB.js" type="text/javascript"></script>

<div class="hidden" id="conTractTemPlatePostCustumJS_kind_html"></div>
<script  type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp='<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath='<%=request.getContextPath()%>';

    var userEntryId=<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
    var org_type=<%=SystemProperties.getProperty("org_type")%>;

    /*custum*/
    var type_custum = '${itemCustum.action_status}'=='null'?"":'${itemCustum.action_status}';
    var id_custum = '${itemCustum.contractTempDetail.id}'=='null'?"":'${itemCustum.contractTempDetail.id}';
    var name_custum = '${itemCustum.contractTempDetail.name}'=='null'?"":'${itemCustum.contractTempDetail.name}';
    var kind_id_custum = '${itemCustum.contractTempDetail.kind_id}'=='null'?"":'${itemCustum.contractTempDetail.kind_id}';
    var kind_id_tt08_custum = '${itemCustum.contractTempDetail.kind_id_tt08}'=='null'?"":'${itemCustum.contractTempDetail.kind_id_tt08}';
    var code_custum = '${itemCustum.contractTempDetail.code}'=='null'?"":'${itemCustum.contractTempDetail.code}';
    var description_custum = '${itemCustum.contractTempDetail.description}'=='null'?"":'${itemCustum.contractTempDetail.description}';
    var file_name_custum = '${itemCustum.contractTempDetail.file_name}'=='null'?"":'${itemCustum.contractTempDetail.file_name}';
    var file_path_custum = '${itemCustum.contractTempDetail.file_path}'=='null'?"":'${itemCustum.contractTempDetail.file_path}';
    var active_flg_custum = '${itemCustum.contractTempDetail.active_flg}'=='null'?"":'${itemCustum.contractTempDetail.active_flg}';
    var relate_object_number_custum = '${itemCustum.contractTempDetail.relate_object_number}'=='null'?"":'${itemCustum.contractTempDetail.relate_object_number}';
    var relate_object_A_display_custum = '${itemCustum.contractTempDetail.relate_object_A_display}'=='null'?"":'${itemCustum.contractTempDetail.relate_object_A_display}';
    var relate_object_B_display_custum = '${itemCustum.contractTempDetail.relate_object_B_display}'=='null'?"":'${itemCustum.contractTempDetail.relate_object_B_display}';
    var relate_object_C_display_custum = '${itemCustum.contractTempDetail.relate_object_C_display}'=='null'?"":'${itemCustum.contractTempDetail.relate_object_C_display}';
    var period_flag_custum = '${itemCustum.contractTempDetail.period_flag}'=='null'?"":'${itemCustum.contractTempDetail.period_flag}';
    var period_req_flag_custum = '${itemCustum.contractTempDetail.period_req_flag}'=='null'?"":'${itemCustum.contractTempDetail.period_req_flag}';
    var mortage_cancel_func_custum = '${itemCustum.contractTempDetail.mortage_cancel_func}'=='null'?"":'${itemCustum.contractTempDetail.mortage_cancel_func}';
    var sync_option_custum = '${itemCustum.contractTempDetail.sync_option}'=='null'?"":'${itemCustum.contractTempDetail.sync_option}';
    var entry_user_id_custum = '${itemCustum.contractTempDetail.entry_user_id}'=='null'?"":'${itemCustum.contractTempDetail.entry_user_id}';
    var entry_user_name_custum = '${itemCustum.contractTempDetail.entry_user_name}'=='null'?"":'${itemCustum.contractTempDetail.entry_user_name}';
    var entry_date_time_custum = '${itemCustum.contractTempDetail.entry_date_time}'=='null'?"":'${itemCustum.contractTempDetail.entry_date_time}';
    var update_user_id_custum = '${itemCustum.contractTempDetail.update_user_id}'=='null'?"":'${itemCustum.contractTempDetail.update_user_id}';
    var update_user_name_custum = '${itemCustum.contractTempDetail.update_user_name}'=='null'?"":'${itemCustum.contractTempDetail.update_user_name}';
    var update_date_time_custum = '${itemCustum.contractTempDetail.update_date_time}'=='null'?"":'${itemCustum.contractTempDetail.update_date_time}';


    $("#conTractTemPlatePostCustumJS_kind_html").html('${itemCustum.contractTempDetail.kind_html=='null'?"":itemCustum.contractTempDetail.kind_html}');
    var kind_html_custum = $("#conTractTemPlatePostCustumJS_kind_html").html();
    var office_code_custum = '${itemCustum.contractTempDetail.office_code}'=='null'?"":'${itemCustum.contractTempDetail.office_code}';
    var code_template_custum = '${itemCustum.contractTempDetail.code_template}'=='null'?"":'${itemCustum.contractTempDetail.code_template}';

    var parent_name_custum = '${itemCustum.contractTempDetail.name_}';
    var parent_code_template_custum = '${itemCustum.contractTempDetail.getCode_template_}';
    var parent_custum_check = '${itemCustum.parent_name_contractTempDetail}';

</script>

<%--
    Thêm mói thông tin mẫu hợp đồng
--%>
<spring:url value="/system/osp/contracttemplate-list" var="backUrl" />

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <c:if test="${itemCustum.action_status.equals('custum_update')}">
        <span id="web-map">Cập nhật mẫu hợp đồng</span>
    </c:if>
    <c:if test="${!itemCustum.action_status.equals('custum_update')}">
        <span id="web-map">Thêm mới mẫu hợp đồng</span>
    </c:if>

</div>

<div class="truong-form-chinhbtt" ng-app="osp" id="contractTempAddController" ng-controller="contractTempAddController">
    <div class="panel-group" id="accordion">
        <form name="myForm" id="form_add" class="form-horizontal">
            <input type="hidden" ng-model="contractTempAdd.entry_user_id"  ng-init="contractTempAdd.entry_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'" >
            <input type="hidden" ng-model="contractTempAdd.entry_user_name" ng-init="contractTempAdd.entry_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
            <input type="hidden" ng-model="contractTempAdd.update_user_id" ng-init="contractTempAdd.update_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
            <input type="hidden" ng-model="contractTempAdd.update_user_name" ng-init="contractTempAdd.update_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse">
                            THÔNG TIN MẪU HỢP ĐỒNG
                        </a>
                    </h4>

                </div>
                <div class="panel-body">

                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Loại hợp đồng</label>
                        <div class="col-md-3">
                            <select id="code_valid" ng-model="contractTempAdd.code" name="contractKind" class="form-control selectpicker select2 col-md-12 no-padding"  ng-change="myFunc(contractTempAdd.code)"  required ${(itemCustum.action_status=='custum_add' || itemCustum.action_status=='custum_update')?"disabled":""}>
                                <option value="">--Chọn--</option>
                                <option  ng-repeat="item in contractKinds" value="{{item.contract_kind_code}}">{{item.name}}</option>
                            </select>
                            <span class="truong-text-colorred" >{{code_valid}}</span>
                        </div>
                        <div id="display_tenHD">
                            <label class="col-md-2 control-label required label-bam-phai">Tên hợp đồng</label>
                            <div class="col-md-5">
                                <select id="kind_id_valid" ng-model="contractTempAdd.kind_id" name="kind_id" class="selectpicker select2 col-md-12 no-padding" ng-change="changeTemplate(contractTempAdd.kind_id)" required ${(itemCustum.action_status=='custum_add' || itemCustum.action_status=='custum_update')?"disabled":""}>
                                    <option value="">--Chọn--</option>
                                    <option  ng-repeat="item in contractTemplates" value="{{item.code_template}}">{{item.name}}</option>
                                </select>
                                <span class="truong-text-colorred" >{{kind_id_valid}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">${(itemCustum.action_status =="custum_update" && itemCustum.contractTempDetail != null && (itemCustum.contractTempDetail.kind_id == 0 || itemCustum.contractTempDetail.kind_id == null)) ? "Tên hợp đồng":"Tên mẫu hợp đồng"}</label>
                        <div class="col-md-3">
                            <input id="name_valid" type="text" class="form-control" name="name" ng-model="contractTempAdd.name" ${itemCustum.action_status=='custum_update'?"disabled":""}>
                            <span class="truong-text-colorred" >{{name_valid}}</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên A</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="relate_object_A_display" ng-model="contractTempAdd.relate_object_A_display">
                        </div>

                        <label class="col-md-2 control-label label-bam-phai">Mô tả Bên B</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="relate_object_B_display" ng-model="contractTempAdd.relate_object_B_display">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên C</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control " name="relate_object_C_display" ng-model="contractTempAdd.relate_object_C_display">
                        </div>

                        <label class="col-md-2 control-label label-bam-phai required">Trạng thái </label>
                        <div style="padding-top: 0px;" class="col-md-5 control-label label-bam-trai">
                            <label class="radio-inline prevent-type">
                                <input id="active_flg_valid" type="radio" name="active_flg" ng-model="contractTempAdd.active_flg" value="1">Đang hoạt động
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="active_flg" ng-model="contractTempAdd.active_flg" value="0">Ngừng hoạt động
                            </label><br>
                            <span class="truong-text-colorred" >{{active_flg_valid}}</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả</label>

                        <div class="col-md-10">
                            <textarea ng-model="contractTempAdd.description" name="description" rows="4" class="form-control"></textarea>
                        </div>

                    </div>


                    <div class="form-group">
                        <label class="col-md-2"></label>
                        <div class="col-md-4">
                            <input type="checkbox" class="truong-margin-left15" name="mortage_cancel_func" ng-model="contractTempAdd.mortage_cancel_func" ng-true-value="1" ng-false-value="0"><span class="truong-font-chu" style="vertical-align: 2px;"> Giải chấp </span>
                            <input type="checkbox" class="truong-margin-left15" name="period_flag"  ng-model="contractTempAdd.period_flag" ng-true-value="1" ng-false-value="0"><span class="truong-font-chu" style="vertical-align: 2px;"> Thời hạn hợp đồng </span>
                        </div>
                    </div>
                    <%--  <div class="form-group">
                          <div class="col-md-offset-2">
                              <input type="checkbox" class="truong-margin-left15" name="period_flag"  ng-model="contractTempAdd.period_flag" ng-true-value="1" ng-false-value="0"><span class="truong-font-chu" style="vertical-align: 2px;">Thời hạn hợp đồng</span>
                          </div>
                      </div>--%>

                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai required">Nội dung mẫu hợp đồng</label>

                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor1" style="margin:auto;width:800px;">
                                <div class="btn btn-success btn-sm " id="cke_inputcontract" title="Thêm text để gán đối tượng" ><i class="fa fa-plus"></i>Text Item</div>
                                <%--<div class="btn btn-success btn-sm" id="viewsource" title="Thêm text để gán đối tượng" ><i class="fa fa-plus"></i>ViewSource</div>--%>
                                <div class="btn btn-success btn-sm " id="addTextBoxSimple" title="Thêm text trống không liên kết đối tượng" ><i class="fa fa-plus"></i>Add text</div>
                                <div class="btn btn-success btn-sm " id="addDuongSu" title="Khu vực hiển thị đương sự trên văn bản" ><i class="fa fa-plus"></i>Đương sự</div>
                                <button type='button' id="addDuongSuBenA"  class="btn btn-success btn-sm " title="Khu vực hiển thị đương sự bên A trên văn bản" ><i class="fa fa-plus">Đương sự bên A</i></button>
                                <button type='button' id="addDuongSuBenB"  class="btn btn-success btn-sm " title="Khu vực hiển thị đương sự bên B trên văn bản" ><i class="fa fa-plus">Đương sự bên B</i></button>
                                <button type='button' id="addDuongSuBenC"  class="btn btn-success btn-sm " title="Khu vực hiển thị đương sự bên C trên văn bản" ><i class="fa fa-plus">Đương sự bên C</i></button>
                                <div class="btn btn-success btn-sm " id="addTaiSan" title="Khu vực hiển thị tài sản trên văn bản" ><i class="fa fa-plus"></i>Tài sản</div>
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

                                <%--<div class="btn-group"><a class="btn btn-default btn-sm" data-edit="bold" title="Bold (Ctrl/Cmd+B)">
                                    <i class="fa fa-bold"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="strikethrough" title="Strikethrough"> <i class="fa fa-strikethrough"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)"> <i class="fa fa-underline"></i></a>
                                </div>
                                <div class="btn-group">
                                    <a class="btn btn-default btn-sm"  data-edit="insertunorderedlist" title="Bullet list">
                                        <i class="fa fa-list-ul"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="Number list">
                                        <i class="fa fa-list-ol"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="outdent" title="Reduce indent (Shift+Tab)">
                                        <i class="fa fa-dedent"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="indent" title="Indent (Tab)">
                                        <i class="fa fa-indent"></i></a>
                                </div>C
                                <div class="btn-group">
                                    <a class="btn btn-default btn-sm" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)">
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
                                        class="fa fa-repeat"></i></a></div>--%>
                                <div class="form-group">
                                    <div id="textboxofp" class="col-md-12" style="padding-left: 5px"></div>
                                </div>
                                <span class="truong-text-colorred">{{HTML_valid}}</span>
                                <div id="editor" <%--contenteditable="true"--%> class="form-control" style="overflow:scroll;">

                                </div>
                            </div>
                            <div id="sourcecontract" <%--contenteditable="true"--%> style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>

                        </div>

                        <textarea hidden class="col-md-12" id="giatriKindHtml" name="contractTempAdd.kind_html" rows="4"></textarea>

                    </div>

                </div>


            </div>

            <div class="form-group" style="text-align: center;margin:20px 0px;">
                <%
                    if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_THEM)){
                %>
                <a class="btn btn-primary" style="min-width:130px;" ng-click="BeforeSubmit()">Lưu</a>
                <%
                    }
                %>
                <a class="btn btn-default"  style="min-width:130px;" href="${backUrl}">Hủy bỏ</a>
            </div>

        </form>

    </div>
</div>


<div class="modal fade  bs-example-modal-lg" id="view-online-modal" role="dialog" style="width:auto;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="margin:auto;align-content:center;width:800px !important;background: #fff;height:100%;min-height:500px;overflow: auto; font-size: 14pt;line-height:1.5;font-family: times new roman;">
            <div class="modal-body">
                <div id="view-online" >

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
                <p>Hãy nhập đủ thông tin vào các trường bắt buộc(có dấu <span class="truong-text-colorred">*</span>) </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="errorEdit" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Error</h4>
            </div>
            <div class="modal-body">
                <p>Có lỗi xảy ra. Hãy thử lại sau! </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>

<script src="<%=request.getContextPath()%>/static/js/system/SM0030.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css" />
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<%--<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>


<script>

   /* $(window).on('resize',function(){
        var win = $(this);
        if (win.width() < 1200){
            $('.truong-rs-bt2os').removeClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2os').addClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2').removeClass('col-md-2');
            $('.truong-rs-bt2').addClass('col-md-3');
        }else {
            $('.truong-rs-bt2os').removeClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2os').addClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2').removeClass('col-md-3');
            $('.truong-rs-bt2').addClass('col-md-2');
        }
    });*/
    jQuery(document).ready(function($) {
        $("a.word-export").click(function(event) {
           /* var htmlEditor = CKEDITOR.instances['editor'].getData();
            var fileName = "Mau-hop-dong-cong-chung.doc";
            exportHTMLToWord(htmlEditor, fileName);*/
           $("#sourcecontract").html(CKEDITOR.instances['editor'].getData());
            $("#sourcecontract").wordExport();
        });

        $("a.view-online").click(function(event) {
            var htmlEditor = CKEDITOR.instances['editor'].getData();
            $("#view-online").html(htmlEditor);
            //$("#view-online") > $("span").removeClass("simple");
            $("#view-online-modal").modal('show');
        });

        /*$("#view-online-modal").on("hidden.bs.modal", function () {
            window.location.reload();
        });*/
    });
</script>

<script>
    $(document).ready(function () {
        loadMenu();

    });
    function loadMenu() {
        $(".sidebar-nav > li > #mau-hop-dong").addClass("father-menu");
    }

</script>

<script type="text/javascript">

    var editor = CKEDITOR.replace('editor', {
        fullPage: true,
        // extraPlugins: 'docprops',
        // // Disable content filtering because if you use full page mode, you probably
        // // want to  freely enter any HTML content in source mode without any limitations.
        // allowedContent: true,
        width: '742px',
        height: '842px',
        overflow:'scroll',
        padding:'20px 20px!important',
        resize_enabled: true
    });

    var listFieldMap = "";

    $(document).ready(function() {
        $.ajax({
            type: "GET",
            url: url+"/ContractTemplate/list-field-map-in-template",
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
    })

    /*$("#viewsource").click(function(){
        var clss=$("#viewsource").attr("class");
        if(clss=='btn btn-success btn-sm')
        {
            $("#editor").css("display","none");
            $("#sourcecontract").css("display","block");
            $("#sourcecontract").text($("#editor").html());
            $(this).addClass("active");
            $("#action_area").css("display","none");
        }
        if(clss=='btn btn-success btn-sm active')
        {
            $("#editor").css("display","block");
            $("#sourcecontract").css("display","none");
            $(this).removeClass("active");
            $("#action_area").css("display","none");
            $("#editor").html( $("#sourcecontract").text());
            $("#action_area").css("display","block");
        }
    });*/
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


    //add div duong su
    $("#addDuongSu").click(function(){
        /*var sel;
        sel = window.getSelection();
        if(typeof(sel.focusNode.data) !='undefined'){*/
            pasteHtmlAtCaret('<div dynamic="duongsu" class="text-duongsu" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a></div>');
        /*}
        else
            pasteHtmlAtCaret('<div dynamic="duongsu" class="text-duongsu" style="text-indent: 50px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a></div>');*/
    });
    //add div duong su bên a
    $("#addDuongSuBenA").click(function(){
        pasteHtmlAtCaret('<div dynamic="duongsubena" class="text-duongsu-ben-a" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a></div>');
    });
    //add div duong su bên b
    $("#addDuongSuBenB").click(function(){
        pasteHtmlAtCaret('<div dynamic="duongsubenb" class="text-duongsu-ben-b" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a></div>');
    });
    //add div duong su bên c
    $("#addDuongSuBenC").click(function(){
        pasteHtmlAtCaret('<div dynamic="duongsubenc" class="text-duongsu-ben-c" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-success">>>Khu vực hiển thị đương sự bên c<<</a></div>');
    });
    //add div tai san
    $("#addTaiSan").click(function(){
        pasteHtmlAtCaret('<div dynamic="taisan" class="text-taisan" style="text-indent: 48px;font-family:Times New Roman;font-size: 14pt;margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt; margin-left:0cm;line-height:150%"><a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a></div>');

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

    /*    //Add span để mapping với editable
        $("#cke_inputcontract").click(function(){
            var sel;
            sel = window.getSelection();
            if(typeof(sel.focusNode.data) !='undefined'){
                pasteHtmlAtCaret("<span class='inputcontract' editspan='newtextbox' placeholder='.....' contenteditable='true'></span> ");
            }
            else
                pasteHtmlAtCaret("<span class='inputcontract' editspan='newtextbox' placeholder='.....' contenteditable='true'></span> ");

        });*/

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


    //for wysiwyg
/*    $('#editor').wysiwyg();*/

</script>
<script>
    var check = '${itemCustum.contractTempDetail}';
    if(check != 'null' && type_custum != "add" && type_custum != "custum_add"){
        var kind_id = '${itemCustum.contractTempDetail.kind_id}';
        if(kind_id == 0 || kind_id == 'null'){
            $("#display_tenHD").css("display","none");
        }
    }
</script>

<script>
    function importFileWord() {
        var fileTemplateImport = $("#fileTemplateImport")[0].files[0];
        if (fileTemplateImport.size > 5242000) {
            $("#errorMaxFile").modal('show');
        } else {
            var uploadUrl = url + "/ContractTemplate/get-html-of-doc-file";

            var formData = new FormData();
            formData.append('file', fileTemplateImport);

            $.ajax({
                url : url + '/ContractTemplate/get-html-of-doc-file',
                type : 'POST',
                data : formData,
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                success : function(data) {
                    CKEDITOR.instances.editor.setData( data );
                    //$('#editor').html(data);
                    $('#giatriKindHtml').val(data);
                    /* console.log(data);
                     alert(data);*/
                }
            });


        }
    }
</script>

