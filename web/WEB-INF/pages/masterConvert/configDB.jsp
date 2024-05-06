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
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';

    var master_dbName_ = '${item.configDBMaster.master_dbName}';
    var master_serverip_ = '${item.configDBMaster.master_serverip}';
    var master_serverport_ = '${item.configDBMaster.master_serverport}';
    var master_driver_ = '${item.configDBMaster.master_driver}';
    var master_databaseUserName_ = '${item.configDBMaster.master_databaseUserName}';
    var master_databasePassword_ = '${item.configDBMaster.master_databasePassword}';
    $("#uchi-status").show();
    setTimeout(function() { $("#uchi-status").hide(); }, 3000);
    setTimeout(function() { $("#uchi-status-2").hide(); }, 10000);
    var timer;
</script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Cấu hình Database Master</span>
</div>

<div class="truong-form-chinhbtt" ng-app="osp" id="contractTempAddController" ng-controller="contractTempAddController">
    <div id="uchi-status">
        <c:if test="${item.status == '1'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Cấu hình Database Master thành công!
            </div>
        </c:if>
        <c:if test="${item.status == '2'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Thử kết nối Database Master thành công!
            </div>
        </c:if>
        <c:if test="${item.status == '3'}">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">
                Thử kết nối Database Master thất bại!
            </div>
        </c:if>

    </div>
    <div id="uchi-status-2" style="font-weight: bold;font-size: 14px;margin-top: 20px;">
        <div style="display: none;" class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Đồng bộ không thành công</div>
        <div style="display: none;" class="status-success" id="status-success-5"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Đồng bộ thành công</div>
    </div>

    <div class="progress" style="display: none;margin-top: 20px">
        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
            0%
        </div>
    </div>
    <div class="panel-group" id="accordion">
        <form name="myForm" class="form-horizontal" id="formSubmit" method="post">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse">
                            THÔNG TIN DATABASE MASTER
                        </a>
                    </h4>

                </div>
                <div class="panel-body">
                    <input type="hidden" ng-model="entry_user_id"  ng-init="entry_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'" >
                    <input type="hidden" ng-model="entry_user_name" ng-init="entry_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Tên Database</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="master_dbName"
                                   ng-model="contractTempAdd.master_dbName">
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_dbName.$touched && myForm.master_dbName.$invalid">Tên Database không thể bỏ trống.</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Địa chỉ IP</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="master_serverip"
                                   ng-model="contractTempAdd.master_serverip">
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_serverip.$touched && myForm.master_serverip.$invalid">Địa chỉ IP không thể bỏ trống.</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Port</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="master_serverport"
                                   ng-model="contractTempAdd.master_serverport">
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_serverport.$touched && myForm.master_serverport.$invalid">Port không thể bỏ trống.</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai required">Driver</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="master_driver"
                                   ng-model="contractTempAdd.master_driver" ng-init="contractTempAdd.master_driver='net.sourceforge.jtds.jdbc.Driver'" disabled>
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_driver.$touched && myForm.master_driver.$invalid">Driver không thể bỏ trống.</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai required">Database UserName</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="master_databaseUserName"
                                   ng-model="contractTempAdd.master_databaseUserName">
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_databaseUserName.$touched && myForm.master_databaseUserName.$invalid">Database userName không thể bỏ trống.</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai required">Database Password</label>
                        <div class="col-md-8">
                            <input type="password" class="form-control " name="master_databasePassword"
                                   ng-model="contractTempAdd.master_databasePassword">
                            <span class="truong-text-colorred"
                                  ng-show="myForm.master_databasePassword.$touched && myForm.master_databasePassword.$invalid">Database password không thể bỏ trống.</span>
                        </div>
                    </div>
                </div>

                <div class="form-group" style="text-align: center;margin:20px 0px;">
                    <%
                        if (ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_SUA)) {
                    %>
                    <a class="btn btn-primary" style="min-width:130px;" id="submitform" ng-click="BeforeSubmit()">Lưu</a>
                    <a class="btn btn-primary" style="min-width:130px;" ng-click="connectDBmaster()">Kết nối</a>
                    <%
                        }
                    %>
                    <%
                        if (ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_THEM)) {
                    %>
                    <a class="btn btn-primary" style="min-width:130px;" data-toggle="modal" data-target="#convertDBmaster">Đồng bộ dữ liệu</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </form>
    </div>

    <div class="modal fade" id="convertDBmaster" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Điều kiện đồng bộ</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 150px;">
                    <div class="form-group" style="padding-bottom: 15px;">
                        <div class="col-md-12" style="padding-bottom: 15px;">
                            <select ng-model="year" class="selectpicker select2 no-padding" ng-change="changeYear(year)">
                                <option value="1">Đồng bộ theo năm</option>
                                <option value="2">Đồng bộ từ năm tới năm</option>
                            </select>
                        </div>
                        <div ng-show="yearCheck1">
                            <div class="col-md-6">
                                <label class="required">Năm đồng bộ</label>
                                <input ng-model="fromYear" type="text" class="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')">
                            </div>
                        </div>
                        <div ng-show="yearCheck2">
                            <div class="col-md-6">
                                <label class="required">Từ Năm</label>
                                <input ng-model="fromYear" type="text" class="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')">
                            </div>
                            <div class="col-md-6">
                                <label class="required">Đến Năm</label>
                                <input ng-model="toYear" type="text" class="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#goiYDieuKien">Gợi ý điều kiện</button>
                    <button type="button" class="btn btn-primary" ng-click="convertDBmaster()">Bắt đầu đồng bộ</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="goiYDieuKien" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Gợi ý điều kiện</h4>
            </div>
            <div class="modal-body">
                <p>- Đồng bộ theo năm : Chọn select box Đồng bộ theo năm.</p>
                <p>Nhập năm muốn đồng bộ. Ví dụ đồng bộ năm 2003 nhập: 2003</p>
                <p>- Đồng bộ từ năm tới năm: Chọn select box Đồng bộ từ năm đến năm.</p>
                <p>Nhập từ năm đến năm muốn đồng bộ.</p>
                <p>Ví dụ đồng bộ từ năm 2003 đến năm 2015</p>
                <p>Nhập từ năm: 2003</p>
                <p>Nhập đến năm: 2015</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
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

<div class="modal fade" id="errorYearConvert" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Error</h4>
            </div>
            <div class="modal-body">
                <p>Từ năm không được lớn hơn đến năm ! </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>

<script src="<%=request.getContextPath()%>/static/js/masterConvert/configDB.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
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
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>


<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        var parentItem2 = $("#dong-bo-master");
        $(parentItem).click();
        $(parentItem2).click();
        $("#config-db-master").addClass("child-menu");
    });
</script>

