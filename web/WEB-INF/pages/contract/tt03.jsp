<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.controller.HomeController" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<%--
    Báo cáo theo thông tu 04
--%>
<spring:url value="/report/by-tt03" var="reportUrl"/>
<spring:url value="/report/export-tt03" var="exportURL"/>


<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Báo cáo theo thông tư 03</span>
</div>
<div class=" truong-form-chinhds panel-group">
    <form class="form-horizontal" action="${reportUrl}" method="get">
        <input type="hidden" name="notaryDateFromFilter" id="notaryDateFromFilter"
               value="${reportByTT03List.notaryDateFromFilter}">
        <input type="hidden" name="notaryDateToFilter" id="notaryDateToFilter"
               value="${reportByTT03List.notaryDateToFilter}">

        <div class="panel-body ">
            <div class="form-group">
                <label class="col-md-2 control-label  label-bam-trai text-nowrap">Ngày công chứng</label>
                <div class="col-md-10">
                    <div class="row">

                        <div class="col-md-3 truong-padding-deleteright">
                            <select class="form-control truong-selectbox-padding select2" name="timeType" id="timeType"
                                    onchange="timeTypeChange()">
                                <option value="01" ${reportByTT03List.timeType.equals('01')?"selected":""}>Trong ngày
                                    hôm nay
                                </option>
                                <option value="02" ${reportByTT03List.timeType.equals('02')?"selected":""}>Trong tuần
                                    này
                                </option>
                                <option value="03" ${reportByTT03List.timeType.equals('03')?"selected":""}>Trong tháng
                                    này
                                </option>
                                <option value="04" ${reportByTT03List.timeType.equals('04')?"selected":""}>Trong năm
                                    nay
                                </option>
                                <option value="05" ${reportByTT03List.timeType.equals('05')?"selected":""}>Trong khoảng
                                    thời gian
                                </option>
                            </select>
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div ${reportByTT03List.timeType.equals('05')?"":"style='display: none;'"}
                                        id="dateTimeFilter">
                                    <div class="col-md-9" id="to-from">
                                        <div class="row">
                                            <label class="col-md-3 control-label  label-bam-trai">Từ ngày</label>
                                            <div class="col-md-3 truong-padding-delete">
                                                <input type="text" value="${reportByTT03List.printFromDate}"
                                                       class="form-control date-time" name="printFromDate" id="fromDate">
                                                <div style="margin-top: 5px;color: red;"
                                                     class="error_tooltip">${validate_msg_from_date}</div>
                                            </div>
                                            <label class="col-md-3 control-label  label-bam-trai">Đến ngày</label>
                                            <div class="col-md-3 truong-padding-delete">
                                                <input type="text" value="${reportByTT03List.printToDate}"
                                                       class="form-control date-time" name="printToDate" id="toDate">
                                                <div style="margin-top: 5px;color: red;"
                                                     class="error_tooltip">${validate_msg_to_date}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3" id="bt-thongke">
                                    <input type="submit" value="Thống kê" class="form-control luu">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="" id="bt-thongke-small" style="text-align: center;display: none;">
                <input type="submit" value="Thống kê" class="btn btn-primary btn-stp" style="width: 120px !important;">
            </div>
            <div class="panel-body">
                <div class="report-contact" class="col-md-12">
                    <p id="report-title">SỐ CÔNG CHỨNG VIÊN VÀ TÌNH HÌNH HOẠT ĐỘNG CÔNG CHỨNG</p>
                    <p>Từ ngày ${reportByTT03List.printFromDate} đến ngày ${reportByTT03List.printToDate}</p>
                </div>
            </div>
        </div>
        <div class="panel-body truong-margin-footer0px">
            <div class="truong-file-bao-cao export-button">

                <a href="${exportURL}" class="label-bam-phai truong-small-linkbt"><input type="button"
                                                                                         class="form-control luu"
                                                                                         value="Tải file báo cáo"></a>


            </div>
            <div>
                <div>
                    <table class="tbl-list truong-border-table col-md-12">
                        <tr class="ann-title truong-border-table table-giua">
                            <%--<th rowspan="4" style="width:100px;" class="ann-title truong-border-table table-giua ">

                            </th>
                            <th rowspan="4" style="width:100px;" class="ann-title truong-border-table table-giua ">
                                Số tổ chức hành nghề công chức<em>(Tổ chức)</em>
                            </th>--%>
                            <th rowspan="4" colspan="2" style="width:150px;"
                                class="ann-title truong-border-table table-giua ">
                                Số công chứng viên
                                <em>(người)</em>
                            </th>
                            <th colspan="12" style="width:655px;" class="ann-title truong-border-table table-giua">
                                Công chứng
                            </th>
                            <th colspan="12" style="width:655px;" class="ann-title truong-border-table table-giua">
                                Chứng thực
                            </th>

                            <th colspan="12" rowspan="4" style="width:150px;" class="ann-title truong-border-table table-giua">
                                Tổng số tiền nộp vào ngân sách <em>(đồng)</em>
                            </th>
                        </tr>
                        <tr class="ann-title truong-border-table table-giua">
                            <th colspan="6" style="width:400px;" class="ann-title truong-border-table table-giua ">
                                Số việc công chứng <em>(việc)</em>
                            </th>
                            <th colspan="3" rowspan="3" style="width:150px;" class="ann-title truong-border-table table-giua">
                                Tổng số thù lao công chứng <em>(đồng)</em>
                            </th>
                            <th colspan="3" rowspan="3" style="width:150px;" class="ann-title truong-border-table table-giua">
                                Tổng số phí công chứng <em>(đồng)</em>
                            </th>
                            <th colspan="6" rowspan="2" style="width:400px;" class="ann-title truong-border-table table-giua">
                                Chứng thực bản sao
                            </th>
                            <th colspan="6" rowspan="2" style="width:400px;" class="ann-title truong-border-table table-giua">
                                Chứng thực chữ ký trong giấy tờ, văn bản
                            </th>
                        </tr>
                        <tr class="ann-title truong-border-table table-giua">
                            <th rowspan="2" colspan="2" class="ann-title truong-border-table table-giua ">
                                Tổng số
                            </th>
                            <th colspan="4" class="ann-title truong-border-table table-giua">
                                Chia ra
                            </th>

                            <%--<th rowspan="2" class="ann-title truong-border-table table-giua ">
                                Tổng số thù lao công chứng<em>(Đồng)</em>
                            </th>
                            <th rowspan="2" class="ann-title truong-border-table table-giua ">
                                Tổng số phí công chứng<em>(Đồng)</em>
                            </th>--%>
                            <%--  <th rowspan="2" class="ann-title truong-border-table table-giua ">
                                  Tổng số tiền nộp vào ngân sách<em>(Đồng)</em>
                              </th>
                              <th colspan="3" class="ann-title truong-border-table table-giua ">Chứng thực bản sao</th>
                              <th colspan="3" class="ann-title truong-border-table table-giua ">Chứng thực chữ kí trong
                                  giấy tờ, văn bản
                              </th>--%>
                        </tr>
                        <tr class="ann-title truong-border-table table-giua">
                            <%--<th class="ann-title truong-border-table table-giua ">Tổng số</th>--%>
                            <%--<th class="ann-title truong-border-table table-giua ">Số công chứng viên hợp danh</th>--%>
                            <th colspan="2" class="ann-title truong-border-table table-giua ">Công chứng hợp đồng giao
                                dịch
                            </th>
                            <th colspan="2" class="ann-title truong-border-table table-giua ">Công chứng bản dịch và các
                                loại việc khác
                            </th>
                            <th colspan="3" class="ann-title truong-border-table table-giua ">Số bản sao</th>
                            <th colspan="3" class="ann-title truong-border-table table-giua ">Phí chứng thực bản sao<em>(Đồng)</em>
                            </th>
                            <%--<th class="ann-title truong-border-table table-giua ">Tổng số tiền nộp vào ngân
                                sách/thuế<em>(Đồng)</em></th>--%>
                            <th colspan="3" class="ann-title truong-border-table table-giua ">Số việc</th>
                            <th colspan="3" class="ann-title truong-border-table table-giua ">Phí chứng thực chữ kí<em>(Đồng)</em>
                            </th>
                            <%-- <th class="ann-title truong-border-table table-giua ">Tổng số tiền nộp vào ngân
                                 sách/thuế<em>(Đồng)</em></th>--%>
                        </tr>
                        <tr>
                            <%--<td class="ann-title truong-border-table table-giua">A</td>--%>
                            <td colspan="2" class="ann-title truong-border-table table-giua">(1)</td>
                            <td colspan="2" class="ann-title truong-border-table table-giua">(2)</td>
                            <td colspan="2" class="ann-title truong-border-table table-giua">(3)</td>
                            <td colspan="2" class="ann-title truong-border-table table-giua">(4)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(5)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(6)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(7)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(8)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(9)</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">(10)</td>
                            <td colspan="12" class="ann-title truong-border-table table-giua">(11)</td>
                            <%--<td class="ann-title truong-border-table table-giua">(12)</td>
                            <td class="ann-title truong-border-table table-giua">(13)</td>
                            <td class="ann-title truong-border-table table-giua">(14)</td>
                            <td class="ann-title truong-border-table table-giua">(15)</td>--%>
                        </tr>
                        <tr>
                            <%--<td class="ann-title truong-border-table table-giua" style="font-weight: bold"><%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getAgency()%></td>
                            <td class="ann-title truong-border-table table-giua">${reportByTT03List.numNotaryOffice}</td>--%>
                            <td colspan="2" class="ann-title truong-border-table table-giua">${reportByTT03List.numberOfNotaryPerson}</td>
                            <%--<td class="ann-title truong-border-table table-giua">${reportByTT03List.numberOfNotaryPersonHopDanh}</td>--%>
                            <td colspan="2" class="ann-title truong-border-table table-giua">${reportByTT03List.numberOfTotalContract}</td>
                            <td colspan="2" class="ann-title truong-border-table table-giua">${reportByTT03List.numberOfTotalContract}</td>
                            <td colspan="2" class="ann-title truong-border-table table-giua">0</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">${tongSoThuLao}</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua">${tongPhiCongChung}</td>
                            <td colspan="3" class="ann-title truong-border-table table-giua"></td>
                            <td colspan="3" class="ann-title truong-border-table table-giua"></td>
                            <td colspan="3" class="ann-title truong-border-table table-giua"></td>
                            <td colspan="3" class="ann-title truong-border-table table-giua"></td>
                            <%--<td colspan="3" class="ann-title truong-border-table table-giua"></td>
                            <td colspan="3" class="ann-title truong-border-table table-giua"></td>--%>
                            <td colspan="12" class="ann-title truong-border-table table-giua">${reportByTT03List.tongNopNganSach}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>


    </form>
</div>
<script>
    $(window).on('load resize', function () {
        var win = $(this);
        var timeType = $('#timeType').val();
        if (timeType == "05") {
            if (win.width() < 1114) {
                $('#to-from').removeClass('col-md-9');
                $('#to-from').addClass('col-md-12');
                $('#bt-thongke').css('display', 'none');
                $('#bt-thongke-small').css('display', 'block');
                $('#to-from').addClass('truong-padding-right30');

            } else {
                $('#to-from').removeClass('col-md-12');
                $('#to-from').addClass('col-md-9');
                $('#bt-thongke').css('display', 'block');
                $('#bt-thongke-small').css('display', 'none');
                $('#to-from').removeClass('truong-padding-right30');

            }
        }

    });
</script>
<script>
    function timeTypeChange() {
        var win = $(this);
        var timeType = $('#timeType').val();
        if (timeType == "05") {
            if (win.width() < 1114) {
                $('#to-from').removeClass('col-md-9');
                $('#to-from').addClass('col-md-12');
                $('#bt-thongke').css('display', 'none');
                $('#bt-thongke-small').css('display', 'block');
                $('#to-from').addClass('truong-padding-right30');
            } else {
                $('#to-from').removeClass('col-md-12');
                $('#to-from').addClass('col-md-9');
                $('#bt-thongke').css('display', 'block');
                $('#bt-thongke-small').css('display', 'none');
                $('#to-from').removeClass('truong-padding-right30');
            }
            $('.date-time').val('');
        }
        else {
            $('#to-from').removeClass('col-md-12');
            $('#to-from').addClass('col-md-9');
            $('#bt-thongke').css('display', 'block');
            $('#bt-thongke-small').css('display', 'none');
            $('#to-from').removeClass('truong-padding-right30');
        }
    };
</script>
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
        var userPage = $('#userPage').val();
        $('#page').val(userPage);
        $("#search-frm").submit();
    }
</script>
<script>
    $(document).ready(function () {
        $("#timeType").change(function () {
            var timeType = $('#timeType option:selected').val();
            if (timeType == '05') {
                $('#dateTimeFilter').css("display", "block");
            }
            if (timeType != '05') {
                $('#dateTimeFilter').css("display", "none");
            }
        });
    });
    $(function () {
        $('#fromDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#toDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $(document).ready(function () {
        var parentItem = $("#bao-cao-thong-ke");
        $(parentItem).click();
        $("#bao-cao-theo-tt03").addClass("child-menu");
        $(".date-time").keypress(function (key) {
            if (key.charCode < 47 || key.charCode > 57) return false;
        });
        $(".date-time").bind("cut copy paste", function (e) {
            e.preventDefault();
        });
    });
</script>

