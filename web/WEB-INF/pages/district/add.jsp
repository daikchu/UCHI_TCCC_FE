<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />
<script>
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
</script>
<%--
    Thêm mói thông tin quận/huyện
--%>
<spring:url value="/system/district/add" var="addUrl" />
<spring:url value="/system/district/list" var="backUrl" />

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Thêm mới thông tin Quận/huyện</span>
</div>
<div class="truong-form-chinhbtt">
    <div id="uchi-status">
        <c:if test="${item.success == true}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">Tạo mới thông tin Quận/huyện thành công</div>
        </c:if>
        <c:if test="${item.success == false}">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">Tạo mới thông tin Quận/huyện không thành công</div>
        </c:if>
    </div>
    <div class="panel-group" id="accordion">
        <form class="form-horizontal" action="${addUrl}" method="post">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">

                        THÔNG TIN QUẬN/HUYỆN

                    </h4>
                </div>
                <div class="panel-body">
                    <div class="row truong-inline-field">

                        <div class="form-group">
                            <label class="col-md-3 control-label required label-bam-trai">Mã Quận/huyện</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control ${item.code_ != null? "error_input":""}" name="code" value="${item.code}">
                                <div class="error_tooltip">${item.code_}</div>
                            </div>
                            <div class="col-md-2"></div>
                            <label class="col-md-1 control-label required label-bam-phai text-nowrap">Tên Quận/huyện</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control ${item.name_ != null? "error_input":""}" name="name" value="${item.name}">
                                <div class="error_tooltip">${item.name_}</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="truong-prevent-btb">
                <div class="truong-can-button3">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"34", Constants.AUTHORITY_THEM)){
                    %>
                    <div class="col-md-2 col-md-offset-4 truong-rs-bt2os">
                        <input type="submit" class="form-control luu" name="" value="Lưu">
                    </div>
                    <%
                        }
                    %>
                    <div class="col-md-2 truong-rs-bt2">
                        <a href="${backUrl}"><input type="button" class="form-control huybo" name="" value="Hủy bỏ"></a>
                    </div>
                </div>
            </div>


        </form>
    </div>


</div>

<script>
    $(window).on('resize',function(){
        var win = $(this);
        if (win.width() < 1200){
            $('.truong-rs-bt2os').removeClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2os').addClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2').removeClass('col-md-2');
            $('.truong-rs-bt2').addClass('col-md-3');
        }else {
            $('.truong-rs-bt2os').removeClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2os').addClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2').removeClass('col-md-3');
            $('.truong-rs-bt2').addClass('col-md-2');
        }
    });
</script>
<script>

    $(function () {
        $('#birthday').datepicker({
            format: "dd/mm/yyyy",
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
    function changeOffice(e){
        var element = $(e).find('option:selected');
        var authorCode = element.attr("authorCode");
        $('#authorValue').text(authorCode);
        $('#authorId').val(authorCode);
    }
    $(document).ready(function () {
        var e = $('#officeAuthor');
        changeOffice(e);
    });
</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />

<script>
    $(document).ready(function () {
        var org_type=<%=SystemProperties.getProperty("org_type")%>;
        var userRole= $("#userRole").val();
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#ds-can-bo-stp").addClass("child-menu");




        //daicq
        var districtValue=$("#districtValue").val();
        $.getJSON(url+"/district/list-by-province/",function (data) {
            if(data.length){
                $('#districtCode').text("");
                for (var i = 0; i < data.length; i++) {
                    if(districtValue==data[i].code){
                        $('#districtCode').append('<option value="' + data[i].code + '"selected>' + data[i].name + '</option>');
                    }else{
                        $('#districtCode').append('<option value="' + data[i].code + '">' + data[i].name + '</option>');
                    }

                }

            }
        });

        var org_type='<%=SystemProperties.getProperty("org_type")%>';
        if(org_type=="0"){//is to chuc cong chung
            $('#div_CCV_hopDanh').show();
            $('#div_HuyenPx').hide();
        }
    });
</script>
