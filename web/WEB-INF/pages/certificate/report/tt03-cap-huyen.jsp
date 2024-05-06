<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
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

<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<script src="<%=request.getContextPath()%>/static/js/certificate/reportTT03CapHuyen.js"
        type="text/javascript"></script>

<%--
    Báo cáo chứng thực theo thông tư 03 cấp huyện
--%>
<spring:url value="/reportCertificate/tt03-cap-huyen" var="reportUrl"/>
<%--<spring:url value="/signatureCertificate/export" var="exportUrl"/>--%>

<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var exportUrl = "/reportCertificate/tt03-cap-huyen-export";
    var userId = ${userId};
    var districtCode = '${districtCode}';

    $("#uchi-status").show();
    setTimeout(function () {
        $("#uchi-status").hide();
        $('#status-success-3').css("display", "none");
    }, 3000);
</script>

<style>
    .panel-heading a:after {
        background-image: none;
    }

    .nav-tabs.nav-justified > .active {
        border-top: 3px solid #2ca9e0;
    }
</style>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Báo cáo chứng thực theo thông tư 03</span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="reportTT03CertCapHuyenController">
    <div class="form-horizontal" id="search-frm">

        <div class="panel-body ">
            <div class="form-group">
                <label class="col-md-2 control-label  label-bam-trai text-nowrap">Ngày chứng thực</label>
                <div class="col-md-10">
                    <div class="row">
                        <div class="col-md-3 truong-padding-deleteright">

                            <select class="form-control truong-selectbox-padding select2"
                                    id="timeType" ng-change="timeTypeChange(searchCondition.timeType)"
                                    ng-model="searchCondition.timeType">
                                <option ng-value="01" selected>Trong ngày hôm nay</option>
                                <option ng-value="02">Trong tuần này</option>
                                <option ng-value="03">Trong tháng này</option>
                                <option ng-value="04">Trong năm nay</option>
                                <option ng-value="05">Trong khoảng thời gian</option>
                            </select>

                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div id="rangeTime" hidden>
                                    <div class="col-md-9" id="to-from">
                                        <div class="row">
                                            <label class="col-md-3 control-label label-bam-phai">Từ ngày</label>
                                            <div class="col-md-3 truong-padding-delete">
                                                <input type="text" ng-model="searchCondition.dateFrom"
                                                       class="form-control date-time" id="dateFrom">
                                                <div style="margin-top: 5px;color: red;"
                                                     class="error_tooltip">{{message.dateFrom}}
                                                </div>
                                            </div>
                                            <label class="col-md-3 control-label label-bam-phai">Đến ngày</label>
                                            <div class="col-md-3 truong-padding-delete">
                                                <input type="text" ng-model="searchCondition.dateTo"
                                                       class="form-control date-time" id="dateTo">
                                                <div style="margin-top: 5px;color: red;"
                                                     class="error_tooltip">{{message.dateTo}}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="report-contact" class="col-md-12">
                    <p id="report-title">KẾT QUẢ CHỨNG THỰC CỦA PHÒNG TƯ PHÁP VÀ ỦY BAN NHÂN DÂN  (UBND) CẤP XÃ TRÊN ĐỊA BÀN HUYỆN</p>
                    <p>Từ ngày {{searchCondition.dateFrom}} đến ngày {{searchCondition.dateTo}}</p>
                </div>
            </div>

        </div>

    </div>

    <div class="panel-body truong-margin-footer0px">
        <div class="export-button" style="float: right">
            <input type="button" ng-click="search()" value="Thống kê" class="btn btn-sm btn-success" style="width: 120px !important;">
            <%--<a href="${exportUrl}?dateFrom={{sear}}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>--%>
            <input type="button" ng-click="export()" value="Tải file báo cáo" class="btn btn-sm btn-success">
            <%--<c:if test="${contractAdditionalWrapper.total >0}">
                <a href="${exportUrl}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>
            </c:if>--%>
        </div>

        <h4 class="font-bold">I. KẾT QUẢ CHỨNG THỰC TẠI PHÒNG TƯ PHÁP</h4>
        <table class="tbl-list truong-border-table col-md-12">
            <tr class="ann-title truong-border-table table-giua">
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực bản sao
                    <em>(Bản)</em>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực chữ ký trong giấy tờ, văn bản
                    <em>(Việc)</em>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực chữ ký người dịch
                    <em>(Việc)</em>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực hợp đồng, giao dịch
                    <em>(Việc)</em>
                </th>

            </tr>
            <tr>
                <%--<td class="ann-title truong-border-table table-giua">A</td>--%>
                    <td colspan="2" class="ann-title truong-border-table table-giua">(1)</td>
                    <td colspan="2" class="ann-title truong-border-table table-giua">(2)</td>
                    <td colspan="2" class="ann-title truong-border-table table-giua">(3)</td>
                    <td colspan="2" class="ann-title truong-border-table table-giua">(4)</td>
            </tr>
            <tr ng-repeat="item in reportTT03PhongTuPhaps">
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_copies_number}}</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_signature_number}}</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">0</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_contract_number}}</td>
            </tr>
        </table>

        <h4 class="font-bold col-md-12 no-padder">II. KẾT QUẢ CHỨNG THỰC TẠI UBND CẤP XÃ TRÊN ĐỊA BÀN HUYỆN</h4>
        <table class="tbl-list truong-border-table col-md-12">
            <tr class="ann-title truong-border-table table-giua">
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    <%--Chứng thực bản sao
                    <em>(A)</em>--%>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực bản sao
                    <em>(Bản)</em>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực chữ ký trong giấy tờ, văn bản
                    <em>(Việc)</em>
                </th>
                <th colspan="2" style="width:150px;"
                    class="ann-title truong-border-table table-giua ">
                    Chứng thực hợp đồng, giao dịch
                    <em>(Việc)</em>
                </th>

            </tr>
            <tr>
                <%--<td class="ann-title truong-border-table table-giua">A</td>--%>
                <td colspan="2" class="ann-title truong-border-table table-giua">A</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">(1)</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">(2)</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">(3)</td>
            </tr>
            <tr>
                <td colspan="2" class="ann-title truong-border-table table-giua font-bold">Tổng số</td>
                <td colspan="2" class="ann-title truong-border-table table-giua"></td>
                <td colspan="2" class="ann-title truong-border-table table-giua"></td>
                <td colspan="2" class="ann-title truong-border-table table-giua"></td>
            </tr>
            <tr ng-repeat="item in reportTT03CapHuyenCerts">
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.user_family_name}} {{item.user_first_name}}</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_copies_number}}</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_signature_number}}</td>
                <td colspan="2" class="ann-title truong-border-table table-giua">{{item.cert_contract_number}}</td>
            </tr>
        </table>

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
    $(function () {
        $('#dateFrom').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#dateTo').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>
<script>
    $(document).ready(function () {
        var parentItem = $("#bao-cao-thong-ke");
        $(parentItem).click();
        $("#bao-cao-chung-thuc-tt03").addClass("child-menu");
    });

</script>
