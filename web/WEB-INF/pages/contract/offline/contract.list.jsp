<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/static/plugin/mark/mark.js" charset="UTF-8"></script>--%>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<%--
   Danh sach hop dong cong chung
--%>
<spring:url value="/contract/list" var="listUrl"/>
<spring:url value="/contract/add" var="addUrl"/>
<spring:url value="/contract/addBrowserFile" var="addBrowserFileUrl"/>
<spring:url value="/contract/detail" var="viewDetail"/>
<script type="text/javascript">
    var org_type =<%=SystemProperties.getProperty("org_type")%>;
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var userEntryId =<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
    $("#uchi-status").show();
    setTimeout(function () {
        $("#uchi-status").hide();
    }, 3000);
</script>
<style>
    .panel {
        webkit-box-shadow: none;
        box-shadow: none;
    }
</style>

<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String congchungHOA = checkcongchung.equals("1") ? "CHỨNG THỰC" : "CÔNG CHỨNG";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
    String nguoiCongChungName = checkcongchung.equals("1") ? "Người ký chứng thực" : "Công chứng viên";
%>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/offline/contract.list.js" type="text/javascript"></script>

<div class="truong-form-chinhpq" ng-app="osp" ng-controller="contractListController">
    <div id="menu-map">
        <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
        <span id="web-map">Danh sách hợp đồng <%=congchung%> </span>
    </div>

    <div id="uchi-status">
        <c:if test="${status==1}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png">Thêm hợp đồng
                thành công!
            </div>
        </c:if>
        <c:if test="${status==2}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Xóa hợp đồng
                thành công!
            </div>
        </c:if>
        <c:if test="${status==3}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Hủy hợp đồng
                thành công!
            </div>
        </c:if>
        <c:if test="${status==4}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Sửa hợp đồng
                thành công!
            </div>
        </c:if>
    </div>

    <div class="panel-group">
        <form class="form-horizontal" id="search-frm" method="get" name="myForm">
            <%
                if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_TIMKIEM)) {
            %>
            <div class="form-group">
                <div class="form-group col-md-12">
                    <section class="panel panel-default" style="margin-left:20px;margin-top:0px;border:none!important;">
                        <div class="panel-body">
                            <form class="bs-example form-horizontal">
                                <div style="border:none;">
                                    <div class="col-md-3">
                                        Nhóm hợp đồng
                                        <select ng-model="search.contract_kind"
                                                class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changeContractKind(search.contract_kind)">
                                            <option value="">--Chọn--</option>
                                            <option ng-repeat="item in contractKinds"
                                                    value="{{item.contract_kind_code}}">{{item.name}}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Tên hợp đồng
                                        <select ng-model="search.contract_template"
                                                class="selectpicker select2 col-md-12 no-padding">
                                            <option value="">--Chọn--</option>
                                            <%--<option  ng-repeat="item in contractTemplates" value="{{item.contractTemplateId}}">{{item.name}}</option>--%>
                                            <option ng-repeat="item in contractTemplates"
                                                    value="{{item.code_template}}">{{item.name}}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        Số <%=hopDong%>
                                        <input type="text" class="form-control" ng-model="search.contract_number"
                                               my-enter="searchAdvance()" id="search_contract_number"/>
                                    </div>
                                    <div class="col-md-3">
                                        Bên liên quan
                                        <input type="text" class="form-control" ng-model="search.relation_object"
                                               my-enter="searchAdvance()" id="search_relation_object"/>
                                    </div>
                                    <div class="col-md-3">
                                        Thông tin tài sản
                                        <input type="text" class="form-control" ng-model="search.property_info"
                                               my-enter="searchAdvance()" id="search_property_info"/>
                                    </div>

                                    <div class="col-md-3">
                                        Ngày <%=congchung%>
                                        <select ng-model="search.time" class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changTime(search.time)">
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
                                            <input type="text" class="form-control" name="fromDate"
                                                   ng-model="search.fromTime" id="fromDate" minlength="10"
                                                   onkeypress="return restrictCharacters(this, event, forDate);"
                                                   required autocomplete="off">
                                            <span class="truong-text-colorred" ng-bind-html="fromDateError"></span>
                                        </div>
                                        <div class="col-md-3">
                                            Đến ngày
                                            <input type="text" class="form-control" name="toDate"
                                                   ng-model="search.toTime" id="toDate" minlength="10" autocomplete="off"
                                                   onkeypress="return restrictCharacters(this, event, forDate);"
                                                   required>
                                            <span class="truong-text-colorred" ng-bind-html="toDateError"></span>
                                        </div>
                                    </div>

                                    <div class="col-md-12 " style="text-align:center;margin-top:20px;"
                                         class="form-group">
                                        <a class="btn btn-success btn-sm" ng-click="searchAdvance()"
                                           style="width:120px;">Tìm kiếm</a>
                                        <a class="btn btn-sm huybo" ng-click="clearCondition()" style="width:120px;">Xóa
                                            điều kiện</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>
            <%
                }

            %>

            <div class="col-md-12">
                <div class="panel-group truong-margin-footer0px">

                    <ul class="nav nav-tabs" style="border-bottom:2px solid #ddd;">
                        <li ng-click="whenClickTabContract()" class="truong-fix-tab20 active"
                            style="text-align: center; border-left: 1px solid #ddd;"><a class="truong-fix-a"
                                                                                        data-toggle="tab"
                                                                                        href="#hopdong">Hợp
                            đồng <%=congchung%>
                            (<span class="truong-text-colorred">{{listContract.rowCount}}</span>)</a></li>
                        <li ng-click="whenClickTabNotSynch()" class="truong-fix-tab20 "
                            style="text-align: center; border-left: 1px solid #ddd;"><a class="truong-fix-a"
                                                                                        data-toggle="tab"
                                                                                        href="#chuadongbo">Hợp đồng chưa
                            đồng bộ
                            (<span class="truong-text-colorred">{{listNotSynch.rowCount}}</span>)</a></li>
                        <li ng-click="whenClickTabContractOfflineTemporary()" class="truong-fix-tab20 "
                            style="text-align: center; border-left: 1px solid #ddd;"><a class="truong-fix-a"
                                                                                        data-toggle="tab"
                                                                                        href="#luutam">Hợp đồng lưu tạm
                            (<span class="truong-text-colorred">{{listContractOfflineTemporary.rowCount}}</span>)</a>
                        </li>
                        <a class="btn btn-success  btn-sm pull-right" ng-click="download()"
                           style="width:120px;margin-left:10px;">Tải file báo cáo</a>

                       <%-- <%
                            if(ValidationPool.checkRoleDetail(request,"11", Constants.AUTHORITY_THEM)){
                        %>
                        <a class="btn btn-success  btn-sm pull-right truong-image-bt" href="${addUrl}" style="width:120px;"></i>Thêm mới</a>
                        <%
                            }
                        %>--%>
                        <%
                            if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_THEM)) {
                                if (ValidationPool.checkRoleDetail(request, "30", Constants.AUTHORITY_THEM)) {
                        %>
                        <div class="btn-group pull-right" style="margin-top:0px;">
                            <button class="btn btn-success btn-sm btn-sm truong-image-bt dropdown-toggle"
                                    data-toggle="dropdown">Thêm mới<span class="caret"></span></button>
                            <ul class="dropdown-menu" style="margin-top:2px !important;">
                                <li><a href="${addUrl}"><i class="fa fa-plus"></i>Soạn mới</a></li>
                                <li><a href="${addBrowserFileUrl}"><i class="fa fa-plus"></i>Soạn từ file</a></li>
                            </ul>
                        </div>
                        <%
                        } else {
                        %>
                        <a class="btn btn-success  btn-sm pull-right truong-image-bt" href="${addUrl}"
                           style="width:120px;"></i>Thêm mới</a>
                        <%
                                }
                            }
                        %>

                    </ul>

                    <div class="tab-content">
                        <div id="hopdong" class="tab-pane fade in active">

                            <table class="table" style="margin-bottom:0%" ng-switch on="listContract.rowCount">

                                <tr class="border-table">
                                    <th class=" ann-title border-table table-giua ">STT</th>
                                    <th class=" ann-title border-table table-giua " style="width:80px;">Số <%=hopDong%></th>
                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                        Ngày <%=congchung%>
                                    </th>
                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                    <%--<c:if test="${SystemProperties.getProperty('org_type')!=1}">--%>
                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%></th>
                                    <%-- </c:if>--%>
                                    <%--<c:if test="${SystemProperties.getProperty('org_type')==1}">&lt;%&ndash; nếu là phường xã&ndash;%&gt;
                                        <th class=" ann-title border-table table-giua ">Người ký chứng thực</th>
                                    </c:if>--%>


                                </tr>
                                <tr ng-switch-when="0">
                                    <td colspan="7"
                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                        Không có dữ liệu
                                    </td>
                                </tr>
                                <tr ng-switch-default class="highlight-content"
                                    ng-repeat="item in listContract.items track by $index">
                                    <td class="border-table align-giua  ">
                                        {{(listContract.pageNumber-1)*listContract.numberPerPage + $index+1}}
                                    </td>
                                    <td class="border-table align-giua  "><a class="link_a"
                                                                             href="<%=request.getContextPath()%>/contract/detail/{{item.contract_id}}">{{item.contract_number}}</a>
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.notary_date}}
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.contract_name}}
                                    </td>

                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.relation_object | limitTo:200"></span>{{
                                        item.relation_object.length > 200 ? '...' : ''}}
                                        <a ng-if="item.relation_object.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.relation_object}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Bên liên quan'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.transaction_content | limitTo:200"></span>{{
                                        item.transaction_content.length > 200 ? '...' : ''}}
                                        <a ng-if="item.transaction_content.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.transaction_content}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Nội dung'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                        <%--<span ng-if="item.cancel_status" style="font-weight:700;"><br>Tình trạng: <span  style="color:#C00000;">{{item.cancel_description}}</span> </span>--%>
                                        <span ng-if="item.cancel_status || item.mortage_cancel_flag"
                                              style="font-weight:700;">
                                            <br>Tình trạng: <span ng-if="item.mortage_cancel_flag"
                                                                  style="color:#C00000;">Đã giải chấp <span
                                                ng-if="item.mortage_cancel_date.length>0">ngày {{item.mortage_cancel_date}} </span> <br></span>
                                            <span style="color:#C00000;">{{item.cancel_description}}</span>
                                        </span>
                                    </td>
                                    <td class="border-table align-giua"
                                        style="color: black;">{{item.notary_person}}
                                    </td>


                                </tr>

                                <tr ng-switch-default class="table-tr-xam">
                                    <th colspan="7">
                                        <div class="truong-padding-foot-table">Tổng số <span style="color: red;">{{listContract.rowCount}}</span>
                                            dữ liệu
                                        </div>
                                        <div class="align-phai">
                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                <li ng-if="listContract.pageNumber>1"><a ng-click="loadPageContract(1)">«</a>
                                                </li>
                                                <li ng-repeat="item in listContract.pageList">
                                                    <a ng-if="item==listContract.pageNumber"
                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                    <a ng-if="item!=listContract.pageNumber"
                                                       ng-click="loadPageContract(item)"> {{item}}</a>
                                                </li>
                                                <li ng-if="listContract.pageNumber<listContract.pageCount"><a
                                                        ng-click="loadPageContract(listContract.pageCount)">»</a></li>
                                            </ul>
                                        </div>
                                    </th>

                                </tr>

                            </table>
                        </div>


                        <div id="chuadongbo" class="tab-pane fade in ">

                            <table class="table" style="margin-bottom:0%" ng-switch on="listNotSynch.rowCount">

                                <tr class="border-table">
                                    <th class=" ann-title border-table table-giua " style="width:40px;">STT</th>
                                    <th class=" ann-title border-table table-giua " style="width:80px;">Số <%=hopDong%></th>
                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                        Ngày <%=congchung%>
                                    </th>
                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%></th>

                                </tr>

                                <tr ng-switch-when="0">
                                    <td colspan="7"
                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                        Không có dữ liệu
                                    </td>
                                </tr>


                                <tr ng-switch-default class="highlight-content"
                                    ng-repeat="item in listNotSynch.items track by $index">
                                    <td class="border-table align-giua  ">
                                        {{(listNotSynch.pageNumber-1)*listNotSynch.numberPerPage + $index+1}}
                                    </td>
                                    <td class="border-table align-giua  "><a class="link_a"
                                                                             href="<%=request.getContextPath()%>/contract/detail/{{item.contract_id}}">{{item.contract_number}}</a>
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.notary_date}}
                                    </td>

                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.contract_name}}
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.relation_object | limitTo:200"></span>{{
                                        item.relation_object.length > 200 ? '...' : ''}}
                                        <a ng-if="item.relation_object.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.relation_object}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Bên liên quan'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                    </td>

                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.transaction_content | limitTo:200"></span>{{
                                        item.transaction_content.length > 200 ? '...' : ''}}
                                        <a ng-if="item.transaction_content.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.transaction_content}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Nội dung'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                        <span ng-if="item.cancel_status || item.mortage_cancel_flag"
                                              style="font-weight:700;">
                                            <br>Tình trạng: <span ng-if="item.mortage_cancel_flag"
                                                                  style="color:#C00000;">Đã giải chấp <span
                                                ng-if="item.mortage_cancel_date.length>0">ngày {{item.mortage_cancel_date}} </span> <br></span>
                                            <span style="color:#C00000;">{{item.cancel_description}}</span>
                                        </span>
                                    </td>
                                    <td class="border-table align-giua"
                                        style="color: black;">{{item.notary_person}}
                                    </td>


                                </tr>

                                <tr ng-switch-default class="table-tr-xam">
                                    <th colspan="7">
                                        <div class="truong-padding-foot-table">Tổng số <span style="color: red;">{{listNotSynch.rowCount}}</span>
                                            dữ liệu
                                        </div>
                                        <div class="align-phai">
                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                <li ng-if="listContract.pageNumber>1"><a ng-click="loadPageNotSynch(1)">«</a>
                                                </li>
                                                <li ng-repeat="item in listNotSynch.pageList">
                                                    <a ng-if="item==listNotSynch.pageNumber"
                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                    <a ng-if="item!=listNotSynch.pageNumber"
                                                       ng-click="loadPageNotSynch(item)"> {{item}}</a>
                                                </li>
                                                <li ng-if="listNotSynch.pageNumber<listNotSynch.pageCount"><a
                                                        ng-click="loadPageNotSynch(listNotSynch.pageCount)">»</a></li>
                                            </ul>
                                        </div>
                                    </th>

                                </tr>

                            </table>
                        </div>
                        <!-- list hợp đồng lựu tạm ở bảng temporary cotnract -->
                        <div id="luutam" class="tab-pane fade in ">

                            <table class="table" style="margin-bottom:0%" ng-switch
                                   on="listContractOfflineTemporary.rowCount">

                                <tr class="border-table">
                                    <th class=" ann-title border-table table-giua " style="width:40px;">STT</th>
                                    <th class=" ann-title border-table table-giua " style="width:80px;">Số <%=hopDong%></th>
                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                        Ngày <%=congchung%>
                                    </th>
                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%></th>

                                </tr>

                                <tr ng-switch-when="0">
                                    <td colspan="7"
                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                        Không có dữ liệu
                                    </td>
                                </tr>


                                <tr class="highlight-content"
                                    ng-repeat="item in listContractOfflineTemporary.items track by $index">
                                    <td class="border-table align-giua  ">
                                        {{(listContractOfflineTemporary.pageNumber-1)*listContractOfflineTemporary.numberPerPage
                                        + $index+1}}
                                    </td>
                                    <td class="border-table align-giua  "><a class="link_a"
                                                                             href="<%=request.getContextPath()%>/contract/addContractOfflineTemporary/{{item.tcid}}">{{item.contract_number}}</a>
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.notary_date}}
                                    </td>

                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        {{item.contract_template_id}}
                                    </td>
                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.relation_object_a | limitTo:200"></span>{{
                                        item.relation_object_a.length > 200 ? '...' : ''}}
                                        <a ng-if="item.relation_object_a.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.relation_object_a}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Bên liên quan'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                    </td>

                                    <td class="border-table truong-text-verticel" style="color: black;">
                                        <span ng-bind-html="item.relation_object_b | limitTo:200"></span>{{
                                        item.relation_object_b.length > 200 ? '...' : ''}}
                                        <a ng-if="item.relation_object_b.length>200" data-trigger="click"
                                           data-toggle="popover" data-html="true" data-placement="top"
                                           data-content=" {{item.relation_object_b}}" title=""
                                           data-original-title='<button type="button" class="close pull-right" data-dismiss="popover" >&times;</button>Nội dung'><img
                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>

                                    </td>

                                    <c:if test="${SystemProperties.getProperty('org_type')!=1}"> <%--Nếu k phải là phường xã--%>
                                        <td class="border-table align-giua"
                                            style="color: black;">{{item.notary_id}}
                                        </td>
                                    </c:if>
                                    <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--Nếu là phường xã--%>
                                        <td class="border-table align-giua"
                                            style="color: black;">{{item.contract_signer}}
                                        </td>
                                    </c:if>


                                </tr>

                                <tr ng-switch-default class="table-tr-xam">
                                    <th colspan="7">
                                        <div class="truong-padding-foot-table">Tổng số <span style="color: red;">{{listContractOfflineTemporary.rowCount}}</span>
                                            dữ liệu
                                        </div>
                                        <div class="align-phai">
                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                <li ng-if="listContractOfflineTemporary.pageNumber>1"><a
                                                        ng-click="loadPageContractOfflineTemporary(1)">«</a></li>
                                                <li ng-repeat="item in listContractOfflineTemporary.pageList">
                                                    <a ng-if="item==listContractOfflineTemporary.pageNumber"
                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                    <a ng-if="item!=listContractOfflineTemporary.pageNumber"
                                                       ng-click="loadPageContractOfflineTemporary(item)"> {{item}}</a>
                                                </li>
                                                <li ng-if="listContractOfflineTemporary.pageNumber<listContractOfflineTemporary.pageCount">
                                                    <a ng-click="loadPageContractOfflineTemporary(listContractOfflineTemporary.pageCount)">»</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </th>

                                </tr>

                            </table>
                        </div>

                    </div>
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
                        <p>Điều kiện tìm kiếm phải đảm bảo Định dạng tìm kiếm theo thời gian phải là: dd/MM/yyyy! </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>


<script>
    /*$(document).ready(function(){
        $("[data-toggle=popover]").popover();
        //load menu
//        var parentItem = $("#quan-ly-hop-dong");
//        $(parentItem).click();
//        $("#ds-hd-cong-chung").addClass("child-menu");

    });*/
    $('body').on('click', function (e) {
        //did not click a popover toggle, or icon in popover toggle, or popover
        if ($(e.target).data('toggle') !== 'popover'
            && $(e.target).parents('[data-toggle="popover"]').length === 0
            && $(e.target).parents('.popover.in').length === 0) {
            $('[data-toggle="popover"]').popover('hide');
        }
    });
    $(function () {
        $('#fromDate').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#toDate').datepicker({
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
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<script>
    $(document).ready(function () {
        /*        if(org_type==1)
                $("#ds-hd-cong-chung").text($("#ds-hd-cong-chung").text().replace('công chứng', 'chứng thực'));*/
        //load menu
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#ds-hd-cong-chung").addClass("child-menu");

    });
</script>