<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
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
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<script src="<%=request.getContextPath()%>/static/js/masterConvert/dataMaster.js" type="text/javascript"></script>

<script  type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';

    $("#uchi-status").show();
    setTimeout(function() {
        $("#uchi-status").hide();
        $('#status-success-3').css("display","none");
    }, 3000);
</script>

<style>
    .panel-heading a:after{
        background-image:none;
    }
    .nav-tabs.nav-justified> .active{
        border-top:3px solid #2ca9e0;
    }
    .panel{
        webkit-box-shadow:none;
        box-shadow:none;
    }
    .popover-content {
        height: 200px;
        overflow-y: auto;
    }

</style>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Dữ liệu database Master chưa chuyển đổi</span>
</div>
<div class="truong-form-chinhpq" ng-app="osp"  ng-controller="contractListController">
    <div id="uchi-status">
        <div style="display: none;" class="status-success" id="status-success-3"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
            Xóa thành công.
        </div>
    </div>
    <div id="uchi-status-2" style="font-weight: bold;font-size: 14px;margin-top: 20px;">
        <div style="display: none;" class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Chuyển đổi không thành công</div>
        <div style="display: none;" class="status-success" id="status-success-5"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Chuyển đổi thành công</div>
    </div>
    <div class="progress" style="display: none;margin-top: 20px">
        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
            0%
        </div>
    </div>

    <div class="panel-group">
        <form class="form-horizontal" id="search-frm" name="myForm" >
            <input type="hidden" ng-model="entry_user_id"  ng-init="entry_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'" >
            <input type="hidden" ng-model="entry_user_name" ng-init="entry_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
            <input type="hidden" id="listIdSelect" name="listIdSelect" style="width: 100%">
            <%
                if(ValidationPool.checkRoleDetail(request,"25", Constants.AUTHORITY_TIMKIEM)){
            %>
            <div class="form-group">
                <div class="form-group col-md-12" style="margin-bottom: 0px;">
                    <section class="panel panel-default" style="margin-left:20px;border:none!important;">
                        <div class="panel-body">
                            <div class="bs-example form-horizontal" >

                                <div>
                                    <div class="col-md-3 hidden">
                                        Nhóm hợp đồng
                                        <select ng-model="search.contract_kind" class="selectpicker select2 col-md-12 no-padding" ng-change="changeContractKind(search.contract_kind)">
                                            <option value="">--Chọn--</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 hidden">
                                        Tên hợp đồng
                                        <select ng-model="search.contract_template" class="selectpicker select2 col-md-12 no-padding" >
                                            <option value="">--Chọn--</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Số hợp đồng
                                        <input type="text" class="form-control"   ng-model="search.contract_number" my-enter="searchAdvance()" >
                                    </div>
                                    <div class="col-md-3">
                                        Bên liên quan
                                        <input type="text" class="form-control"   ng-model="search.relation_object" my-enter="searchAdvance()"  />
                                    </div>
                                    <div class="col-md-3">
                                        Thông tin tài sản
                                        <input type="text" class="form-control"  ng-model="search.property_info" my-enter="searchAdvance()" />
                                    </div>
                                    <div class="col-md-3">
                                        Ngày công chứng
                                        <select ng-model="search.time" class="selectpicker select2 col-md-12 no-padding" ng-change="changTime(search.time)" >
                                            <option value="">--Chọn--</option>
                                            <option value="1">Trong hôm nay</option>
                                            <option value="2">Trong tuần này</option>
                                            <option value="3">Trong tháng này</option>
                                            <option value="4">Trong năm nay</option>
                                            <option value="5">Khoảng thời gian</option>
                                        </select>
                                    </div>
                                    <div ng-show="showTime">
                                        <div class="col-md-3">
                                            Từ ngày
                                            <input type="text" class="form-control"  name="fromDate" ng-model="search.fromTime" id="fromDate" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);" required>
                                            <span class="truong-text-colorred"  ng-bind-html="fromDateError"></span>
                                        </div>
                                        <div class="col-md-3">
                                            Đến ngày
                                            <input type="text" class="form-control"  name="toDate" ng-model="search.toTime" id="toDate" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);" required>
                                            <span class="truong-text-colorred"  ng-bind-html="toDateError"></span>
                                        </div>
                                    </div>

                                    <div class="col-md-12" style="margin-top:20px;text-align: center;">
                                        <a class="btn btn-sm btn-success" ng-click="searchAdvance()">Tìm kiếm</a>
                                        <a class="btn btn-sm btn-danger" data-toggle="modal" data-target="#checkDelete">Xóa hợp đồng</a>
                                        <a class="btn btn-sm btn-default" ng-click="clearCondition()">Xóa điều kiện</a>
                                        <div class="btn-group pull-right" style="padding-left: 5px;">
                                            <button class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown"><i class="fa fa-plus"></i>Chuyển đổi từ master<span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li><a data-toggle="modal" data-target="#addAllMasterToTransaction" ><i class="fa fa-plus"></i>Tất cả</a></li>
                                                <li><a data-toggle="modal" data-target="#addLimitMasterToTransaction"><i class="fa fa-plus"></i>Các bản ghi đã chọn</a></li>
                                            </ul>
                                        </div>
                                        <div class="btn-group pull-right">
                                            <button class="btn btn-sm btn-warning btn-secondary dropdown-toggle " data-toggle="dropdown"><i class="fa fa-plus"></i>Lọc hợp đồng<span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li><a data-toggle="modal" ng-click="searchCoincideContent()"><i class="fa fa-plus"></i>Lọc hợp đồng trùng nội dung</a></li>
                                                <li><a data-toggle="modal" ng-click="searchTypeMasterToTransaction1()"><i class="fa fa-plus"></i>Lọc hợp đồng đã chuyển đổi</a></li>
                                                <li><a data-toggle="modal" ng-click="searchTypeMasterToTransaction0()"><i class="fa fa-plus"></i>Lọc hợp đồng chưa chuyển đổi</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <%
                }
            %>
            <div class="col-md-12">
                <div class="panel-group truong-margin-footer0px">
                    <section class="panel panel-default">
                        <div class="panel-body" style="padding: 0px;">
                            <div class="tab-content">
                                <div class="tab-pane active" id="choky">
                                    <table class="table" style="margin-bottom:0%;table-layout: fixed;" ng-switch on="listDataMaster.rowCount">

                                        <tr class="border-table" >
                                            <th class=" ann-title border-table table-giua" style="width: 50px;">
                                                <input id="select_all" ng-model="selectAll" type="checkbox" ng-click="select_all(selectAll);" select="false">
                                            </th>
                                            <th class=" ann-title border-table table-giua" style="width:70px;">STT</th>
                                            <th class=" ann-title border-table table-giua" style="width:100px;">Số DM Công chứng</th>
                                            <th class=" ann-title border-table table-giua" style="width:100px;">Ngày công chứng</th>
                                            <th class=" ann-title border-table table-giua">Bên liên quan</th>
                                            <th class=" ann-title border-table table-giua" style="width:100px;">Loại việc Công chứng</th>
                                            <th class=" ann-title border-table table-giua">Nội dung</th>
                                            <th class=" ann-title border-table table-giua" style="width:100px;">Công chứng viên</th>
                                        </tr>

                                        <tr ng-switch-when="0">
                                            <td colspan="8"
                                                style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                                Không có dữ liệu
                                            </td>
                                        </tr>

                                        <tr ng-switch-default class="highlight-content" ng-repeat="item in listDataMaster.items track by $index" style="height:50px!important;">
                                            <td class="border-table align-giua"><center>
                                                <input class="onChangeSelectBox_" ng-model="checkbox" type="checkbox" select="false" ng-click="addIdSelect(this,$index,checkbox)">
                                            </center></td>
                                            <td class="border-table align-giua" style="width:20px!important;">{{(listDataMaster.pageNumber-1)*listDataMaster.numberPerPage + $index+1}}</td>
                                            <td class="border-table align-giua breakAll"><a class="link_a" href="<%=request.getContextPath()%>/system/osp/data-master-view/{{item.id}}">{{item.contract_number_new}}</a></td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                {{item.notary_date}}
                                            </td>

                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.relation_object | limitTo:200"></span>{{ item.relation_object.length > 200 ? '...' : ''}}

                                                <a ng-if="item.relation_object.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.relation_object}}" title="" data-original-title='Bên liên quan'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.contracttype_name | limitTo:200"></span>{{ item.contracttype_name.length > 200 ? '...' : ''}}

                                                <a ng-if="item.contracttype_name.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.contracttype_name}}" title="" data-original-title='Loại việc công chứng'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>

                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.property_info | limitTo:200"></span>{{ item.property_info.length > 200 ? '...' : ''}}
                                                <a ng-if="item.property_info.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.property_info}}" title="" data-original-title='Nội dung'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>
                                            <td class="border-table align-giua"
                                                style="color: black;">{{item.notary_person}}
                                            </td>

                                        </tr>

                                        <tr ng-switch-default class="table-tr-xam">
                                            <th colspan="8"><div class="truong-padding-foot-table">Tổng số <span style="color: red;">{{listDataMaster.rowCount}}</span> dữ liệu</div>
                                                <div class="align-phai">
                                                    <ul class="pagination pagination-sm m-t-none m-b-none">
                                                        <li ng-if="listDataMaster.pageNumber>1"><a ng-click="loadPageDataMaster(1)">«</a></li>
                                                        <li ng-repeat="item in listDataMaster.pageList">
                                                            <a ng-if="item==listDataMaster.pageNumber"  style="color:mediumvioletred;"> {{item}}</a>
                                                            <a ng-if="item!=listDataMaster.pageNumber" ng-click="loadPageDataMaster(item)"> {{item}}</a>
                                                        </li>
                                                        <li ng-if="listDataMaster.pageNumber<listDataMaster.pageCount"><a ng-click="loadPageDataMaster(listDataMaster.pageCount)">»</a></li>
                                                    </ul>
                                                </div>
                                            </th>
                                        </tr>

                                    </table>
                                </div>

                            </div>
                        </div>
                    </section>
                </div>
            </div>

        </form>

        <div class="modal fade" id="errorFormatDate" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <label>Định dạng tìm kiếm theo thời gian phải là: dd/MM/yyyy! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
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
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <label>Bạn chưa chọn bản ghi nào ! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal fade" id="checkDelete" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <label>Bạn có chắc muốn xóa ! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" ng-click="deleteCondition()">OK</button>
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

        <div class="modal fade" id="addAllMasterToTransaction" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Chuyển đổi tất cả</h4>
                    </div>
                    <div class="modal-body">
                        <label>Bạn muốn chuyển đổi tất cả dữ liệu từ master ! </label><br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" ng-click="addAllMasterToTransaction()">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addLimitMasterToTransaction" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Chuyển đổi chọn lọc</h4>
                    </div>
                    <div class="modal-body">
                        <label>Bạn muốn chuyển đổi các bản ghi đã chọn ! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" ng-click="addLimitMasterToTransaction()">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="addMasterToTransactionSucsses" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Chuyển đổi</h4>
                    </div>
                    <div class="modal-body">
                        <label>Chuyển đổi master thành công ! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script>

    $(function () {
        $('#fromDate').datepicker({
            format: "dd/mm/yyyy",
            startDate:"01/01/1900",
            endDate:endDate,
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#toDate').datepicker({
            format: "dd/mm/yyyy",
            startDate:"01/01/1900",
            endDate:endDate,
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

        $('body').on('click', function (e) {
            //did not click a popover toggle, or icon in popover toggle, or popover
            if ($(e.target).data('toggle') !== 'popover'
                && $(e.target).parents('[data-toggle="popover"]').length === 0
                && $(e.target).parents('.popover.in').length === 0) {
                $('[data-toggle="popover"]').popover('hide');
            }
        });

    });
</script>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        var parentItem2 = $("#dong-bo-master");
        $(parentItem).click();
        $(parentItem2).click();
        $("#data-db-master").addClass("child-menu");
    });
</script>