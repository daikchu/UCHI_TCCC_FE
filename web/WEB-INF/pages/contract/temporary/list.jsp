<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>

<spring:url value="/contract/temporary/list" var="listUrl"/>
<spring:url value="/contract/temporary/add" var="addUrl"/>
<spring:url value="/contract/temporary/detail" var="viewDetail"/>
<spring:url value="/contract/temporary/addBrowserFile" var="addBrowserFileUrl"/>

<script type="text/javascript">
    var userEntryId =<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
    var org_type =<%=SystemProperties.getProperty("org_type")%>;
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var users = '${userList.userList}';
    $("#uchi-status").show();
    setTimeout(function () {
        $("#uchi-status").hide();
    }, 3000);
</script>

<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String congchungHOA = checkcongchung.equals("1") ? "CHỨNG THỰC" : "CÔNG CHỨNG";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
    String nguoiCongChungName = checkcongchung.equals("1") ? "Người ký chứng thực" : "Công chứng viên";
%>

<script src="<%=request.getContextPath()%>/static/js/contract/temporary/list.js" type="text/javascript"></script>
<style>
    .panel-heading a:after {
        background-image: none;
    }

    .nav-tabs.nav-justified > .active {
        border-top: 3px solid #2ca9e0;
    }

    .panel {
        webkit-box-shadow: none;
        box-shadow: none;
    }

    .popover-content {
        height: 200px;
        overflow-y: auto;
    }

</style>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Quản lý hợp đồng online </span>
</div>
<div class="truong-form-chinhpq" ng-app="osp" ng-controller="contractListController">

    <div id="uchi-status">
        <c:if test="${status==0}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png">Chuyển CCV ký
                hợp đồng thành công!
            </div>
        </c:if>
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
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Sửa hợp đồng
                thành công!
            </div>
        </c:if>
        <c:if test="${status==4}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Hủy hợp đồng
                thành công!
            </div>
        </c:if>
        <c:if test="${status==5}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Đóng dấu hợp
                đồng thành công!
            </div>
        </c:if>
        <c:if test="${status==6}">
            <div class="status-success"><img class="status-img"
                                             src="<%=request.getContextPath()%>/static/image/success.png"> Hợp đồng trả
                về thành công!
            </div>
        </c:if>

    </div>

    <div class="panel-group">
        <form class="form-horizontal" id="search-frm" name="myForm">
            <%
                if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_TIMKIEM)) {
            %>
            <div class="form-group">
                <div class="form-group col-md-12" style="margin-bottom: 0px;">
                    <section class="panel panel-default" style="margin-left:20px;border:none!important;">
                        <div class="panel-body">
                            <div class="bs-example form-horizontal">

                                <div>
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
                                               my-enter="searchAdvance()" id="search_contract_number">
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
                                                   required>
                                            <span class="truong-text-colorred" ng-bind-html="fromDateError"></span>
                                        </div>
                                        <div class="col-md-3">
                                            Đến ngày
                                            <input type="text" class="form-control" name="toDate"
                                                   ng-model="search.toTime" id="toDate" minlength="10"
                                                   onkeypress="return restrictCharacters(this, event, forDate);"
                                                   required>
                                            <span class="truong-text-colorred" ng-bind-html="toDateError"></span>
                                        </div>
                                    </div>

                                    <div class="col-md-12 form-group " style="margin-top:20px;text-align: center;">
                                        <a class="btn btn-success btn-sm" ng-click="searchAdvance()"
                                           style="width:120px;">Tìm kiếm</a>
                                        <a class="btn btn-sm huybo " ng-click="clearCondition()"
                                           style="width:120px;margin-left:10px;">Xóa điều kiện</a>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>

            <%--<%
                }
                if(ValidationPool.checkRoleDetail(request,"14", Constants.AUTHORITY_THEM)){
            %>
            <div class="col-md-12">
                <div class="btn-group pull-right" style="margin-top:0px;">
                    <a href="${addUrl}" class="btn btn-success btn-sm pull-right truong-image-bt dropdown-toggle" style="width:120px;">Thêm mới</a>
                </div>
            </div>

            <%
                }
            %>--%>
            <%--<%
                }
                if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_THEM)) {
                    if (ValidationPool.checkRoleDetail(request, "31", Constants.AUTHORITY_THEM)) {
            %>
            <div class="col-md-12">
                <div class="btn-group pull-right" style="margin-top:0px;">
                    <button class="btn btn-success btn-sm btn-sm pull-right truong-image-bt dropdown-toggle"
                            data-toggle="dropdown">Thêm mới<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <li><a href="${addUrl}"><i class="fa fa-plus"></i>Soạn mới</a></li>
                        <li><a href="${addBrowserFileUrl}"><i class="fa fa-plus"></i>Soạn từ file</a></li>
                    </ul>
                </div>
            </div>
            <%
            } else {
            %>
            <a href="${addUrl}" class="btn btn-success btn-sm pull-right truong-image-bt dropdown-toggle"
               style="width:120px;">Thêm mới</a>
            <%
                    }
                }
            %>--%>

                <div class="col-md-12 truong-margin-footer0px">
                    <section class="panel-group">

                        <%--<header class="panel-heading bg-light">--%>
                            <%--<ul class="nav nav-tabs nav-justified" style="border-bottom:2px solid #ddd;">
                                <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                    <li class="active" ng-click="whenClickTabChoKy()"
                                        style="text-align: center; border-left: 1px solid #ddd; "><a href="#choky"
                                                                                                     data-toggle="tab">Hợp
                                        đồng chờ ký (<span
                                                class="truong-text-colorred">{{listChoKy.rowCount}}</span>)</a>
                                    </li>
                                    <li ng-click="whenClickTabDaKy()"><a href="#daky" data-toggle="tab"
                                                                         style="text-align: center; border-left: 1px solid #ddd;">Hợp
                                        đồng đã ký (<span class="truong-text-colorred">{{listDaKy.rowCount}}</span>)</a>
                                    </li>
                                    <li ng-click="whenClickTabDongDau()"><a href="#dongdau" data-toggle="tab"
                                                                            style="text-align: center; border-left: 1px solid #ddd;">Hợp
                                        đồng đã đóng dấu (<span
                                                class="truong-text-colorred">{{listDongDau.rowCount}}</span>)</a>
                                    </li>
                                </c:if>
                                <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                    <li class="active" ng-click="whenClickTabDongDau()"><a href="#dongdau"
                                                                                           data-toggle="tab"
                                                                                           style="text-align: center; border-left: 1px solid #ddd;">Hợp
                                        đồng đã đóng dấu (<span
                                                class="truong-text-colorred">{{listDongDau.rowCount}}</span>)</a>
                                    </li>
                                </c:if>
                                <li ng-click="whenClickTabChinhSua()"><a href="#chinhsua" data-toggle="tab"
                                                                         style="text-align: center; border-left: 1px solid #ddd; ">Hợp
                                    đồng lưu tạm (<span
                                            class="truong-text-colorred">{{listChinhSua.rowCount}}</span>)</a></li>
                                <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                    <li ng-click="whenClickTabTraVe()"><a href="#trave" data-toggle="tab"
                                                                          style="text-align: center; border-left: 1px solid #ddd; ">Hợp
                                        đồng bị trả về (<span
                                                class="truong-text-colorred">{{listTraVe.rowCount}}</span>)</a></li>
                                </c:if>
                            </ul>--%>

                        <%--</header>--%>

                            <ul class="nav nav-tabs">
                                <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                    <li class="active" ng-click="whenClickTabChoKy()"><a data-toggle="tab"  href="#choky">Hợp
                                        đồng chờ ký
                                        (<span class="truong-text-colorred">{{listChoKy.rowCount}}</span>)</a></li>
                                    <li ng-click="whenClickTabDaKy()"><a data-toggle="tab" href="#daky">Hợp
                                        đồng đã ký
                                        (<span class="truong-text-colorred">{{listDaKy.rowCount}}</span>)</a></li>
                                    <li ng-click="whenClickTabDongDau()"><a data-toggle="tab" href="#dongdau">Hợp
                                        đồng đã đóng dấu
                                        (<span class="truong-text-colorred">{{listDongDau.rowCount}}</span>)</a></li>

                                </c:if>
                                <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                    <li class="active" ng-click="whenClickTabDongDau()"><a data-toggle="tab"  href="#dongdau">Hợp
                                        đồng đã đóng dấu
                                        (<span class="truong-text-colorred">{{listDongDau.rowCount}}</span>)</a></li>
                                </c:if>
                                <li ng-click="whenClickTabChinhSua()"><a data-toggle="tab" href="#chinhsua">Hợp
                                    đồng lưu tạm
                                    (<span class="truong-text-colorred">{{listChinhSua.rowCount}}</span>)</a></li>

                                <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                    <li ng-click="whenClickTabTraVe()"><a data-toggle="tab" href="#trave">Hợp
                                        đồng bị trả về
                                        (<span class="truong-text-colorred">{{listTraVe.rowCount}}</span>)</a></li>
                                </c:if>
                                <%--<%
                                    }
                                %>
--%>
                                <%
                                    }
                                    if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_THEM)) {
                                        if (ValidationPool.checkRoleDetail(request, "31", Constants.AUTHORITY_THEM)) {
                                %>

                                <li id="prevent-them-moi" >

                                    <div class="btn-group pull-right" style="margin-top:0px;">
                                        <button class="btn btn-success btn-sm btn-sm pull-right truong-image-bt dropdown-toggle"
                                                data-toggle="dropdown">Thêm mới<span class="caret"></span></button>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a style="padding: 5px" href="${addUrl}"><i class="fa fa-plus"></i>Soạn mới</a></li>
                                            <li><a style="padding: 5px" href="${addBrowserFileUrl}"><i class="fa fa-plus"></i>Soạn từ file</a></li>
                                        </ul>
                                    </div>
                                </li>
                                <%
                                } else {
                                %>
                                <li id="prevent-them-moi">
                                    <a href="${addUrl}" class="btn btn-success btn-sm pull-right truong-image-bt dropdown-toggle"
                                       style="width:120px;">Thêm mới</a>
                                </li>
                                <%
                                        }
                                    }
                                %>

                                <%--<%
                                    if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_THEM)) {
                                %>
                                    <a href="${addUrl}" class="btn btn-success btn-sm pull-right truong-image-bt dropdown-toggle"
                                       style="width:120px;">Thêm mới</a>
                                <%
                                    }
                                %>--%>
                            </ul>

                        <%--<div class="panel-body" style="padding: 0px;">--%>
                            <div class="tab-content">
                                <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                <div class="tab-pane active" id="choky"> </c:if>
                                    <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                    <div class="tab-pane" id="choky">
                                        </c:if>

                                        <table class="table" style="margin-bottom:0%" ng-switch on="listChoKy.rowCount">

                                            <tr class="border-table">
                                                <th class=" ann-title border-table table-giua " style="width:40px;">
                                                    STT
                                                </th>
                                                <th class=" ann-title border-table table-giua " style="width:80px;">Số <%=hopDong%>
                                                </th>
                                                <th class=" ann-title border-table table-giua" style="width:80px;">Ngày <%=congchung%>
                                                </th>
                                                <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                                <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                                <th class=" ann-title border-table table-giua">Nội dung</th>
                                                <%--<c:if test="${SystemProperties.getProperty('org_type')!=1}">--%>
                                                <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%>
                                                </th>
                                                <%--</c:if>
                                                <c:if test="${SystemProperties.getProperty('org_type')==1}">&lt;%&ndash; nếu là phường xã&ndash;%&gt;
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
                                                ng-repeat="item in listChoKy.items track by $index"
                                                style="height:50px!important;">
                                                <td class="border-table align-giua  " style="width:20px!important;">
                                                    {{(listChoKy.pageNumber-1)*listChoKy.numberPerPage + $index+1}}
                                                </td>
                                                <%--<td class="border-table align-giua  " style="width:20px!important;">{{listChoKy.numberPerPage*(listChoKy.pageNumber-1)+ $index+1}}</td>--%>
                                                <td class="border-table align-giua  breakAll"><a class="link_a"
                                                                                                 href="<%=request.getContextPath()%>/contract/temporary/detail/{{item.tcid}}">{{item.contract_number}}</a>
                                                </td>
                                                <td class="border-table truong-text-verticel"
                                                    style="color: black; text-align: center">
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
                                                       data-original-title='Bên liên quan'><img
                                                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                </td>

                                                <td class="border-table truong-text-verticel" style="color: black;">
                                                    <span ng-bind-html="item.summary | limitTo:200"></span>{{
                                                    item.summary.length > 200 ? '...' : ''}}
                                                    <%--<span ng-bind-html="item.relation_object_b  | limitTo:80"></span>{{ item.summary.length > 80 ? '...' : ''}}--%>
                                                    <a ng-if="item.summary.length>200" data-trigger="click"
                                                       data-toggle="popover" data-html="true" data-placement="top"
                                                       data-content=" {{item.summary}}" title=""
                                                       data-original-title='Nội dung'><img
                                                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                </td>
                                                <td class="border-table align-giua"
                                                    style="color: black;">{{item.notary_id}}
                                                </td>


                                            </tr>

                                            <tr ng-switch-default class="table-tr-xam">
                                                <th colspan="7">
                                                    <div class="truong-padding-foot-table">Tổng số <span
                                                            style="color: red;">{{listChoKy.rowCount}}</span> dữ liệu
                                                    </div>
                                                    <div class="align-phai">
                                                        <ul class="pagination pagination-sm m-t-none m-b-none">
                                                            <li ng-if="listChoKy.pageNumber>1"><a
                                                                    ng-click="loadPageChoKy(1)">«</a></li>
                                                            <li ng-repeat="item in listChoKy.pageList">
                                                                <a ng-if="item==listChoKy.pageNumber"
                                                                   style="color:mediumvioletred;"> {{item}}</a>
                                                                <a ng-if="item!=listChoKy.pageNumber"
                                                                   ng-click="loadPageChoKy(item)"> {{item}}</a>
                                                            </li>
                                                            <li ng-if="listChoKy.pageNumber<listChoKy.pageCount"><a
                                                                    ng-click="loadPageChoKy(listChoKy.pageCount)">»</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </th>

                                            </tr>

                                        </table>
                                    </div>
                                    <div class="tab-pane" id="daky">
                                        <table class="table" style="margin-bottom:0%" ng-switch on="listDaKy.rowCount">

                                            <tr class="border-table">
                                                <th class=" ann-title border-table table-giua " style="width:40px;">
                                                    STT
                                                </th>
                                                <th class=" ann-title border-table table-giua " style="width:80px;">Số <%=hopDong%>
                                                </th>
                                                <th class=" ann-title border-table table-giua" style="width:80px;">Ngày <%=congchung%>
                                                </th>
                                                <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                                <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                                <th class=" ann-title border-table table-giua">Nội dung</th>
                                                <%--<c:if test="${SystemProperties.getProperty('org_type')!=1}">--%>
                                                <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%>
                                                </th>
                                                <%--</c:if>
                                                <c:if test="${SystemProperties.getProperty('org_type')==1}">&lt;%&ndash; nếu là phường xã&ndash;%&gt;
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
                                                ng-repeat="item in listDaKy.items track by $index">
                                                <td class="border-table align-giua  ">
                                                    {{(listDaKy.pageNumber-1)*listDaKy.numberPerPage + $index+1}}
                                                </td>
                                                <td class="border-table align-giua  "><a class="link_a"
                                                                                         href="<%=request.getContextPath()%>/contract/temporary/detailMark/{{item.tcid}}">{{item.contract_number}}</a>
                                                </td>
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
                                                    <%--{{ item.relation_object_a | limitTo: 100}}{{ item.relation_object_a.length > 100 ? '...' : ''}}--%>
                                                    <a ng-if="item.relation_object_a.length>200" data-trigger="click"
                                                       data-toggle="popover" data-html="true" data-placement="top"
                                                       data-content=" {{item.relation_object_a}}" title=""
                                                       data-original-title='Bên liên quan'><img
                                                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                </td>

                                                <td class="border-table truong-text-verticel" style="color: black;">
                                                    <span ng-bind-html="item.summary | limitTo:200"></span>{{
                                                    item.summary.length > 200 ? '...' : ''}}
                                                    <%--{{ item.summary | limitTo: 100}}{{ item.summary.length > 100 ? '...' : ''}}--%>
                                                    <a ng-if="item.summary.length>200" data-trigger="click"
                                                       data-toggle="popover" data-html="true" data-placement="top"
                                                       data-content=" {{item.summary}}" title=""
                                                       data-original-title='Nội dung'><img
                                                            src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>

                                                </td>
                                                <td class="border-table align-giua"
                                                    style="color: black;">{{item.notary_id}}
                                                </td>


                                            </tr>

                                            <tr ng-switch-default class="table-tr-xam">
                                                <th colspan="7">
                                                    <div class="truong-padding-foot-table">Tổng số <span
                                                            style="color: red;">{{listDaKy.rowCount}}</span> dữ liệu
                                                    </div>
                                                    <div class="align-phai">
                                                        <ul class="pagination pagination-sm m-t-none m-b-none">
                                                            <li ng-if="listDaKy.pageNumber>1"><a
                                                                    ng-click="loadPageDaKy(1)">«</a>
                                                            </li>
                                                            <li ng-repeat="item in listDaKy.pageList">
                                                                <a ng-if="item==listDaKy.pageNumber"
                                                                   style="color:mediumvioletred;"> {{item}}</a>
                                                                <a ng-if="item!=listDaKy.pageNumber"
                                                                   ng-click="loadPageDaKy(item)"> {{item}}</a>
                                                            </li>
                                                            <li ng-if="listDaKy.pageNumber<listDaKy.pageCount"><a
                                                                    ng-click="loadPageDaKy(listDaKy.pageCount)">»</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </th>

                                            </tr>

                                        </table>
                                    </div>
                                    <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                    <div class="tab-pane" id="dongdau"> </c:if>
                                        <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                        <div class="tab-pane active" id="dongdau">
                                            </c:if>

                                            <table class="table" style="margin-bottom:0%" ng-switch
                                                   on="listDongDau.rowCount">
                                                <tr class="border-table">
                                                    <th class=" ann-title border-table table-giua " style="width:40px;">
                                                        STT
                                                    </th>
                                                    <th class=" ann-title border-table table-giua " style="width:80px;">
                                                        Số <%=hopDong%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                                        Ngày <%=congchung%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%>
                                                    </th>

                                                </tr>
                                                <tr ng-switch-when="0">
                                                    <td colspan="7"
                                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                                        Không có dữ liệu
                                                    </td>
                                                </tr>
                                                <tr ng-switch-default class="highlight-content"
                                                    ng-repeat="item in listDongDau.items track by $index">
                                                    <td class="border-table align-giua  ">
                                                        {{(listDongDau.pageNumber-1)*listDongDau.numberPerPage +
                                                        $index+1}}
                                                    </td>
                                                    <td class="border-table align-giua  "><a class="link_a"
                                                                                             href="<%=request.getContextPath()%>/contract/detail/{{item.contract_id}}?from=1">{{item.contract_number}}</a>
                                                    </td>
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
                                                        <%--{{ item.relation_object | limitTo: 100}}{{ item.relation_object.length > 100 ? '...' : ''}}--%>
                                                        <a ng-if="item.relation_object.length>200" data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.relation_object}}" title=""
                                                           data-original-title='Bên liên quan'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                    </td>
                                                    <td class="border-table truong-text-verticel" style="color: black;">
                                                        <span ng-bind-html="item.transaction_content | limitTo:200"></span>{{
                                                        item.transaction_content.length > 200 ? '...' : ''}}
                                                        <a ng-if="item.transaction_content.length>200"
                                                           data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.transaction_content}}" title=""
                                                           data-original-title='Nội dung'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                        <span ng-if="item.cancel_status || item.mortage_cancel_flag"
                                                              style="font-weight:700;">
                                                    <br>Tình trạng: <span ng-if="item.mortage_cancel_flag"
                                                                          style="color:#C00000;">Đã giải chấp <span
                                                                ng-if="item.mortage_cancel_date.length>0">ngày {{item.mortage_cancel_date}} </span> <br></span>
                                                    <span style="color:#C00000;">{{item.cancel_description}}</span>
                                                </span>
                                                    </td>
                                                    <td class="border-table align-giua" style="color: black;">
                                                        {{item.notary_person}}
                                                    </td>

                                                </tr>

                                                <tr ng-switch-default class="table-tr-xam">
                                                    <th colspan="7">
                                                        <div class="truong-padding-foot-table">Tổng số <span
                                                                style="color: red;">{{listDongDau.rowCount}}</span> dữ
                                                            liệu
                                                        </div>
                                                        <div class="align-phai">
                                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                                <li ng-if="listDongDau.pageNumber>1"><a
                                                                        ng-click="loadPageDongDau(1)">«</a></li>
                                                                <li ng-repeat="item in listDongDau.pageList">
                                                                    <a ng-if="item==listDongDau.pageNumber"
                                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                                    <a ng-if="item!=listDongDau.pageNumber"
                                                                       ng-click="loadPageDongDau(item)"> {{item}}</a>
                                                                </li>
                                                                <li ng-if="listDongDau.pageNumber<listDongDau.pageCount">
                                                                    <a
                                                                            ng-click="loadPageDongDau(listDongDau.pageCount)">»</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </th>

                                                </tr>

                                            </table>
                                        </div>
                                        <div class="tab-pane" id="chinhsua">
                                            <table class="table" style="margin-bottom:0%" ng-switch
                                                   on="listChinhSua.rowCount">

                                                <tr class="border-table">
                                                    <th class=" ann-title border-table table-giua " style="width:40px;">
                                                        STT
                                                    </th>
                                                    <th class=" ann-title border-table table-giua " style="width:80px;">
                                                        Số <%=hopDong%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                                        Ngày <%=congchung%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%>
                                                    </th>
                                                </tr>

                                                <tr ng-switch-when="0">
                                                    <td colspan="7"
                                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                                        Không có dữ liệu
                                                    </td>
                                                </tr>


                                                <tr ng-switch-default class="highlight-content"
                                                    ng-repeat="item in listChinhSua.items track by $index">
                                                    <td class="border-table align-giua  ">{{
                                                        (listChinhSua.pageNumber-1)*listChinhSua.numberPerPage +
                                                        $index+1}}
                                                    </td>
                                                    <td class="border-table align-giua  "><a class="link_a"
                                                                                             href="<%=request.getContextPath()%>/contract/temporary/edit/{{item.tcid}}">{{item.contract_number}}</a>
                                                    </td>
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
                                                        <%--{{ item.relation_object_a | limitTo: 100}}{{ item.relation_object_a.length > 100 ? '...' : ''}}--%>
                                                        <a ng-if="item.relation_object_a.length>200"
                                                           data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.relation_object_a}}" title=""
                                                           data-original-title='Bên liên quan'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                    </td>

                                                    <td class="border-table truong-text-verticel" style="color: black;">
                                                        <span ng-bind-html="item.summary | limitTo:200"></span>{{
                                                        item.summary.length > 200 ? '...' : ''}}
                                                        <%--{{ item.summary | limitTo: 100}}{{ item.summary.length > 100 ? '...' : ''}}--%>
                                                        <a ng-if="item.summary.length>200" data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.summary}}" title=""
                                                           data-original-title='Nội dung'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>

                                                    </td>
                                                    <td class="border-table align-giua"
                                                        style="color: black;">{{item.notary_id}}
                                                    </td>


                                                </tr>

                                                <tr ng-switch-default class="table-tr-xam">
                                                    <th colspan="7">
                                                        <div class="truong-padding-foot-table">Tổng số <span
                                                                style="color: red;">{{listChinhSua.rowCount}}</span> dữ
                                                            liệu
                                                        </div>
                                                        <div class="align-phai">
                                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                                <li ng-if="listChinhSua.pageNumber>1"><a
                                                                        ng-click="loadPageChinhSua(1)">«</a></li>
                                                                <li ng-repeat="item in listChinhSua.pageList">
                                                                    <a ng-if="item==listChinhSua.pageNumber"
                                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                                    <a ng-if="item!=listChinhSua.pageNumber"
                                                                       ng-click="loadPageChinhSua(item)"> {{item}}</a>
                                                                </li>
                                                                <li ng-if="listChinhSua.pageNumber<listChinhSua.pageCount">
                                                                    <a
                                                                            ng-click="loadPageChinhSua(listChinhSua.pageCount)">»</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </th>

                                                </tr>

                                            </table>
                                        </div>
                                        <div class="tab-pane" id="trave">
                                            <table class="table" style="margin-bottom:0%" ng-switch
                                                   on="listTraVe.rowCount">

                                                <tr class="border-table">
                                                    <th class=" ann-title border-table table-giua " style="width:40px;">
                                                        #
                                                    </th>
                                                    <th class=" ann-title border-table table-giua " style="width:80px;">
                                                        Số <%=hopDong%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua" style="width:80px;">
                                                        Ngày <%=congchung%>
                                                    </th>
                                                    <th class=" ann-title border-table table-giua ">Tên hợp đồng</th>
                                                    <th class=" ann-title border-table table-giua ">Bên liên quan</th>
                                                    <th class=" ann-title border-table table-giua">Nội dung</th>
                                                    <th class=" ann-title border-table table-giua "><%=nguoiCongChungName%>
                                                    </th>
                                                </tr>

                                                <tr ng-switch-when="0">
                                                    <td colspan="7"
                                                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 250%">
                                                        Không có dữ liệu
                                                    </td>
                                                </tr>


                                                <tr ng-switch-default class="highlight-content"
                                                    ng-repeat="item in listTraVe.items track by $index">
                                                    <td class="border-table align-giua  ">
                                                        {{(listTraVe.pageNumber-1)*listTraVe.numberPerPage + $index+1}}
                                                    </td>
                                                    <td class="border-table align-giua  "><a class="link_a"
                                                                                             href="<%=request.getContextPath()%>/contract/temporary/edit/{{item.tcid}}">{{item.contract_number}}</a>
                                                    </td>
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
                                                        <%--{{ item.relation_object_a | limitTo: 100}}{{ item.relation_object_a.length > 100 ? '...' : ''}}--%>
                                                        <a ng-if="item.relation_object_a.length>200"
                                                           data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.relation_object_a}}" title=""
                                                           data-original-title='Bên liên quan'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>
                                                    </td>

                                                    <td class="border-table truong-text-verticel" style="color: black;">
                                                        <span ng-bind-html="item.summary | limitTo:200"></span>{{
                                                        item.summary.length > 200 ? '...' : ''}}
                                                        <%--{{ item.summary | limitTo: 100}}{{ item.summary.length > 100 ? '...' : ''}}--%>
                                                        <a ng-if="item.summary.length>200" data-trigger="click"
                                                           data-toggle="popover" data-html="true" data-placement="top"
                                                           data-content=" {{item.summary}}" title=""
                                                           data-original-title='Nội dung'><img
                                                                src="<%=request.getContextPath()%>/static/image/xemthem.png"/></a>

                                                    </td>
                                                    <td class="border-table align-giua"
                                                        style="color: black;">{{item.notary_id}}
                                                    </td>


                                                </tr>

                                                <tr ng-switch-default class="table-tr-xam">
                                                    <th colspan="7">
                                                        <div class="truong-padding-foot-table">Tổng số <span
                                                                style="color: red;">{{listTraVe.rowCount}}</span> dữ
                                                            liệu
                                                        </div>
                                                        <div class="align-phai">
                                                            <ul class="pagination pagination-sm m-t-none m-b-none">
                                                                <li ng-if="listTraVe.pageNumber>1"><a
                                                                        ng-click="loadPageTraVe(1)">«</a></li>
                                                                <li ng-repeat="item in listTraVe.pageList">
                                                                    <a ng-if="item==listTraVe.pageNumber"
                                                                       style="color:mediumvioletred;"> {{item}}</a>
                                                                    <a ng-if="item!=listTraVe.pageNumber"
                                                                       ng-click="loadPageTraVe(item)"> {{item}}</a>
                                                                </li>
                                                                <li ng-if="listTraVe.pageNumber<listTraVe.pageCount"><a
                                                                        ng-click="loadPageTraVe(listTraVe.pageCount)">»</a>
                                                                </li>
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
           <%-- </div>--%>


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
                        <p>Định dạng tìm kiếm theo thời gian phải là: dd/MM/yyyy! </p>
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
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#ds-hd-online").addClass("child-menu");
    });
</script>