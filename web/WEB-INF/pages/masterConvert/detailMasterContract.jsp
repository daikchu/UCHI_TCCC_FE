<%@ page import="com.vn.osp.context.CommonContext"%>
<%@ page import="com.vn.osp.common.util.SystemProperties"%>
<%@ page import="com.vn.osp.common.util.ValidationPool"%>
<%@ page import="com.vn.osp.common.global.Constants"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<script type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath='<%=request.getContextPath()%>';
    var urlstp='<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var id='${masterContract.id}';
</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/masterConvert/detailMasterConvert.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết hợp đồng</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="detailMaster">
    <div id="uchi-status">
    </div>
    <div class="panel-group" id="accordion">
        <div class="form-horizontal">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">Thông tin hợp đồng</h4>
                </div>
                <div class="panel-body">
                    <input type="hidden" ng-model="entry_user_id"  ng-init="entry_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'" >
                    <input type="hidden" ng-model="entry_user_name" ng-init="entry_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Loại việc Công chứng</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.contracttype_name"  ng-model="listDataMaster.contracttype_name"  disabled="true" />
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Số hợp đồng cũ</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.contract_number"  ng-model="listDataMaster.contract_number"  disabled="true" />

                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Số hợp đồng mới</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.contract_number_new"  ng-model="listDataMaster.contract_number_new"  disabled="true" />

                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Ngày công chứng</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.notary_date"  ng-model="listDataMaster.notary_date"  disabled="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group" >
                            <div class="">
                                <label class="col-md-2 control-label  label-bam-trai">Bên liên quan</label>
                                <div class="col-md-10">
                                    <textarea class="form-control" name="listDataMaster.relation_object" ng-model="listDataMaster.relation_object" style="min-height: 200px;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group" >
                            <div class="">
                                <label class="col-md-2 control-label  label-bam-trai">Tài sản</label>
                                <div class="col-md-10">
                                    <textarea class="form-control" name="listDataMaster.property_info" ng-model="listDataMaster.property_info" style="min-height: 100px;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group" >
                            <div class="">
                                <label class="col-md-2 control-label  label-bam-trai">Tóm tắt nội dung</label>
                                <div class="col-md-10">
                                    <textarea class="form-control" name="listDataMaster.transaction_content" ng-model="listDataMaster.transaction_content" style="min-height: 100px;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group" >
                            <div class="">
                                <label class="col-md-2 control-label  label-bam-trai">Tổng quan</label>
                                <div class="col-md-10">
                                    <textarea class="form-control" name="listDataMaster.content" ng-model="listDataMaster.content"  disabled="true" style="min-height: 200px;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Công chứng viên</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.notary_person"  ng-model="listDataMaster.notary_person"  disabled="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Ngày đồng bộ lần cuối</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.update_date_time"  ng-model="listDataMaster.update_date_time"  disabled="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-2 control-label  label-bam-trai">Người đồng bộ lần cuối</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="listDataMaster.update_user_name"  ng-model="listDataMaster.update_user_name"  disabled="true"/>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="panel-body" style="margin-bottom:30px;">
                <div class="list-buttons" style="text-align: center;">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"25", Constants.AUTHORITY_SUA)){
                    %>
                    <a class="btn btn-s-md btn-info" data-toggle="modal"  data-target="#editContract">Chỉnh sửa</a>
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/system/osp/data-master-view" class="btn btn-s-md btn-default">Quay lại danh sách</a>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="editContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Chỉnh sửa</h4>
                </div>
                <div class="modal-body">
                    <label>Bạn muốn chỉnh sửa dữ liệu ! </label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" ng-click="editMasterContract()">OK</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="editContractSucsses" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Chỉnh sửa</h4>
                </div>
                <div class="modal-body">
                    <label>Chỉnh sửa thành công ! </label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
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
                    <label>Có lỗi xảy ra. Hãy thử lại sau! </label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        var parentItem2 = $("#dong-bo-master");
        $(parentItem).click();
        $(parentItem2).click();
        $("#data-db-master").addClass("child-menu");
    });
</script>
