<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="layout/header.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/login.css" type="text/css"/>
<%--<script src="./static/plugin/jquery.min-1.9.1.js" type="text/javascript"></script>--%>
<%--<script src="./static/plugin/jquery.cookie.js" type="text/javascript"></script>
<script src="./static/js/login.js" type="text/javascript"></script>--%>

<%--<jsp:include page="layout/body_top.jsp" />--%>
<spring:url value="/forgot-password" var="quenmatkhauUrl"/>
<spring:url value="/preventmanager" var="preventManagerUrl"/>
<spring:url value="/login" var="loginUrl"/>

<form name="loginform" method="post" action="<%=request.getContextPath()%>/login" id="loginform">
    <input type="hidden" value="${stopUser}" id="stopUser">
    <div id="content" class="col-md-12">
        <div class="truong-logo-stp">
            <img id="img-uchi-logo" src="<%=request.getContextPath()%>/static/image/stp_logo.png" alt="Uchi Logo"
                 style="width: 100px !important;float: left;height: 100% !important;"/>
            <span style="vertical-align: middle;font-size: 20px;margin-left: 5px">Hệ Thống Quản Lý Chứng Thực Tỉnh Kiên Giang</span>

        </div>
        <div id="form" class="truong-login-form">
            <div id="focus">

                <div class="row">

                    <div id="uchi-logo" class="col-md-8 col-md-offset-2 col-xs-10 col-xs-offset-1 ">
                        <%--<img id="img-uchi-logo" src="<%=request.getContextPath()%>/static/image/login/uchi-icon.png" alt="Uchi Logo"/>--%>
                        <p id="uchi-slogan"> HỆ THỐNG CƠ SỞ DỮ LIỆU CÔNG CHỨNG VÀ THÔNG TIN NGĂN CHẶN </p>
                    </div>
                    <div class="col-md-2"></div>
                </div>
                <div id="truong-login-view" class="">
                    <ul>
                        <li class="col-md-5" id="uchi-info">
                            <%--<div class="row">
                                <div class="col-md-9"></div>
                                <div class="col-md-3">
                                    <img id="img-logo" src="<%=request.getContextPath()%>/static/image/login/uchi-icon2.png" alt="Uchi Logo"/>
                                </div>
                            </div>--%>
                            <div class="row" class="uchi-info">

                                <div class="col-md-12" id="about-us">
                                    <img src="<%=request.getContextPath()%>/static/image/login/uchi-icon.png"
                                         alt="Uchi Logo"
                                         style="max-width: 80px !important;max-height: 80px !important;"/>
                                    <p style="font-size: 14px !important;">Ngôi nhà chung của các tổ chức công chứng</p>
                                    <p style="margin-bottom: 0px !important;">Hotline: 02435 682 502 - 0986 083 003</p>
                                    <p>2019 Bản quyền thuộc về osp.com.vn</p>
                                </div>
                            </div>
                            <div class="row"></div>
                        </li>
                        <li class="truong-user-fixwidth" id="login-form">
                            <div class="row">
                                <div id="login-system">Đăng nhập hệ thống</div>
                            </div>
                            <div class="row">
                                <div class="image-user" style="float: left"></div>
                                <input type="text" name="username" id="username" placeholder="Tài khoản..."/>
                                <div class="error_tooltip">${loginForm.username_}</div>
                            </div>
                            <div class="row">
                                <div class="image-password" style="float: left"></div>
                                <input type="password" name="password" id="password" placeholder="Mật khẩu..."/>
                                <div class="error_tooltip">${loginForm.password_}</div>
                            </div>
                            <input type="hidden" name="flg_show_captcha" value="${loginForm.flg_show_captcha}"
                                   id="flg_show_captcha">

                            <div class="row" id="captchaAuth">

                                <div id="captchaChonSo">
                                    <div class="col-md-12 col-sm-12 col-xs-12 nopadding" style="padding-left: 0px;">
                                        <div class="form-group col-md-5 col-sm-5 col-xs-5 nopadding"
                                             style="float: left; padding-left:0%;">
                                            <input type="text" placeholder="Mã xác nhận" id="code_captcha"
                                                   name="captcha" class="form-control search_number enter"
                                                   style="width:100%">
                                        </div>
                                        <div class="form-group col-md-6 col-sm-5 col-xs-5 nopadding"
                                             style="padding-left:0%;">
                                            <img src="<%=request.getContextPath()%>/captcha"
                                                 style="max-width: 75%; padding-top:4%" id="imgCaptcha">
                                            <a style="padding-right: 0px" href="javascript:void(0)"
                                               onclick="changeCaptcha();"><span
                                                    class="fa fa-refresh" style="font-size: small"></span></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="error_tooltip">${captchaError}</div>
                            </div>
                            <div class="row" id="login-consol">
                                <button type="submit" class="col-md-5 col-xs-6" id="login">ĐĂNG NHẬP</button>
                                <%--<div class="col-md-1"></div>--%>
                                <div class="col-md-6 col-md-offset-1 col-xs-6" id="forget-pass"><a
                                        href="${quenmatkhauUrl}"><img id="forget-img"
                                                                      src="<%=request.getContextPath()%>/static/image/login/quenmatkhau.png">Quên
                                    mật khẩu?</a></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-1"></div>
        <div class="row" id="footer-info">
            <div class="col-md-3"><img src="<%=request.getContextPath()%>/static/image/login/uchi-icon-mini.png"> Quản
                Lý Chứng Thực 2019
            </div>
            <div class="col-md-5"></div>
            <div class="col-md-4" id="company">Công ty cổ phần công nghệ phần mềm và nội dung số OSP</div>
        </div>
    </div>
</form>
<div class="modal fade" id="myModal" role="dialog" style="margin-top: 150px;">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="panel-heading" style="background-color: #2e9ad0 ">
                <h5 class="panel-title truong-text-colorwhite">
                    Đăng nhập thất bại.
                    <button type="button" class="close truong-button-xoa" data-dismiss="modal" style="margin-bottom: 5px"><img
                            src="<%=request.getContextPath()%>/static/image/close.png" class="control-label truong-imagexoa-fix"></button>
                </h5>
            </div>
            <div class="panel-body">
                <div class="truong-modal-padding" style="padding-bottom: 7%;">
                    <label class="col-md-12 control-label align-giua" id="loginErrorCode" style="color: red;"></label>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var firstTarget = $("form[name ='loginform']").find('input[type=text],textarea,select').filter(':visible:first');
        firstTarget.focus();
        $(".error_input:first").focus();

    });
</script>
<style>
    input:-webkit-autofill,
    input:-webkit-autofill:hover,
    input:-webkit-autofill:focus,
    input:-webkit-autofill {


        -webkit-box-shadow: 0 0 0px 1000px white inset;
    }
</style>

<%--<jsp:include page="layout/footer.jsp" />--%>
<script type="text/javascript">
    $(document).ready(function () {
        var flg_show_captcha = $("#flg_show_captcha").val();
        if(flg_show_captcha!=1){
            $('#captchaAuth').css('display','none');
        }

        var stopUser = $("#stopUser").val();
        if(stopUser != null && stopUser.length > 0){
            $("#loginErrorCode").text(stopUser);
            $("#myModal").modal("show");
        }
    });

    function changeCaptcha(){
        var _uri = $("body").attr("uri");
        $("#imgCaptcha").attr("src", "<%=request.getContextPath()%>/captcha?u="+new Date());
    }
</script>

<script>
    $(window).on('load resize', function () {
        var win = $(this);
        if (win.width() < 970 && win.width() > 700) {
            $('#truong-login-view').addClass('truong-padding-300px');


        } else {
            $('#truong-login-view').removeClass('truong-padding-300px');
        }
    });
    $(window).on('load resize', function () {
        var win = $(this);
        if (win.width() > 700) {
            $('#uchi-info').css('display', 'block');


        } else {
            $('#uchi-info').css('display', 'none');
        }
    });
</script>

