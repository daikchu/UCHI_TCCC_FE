<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />
<%--
    Danh sách gợi ý phí hợp đồng
--%>
<%--<spring:url value="/fee/add-view" var="addUrl" />--%>
<spring:url value="/fee/list" var="listUrl" />
<%--<spring:url value="/fee/update-view" var="updateUrl"/>--%>
<spring:url value="/fee/loadContractTemplate" var="loadContractTemplate"/>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách phí công chứng</span>
</div>
<div class="truong-form-chinhds panel-group">

    <%--<c:if test="${contractKindList.action_status != null}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">${contractKindList.action_status} </div>
        </div>
    </c:if>--%>

    <%--<c:if test="${deleteStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Xóa gợi ý tính phí thành công </div>
        </div>
    </c:if>
    <c:if test="${deleteStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Xóa gợi ý tính phí thất bại </div>
        </div>
    </c:if>
    <c:if test="${addStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Thêm mới gợi ý tính phí thành công </div>
        </div>
    </c:if>
    <c:if test="${addStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Thêm mới gợi ý tính phí thất bại </div>
        </div>
    </c:if>
    <c:if test="${updateStatus == true}">
        <div class="padding-default" id="uchi-status">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Cập nhật gợi ý tính phí thành công </div>
        </div>
    </c:if>
    <c:if test="${updateStatus == false}">
        <div class="padding-default" id="uchi-status">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Cập nhật gợi ý tính phí thất bại </div>
        </div>
    </c:if>--%>


    <form class="form-horizontal" action="${listUrl}" id="search-frm" method="get">
        <input type="hidden" name="page" id="page" value="${contractFeeList.page}">
        <input type="hidden" name="totalPage" id="totalPage" value="${contractFeeList.totalPage}">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-md-2 control-label label-bam-trai">Mã mẫu hợp đồng</label>
                <div class="col-md-3">
                    <select name="nhomHD" id="nhomHD" class="form-control truong-selectbox-padding" onchange="loadContractTemplate()" >
                        <option value="">Tất cả</option>
                        <c:forEach items="${contractFeeList.contractKindList}" var="item" >
                            <option value="${item.contract_kind_code}" ${contractFeeList.nhomHD == item.contract_kind_code?"selected":""}>${item.name}</option>
                        </c:forEach>
                    </select>

                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label label-bam-trai">Mã hợp đồng</label>
                <div class="col-md-3">
                    <select name="code" id="tenHD" class="form-control truong-selectbox-padding" >
                        <option value="">Tất cả</option>
                        <c:forEach items="${contractFeeList.listContractTemp}" var="item" >
                            <option value="${item.code_template}" ${contractFeeList.code == item.code_template?"selected":""} >${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-7">
                    <div class="truong-button-fixwidth-right">
                        <input type="button" class="form-control huybo" name="" value="Xóa điều kiện" onclick="clearText()">
                    </div>
                    <div class="truong-button-fixwidth-right">

                        <input type="submit" class="form-control luu" name="" value="Tìm kiếm">
                    </div>

                </div>



            </div>





        </div>

        <div class="col-md-12 truong-margin-footer0px">

            <table class="table" style="margin-bottom:0%" >

                <tr class="border-table">
                    <th class="ann-title border-table table-giua" style="width: 50px !important;">Mã</th>
                    <th class=" ann-title border-table table-giua">Tên mẫu hợp đồng</th>
                    <th class=" ann-title border-table table-giua">Tên hợp đồng</th>
                    <th class=" ann-title border-table table-giua" style="width: 150px !important;">Khoảng tiền từ</th>
                    <th class=" ann-title border-table table-giua " style="width: 150px !important;">Khoảng tiền đến</th>
                    <th class=" ann-title border-table table-giua" style="width: 200px !important;">Công thức tính</th>

                </tr>
                <c:if test="${contractFeeList.total > 0}">
                    <c:forEach items="${contractFeeList.contractFeeLists}" var="item" varStatus="stat">
                        <tr>
                            <td class="border-table truong-text-verticel" >${stat.index+1+(contractFeeList.page-1)*20} </td>
                            <td class="border-table truong-text-verticel">${item.kind_name}</td>
                            <td class="border-table truong-text-verticel">${item.template_name}</td>
                            <td class="border-table  truong-text-verticel" style="color: black">${item.from_fee}</td>
                            <td class="border-table  truong-text-verticel" style="color: black">${item.to_fee}</td>
                            <td class="border-table  truong-text-verticel" style="color: black;">${item.formula_fee}</td>

                        </tr>
                    </c:forEach>
                    <tr class="table-tr-xam">
                        <th colspan="7"><div class="truong-padding-foot-table"> Tổng số <span style="color:red">${contractFeeList.total}</span> dữ
                            liệu</div>
                            <div class="align-phai">
                                <c:if test="${contractFeeList.page==1}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                <c:if test="${contractFeeList.page!=1}">
                                    <img onclick="firstPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                    <img onclick="previewPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                    ${contractFeeList.page}
                                trên ${contractFeeList.totalPage}
                                <c:if test="${contractFeeList.page == contractFeeList.totalPage}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                </c:if>
                                <c:if test="${contractFeeList.page != contractFeeList.totalPage}">
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
                <c:if test="${contractFeeList.total == 0}">
                    <tr>
                        <td colspan="7"
                            style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                            Chưa có dữ liệu
                        </td>
                    </tr>
                </c:if>

            </table>
        </div>
    </form>
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
        var provinceTotalPage = $('#provinceTotalPage').val();
        $('#page').val(provinceTotalPage);
        $("#search-frm").submit();
    }
    function clearText(){
        $('#name1').val("");
        $('#code').val("");

    }
    function loadContractTemplate() {
        var loadContractTemplate=  document.getElementById("nhomHD").value;
        $.ajax({
            type: "GET",
            url: '${loadContractTemplate}',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                contractKind: loadContractTemplate,
            },
            success: function (response) {
                var stringVpcc = response.result;
                var htmlContent1 = '<select name="ct_template_code" class="form-control truong-selectbox-padding"><option value="">Tất cả</option>';
                var listVpcc = stringVpcc.split(";");
                for( var i =0;i<listVpcc.length-1;i++){
                    var nameVPCC = listVpcc[i];
                    var arr = nameVPCC.split("o0o");
                    var idVPCC = arr[0];
                    var tenVPCC = arr[1];

                    htmlContent1 += '<option value ="'+idVPCC+'">'+tenVPCC+'</option>';
                }
                htmlContent1+='</select>';
                $('#tenHD').html(htmlContent1);


            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })

    }
</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<script>
    $(document).ready(function () {
        //load menu
        var parentItem = $("#mau-giao-dien");
        $(parentItem).click();
        $("#phihopdong").addClass("child-menu");

    });
</script>


