<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
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
<script src="<%=request.getContextPath()%>/static/js/report/tkGDBDS.js?v=1"
        type="text/javascript"></script>

<%--
    Báo cáo chứng thực theo thông tư 03 cấp tỉnh
--%>
<spring:url value="/reportCertificate/tt03-cap-huyen" var="reportUrl"/>
<%--<spring:url value="/signatureCertificate/export" var="exportUrl"/>--%>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1")?"chứng thực":"công chứng";
    String congchungH = checkcongchung.equals("1")?"CHỨNG THỰC":"CÔNG CHỨNG";
%>
<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var org_type = '<%=SystemProperties.getProperty("org_type")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var exportUrl = "/report/export-luong-giao-dich-bds";
    var userId = ${userId};
    var districtCode = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getDistrict_code()%>';
    var levelCert = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getLevel_cert()%>';
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
    <span id="web-map">Báo cáo về lượng giao dịch bđs để bán qua <%=congchung%></span>
</div>
<div class="truong-form-chinhds panel-group" ng-app="osp" ng-controller="reportGDBDSController">
    <div class="form-horizontal" id="search-frm">

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-3">
                            <span>Ngày <%=congchung%></span>
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
                        <%--<div class="col-md-6 truong-padding-delete">--%>
                            <%--<div class="row">--%>
                                <div id="rangeTime" hidden>
                                    <div id="to-from">
                                        <div class="col-md-3">
                                            <span>Từ ngày</span>
                                            <input type="text" ng-model="searchCondition.dateFrom"
                                                   class="form-control date-time" id="dateFrom">
                                            <div style="margin-top: 5px;color: red;"
                                                 class="error_tooltip">{{message.dateFrom}}
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <span>Đến ngày</span>
                                            <input type="text" ng-model="searchCondition.dateTo"
                                                   class="form-control date-time" id="dateTo">
                                            <div style="margin-top: 5px;color: red;"
                                                 class="error_tooltip">{{message.dateTo}}
                                            </div>
                                        </div>
                                    </div>
                                <%--</div>--%>

                            <%--</div>--%>
                        </div>
                        <div class="col-md-3 p-trl-btn">
                            <input type="button" ng-click="search()" value="Thống kê" class="btn btn-sm btn-success"
                                   style="width: 120px !important;">
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="report-contact" class="col-md-12">
                    <p id="report-title">BÁO CÁO VỀ LƯỢNG GIAO DỊCH BẤT ĐỘNG SẢN ĐỂ BÁN QUA <%=congchungH%></p>
                    <p>Từ ngày {{searchCondition.dateFrom}} đến ngày {{searchCondition.dateTo}}</p>
                </div>
            </div>

        </div>

    </div>

    <div class="panel-body truong-margin-footer0px">
        <div class="export-button" style="float: right">
            <%--<a href="${exportUrl}?dateFrom={{sear}}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>--%>
            <input type="button" ng-click="export()" value="Tải file báo cáo" class="btn btn-sm btn-success">
            <%--<c:if test="${contractAdditionalWrapper.total >0}">
                <a href="${exportUrl}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>
            </c:if>--%>
        </div>

        <%--<h4 class="font-bold col-md-12 no-padder">II. KẾT QUẢ CHỨNG THỰC TẠI CÁC UBND CẤP XÃ TRÊN ĐỊA BÀN TỈNH</h4>--%>
        <table class="tbl-list truong-border-table col-md-12">
            <tr class="ann-title truong-border-table table-giua">
                <td rowspan="3" class="ann-title truong-border-table table-giua font-bold">TT</td>
                <td rowspan="3" class="ann-title truong-border-table table-giua font-bold">Địa điểm bất động sản</td>
                <th colspan="9" style="width:150px;"
                    class="ann-title truong-border-table table-giua font-bold">
                    Số lượng giao dịch bất động sản để bán được tổng hợp từ số liệu <%=congchung%> trong tháng
                    báo cáo
                </th>

            </tr>
            <tr>
                <%--<td class="ann-title truong-border-table table-giua">A</td>--%>
                <td colspan="2" class="ann-title truong-border-table table-giua font-bold">Đất nền để ở <br>(căn)
                </td>
                <td colspan="2" class="ann-title truong-border-table table-giua font-bold">Nhà ở riêng lẻ <br>(căn)
                </td>
                <td colspan="3" class="ann-title truong-border-table table-giua font-bold">Căn hộ chung cư
                    <br>(căn)</td>
                <td rowspan="2" class="ann-title truong-border-table table-giua font-bold">Văn phòng cho thuê <br>(m2)</td>
                <td rowspan="2" class="ann-title truong-border-table table-giua font-bold">Mặt bằng thương mại, dịch vụ <br>(m2)</td>
            </tr>
            <tr>
                <td class="ann-title truong-border-table table-giua font-bold">Phát triển theo dự án</td>
                <td class="ann-title truong-border-table table-giua font-bold">Trong khu dân cư hiện hữu</td>
                <td class="ann-title truong-border-table table-giua font-bold">Phát triển theo dự án</td>
                <td class="ann-title truong-border-table table-giua font-bold">Trong khu dân cư hiện hữu</td>
                <td class="ann-title truong-border-table table-giua font-bold">Diện tích ≤70 m2</td>
                <td class="ann-title truong-border-table table-giua font-bold">70 m2< Diện tích ≤120 m2</td>
                <td class="ann-title truong-border-table table-giua font-bold">Diện tích >120 m2</td>
                <%--<td class="ann-title truong-border-table table-giua"></td>
                <td class="ann-title truong-border-table table-giua"></td>--%>
            </tr>
            <tr>
                <td class="ann-title truong-border-table table-giua">(1)</td>
                <td class="ann-title truong-border-table table-giua">(2)</td>
                <td class="ann-title truong-border-table table-giua">(3)</td>
                <td class="ann-title truong-border-table table-giua">(4)</td>
                <td class="ann-title truong-border-table table-giua">(5)</td>
                <td class="ann-title truong-border-table table-giua">(6)</td>
                <td class="ann-title truong-border-table table-giua">(7)</td>
                <td class="ann-title truong-border-table table-giua">(8)</td>
                <td class="ann-title truong-border-table table-giua">(9)</td>
                <td class="ann-title truong-border-table table-giua">(10)</td>
                <td class="ann-title truong-border-table table-giua">(11)</td>
            </tr>
            <tr ng-repeat="item in dataReport">
                <td class="ann-title truong-border-table table-giua">{{$index+1}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.district_name}}
                </td>
                <td class="ann-title truong-border-table table-giua">{{item.count_DNDO_phatTrienTheoDuAn}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_DNDO_trongKhuDanCu}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_NORL_phatTrienTheoDuAn}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_NORL_trongKhuDanCu}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_CHCC_dienTichDuoi70m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_CHCC_dienTichTu70Den120m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_CHCC_dienTichTren120m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_vanPhongChoThue}}</td>
                <td class="ann-title truong-border-table table-giua">{{item.count_matBangThuongMaiDichVu}}</td>
            </tr>
            <tr>
                <td class="ann-title truong-border-table table-giua"></td>
                <td class="ann-title truong-border-table table-giua font-bold">Tổng số
                </td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_DNDO_phatTrienTheoDuAn}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_DNDO_trongKhuDanCu}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_NORL_phatTrienTheoDuAn}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_NORL_trongKhuDanCu}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_CHCC_dienTichDuoi70m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_CHCC_dienTichTu70Den120m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_CHCC_dienTichTren120m2}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_vanPhongChoThue}}</td>
                <td class="ann-title truong-border-table table-giua">{{totalData.total_count_matBangThuongMaiDichVu}}</td>
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
        $("#bao-cao-luong-giao-dich-bds").addClass("child-menu");
    });

</script>
