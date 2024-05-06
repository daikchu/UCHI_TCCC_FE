<%--
  Created by IntelliJ IDEA.
  User: quang
  Date: 10/9/2023
  Time: 12:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />

<spring:url value="/xac-thuc-danh-tinh/them-moi" var="addUrl" />
<spring:url value="/xac-thuc-danh-tinh/danh-sach" var="listUrl" />
<spring:url value="/xac-thuc-danh-tinh/chinh-sua" var="updateUrl"/>
<spring:url value="/xac-thuc-danh-tinh/xuat-file-excel" var="exportExcelUrl"/>

<script src="<%=request.getContextPath()%>/static/angularjs/angular.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/angularjs/angular-sanitize.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/citizenVerification/citizenVerificationList.js?v=20231107" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/citizenVerify/citizen-verification.css?v=20231107">
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách lượt xác thực danh tính</span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="citizenVerificationController">

    <c:if test="${getMessage != null}">
        <div style="display: none" class="padding-default notifyMessage">
            <div class="status-error">
                <img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">
                    ${getMessage}
            </div>
        </div>
    </c:if>

    <c:if test="${deleteStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Xóa thành công </div>
        </div>
    </c:if>
    <c:if test="${deleteStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Xóa thất bại </div>
        </div>
    </c:if>
    <c:if test="${addStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Thêm mới thành công </div>
        </div>
    </c:if>
    <c:if test="${addStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Thêm mới thất bại </div>
        </div>
    </c:if>
    <c:if test="${updateStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Cập nhật thành công </div>
        </div>
    </c:if>
    <c:if test="${updateStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Cập nhật thất bại </div>
        </div>
    </c:if>


    <form id="search-frm" class="form-horizontal" action="${listUrl}" method="get">
        <div>
            <input type="hidden" name="page" id="page" value="${dataWrapper.page}">
            <input type="hidden" name="totalPage" id="totalPage" value="${dataWrapper.totalPage}">
            <input type="hidden" name="verify_status" id="search_verify_status" value="${dataWrapper.verify_status}">
        </div>

        <div class="panel-body">
            <div class="row form-group">
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Mã xác thực</label>
                    <input type="text" class="form-control" name="verify_id" id="verify_id"
                           placeholder="Tìm mã xác thực"
                           value="${dataWrapper.verify_id}">
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Mã đơn hàng</label>
                    <input type="text" class="form-control" name="order_id" id="order_id"
                           placeholder="Tìm mã đơn hàng"
                           value="${dataWrapper.order_id}">
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Trạng thái xác thực</label>
                    <select id="verify_status" ng-model="searchCondition.verify_status"
                            class="form-control truong-selectbox-padding" placeholder="Lựa chọn 123">
                        <option class="placeholder" value="">--Lựa chọn--</option>
                        <option value="success">Thành công</option>
                        <option value="fail">Thất bại</option>
                    </select>
                </div>


                <%--<div class="form-group">
                    &lt;%&ndash;Tìm kiếm theo Tên tổ chức công chứng&ndash;%&gt;
                    <label class="col-md-2 control-label label-bam-trai"> Tên tổ chức </label>
                    <div class="col-md-3 replace">
                        <input type="text" class="form-control" name="nameFilter" id="nameFilter"
                               value="${customerListWrapper.nameFilter}">
                    </div>
                </div>--%>
            </div>
            <div class="row form-group">
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Công dân được xác thực</label>
                    <input type="text" class="form-control" name="citizen_verify_fullname" id="citizen_verify_fullname"
                           value="${dataWrapper.citizen_verify_fullname}" placeholder="Tìm họ và tên">
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Số CCCD được xác thực</label>
                    <input type="text" class="form-control" name="citizen_verify_cccd" id="citizen_verify_cccd"
                           value="${dataWrapper.citizen_verify_cccd}" placeholder="Tìm CCCD">
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Cán bộ thực hiện</label>
                    <select class="form-control select2" name="verify_by" id="verify_by">
                        <option value="">---Lựa chọn---</option>
                        <c:forEach items="${dataWrapper.users}" var="item">
                            <option value="${item.account}" ${dataWrapper.verify_by == item.account?"selected":""}>${item.family_name} ${item.first_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-8">
                    <label class="control-label label-bam-trai">Thời gian xác thực</label>
                    <div class="row">
                        <div class="col-md-6">

                            <input type="text" value="${dataWrapper.verify_date_from}"
                                   class="form-control date-time" name="verify_date_from"
                                   id="verify_date_from" placeholder="Từ ngày"
                                   onblur="checkDateFormat(this.value, 'verify_date_from')">
                            <div style="margin-top: 5px;color: red;">{{searchConditionMessage.verify_date_from}}</div>
                        </div>
                        <div class="col-md-6">
                            <input type="text" value="${dataWrapper.verify_date_to}"
                                   class="form-control date-time" name="verify_date_to"
                                   id="verify_date_to" placeholder="Đến ngày"
                                   onblur="checkDateFormat(this.value, 'verify_date_to')">
                            <div style="margin-top: 5px;color: red;">{{searchConditionMessage.verify_date_to}}</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" style="padding-top: 23px">
                    <label class="control-label label-bam-trai"></label>
                    <div class="col-md-6 clear-padding">
                        <input type="button" ng-click="onSearch()" class="form-control luu" name="" value="Tìm kiếm">
                    </div>
                    <div class="col-md-6 clear-padding" style="padding-right: 0px">
                        <input type="button" ng-click="clearSearchCondition()" class="form-control huybo" name="" value="Xóa điều kiện" onclick="clearText()">
                    </div>
                </div>
            </div>


        </div>

        <div class="col-md-12 truong-margin-footer0px">
            <div class="truong-re-bt col-md-12 export-button truong-image-fix">
                <a class="truong-small-linkbt"> <input ng-click="export()" type="button" class="form-control luu truong-image-bt "  name="" value="Xuất Excel" ></a>

            </div>
            <table class="table" style="margin-bottom:0%" >

                <tr class="border-table">
                    <th class="ann-title border-table table-giua" style="width: 50px !important;">Thời gian xác thực</th>
                    <th class=" ann-title border-table table-giua">Mã xác thực</th>
                    <th class=" ann-title border-table table-giua">Công dân được xác thực</th>
                    <th class=" ann-title border-table table-giua">Cán bộ thực hiện</th>
                    <th class=" ann-title border-table table-giua">Mã đơn hàng</th>
                    <th class=" ann-title border-table table-giua">Trạng thái xác thực</th>
                </tr>
                <c:if test="${dataWrapper.total > 0}">
                    <c:forEach items="${dataWrapper.citizenVerifications}" var="item" varStatus="stat">
                        <c:if test="${item.verify_status=='success'}">
                            <tr ng-click="viewDetail('${item.verify_id}')">
                                <td class="border-table truong-text-verticel text-center">${item.verify_date_formatted}</td>
                                <td class="border-table truong-text-verticel text-center">
                                    <c:if test="${item.verify_status=='success'}">
                                        <a ng-click="viewDetail('${item.verify_id}')">${item.verify_id}</a>
                                    </c:if>
                                </td>
                                <td class="border-table truong-text-verticel text-center">${item.citizen_verify_fullname}<br>${item.citizen_verify_cccd}</td>
                                <td class="border-table  truong-text-verticel text-center">${item.verify_by}/${item.verify_by_name}</td>
                                <td class="border-table  truong-text-verticel text-center">${item.order_id}</td>
                                <td class="border-table  truong-text-verticel text-center"><span class="status-box-${item.verify_status}">${item.verify_status_name}</span></td>
                            </tr>
                        </c:if>

                        <c:if test="${item.verify_status!='success'}">
                            <tr>
                                <td class="border-table truong-text-verticel text-center">${item.verify_date_formatted}</td>
                                <td class="border-table truong-text-verticel text-center">${item.verify_id}</td>
                                <td class="border-table truong-text-verticel text-center">${item.citizen_verify_fullname}<br>${item.citizen_verify_cccd}</td>
                                <td class="border-table  truong-text-verticel text-center">${item.verify_by}/${item.verify_by_name}</td>
                                <td class="border-table  truong-text-verticel text-center">${item.order_id}</td>
                                <td class="border-table  truong-text-verticel text-center"><span class="status-box-${item.verify_status}">${item.verify_status_name}</span></td>
                            </tr>
                        </c:if>

                    </c:forEach>
                    <tr class="table-tr-xam">

                        <th colspan="10"><div class="truong-padding-foot-table"> Tổng số <span style="color:red">${dataWrapper.total}</span> lượt xác thực</div>
                            <div class="align-phai">
                                <c:if test="${dataWrapper.page==1}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                <c:if test="${dataWrapper.page!=1}">
                                    <img onclick="firstPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                    <img onclick="previewPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                    ${dataWrapper.page}
                                trên ${dataWrapper.totalPage}
                                <c:if test="${dataWrapper.page == dataWrapper.totalPage}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                </c:if>
                                <c:if test="${dataWrapper.page != dataWrapper.totalPage}">
                                    <img onclick="nextPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                    <img onclick="lastPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                </c:if>
                            </div>
                        </th>
                    </tr>
                </c:if>
                <c:if test="${dataWrapper.total == 0}">
                    <tr>
                        <td colspan="10"
                            style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                            Chưa có dữ liệu
                        </td>
                    </tr>
                </c:if>

            </table>
        </div>
    </form>

        <div class="modal fade" id="viewCitizenInfoDetail" role="dialog" style="width:auto;">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content modal-medium">
                    <div class="modal-header">
                        <button ng-click="closePopup('viewCitizenInfoDetail')" type="button" class="close">&times;</button>
                        <h4 class="modal-title">Thông tin danh tính công dân</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row ">
                                <label class="col-md-4">Mã đơn hàng</label>
                                <span class="col-md-8">{{citizenVerification.order_id}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4">Mã xác thực </label>
                                <span class="col-md-8">{{citizenVerification.verify_id ? citizenVerification.verify_id : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Thông tin công dân</label>
                            </div>
                            <div style="width: 100%; height: 396px; position: relative; background: linear-gradient(291deg, #AFE5E7 0%, #FCFCFC 100%); border-radius: 12px; overflow: hidden; border-left: 1px #BAE7EF solid; border-top: 1px #BAE7EF solid; border-right: 1px #BAE7EF solid; border-bottom: 1px #BAE7EF solid">
                                <img style="width: 100%; top: 0px; position: absolute; opacity: 0.40" src="<%=request.getContextPath()%>/static/image/icon-mkserver/bg-scan-success.png" />

                                <img style="width: 158px; height: 212px; left: 24px; top: 158px; position: absolute; border-radius: 8px" src="data:image/png;base64,{{citizenVerification.citizen_info.faceImage}}" />

                                <div style="left: 24px; top: 24px; position: absolute; flex-direction: column; justify-content: center; align-items: flex-start; gap: 12px; display: inline-flex">
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Số CCCD</div>
                                        <div style="color: #2A85FF; font-size: 20px; font-family: Inter; font-weight: 600; line-height: 28px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.idCardNo}}</div>
                                    </div>
                                    <div style="width: 52px; height: 2px; position: relative; background: #BAE7EF; border-radius: 1px"></div>
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Số CMND đã cấp</div>
                                        <div style="color: #272B30; font-size: 20px; font-family: Inter; font-weight: 600; line-height: 28px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.oldIdCardNumber}}</div>
                                    </div>
                                </div>
                                <div style="left: 206px; top: 24px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                    <div style="align-self: stretch; justify-content: space-between; align-items: flex-start; gap: 32px; display: inline-flex">
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Họ và tên</div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.name}}</div>
                                            </div>
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Quốc tịch</div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.nationality}}</div>
                                            </div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Ngày sinh</div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.dateOfBirth}}</div>
                                            </div>
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Dân tộc </div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.ethnic}}</div>
                                            </div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Giới tính</div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.gender}}</div>
                                            </div>
                                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                                <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Tôn giáo</div>
                                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.religion}}</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="align-self: stretch; height: 44px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Quê quán</div>
                                        <div style="align-self: stretch; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.placeOfOrigin}}</div>
                                    </div>
                                    <div style="align-self: stretch; height: 44px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Địa chỉ thường trú</div>
                                        <div style="align-self: stretch; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.residenceAddress}}</div>
                                    </div>
                                    <div style="align-self: stretch; justify-content: flex-start; align-items: flex-start; gap: 39px; display: inline-flex">
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: inline-flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Ngày cấp </div>
                                            <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.dateOfIssuance}}</div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: inline-flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Ngày hết hạn</div>
                                            <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.dateOfExpiry}}</div>
                                        </div>
                                    </div>
                                    <div style="align-self: stretch; height: 68px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">Đặc điểm nhận dạng</div>
                                        <div style="width: 354px; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">{{citizenVerification.citizen_info.dg13.personalSpecificIdentification}}</div>
                                    </div>
                                </div>
                                <img class="icon-quochuy" src="<%=request.getContextPath()%>/static/image/icon-mkserver/quoc-huy-viet-nam.png" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
<script>
    $(window).on('resize', function() {
        var win = $(this);
        if (win.width() < 1371) {
            $('.123').removeClass('col-md-4');
            $('.123').addClass('col-md-6');

        } else {
            $('.123').removeClass('col-md-6');
            $('.123').addClass('col-md-4');
        }
    });
    $(function () {

        $('#verify_date_from').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#verify_date_to').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>
<%--
<script>
    $(window).on('resize', function() {
        var win = $(this);
        if (win.width() < 1600) {
            $('.truong-re-bt').removeClass('col-md-1');
            $('.truong-re-bt').addClass('col-md-2');
            $('.truong-re-bt').removeClass('col-md-offset-11');
            $('.truong-re-bt').addClass('col-md-offset-10');

        } else {
            $('.truong-re-bt').removeClass('col-md-2');
            $('.truong-re-bt').addClass('col-md-1');
            $('.truong-re-bt').removeClass('col-md-offset-10');
            $('.truong-re-bt').addClass('col-md-offset-11');
        }
    });
</script>
--%>

<script>
    function firstPage() {
        $('#page').val(1);
        $("#search-frm").submit();
    }
    function previewPage() {
        var page = $('#page').val();
        $('#page').val(parseInt(page) - 1);
        $("#search-frm").submit();
    }
    function nextPage() {
        var page = $('#page').val();
        $('#page').val(parseInt(page) + 1);
        $("#search-frm").submit();
    }
    function lastPage() {
        var totalPage = $('#totalPage').val();
        $('#page').val(totalPage);
        $("#search-frm").submit();
    }
    function clearText(){
        $('#name1').val("");
        $('#code').val("");

    }
    function checkDateFormat(dateStr, idTag){
        if(!isValidDateFormat(dateStr)) $("#"+idTag).val("");
    }
</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<script>
    $(document).ready(function () {
        loadMenu();
    });
    function loadMenu() {
        var parentItem = $("#quan-ly-xac-thuc-danh-tinh");
        $(parentItem).click();
        $("#danh-sach-luot-xac-thuc").addClass("child-menu");
    }
</script>



