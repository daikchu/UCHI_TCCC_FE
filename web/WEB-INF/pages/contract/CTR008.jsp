<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.vn.osp.common.util.SystemMessageProperties" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<%--
    Báo cáo theo hợp đồng lỗi
--%>
<spring:url value="/report/contract-error" var="reportUrl"/>
<spring:url value="/report/export-contract-error" var="exportUrl"/>

<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String nguoiCongChung_NameLower = checkcongchung.equals("1") ? "người ký chứng thực" : "công chứng viên";
    String nguoiCongChung_Name = checkcongchung.equals("1") ? "Người ký chứng thực" : "Công chứng viên";
    String congChung_NameLower = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String hopDong_NameLower = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
%>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Báo cáo theo hợp đồng lỗi</span>
</div>
<div class="truong-form-chinhds panel-group">
    <form class="form-horizontal" id="search-frm" action="${reportUrl}" method="get">
        <input type="hidden" name="page" id="page" value="${contractErrorWrapper.page}">
        <input type="hidden" name="totalPage" id="totalPage" value="${contractErrorWrapper.totalPage}">

        <div class="panel-body ">

            <%--
                                            <div class="form-group">
                                                <label class="col-md-2 control-label  label-bam-trai">Nguồn dữ liệu:</label>
                                                <div class="col-md-3">
                                                    <label class="radio-inline">
                                                        <input type="radio" value="2" name="officeType"  checked ${reportByNotaryOfficeList.officeType==2?"checked":""} onchange="this.form.submit()" >
                                                        <span >Văn phòng công chứng</span>
                                                    </label>

                                                    <label class="radio-inline" >
                                                        <input type="radio" value="3" name="officeType" ${reportByNotaryOfficeList.officeType==3?"checked":""} onchange="this.form.submit()" >
                                                        <span>Phường xã</span>
                                                    </label>


                                                </div>
                                                </div>
            --%>

                <div class="form-group">



                    <label class="col-md-2 control-label  label-bam-trai text-nowrap">Ngày <%=congChung_NameLower%></label>
                    <div class="col-md-10">
                        <div class="row">
                            <div class="col-md-3 truong-padding-deleteright">

                                <select class="form-control truong-selectbox-padding select2" name="timeType" id="timeType" onchange="timeTypeChange()">
                                    <option value="01" ${contractErrorWrapper.timeType.equals('01')?"selected":""}>Trong ngày hôm nay</option>
                                    <option value="02" ${contractErrorWrapper.timeType.equals('02')?"selected":""}>Trong tuần này</option>
                                    <option value="03" ${contractErrorWrapper.timeType.equals('03')?"selected":""}>Trong tháng này</option>
                                    <option value="04" ${contractErrorWrapper.timeType.equals('04')?"selected":""}>Trong năm nay</option>
                                    <option value="05" ${contractErrorWrapper.timeType.equals('05')?"selected":""}>Trong khoảng thời gian</option>
                                </select>

                            </div>
                            <div class="col-md-9">
                                <div class="row">
                                    <div ${contractErrorWrapper.timeType.equals('05')?"":"style='display: none;'"} id="dateTimeFilter">
                                        <div class="col-md-9" id="to-from">
                                            <div class="row">
                                                <label class="col-md-3 control-label  label-bam-phai">Từ ngày</label>
                                                <div class="col-md-3 truong-padding-delete">
                                                    <input type="text" value="${contractErrorWrapper.fromDate}" class="form-control date-time ${validate_msg_from_date != ""? "error_input":""}" name="fromDate" id="fromDate" >
                                                    <div style="margin-top: 5px;color: red;" class="error_tooltip">${validate_msg_from_date}</div>
                                                </div>
                                                <label class="col-md-3 control-label  label-bam-phai">Đến ngày</label>
                                                <div class="col-md-3 truong-padding-delete">
                                                    <input type="text" value="${contractErrorWrapper.toDate}" class="form-control date-time ${validate_msg_to_date != ""? "error_input":""}" name="toDate" id="toDate">
                                                    <div style="margin-top: 5px;color: red;" class="error_tooltip">${validate_msg_to_date}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3" id="bt-thongke">
                                        <input type="submit" value="Thống kê"  class="form-control luu">
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="" id="bt-thongke-small" style="text-align: center;display: none;">
                    <input type="submit" value="Thống kê" class="btn btn-primary btn-stp" style="width: 120px !important;">
                </div>
            <%--
                                <div class="form-group">
                                                <label class="col-md-2 control-label  label-bam-trai">Văn phòng công chứng:</label>
                                                <div class="col-md-3">
                                                        <select class="form-control" name="notaryOfficeAuthentication" id="notaryOfficeAuthentication" onchange="this.form.submit()" >
                                                            <option value="">Tất cả</option>
                                                            <c:forEach items="${reportByNotaryOfficeList.notaryOffices}" var="item">
                                                                <option value ="${item.authentication_id}" ${item.authentication_id.equals(reportByNotaryOfficeList.notaryOfficeAuthentication)?"selected":""}> ${item.name}</option>

                                                            </c:forEach>
                                                        </select>
                                                </div>

                                                <label class="col-md-2 control-label  label-bam-trai">Công chứng viên:</label>
                                                <div class="col-md-3">

                                                    <select class="form-control" name = "notaryPerson" id="notaryName" >
                                                        <option value=""> Tất cả </option>
                                                        <c:forEach items="${reportByNotaryOfficeList.selectNotaryPersons}" var="item" >
                                                            <option value = "${item.notary_name}" ${item.notary_name.equals(reportByNotaryOfficeList.notaryPerson)?"selected":""} >${item.notary_name}</option>
                                                        </c:forEach>
                                                    </select>

                                                </div>

                                            </div>
            --%>







        </div>

    </form>

    <div class="panel-body truong-margin-footer0px">

<%--
        <div class=" ">
            <c:if test="${contractErrorWrapper.total >0}">
                <a href="${exportUrl}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>
            </c:if>
        </div>
--%>
    <div class=" ">
        <c:if test="${contractErrorWrapper.total >0}">
            <a href="${exportUrl}"><input type="button" class="form-control luu report-button" value="Tải file báo cáo"></a>
        </c:if>
    </div>

    <table class="table" style="margin-bottom:0%">

            <tr class="border-table">
                <th class=" ann-title border-table table-giua truong-rstable-widthper15">Số <%=hopDong_NameLower%></th>
                <th class=" ann-title border-table table-giua truong-rstable-widthper12">Ngày <%=congChung_NameLower%></th>
                <th class=" ann-title border-table table-giua truong-rstable-widthper8">Tên hợp đồng</th>
                <th class=" ann-title border-table table-giua truong-rstable-widthper15">Bên liên quan</th>
                <th class=" ann-title border-table table-giua truong-rstable-widthper15"><%=nguoiCongChung_Name%></th>
                <th class=" ann-title border-table table-giua truong-rstable-widthper15">Hợp đồng lỗi</th>
            </tr>
            <c:if test="${contractErrorWrapper.total == 0}">
                <tr>
                    <td colspan="7"
                        style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                        Chưa có dữ liệu
                    </td>
                </tr>
            </c:if>
            <c:if test="${contractErrorWrapper.total != 0}">

                <c:forEach items="${contractErrorWrapper.contractErrors}" var="item">

                    <tr>
                        <td class="border-table truong-text-verticel">${item.contract_number}</td>
                        <td class="border-table truong-text-verticel">${item.notaryDatePrint}</td>
                        <td class="border-table align-giua">${item.contract_name}</td>
                        <td class="border-table truong-text-verticel"
                            style="color: black;" >

                        <c:if test="${(item.relation_object_A.concat(item.relation_object_B).concat(item.relation_object_C).length()) <= 200}">

                                ${item.relation_object_A.concat(item.relation_object_B).concat(item.relation_object_C).replace("\\n","<br>")}
                                <%--${(item.relation_object_A)} <br>
                                ${(item.relation_object_B)} <br>

                                <c:if test="${item.relation_object_C != null && !item.relation_object_C.equals('')}">
                                    Bên C: &nbsp&nbsp ${(item.relation_object_C)} <br>
                                </c:if>--%>

                        </c:if>
                        <div id ="relation" style="display: none">
                            <div class='title-green'>Bên A:</div>${item.relation_object_A}<div class='title-green'>Bên B:</div>${item.relation_object_B}
                            <c:if test="${item.relation_object_C != null && !item.relation_object_C.equals('')}">
                                <div class='title-green'>Bên C:</div>${item.relation_object_C}
                            </c:if>

                        </div>
                        <c:if test="${(item.relation_object_A.concat(item.relation_object_B).concat(item.relation_object_C).length()) > 200}">


                                    <%--<c:if test="${item.relation_object_A != null && !item.relation_object_A.equals('')}">
                                        Bên A: &nbsp&nbsp ${(item.relation_object_A)} <br>
                                    </c:if>
                                    <c:if test="${item.relation_object_B != null && !item.relation_object_B.equals('')}">
                                        Bên B: &nbsp&nbsp ${(item.relation_object_B)} <br>
                                    </c:if>--%>
                                    <%--<c:if test="${item.relation_object_C != null && !item.relation_object_C.equals('')}">
                                        Bên C: &nbsp&nbsp ${(item.relation_object_C)} <br>
                                    </c:if>--%>
                                    ${''.concat(item.relation_object_A).concat(item.relation_object_B).concat(item.relation_object_C).substring(0,200).replace("\\n","<br>")} <a data-html="true" data-toggle="popover" data-trigger="click"  data-placement="top" data-content="<div class='title-green'>Bên liên quan</div>${item.relation_object_A.replace("\\n","<br>")}${item.relation_object_B.replace("\\n","<br>")}<c:if test='${item.relation_object_C != null && !item.relation_object_C.equals("")}'>${item.relation_object_C.replace("\\n","<br>")}</c:if>"><img  src="<%=request.getContextPath()%>/static/image/xemthem.png"></a>

                        </c:if>
                        </td>

                        <td class="border-table truong-text-verticel">${item.family_name} ${item.first_name}</td>

                        <c:if test="${item.error_description.length() <= 200 || item.error_description == null}">
                            <td class="border-table truong-text-verticel"
                                style="color: black;" >${item.error_description}</td>
                        </c:if>
                        <c:if test="${item.error_description.length() > 200}">
                            <td class="border-table truong-text-verticel"
                                style="color: black;" >${item.error_description.substring(0,200)} <a data-html="true" data-toggle="popover" data-trigger="click"  data-placement="top" data-content="<div class='title-green'>Nội dung hợp đồng lỗi :</div>${item.error_description}"><img  src="<%=request.getContextPath()%>/static/image/xemthem.png"></a>
                            </td>
                        </c:if>

                    </tr>
                </c:forEach>

                <tr class="table-tr-xam">
                    <th colspan="7"><div class="truong-padding-foot-table">Tổng số <span class="truong-text-colorred">${contractErrorWrapper.total}</span> dữ
                        liệu</div>
                        <div class="align-phai">
                            <c:if test="${contractErrorWrapper.page==1}">
                                <img
                                        class="truong-pagging-icon"
                                        src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                <img
                                        class="truong-pagging-icon"
                                        src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                            </c:if>
                            <c:if test="${contractErrorWrapper.page!=1}">
                                <img onclick="firstPage()"
                                     class="pagging-icon"
                                     src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                <img onclick="previewPage()"
                                     class="pagging-icon"
                                     src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                            </c:if>
                                ${contractErrorWrapper.page}
                            trên ${contractErrorWrapper.totalPage}
                            <c:if test="${contractErrorWrapper.page==contractErrorWrapper.totalPage}">
                                <img
                                        class="truong-pagging-icon"
                                        src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                <img
                                        class="truong-pagging-icon"
                                        src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                            </c:if>
                            <c:if test="${contractErrorWrapper.page!=contractErrorWrapper.totalPage}">
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

        </table>




    </div>
</div>
<script>
    $(window).on('load resize',function(){
        var win = $(this);
        var timeType = $('#timeType').val();
        if(timeType== "05") {
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
    function timeTypeChange() {
        var win = $(this);
        var timeType = $('#timeType').val();
        if(timeType== "05") {
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
        else {
            $('#to-from').removeClass('col-md-12');
            $('#to-from').addClass('col-md-9');
            $('#bt-thongke').css('display', 'block');
            $('#bt-thongke-small').css('display', 'none');
            $('#to-from').removeClass('truong-padding-right30');

        }
    }
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
        var userTotalPage = $('#totalPage').val();
        $('#page').val(userTotalPage);
        $("#search-frm").submit();
    }
    $(document).ready(function () {
        $( "#timeType" ).change(function() {
            var timeType = $('#timeType option:selected').val();
            if(timeType == '05'){
                $('#dateTimeFilter').css("display","block");


            }
            if(timeType != '05'){
                $('#dateTimeFilter').css("display","none");

            }
        });
        $('[data-toggle=popover]').popover();
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
        $('#fromDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#toDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse : false,
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
        $("#bao-cao-theo-hd-huy").addClass("child-menu");
        $(".date-time").keypress(function(key) {
            if(key.charCode < 47 || key.charCode > 57) return false;
        });
        $(".date-time").bind("cut copy paste",function(e) {
            e.preventDefault();
        });
    });
</script>
