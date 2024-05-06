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


<script  type="text/javascript">
    var id = '${bo.id}';
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp='<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath='<%=request.getContextPath()%>';

</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/createKeyMap/detailKeyMap.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css" />
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết từ khóa</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" id="contractAddController" ng-controller="contractAddController">

    <div class="panel-group" id="accordion">

        <div class="form-horizontal">
            <form name="myForm" class="panel panel-default" id="panel1">
                <div class="panel-heading col-md-12">
                    <div style="padding-left: 0px;">
                        <h4 class="panel-title" style="padding-left: 0px;">Thông tin từ khóa</h4>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="panel-body col-md-12" style="padding-bottom: 0px;margin-bottom: 0px;">
                        <input type="hidden" ng-model="contract.update_user_id" ng-init="contract.update_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
                        <input type="hidden" ng-model="contract.update_user_name" ng-init="contract.update_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required">Loại từ khóa</label>
                                    <div class="col-md-6" style="padding-left: 7px !important;">
                                        <select id="type_valid" ng-model="contract.type" class="selectpicker select2 col-md-12 no-padding" ng-change="myFunc(contract.type);myFunc_();"  required>
                                            <option ng-repeat="item in contractKinds" value="{{item.type}}">{{item.name}}</option>
                                        </select>
                                        <span class="truong-text-colorred">{{type_valid}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div ng-show="(contract.type != 'undefined' && contract.type != '3')">
                            <div ng-show="!check_type_special_word">
                            <div ng-show="check_" class="row truong-inline-field">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="col-md-3 control-label  label-bam-trai required">mẫu từ khóa</label>
                                        <div class="col-md-6" style="padding-left: 7px !important;">
                                            <select id="type_property_valid" ng-model="contract.type_property" class="selectpicker select2 col-md-12 no-padding" ng-change="changekeyName(contract.type_property)" required>
                                                <option  ng-repeat="item in template" value="{{item.id}}">{{item.name}}</option>
                                            </select>
                                            <span class="truong-text-colorred">{{type_property_valid}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div ng-show="!begin_or_close || contract.type == '3'">
                            <div class="row truong-inline-field" ng-show="!check_type_special_word">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="col-md-3 control-label  label-bam-trai required">Từ khóa dành cho</label>
                                        <div class="col-md-6" style="padding-left: 7px !important;">
                                            <select id="map_var_valid" ng-model="contract.map_var" class="selectpicker select2 col-md-12 no-padding">
                                                <option ng-repeat="item in keyName" value="{{item.map_var}}">{{item.name}}</option>
                                            </select>
                                            <span class="truong-text-colorred">{{map_var_valid}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>


                        <div class="row truong-inline-field" ng-show="!check_type_special_word">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label label-bam-trai">Từ khóa duyệt</label>
                                    <div class="col-md-6 control-label label-bam-trai">
                                        <label class="radio-inline prevent-type">
                                            <input id="begin_or_close_1" ng-click="begin_or_close_(contract.begin_or_close);myFunc_();" type="radio" ng-model="contract.begin_or_close" value="1">Bắt đầu
                                        </label>
                                        <label class="radio-inline">
                                            <input id="begin_or_close_2" ng-click="begin_or_close_(contract.begin_or_close);myFunc_();" type="radio" ng-model="contract.begin_or_close" value="2">Kết thúc
                                        </label>
                                        <label class="radio-inline">
                                            <input id="begin_or_close_0" ng-click="begin_or_close_(contract.begin_or_close);myFunc_();" type="radio" ng-model="contract.begin_or_close" value="0">Bỏ chọn
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row truong-inline-field" ng-show="!check_type_special_word">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required">Từ khóa tìm kiếm</label>
                                    <div class="col-md-9">
                                        <input id="key_name_valid" type="text" class="form-control"  ng-model="contract.key_name" required>
                                        <span class="truong-text-colorred">{{key_name_valid}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div ng-show="!begin_or_close">
                            <div ng-show="!check_type_special_word">
                            <div class="row truong-inline-field">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="col-md-3 control-label  label-bam-trai">Từ khóa bắt đầu cắt chuỗi</label>
                                        <div class="col-md-9">
                                            <input id="first_word_valid" type="text" class="form-control"  ng-model="contract.first_word">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row truong-inline-field">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="col-md-3 control-label  label-bam-trai">Từ khóa kết thúc cắt chuỗi</label>
                                        <div class="col-md-9">
                                            <input id="end_word_valid" type="text" class="form-control" ng-model="contract.end_word">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>
                    <div ng-show="check_type_special_word">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai required">Nhập từ khóa đặc biệt</label>
                                    <div class="col-md-9">
                                        <input id="special_word_valid" type="text" class="form-control" ng-model="contract.key_name" required>
                                        <span class="truong-text-colorred">{{special_word_valid}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="col-md-3 control-label  label-bam-trai">Ghi chú</label>
                                <div class="col-md-9">
                                    <textarea type="text" class="form-control" ng-model="contract.note" required></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

        </div>

        <div class="panel-body" style="text-align: center;">
            <%
                if(ValidationPool.checkRoleDetail(request,"30", Constants.AUTHORITY_THEM)){
            %>
            <a  data-toggle="modal"  data-target="#addKeyMap" ng-dissable="checkLoad" class="btn btn-s-md btn-success">Lưu</a>
            <%
                }
            %>
            <a href="<%=request.getContextPath()%>/contract/list-key-map-contract" class="btn btn-s-md btn-default">Hủy bỏ</a>

        </div>

    </div>

    <div class="modal fade" id="addKeyMap" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Chỉnh sửa từ khóa</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận chỉnh sửa từ khóa? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="editKeyMap()">Đồng ý</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="error2" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lỗi tạo từ khóa</h4>
                </div>
                <div class="modal-body">
                    <p>Thông tin từ khóa này đã tồn tại, vui lòng kiểm tra lại! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="error" role="dialog">
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

</div>

<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/demo.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
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
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#list-key-map-contract").addClass("child-menu");
    });
</script>
