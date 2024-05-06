<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />
<%--
    Danh sách quận huyện
--%>
<spring:url value="/system/district/add-view" var="addUrl" />
<spring:url value="/system/district/delete" var="deleteUrl" />
<spring:url value="/system/district/list" var="listUrl" />
<spring:url value="/system/district/update-view" var="updateUrl" />

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách Quận/huyện</span>
</div>
<div class="truong-form-chinhds panel-group">

    <div id="uchi-status" class="padding-default">
        <c:if test="${items.action_status != null}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">${items.action_status}</div>
        </c:if>
    </div>
    <form class="form-horizontal" action="${listUrl}" id="search-frm" method="get">
        <input type="hidden" name="page" id="page" value="${items.page}">
        <input type="hidden" name="totalPage" id="userTotalPage" value="${items.totalPage}">
        <%
            if(ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_TIMKIEM)){
        %>
        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-3 float-left">
                    <span class="truong-label-top">Mã Quận/huyện</span>
                    <input type="text" class="form-control" name="code" id="code" value="${items.code}">

                </div>
                <div class="col-md-3 float-left">
                    <span class="truong-label-top">Tên Quận/huyện</span>
                    <input type="text" class="form-control" name="name" id="name" style="color: black !important;" value="${items.name}">
                </div>

                <%--<div class="col-md-4">
                    <div class="row">
                        <label class="col-md-3 control-label label-bam-trai">Tên tổ chức</label>
                        <div class="col-md-9">
                            <select class="select2" name="office_id"  id="officeAuthor" style="width:200px;">
                                <option value="" ${item.noid==""?"selected":""}>[Tất cả]</option>
                                <c:forEach items="${users.notaryOffices}" var="item">
                                    <option value="${item.noid}" authorCode="${item.authentication_id}" ${item.noid==users.office_id?"selected":""}>${item.name}</option>
                                </c:forEach>
                            </select>

                        </div>
                    </div>
                </div>--%>
            </div>


            <div class="form-group">
                <div class="col-md-5 float-right" style="padding-top: 16px !important;padding-left: 0px !important;">

                    <div class="truong-button-fixwidthright truong-rs-bt2" style="margin-right: 0px !important;">

                        <input type="submit" class="form-control luu" name="" value="Tìm kiếm">
                    </div>
                    <div class="truong-button-fixwidthright truong-rs-bt2">
                        <input type="button" class="form-control huybo" name="" value="Xóa điều kiện" onclick="clearText()">
                    </div>

                </div>
            </div>

        </div>
        <%
            }
        %>
        <div class="panel-body truong-margin-footer0px">
            <%
                if(ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_THEM)){
            %>
            <div class=" export-button truong-image-fix">
                <a class="truong-small-linkbt" href="${addUrl}"> <input type="button" class="form-control luu truong-image-bt "  name="" value="Thêm mới" ></a>

            </div>
            <%
                }
            %>
            <table class="table" style="margin-bottom:0%" >

                <tr class="border-table">
                    <th class=" ann-title border-table table-giua truong-rstable-widthper5">Mã Quận/huyện</th>
                    <th class=" ann-title border-table table-giua truong-rstable-widthper15">Tên Quận/huyện</th>
                    <th class=" ann-title border-table table-giua  truong-rstable-widthper5">Hành động</th>
                </tr>
                <c:if test="${items.total > 0}">
                    <c:forEach items="${items.items}" var="item">
                        <tr>
                            <td class="border-table align-giua truong-text-verticel  "><a href="${updateUrl}/${item.id}">${item.code}</a></td>
                            <td class="border-table truong-text-verticel" style="color: black;"><a href="${updateUrl}/${item.id}">${item.name}</a></td>
                            <td class="border-table align-giua truong-text-verticel" style="width: 10px">
                                <%
                                    if(ValidationPool.checkRoleDetail(request,"34", Constants.AUTHORITY_SUA)){
                                %>
                                <a href="${updateUrl}/${item.id}" class="btn btn-primary btn-xs">Cập nhật</a> /
                                <%
                                    }
                                %>
                                <%
                                    if(ValidationPool.checkRoleDetail(request,"34", Constants.AUTHORITY_XOA)){
                                %>
                                <a class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal${item.id}">Xóa</a>
                                <%
                                    }
                                %>
                            </td>


                            <div class="modal fade" id="myModal${item.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel" style="color: white">Xóa Quận/huyện!</h4>
                                        </div>
                                        <div class="modal-body">
                                            Xóa Quận/huyện có thể ảnh hưởng đến tài khoản người dùng thuộc Quận/huyện này. Bạn có chắc chắn muốn xóa Quận/huyện có mã là ${item.code}, click xác nhận để tiếp tục xóa.
                                        </div>
                                        <div class="modal-footer">
                                            <div class="row" style="margin-bottom: 2%;">
                                                <div class="col-md-2 col-md-offset-4">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 85px">Đóng</button>
                                                </div>
                                                <div class="col-md-2 ">
                                                    <a href="${deleteUrl}/${item.id}" class="btn btn-danger" style="width: 85px">Xác nhận</a>
                                                </div>

                                            </div>
                                            <%--<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                            <a href="${deleteUrl}/${item.id}" class="btn btn-danger">Xác nhận</a>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </tr>
                    </c:forEach>
                    <tr class="table-tr-xam">
                        <th colspan="7"><div class="truong-padding-foot-table">  Tổng số <span class="truong-text-colorred">${items.total}</span> dữ
                            liệu </div>
                            <div class="align-phai">
                                <c:if test="${items.page==1}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                <c:if test="${items.page!=1}">
                                    <img onclick="firstPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">
                                    <img onclick="previewPage()"
                                         class="pagging-icon"
                                         src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                </c:if>
                                    ${items.page}
                                trên ${items.totalPage}
                                <c:if test="${items.page==items.totalPage}">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                    <img
                                            class="truong-pagging-icon"
                                            src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                </c:if>
                                <c:if test="${items.page!=items.totalPage}">
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
                <c:if test="${items.total == 0}">
                    <tr>
                        <td colspan="7"
                            style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                            Không có dữ liệu
                        </td>
                    </tr>
                </c:if>

            </table>
        </div>
    </form>
</div>

<script type="text/javascript">
    $(".select2").select2();
</script>
<script>
    $(window).on('load resize',function(){
        var win = $(this);
        if(win.width() < 1260){

            $('.truong-rs-bt2').removeClass('truong-button-fixwidthright');
            $('.truong-rs-bt2').addClass('truong-button-fixwidthrightp5');
        }else {

            $('.truong-rs-bt2').removeClass('truong-button-fixwidthrightp5');
            $('.truong-rs-bt2').addClass('truong-button-fixwidthright');

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
        var totalPage = $('#totalPage').val();
        $('#page').val(totalPage);
        $("#search-frm").submit();
    }
    function clearText(){
        $('#code').val("");
        $('#name').val("");
    }
</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#quan-huyen").addClass("child-menu");
    });
</script>


