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
<script src="<%=request.getContextPath()%>/static/js/contract/createKeyMap/listKeyMap.js" type="text/javascript"></script>

<spring:url value="/contract/add-key-map-contract" var="addUrl"/>
<spring:url value="/contract/detail-key-map-contract" var="viewDetail"/>
<spring:url value="/contract/detail-key-map-contract" var="testFileFormatUrl"/>
<spring:url value="/contract/read-file-doc" var="readfiledocUrl"/>

<script  type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var readfiledocUrl = '${readfiledocUrl}';

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
    <span id="web-map">Danh sách từ khóa bóc tách trong hợp đồng</span>
</div>
<div class="truong-form-chinhpq" ng-app="osp"  ng-controller="contractListController">
    <div id="uchi-status">
        <c:if test="${status == '1'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Thêm mới thành công
            </div>
        </c:if>
        <c:if test="${status == '2'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Sửa thành công
            </div>
        </c:if>
        <c:if test="${status == '3'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Xóa thành công
            </div>
        </c:if>
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
                if(ValidationPool.checkRoleDetail(request,"30", Constants.AUTHORITY_TIMKIEM)){
            %>
            <div class="form-group" style="margin-bottom: 0px;">
                <div class="form-group col-md-12" style="margin-bottom: 0px;">
                    <section class="panel panel-default" style="margin-left:20px;border:none!important;">
                        <div class="panel-body">
                            <div class="bs-example form-horizontal" >

                                <div class="form-group">
                                    <div class="col-md-3">
                                        Loại từ khóa
                                        <%--<select id="search_type" ng-model="search.type" class="selectpicker select2 col-md-12 no-padding" ng-change="myFunc(search.type);changekeyName('-1');">--%>
                                        <select id="search_type" ng-model="search.type" class="selectpicker select2 col-md-12 no-padding" ng-change="myFunc(search.type);">
                                            <option value="">--Chọn--</option>
                                            <option ng-repeat="item in contractKinds" value="{{item.type}}">{{item.name}}</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Mẫu từ khóa
                                        <select id="search_type_property" ng-model="search.type_property" class="selectpicker select2 col-md-12 no-padding" ng-change="changekeyName(search.type_property)">
                                            <option value="">--Chọn--</option>
                                            <option  ng-repeat="item in template" value="{{item.id}}">{{item.name}}</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Từ khóa dành cho
                                        <select id="search_map_var" ng-model="search.map_var" class="selectpicker select2 col-md-12 no-padding">
                                            <option value="">--Chọn--</option>
                                            <option ng-repeat="item in keyName" value="{{item.map_var}}">{{item.name}}</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Từ khóa duyệt
                                        <select id="search_begin_or_close" ng-model="search.begin_or_close" class="selectpicker select2 col-md-12 no-padding">
                                            <option value="">--Chọn--</option>
                                            <option value="1">Bắt đầu</option>
                                            <option value="2">Kết thúc</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-3">
                                        Từ khóa bắt đầu cắt chuỗi
                                        <input type="text" class="form-control" ng-model="search.first_word" my-enter="searchAdvance()"/>
                                    </div>
                                    <div class="col-md-3">
                                        Từ khóa kết thúc cắt chuỗi
                                        <input type="text" class="form-control" ng-model="search.end_word" my-enter="searchAdvance()"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12" style="text-align: center;">
                                        <a class="btn btn-sm btn-success" ng-click="searchAdvance()">Tìm kiếm</a>
                                        <%--<a class="btn btn-sm btn-danger" data-toggle="modal" data-target="#checkDelete">Xóa từ khóa đã chọn</a>--%>
                                        <a class="btn btn-sm btn-default" ng-click="clearCondition()">Xóa điều kiện</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <div class="col-md-12" style="margin-bottom: 0px;padding-bottom: 0px; text-align: right">
                <a href="${addUrl}" class="btn btn-sm btn-success">Thêm mới</a>
                <a class="btn btn-sm btn-danger" data-toggle="modal" data-target="#checkDelete">Xóa từ khóa đã chọn</a>

               <%-- <div class="hidden col-md-3 pull-right">
                    <a target="_blank" class="btn btn-success btn-sm dropdown-toggle"  ng-click="importFileWord()">Test kiểm tra định dạng WORD</a>
                </div>
                <div class="hidden col-md-3 pull-right">
                    <input type="file" class="btn btn-success pull-right btn-sm dropdown-toggle"  file-model="myFileImport">
                </div>--%>
            </div>
            <%
                }
            %>
            <div class="col-md-12">
                <div class="panel-group truong-margin-footer0px">
                    <section class="panel panel-default">
                        <div class="panel-body" style="padding: 0px;">
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <table class="table" style="margin-bottom:0%;table-layout: fixed;" ng-switch on="listDataMapKey.rowCount">

                                        <tr class="border-table">
                                            <th class=" ann-title border-table table-giua" style="width: 50px;">
                                                <input id="select_all_{{listDataMapKey.pageNumber}}" ng-model="selectAllCurrentPage" type="checkbox" ng-click="select_all(selectAllCurrentPage)">
                                            </th>
                                            <th class=" ann-title border-table table-giua" style="width: 50px;">STT</th>
                                            <th class=" ann-title border-table table-giua">Từ khóa tìm kiếm</th>
                                            <th class=" ann-title border-table table-giua">Loại từ khóa</th>
                                            <th class=" ann-title border-table table-giua">Từ khóa dành cho</th>
                                            <th class=" ann-title border-table table-giua">Từ khóa bắt đầu cắt chuỗi</th>
                                            <th class=" ann-title border-table table-giua">Từ khóa kết thúc cắt chuỗi</th>
                                            <th class=" ann-title border-table table-giua">Từ khóa duyệt</th>
                                            <th class=" ann-title border-table table-giua">Ghi chú</th>
                                        </tr>

                                        <tr ng-switch-when="0">
                                            <td colspan="9"
                                                style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                                Không có dữ liệu
                                            </td>
                                        </tr>

                                        <tr ng-switch-default class="highlight-content" ng-repeat="item in listDataMapKey.items track by $index" style="height:50px!important;">
                                            <td class="border-table align-giua"><center>
                                                <input id="IDonChangeSelectBox_{{item.id}}" class="onChangeSelectBox_" type="checkbox"  ng-click="addIdSelect(this,$index,checkbox)">
                                            </center></td>
                                            <td class="border-table align-giua" style="width:20px!important;">{{(listDataMapKey.pageNumber-1)*listDataMapKey.numberPerPage + $index+1}}</td>
                                            <td class="border-table align-giua breakAll"><a class="link_a" href="<%=request.getContextPath()%>/contract/detail-key-map-contract/{{item.id}}">{{item.key_name}}</a></td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <div ng-show="item.type==1">
                                                    Đương sự
                                                </div>
                                                <div ng-show="item.type==2">
                                                    Tài sản
                                                </div>
                                                <div ng-show="item.type==3">
                                                    Các Loại khác
                                                </div>
                                                <div ng-show="item.type==4">
                                                    Ký tự đặc biệt
                                                </div>
                                            </td>

                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                {{item.map_var_search}}
                                            </td>

                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.first_word | limitTo:200"></span>{{ item.first_word.length > 200 ? '...' : ''}}

                                                <a ng-if="item.first_word.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.first_word}}" title="" data-original-title='Từ khóa bắt đầu cắt chuỗi'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.end_word | limitTo:200"></span>{{ item.end_word.length > 200 ? '...' : ''}}

                                                <a ng-if="item.end_word.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.end_word}}" title="" data-original-title='Từ khóa kết thúc cắt chuỗi'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <div ng-show="item.begin_or_close==1">
                                                    Bắt đầu
                                                </div>
                                                <div ng-show="item.begin_or_close==2">
                                                    Kết thúc
                                                </div>
                                            </td>
                                            <td class="border-table truong-text-verticel" style="color: black;">
                                                <span ng-bind-html="item.note | limitTo:200"></span>{{ item.note.length > 200 ? '...' : ''}}
                                                <a ng-if="item.note.length>200" data-trigger="click" data-toggle="popover" data-html="true" data-placement="top" data-content=" {{item.note}}" title="" data-original-title='Ghi chú'><img src="<%=request.getContextPath()%>/static/image/xemthem.png" /></a>
                                            </td>

                                        </tr>

                                        <tr ng-switch-default class="table-tr-xam">
                                            <th colspan="9"><div class="truong-padding-foot-table">Tổng số <span style="color: red;">{{listDataMapKey.rowCount}}</span> dữ liệu</div>
                                                <div class="align-phai">
                                                    <ul class="pagination pagination-sm m-t-none m-b-none">
                                                        <li ng-if="listDataMapKey.pageNumber>1"><a ng-click="loadPageData(1)">«</a></li>
                                                        <li ng-repeat="item in listDataMapKey.pageList">
                                                            <a ng-if="item==listDataMapKey.pageNumber"  style="color:mediumvioletred;"> {{item}}</a>
                                                            <a ng-if="item!=listDataMapKey.pageNumber" ng-click="loadPageData(item)"> {{item}}</a>
                                                        </li>
                                                        <li ng-if="listDataMapKey.pageNumber<listDataMapKey.pageCount"><a ng-click="loadPageData(listDataMapKey.pageCount)">»</a></li>
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
                        <h4 class="modal-title">Xóa từ khóa</h4>
                    </div>
                    <div class="modal-body">
                        <label>Bạn có chắc muốn xóa ! </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" ng-click="deleteContractKeyMap()">OK</button>
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
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<script>
    $(function () {
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
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#list-key-map-contract").addClass("child-menu");
    });
</script>