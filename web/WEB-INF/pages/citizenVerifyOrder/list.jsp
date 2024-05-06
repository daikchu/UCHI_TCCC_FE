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

<spring:url value="/giao-dich-phi-xac-thuc/them-moi" var="addUrl" />
<spring:url value="/giao-dich-phi-xac-thuc/danh-sach" var="listUrl" />
<spring:url value="/giao-dich-phi-xac-thuc/chinh-sua" var="updateUrl"/>
<spring:url value="/giao-dich-phi-xac-thuc/xuat-file-excel" var="exportExcelUrl"/>

<script src="<%=request.getContextPath()%>/static/angularjs/angular.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/angularjs/angular-sanitize.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/citizenVerifyOrder/citizenVerifyOrderList.js?v=20231107" type="text/javascript"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách giao dịch phí xác thực</span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="citizenVerifyOrderController">

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
            <input type="hidden" id="search_province_code" value="${dataWrapper.province_code}">
            <input type="hidden" id="search_notary_office_code" value="${dataWrapper.notary_office_code}">
            <input type="hidden" id="search_transaction_status" value="${dataWrapper.transaction_status}">
            <input type="hidden" id="search_status" value="${dataWrapper.status}">
        </div>

        <div class="panel-body">
            <div class="row form-group">
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Mã đơn hàng</label>
                    <input type="text" class="form-control" name="order_id" id="order_id"
                           placeholder="Tìm mã đơn hàng"
                           value="${dataWrapper.order_id}">
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Cán bộ thực hiện</label>
                    <select class="form-control select2" name="update_by" id="update_by">
                        <option value="">---Lựa chọn---</option>
                        <c:forEach items="${dataWrapper.user_updates}" var="item">
                            <option value="${item.account}" ${dataWrapper.update_by == item.account?"selected":""}>${item.family_name} ${item.first_name}</option>
                        </c:forEach>
                    </select>

                    <%--<select name="notary_office_code" id="notary_office_code" class="form-control truong-selectbox-padding" onchange="loadContractTemplate()">
                        <option value="">Tất cả</option>
                        <c:forEach items="${dataWrapper.notary_offices}" var="item" >
                            <option value="${item.code}" ${dataWrapper.notary_office_code == item.code?"selected":""}>${item.name}</option>
                        </c:forEach>
                    </select>--%>
                </div>
                <div class="col-md-4">
                    <label class="control-label label-bam-trai">Trạng thái giao dịch</label>
                    <select name="transaction_status" ng-model="searchCondition.transaction_status"
                            class="form-control truong-selectbox-padding">
                        <option value="">--Lựa chọn--</option>
                        <option ng-repeat="item in transactionStatuses" value="{{item.code}}">
                            {{item.name}}
                        </option>
                    </select>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-8">
                    <label class="control-label label-bam-trai">Thời gian giao dịch</label>
                    <div class="row">
                        <div class="col-md-6">

                            <input type="text" value="${dataWrapper.order_time_from}"
                                   class="form-control date-time" name="order_time_from"
                                   id="order_time_from" placeholder="Từ ngày"
                                   onblur="checkDateFormat(this.value, 'order_time_from')">
                            <div style="margin-top: 5px;color: red;">{{searchConditionMessage.order_time_from}}</div>
                        </div>
                        <div class="col-md-6">
                            <input type="text" value="${dataWrapper.order_time_to}"
                                   class="form-control date-time" name="order_time_to"
                                   id="order_time_to" placeholder="Đến ngày"
                                   onblur="checkDateFormat(this.value, 'order_time_to')">
                            <div style="margin-top: 5px;color: red;">{{searchConditionMessage.order_time_to}}</div>
                        </div>
                    </div>


                </div>
                <div class="col-md-4" style="padding-top: 23px">
                    <label class="control-label label-bam-trai"></label>
                    <div class="col-md-6 clear-padding">
                        <input type="button" ng-click="onSearchOrders()" class="form-control luu" name="" value="Tìm kiếm">
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
            <table id="tableOrder" class="table" style="margin-bottom:0%" >

                <tr class="border-table">
                    <th class="ann-title border-table table-giua">Thời gian giao dịch</th>
                    <th class=" ann-title border-table table-giua">Mã đơn hàng</th>
                    <th class=" ann-title border-table table-giua">Số lượt xác thực</th>
                    <th class=" ann-title border-table table-giua">Phí xác thực (VNĐ)</th>
                    <th class=" ann-title border-table table-giua ">Số tiền thực nhận (VNĐ)</th>
                    <th class=" ann-title border-table table-giua" style="width: 120px">Trạng thái giao dịch</th>
                    <th class=" ann-title border-table table-giua">Trạng thái bổ sung</th>
                    <th class=" ann-title border-table table-giua">Cán bộ thực hiện</th>
                </tr>
                <c:if test="${dataWrapper.total > 0}">
                    <c:forEach items="${dataWrapper.citizenVerifyOrders}" var="item" varStatus="stat">
                        <tr ng-click="viewDetail('${item.order_id}')">
<%--                            <td class="border-table truong-text-verticel" >${stat.index+1+(dataWrapper.page-1)*20} </td>--%>

                            <td class="border-table truong-text-verticel text-center">${item.order_time_formatted}</td>
                            <td class="border-table truong-text-verticel text-center">${item.order_id}</td>
                            <td class="border-table truong-text-verticel text-center">${item.verify_number}</td>
                            <td class="border-table  truong-text-verticel text-center">
                                <script>
                                    function formatPrice(){
                                        return formatNumberReturn(${item.verify_fee})
                                    };
                                    var formattedNumber = formatPrice();
                                    document.write(formattedNumber);
                                </script>
                            </td>
                            <td class="border-table  truong-text-verticel text-center">
                                <script>
                                    function formatPrice(){
                                        return formatNumberReturn(${item.verify_fee_received})
                                    };
                                    var formattedNumber = formatPrice();
                                    document.write(formattedNumber && && ${item.transaction_status == "success"}  ? formattedNumber : '-');
                                </script>
                            </td>
                            <td class="border-table  truong-text-verticel text-center"><span class="status-box-${item.transaction_status}">${item.transaction_status_name != null ? item.transaction_status_name : '-'}</span></td>
                            <td class="border-table  truong-text-verticel text-center">${item.status_name != null ? item.status_name : '-'}</td>
                            <td class="border-table  truong-text-verticel text-center">${item.update_by}/${item.update_by_name}</td>
                        </tr>
                    </c:forEach>
                    <tr class="table-tr-xam">

                        <th colspan="8"><div class="truong-padding-foot-table"> Tổng số <span style="color:red">${dataWrapper.total}</span> giao dịch</div>
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
                        <td colspan="8"
                            style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                            Không có dữ liệu
                        </td>
                    </tr>
                </c:if>

            </table>
        </div>
    </form>

        <div class="modal fade" id="viewCitizenVerifyOrderDetail" role="dialog" style="width:auto;">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content modal-medium">
                    <div class="modal-header">
                        <button ng-click="closePopup('viewCitizenVerifyOrderDetail')" type="button" class="close">&times;</button>
                        <h4 class="modal-title">Thông tin giao dịch</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body">
                            <div class="row ">
                                <label class="col-md-4">Thời gian giao dịch</label>
                                <span class="col-md-8">{{citizenVerifyOrder.order_time_formatted}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4">Mã đơn hàng</label>
                                <span class="col-md-8">{{citizenVerifyOrder.order_id ? citizenVerifyOrder.order_id : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4">Số lượt xác thực </label>
                                <span class="col-md-8">{{citizenVerifyOrder.verify_number ? citizenVerifyOrder.verify_number : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4">Phí xác thực (VNĐ)</label>
                                <span class="col-md-8">
                                    {{citizenVerifyOrder.verify_fee ? formatNumber(citizenVerifyOrder.verify_fee) : '-'}}
                                </span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4">Số tiền thực nhận (VNĐ)</label>
                                <span class="col-md-8">{{citizenVerifyOrder.verify_fee_received &&  citizenVerifyOrder.transaction_status === "success"? formatNumber(citizenVerifyOrder.verify_fee_received) : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Cán bộ thực hiện</label>
                                <span class="col-md-8">{{citizenVerifyOrder.update_by_name ? (citizenVerifyOrder.update_by + '/' + citizenVerifyOrder.update_by_name) : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Trạng thái giao dịch</label>
                                <span class="col-md-8 truong-margin-left15 {{setCssByStatus(citizenVerifyOrder.transaction_status)}}">{{citizenVerifyOrder.transaction_status_name ? citizenVerifyOrder.transaction_status_name : '-'}}</span>
                            </div>
                            <div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Trạng thái bổ sung</label>
                                <span class="col-md-8">{{citizenVerifyOrder.status_name ? citizenVerifyOrder.status_name : '-'}}</span>
                            </div>
                            <div ng-show="citizenVerifyOrder.transaction_status==='success'"
                                 class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Thông tin các lượt xác thực</label>
                            </div>
                            <div ng-show="citizenVerifyOrder.transaction_status==='success'">
                                <table class="table" style="margin-bottom:0%" >

                                    <tr class="border-table">
                                        <th class="ann-title border-table table-giua">Thời gian xác thực</th>
                                        <th class=" ann-title border-table table-giua">ID lượt xác thực</th>
                                        <th class=" ann-title border-table table-giua">Công dân được xác thực</th>
                                        <th class=" ann-title border-table table-giua">Cán bộ thực hiện</th>
                                        <th class=" ann-title border-table table-giua">Trạng thái xác thực</th>
                                    </tr>
                                    <tr ng-repeat="item in citizenVerifyOrder.verifications" >
                                        <td class="border-table truong-text-verticel text-center">{{item.verify_date ? convertIntToDateTime(item.verify_date) : '-'}}</td>
                                        <td class="border-table truong-text-verticel text-center">{{item.verify_id}}</td>
                                        <td class="border-table truong-text-verticel text-center" ng-show="item.citizen_verify_fullname">{{item.citizen_verify_fullname}}<br/>{{item.citizen_verify_cccd}}</td>
                                        <td class="border-table truong-text-verticel text-center" ng-show="!item.citizen_verify_fullname">-</td>
                                        <td class="border-table  truong-text-verticel text-center" ng-show="item.verify_by">{{item.verify_by}}/{{item.verify_by_name}}</td>
                                        <td class="border-table  truong-text-verticel text-center"  ng-show="!item.verify_by">-</td>
                                        <td class="border-table  truong-text-verticel text-center" style="width: 130px"><span class="{{setCssByStatus(item.verify_status)}}">{{item.verify_status_name ? item.verify_status_name: '-'}}</span></td>
                                    </tr>

                                </table>
                            </div>

                            <%--<div class="row truong-padding-top-bottom-5 row-line-top">
                                <label class="col-md-4 control-label">Lịch sử giao dịch</label>
                            </div>
                            <div>
                                <table class="table" style="margin-bottom:0%" >

                                    <tr class="border-table">
                                        <th class="ann-title border-table table-giua">Thời gian</th>
                                        <th class=" ann-title border-table table-giua">Mã giao dịch</th>
                                        <th class=" ann-title border-table table-giua">Phí xác thực (VNĐ)</th>
                                        <th class=" ann-title border-table table-giua">Số tiền nhận (VNĐ)</th>
                                        <th class=" ann-title border-table table-giua ">Trạng thái giao dịch</th>
                                        <th class=" ann-title border-table table-giua">Trạng thái bổ sung</th>
                                        <th class=" ann-title border-table table-giua">Ghi chú</th>
                                        <th class=" ann-title border-table table-giua">File đính kèm</th>
                                        <th class=" ann-title border-table table-giua">Người cập nhật</th>
                                    </tr>
                                    <tr ng-repeat="item in citizenVerifyOrder.transaction_hists" >
                                        <td class="border-table truong-text-verticel text-center">{{convertIntToDateTime(item.transaction_time)}}</td>
                                        <td class="border-table truong-text-verticel text-center">{{item.transaction_id}}</td>
                                        <td class="border-table truong-text-verticel text-center">{{citizenVerifyOrder.verify_fee ? citizenVerifyOrder.verify_fee : '-'}}</td>
                                        <td class="border-table  truong-text-verticel text-center">{{item.amount ? item.amount : '-'}}</td>
                                        <td class="border-table  truong-text-verticel text-center" style="width: 130px"><span class="{{setCssByStatus(item.transaction_status)}}">{{item.transaction_status_name ? item.transaction_status_name: '-'}}</span></td>
                                        <td class="border-table  truong-text-verticel text-center">{{item.status_name ? item.status_name : '-'}}</td>
                                        <td class="border-table  truong-text-verticel text-center">{{item.note ? item.note : '-'}}</td>
                                        <td class="border-table  truong-text-verticel">File đính kèm?</td>
                                        <td class="border-table  truong-text-verticel text-center">Người cập nhật?</td>
                                    </tr>

                                </table>
                            </div>--%>

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

        $('#order_time_from').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#order_time_to').datepicker({
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
        $("#danh-sach-giao-dich-phi-xac-thuc").addClass("child-menu");
    }
</script>



