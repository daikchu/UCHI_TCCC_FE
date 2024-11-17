<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.service.QueryFactory" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/index.css?<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/citizenVerify/add-number-verify-citizen.css?<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/citizenVerify/payment-transaction.css?<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/citizenVerify/citizen-verification.css?<%= System.currentTimeMillis() %>">
<link rel="stylesheet"
      href="<%=request.getContextPath()%>/static/css/citizenVerify/display-payment-transaction-error.css?<%= System.currentTimeMillis() %>">
<link rel="stylesheet"
      href="<%=request.getContextPath()%>/static/css/citizenVerify/display-payment-transaction-success.css?<%= System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<%--
    Thêm mói nhóm quyền
--%>


<spring:url value="/system/create-grouprole" var="addUrl"/>
<%--<spring:url value="/announcement/update-view" var="announcementUrl"/>--%>
<spring:url value="/contract/detail" var="contractUrl"/>
<spring:url value="/announcement/list" var="announcementListUrl"/>
<spring:url value="/transaction/search" var="searchUrl"/>
<spring:url value="/contract/add" var="addUrl"/>
<spring:url value="/contract/get-kinds" var="getKindUrl"/>
<spring:url value="/system/download" var="downloadUrl"/>
<spring:url value="/announcement/download-from-stp-api" var="downloadUrlFromSTP"/>
<spring:url value="/announcement/download" var="downloadUrlTCCC"/>
<spring:url value="system/osp/contracttemplate-view" var="contractTemplateView"/>
<spring:url value="/announcement/announcement-detail-view" var="announcementUrl"/>
<spring:url value="/contract/FindContractTempListByParentId" var="FindContractTempListByParentId"/>
<%
    String checkcongchung=SystemProperties.getProperty("org_type");
    String congchung=checkcongchung.equals("1")?"chứng thực":"công chứng";
    String congchungH=checkcongchung.equals("1")?"Chứng thực":"Công chứng";
    String congchungHOA=checkcongchung.equals("1")?"CHỨNG THỰC":"CÔNG CHỨNG";


%>

<script>
    var contextPath = '<%=request.getContextPath()%>';
    var ospApiUrl = '<%=SystemProperties.getProperty("OSP_API_LINK_PUBLIC")%>';
    <%--var notary_office= '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getAgency()%>';--%>
    var notary_office = '<%=QueryFactory.getSystemConfigByKey("system_authentication_id")%>';
    var province_code = '<%=QueryFactory.getSystemConfigByKey("notary_office_province_code")%>';
    var notary_officer = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getFamily_name()%>' + " " + '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getFirst_name()%>';
    var update_by = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getAccount()%>';
    var update_by_name = notary_officer;
    // $("#errorUnitPrice").show();
    // setTimeout(function() { $("#errorUnitPrice").hide(); }, 5000);
    // if(document.getElementById("errorUnitPrice").style.display == 'block'){
    //     setTimeout(function() { $("#errorUnitPrice").style.display == 'none'}, 3000);
    // }
</script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/websocket/index.js?v=20231107" type="text/javascript"></script>--%>
<script src="<%=request.getContextPath()%>/static/qrcode/qrcode.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/main.js?v=20231107" type="text/javascript"></script>

<script src="<%=request.getContextPath()%>/static/js/checkId/index.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/checkId/faceIdSocket.js" type="text/javascript"></script>


<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Trang chủ</span>
</div>
<div id="home-wapper" ng-app="osp" ng-controller="indexFaceIdController">
    <div class="col-md-12">
        <div id="uchi-status"
             style="padding-left: 15px;padding-right: 15px; padding-bottom: 5px;margin-top:0px !important;">
            <c:if test="${successCode != null}">
                <div class="status-success"><img class="status-img"
                                                 src="<%=request.getContextPath()%>/static/image/success.png">${successCode}
                </div>
            </c:if>
            <c:if test="${errorCode != null}">
                <div class="status-error"><img class="status-img"
                                               src="<%=request.getContextPath()%>/static/image/error.png">${errorCode}
                </div>
            </c:if>
        </div>
        <div class="col-md-8">
            <div class="home-header "><a href="${announcementListUrl}" class="truong-small-home">BẢNG THÔNG BÁO NỘI
                BỘ</a></div>


            <div class="home-content">

                <c:forEach items="${homeForm.announcementArrayList}" var="item" varStatus="index">
                    <div class="other-row"><span class="other-cursor">${index.index + 1}</span>
                        <div class="other-title">
                            <a href="${announcementUrl}/${item.aid}">${item.title}</a>
                            <c:if test="${item.importance_type == 2}">
                                <img style="height: 21px;float: top;padding-bottom: 7px;"
                                     src="<%=request.getContextPath()%>/static/image/flag.png">
                            </c:if>
                        </div>
                    </div>

                </c:forEach>

            </div>
            <%-- <div ="home-anouncement-other">Thông báo khác<span class="ann-see-all"><a href="${announcementListUrl}">Xem tất cả ></a></span>
             </div>--%>


            <div class="home-header truong-margin-top30px"><a href="${announcementListUrl}?tab=stp"
                                                              class="truong-small-home">BẢNG THÔNG BÁO TỪ SỞ TƯ PHÁP</a>
            </div>
            <div class="home-content">

                <c:forEach items="${homeForm.stpAnnouncementArrayList}" var="item" varStatus="index">
                    <div class="other-row"><span class="other-cursor">${index.index + 1}</span>
                        <div class="other-title">
                            <a href="<%=request.getContextPath()%>/announcement/view/${item.aid}">${item.title}</a>
                            <c:if test="${item.importance_type == 2}">
                                <img style="height: 21px;float: top;padding-bottom: 7px;"
                                     src="<%=request.getContextPath()%>/static/image/flag.png">
                            </c:if>
                        </div>
                    </div>

                </c:forEach>

            </div>
            <%--<div class="home-anouncement-other">Thông báo khác<span class="ann-see-all"><a href="${announcementListUrl}">Xem tất cả ></a></span>
            </div>--%>

            <div class="home-header truong-margin-top30px"><a href="<%=request.getContextPath()%>/contract/list"
                                                              class="truong-small-home">HỢP ĐỒNG MỚI NHẬP </a></div>
            <div class="home-content">

                <c:forEach items="${homeForm.contractArrayList}" var="item" varStatus="index">
                    <div class="other-row"><span class="other-cursor">${index.index + 1}</span>
                        <div class="other-title"><a href="${contractUrl}/${item.id}">${item.contract_number}</a></div>

                    </div>

                </c:forEach>

            </div>

        </div>
        <div class="col-md-4">
            <div class="home-header"><a href="" class="truong-small-home">CÔNG CỤ TRUY CẬP NHANH</a></div>
            <div class="home-content">
                <div class="col-md-12" style="display: flex">
                    <div class="col-md-6 clear-padding">
                        <a href="${searchUrl}"><img class="home-fast-icon"
                                                    src="<%=request.getContextPath()%>/static/image/home-1.png"
                                                    width="90%"></a>
                    </div>
                    <div class="col-md-6 clear-padding align-phai">
                        <a href="${addUrl}"><img class="home-fast-icon"
                                                 src="<%=request.getContextPath()%>/static/image/home-2.png"
                                                 width="90%"></a>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-12 clear-padding">
                        <div class="home-fast-icon"
                             style="width: 100%; padding: 16px; background: white; box-shadow: 0px 32px 48px -8px rgba(0, 0, 0, 0.04); border-radius: 8px; overflow: hidden; border-left: 0.50px #F4F4F4 solid; border-top: 0.50px #F4F4F4 solid; border-right: 0.50px #F4F4F4 solid; border-bottom: 0.50px #F4F4F4 solid; backdrop-filter: blur(32px); flex-direction: column; justify-content: center; align-items: flex-start; gap: 16px; display: inline-flex">
                            <div style="align-self: stretch; justify-content: flex-start; align-items: center; gap: 12px; display: inline-flex">
                                <div style="padding: 10px; border-radius: 71px; justify-content: flex-start; align-items: flex-start; gap: 10px; display: flex; background-image: url(<%=request.getContextPath()%>/static/image/icon-mkserver/icon-scan.png)">
                                    <div style="width: 20px; height: 20px; position: relative">
                                        <div style="width: 17.92px; height: 17.92px; left: 1.04px; top: 1.04px; position: absolute;"></div>
                                    </div>
                                </div>
                                <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                                    <div style="text-align: center; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        Xác thực danh tính công dân
                                    </div>
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Cơ sở dữ liệu từ Bộ Công an
                                    </div>
                                </div>
                            </div>
                            <%--                            <div ng-click="devices();" data-toggle="modal" data-target="#popupIdentification" style="cursor: pointer;align-self: stretch; padding-left: 16px; padding-right: 16px; padding-top: 8px; padding-bottom: 8px; background: #0054D1; border-radius: 8px; justify-content: center; align-items: center; gap: 8px; display: inline-flex">--%>
                            <%--                                <div style="color: #FCFCFC; font-size: 13px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">--%>
                            <%--                                    Xác thực định danh--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <div ng-click="devices(true, false)"
                                 style="cursor: pointer;align-self: stretch; padding-left: 16px; padding-right: 16px; padding-top: 8px; padding-bottom: 8px; background: #0054D1; border-radius: 8px; justify-content: center; align-items: center; gap: 8px; display: inline-flex">
                                <div style="color: #FCFCFC; font-size: 13px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">
                                    Xác thực (còn {{verify_number_available.verify_number_total}} lượt)
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="home-header"><a href="" class="truong-small-home">HỢP ĐỒNG <%=congchungHOA%>
            </a></div>
            <div class="home-content">

                <div class="other-row">
                    <div class="other-title2 truong-other-title"><img class="home-tttc"
                                                                      src="<%=request.getContextPath()%>/static/image/cursor.png">
                        <a href="<%=request.getContextPath()%>/contract/list" onclick="showImage()">Hợp
                            đồng <%=congchung%>
                        </a></div>
                </div>
                <div class="other-row">
                    <div class="other-title2 truong-other-title"><img class="home-tttc"
                                                                      src="<%=request.getContextPath()%>/static/image/cursor.png">
                        <a href="<%=request.getContextPath()%>/contract/not-sync-list" onclick="showImage()">Hợp đồng
                            chưa đồng bộ </a></div>
                </div>
            </div>
            <div class="home-header col-item"><a href="" class="truong-small-home">DANH SÁCH HỢP ĐỒNG MẪU</a></div>
            <div class="home-content col-md-12 truong-padding-delete">
                <div style="margin-left: 10px;margin-right: 10px;margin-bottom: 10px">
                    <select onchange="changContractkind(this)" id="changContractkind"
                            class="form-control truong-select truong-selectbox-padding">
                        <c:forEach items="${homeForm.contractKinds}" var="item">
                            <option value="${item.contract_kind_code}">${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div id="contract-template" style="margin: 20px;">
                    <c:forEach items="${homeForm.contractTemplates}" var="item">
                        <c:if test="${item.file_name != nullchangeUnitPrice && item.file_name != '' && item.file_name != 'null'}">
                            <a href="${downloadUrl}?filename=${item.file_name}&filepath=${item.file_path}">
                                    ${item.file_name}
                            </a><br>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="popupIdentification" role="dialog">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content" style="width:850px;">
                <div class="modal-header">

                    <button ng-click="closeWebSocket();"
                            type="button" class="close"
                    <%--                            data-dismiss="modal"--%>
                            data-toggle="modal" data-target="#confirmClosePopupVerify">&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>

                <div ng-show="stateIdentity == -2"
                     style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">
                    <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">

                        <div style="text-align: center; color: #9A9FA5; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 32px; word-wrap: break-word">
                            Tìm thiết bị
                        </div>

                        <div style="width: 101px; height: 101px; background: #58C27D; border-radius: 200px; border-left: 3px #B5E4CA solid; border-top: 3px #B5E4CA solid; border-right: 3px #B5E4CA solid; border-bottom: 3px #B5E4CA solid; justify-content: center; align-items: center; display: inline-flex">
                            <img style="width: 117px; height: 117px"
                                 src="<%=request.getContextPath()%>/static/image/icon-mkserver/mk-device-icon.png"/>
                        </div>
                        <div style="margin-top: 10px;flex-direction: column; justify-content: flex-start; align-items: center; gap: 28px; display: flex">
                            <div style="text-align: center; color: #FF6A55; font-size: 14px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
                                Hãy đảm bảo thiết bị đầu đọc CCCD<br/>đã được kết nối vào máy tính
                            </div>
                            <div data-dismiss="modal" ng-click="closeWebSocket();"
                                 style="padding-bottom: 20px; cursor: pointer; padding-left: 20px; padding-right: 20px; padding-top: 12px; padding-bottom: 12px; background: #FCFCFC; border-radius: 12px; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; gap: 8px; display: inline-flex">
                                <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">
                                    Hủy bỏ
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- error --%>
                <div ng-show="stateIdentity == -1 && (errorIdentity.code == 1016 || errorIdentity.code == -1)"
                     class="modal-body" style="height: unset; overflow-y: unset">
                    <div style="width: 100%; padding: 24px; background: #FCFCFC; box-shadow: 0px 32px 48px -8px rgba(0, 0, 0, 0.10); border-radius: 20px; backdrop-filter: blur(32px); flex-direction: column; justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">

                        <div style="width: 100px; padding-left: 34px; padding-right: 34px; padding-top: 30px; padding-bottom: 30px; background: #F4F4F4; box-shadow: 0px 64px 64px -48px rgba(14.88, 14.88, 14.88, 0.10); border-radius: 1000px; overflow: hidden; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; display: inline-flex">
                            <div style="text-align: center; color: black; font-size: 32px; font-family: Inter; font-weight: 600; line-height: 40px; word-wrap: break-word">
                                ❌
                            </div>
                        </div>
                        <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 24px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: flex">
                                <div style="width: 452px; text-align: center; color: #FF6A55; font-size: 24px; font-family: Inter; font-weight: 600; line-height: 32px; word-wrap: break-word">
                                    {{errorIdentity.messageFix}}
                                </div>
                                <div style="width: 452px; text-align: center; color: #6F767E; font-size: 15px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word"
                                     ng-bind-html="errorIdentity.messageHtml"></div>
                            </div>
                            <div ng-show="errorIdentity.code != 602"
                                 style="justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                <div ng-click="closeWebSocket();" data-dismiss="modal"
                                     style="cursor: pointer; padding-left: 20px; padding-right: 20px; padding-top: 12px; padding-bottom: 12px; background: #FCFCFC; border-radius: 12px; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; gap: 8px; display: flex">
                                    <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">
                                        Đã hiểu
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div ng-show="stateIdentity == -1 && errorIdentity.code != 1016 && errorIdentity.code != -1" class="modal-body">
                    <%--<div ng-show="errorIdentity.code != 1016" class="show-verify-number-available">
                        Còn
                        <span ng-if="verify_number_available.verify_number_total > 0" class="citizen-verify-number-more0">{{verify_number_available.verify_number_total}}</span>
                        <span ng-if="verify_number_available.verify_number_total == 0" class="citizen-verify-number-0">{{verify_number_available.verify_number_total}}</span>
                        lượt xác thực
                    </div>--%>
                    <div ng-show="errorIdentity.code != 1016" class="show-verify-number-available-background">
                        Còn {{verify_number_available.verify_number_total > 10 ?
                        verify_number_available.verify_number_total : '0' +
                        verify_number_available.verify_number_total}} lượt xác thực
                    </div>
                    <div style="width: 100%; padding: 24px; background: #FCFCFC; box-shadow: 0px 32px 48px -8px rgba(0, 0, 0, 0.10); border-radius: 20px; backdrop-filter: blur(32px); flex-direction: column; justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">

                        <div ng-show="errorIdentity.code != 1016"
                             style="padding: 12px; background: #F4F4F4; border-radius: 8px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: flex">
                                <div style="width: 100%; color: #6F767E; font-size: 14px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
                                    Hướng dẫn sử dụng máy xác thực định danh:
                                </div>
                                <div style="justify-content: flex-start; align-items: center; gap: 12px; display: inline-flex">
                                    <div style="padding-left: 4px; padding-right: 4px; background: white; border-radius: 100px; border-left: 0.50px #EFEFEF solid; border-top: 0.50px #EFEFEF solid; border-right: 0.50px #EFEFEF solid; border-bottom: 0.50px #EFEFEF solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: inline-flex">
                                        <div style="width: 16px; text-align: center; color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            1
                                        </div>
                                    </div>
                                    <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        Đặt CCCD lên khu vực đọc thẻ
                                    </div>
                                </div>
                                <div style="justify-content: flex-start; align-items: center; gap: 12px; display: inline-flex">
                                    <div style="padding-left: 4px; padding-right: 4px; background: white; border-radius: 100px; border-left: 0.50px #EFEFEF solid; border-top: 0.50px #EFEFEF solid; border-right: 0.50px #EFEFEF solid; border-bottom: 0.50px #EFEFEF solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: inline-flex">
                                        <div style="width: 16px; text-align: center; color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            2
                                        </div>
                                    </div>
                                    <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        Thực hiện quét khuôn mặt trên thiết bị
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style="width: 100px; padding-left: 34px; padding-right: 34px; padding-top: 30px; padding-bottom: 30px; background: #F4F4F4; box-shadow: 0px 64px 64px -48px rgba(14.88, 14.88, 14.88, 0.10); border-radius: 1000px; overflow: hidden; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; display: inline-flex">
                            <div style="text-align: center; color: black; font-size: 32px; font-family: Inter; font-weight: 600; line-height: 40px; word-wrap: break-word">
                                ❌
                            </div>
                        </div>
                        <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 24px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: flex">
                                <div style="width: 452px; text-align: center; color: #FF6A55; font-size: 24px; font-family: Inter; font-weight: 600; line-height: 32px; word-wrap: break-word">
                                    {{errorIdentity.messageFix}}
                                </div>
                                <div style="width: 452px; text-align: center; color: #6F767E; font-size: 15px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word"
                                     ng-bind-html="errorIdentity.messageHtml"></div>
                            </div>
                            <div ng-show="errorIdentity.code != 602"
                                 style="justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                <div ng-click="closeWebSocket();" data-dismiss="modal"
                                     style="cursor: pointer; padding-left: 20px; padding-right: 20px; padding-top: 12px; padding-bottom: 12px; background: #FCFCFC; border-radius: 12px; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; gap: 8px; display: flex">
                                    <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">
                                        Hủy bỏ
                                    </div>
                                </div>
                                <div ng-click="retryToVerify(errorIdentity.code)"
                                     style="cursor: pointer; justify-content: flex-start; align-items: flex-start; gap: 12px; display: flex">
                                    <div style="padding-left: 20px; padding-right: 20px; padding-top: 12px; padding-bottom: 12px; background: #2A85FF; border-radius: 12px; justify-content: center; align-items: center; gap: 8px; display: flex">
                                        <div style="color: #FCFCFC; font-size: 15px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word">
                                            Thử lại
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div ng-show="errorIdentity.code == 602"
                                 style="justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                <button ng-click="showDlgBuyNumberVerify(false, 'buyNumberVerifyOrVerify')"
                                        data-dismiss="modal" class="btn-white">Mua thêm lượt
                                </button>
                                <button ng-if="verify_number_available.verify_number_total > 0" ng-click="devices(false, true
                                );" class="btn-blue">Tiếp tục xác thực
                                </button>
                                <button disabled
                                        ng-if="verify_number_available.verify_number_total == '' || verify_number_available.verify_number_total == 0"
                                        class="btn-blue-disable">Tiếp tục xác thực
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- scan processing --%>
                <div ng-show="stateIdentity == 0 || stateIdentity == 1 || stateIdentity == 2" class="modal-body">
                    <div class="popup-content-citizen-verification">
                        <div class="show-verify-number-available-background">
                            Còn {{verify_number_available.verify_number_total > 10 ?
                            verify_number_available.verify_number_total : '0' +
                            verify_number_available.verify_number_total}} lượt xác thực
                        </div>
                        <div style="padding: 12px; background: #F4F4F4; border-radius: 8px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: flex">
                                <div style="width: 100%; color: #6F767E; font-size: 14px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
                                    Hướng dẫn sử dụng máy xác thực định danh:
                                </div>
                                <div style="justify-content: flex-start; align-items: center; gap: 12px; display: inline-flex">
                                    <div style="padding-left: 4px; padding-right: 4px; background: white; border-radius: 100px; border-left: 0.50px #EFEFEF solid; border-top: 0.50px #EFEFEF solid; border-right: 0.50px #EFEFEF solid; border-bottom: 0.50px #EFEFEF solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: inline-flex">
                                        <div style="width: 16px; text-align: center; color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            1
                                        </div>
                                    </div>
                                    <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        Đặt CCCD vào khe thiết bị đọc thẻ
                                    </div>
                                </div>
                                <div style="justify-content: flex-start; align-items: center; gap: 12px; display: inline-flex">
                                    <div style="padding-left: 4px; padding-right: 4px; background: white; border-radius: 100px; border-left: 0.50px #EFEFEF solid; border-top: 0.50px #EFEFEF solid; border-right: 0.50px #EFEFEF solid; border-bottom: 0.50px #EFEFEF solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: inline-flex">
                                        <div style="width: 16px; text-align: center; color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            2
                                        </div>
                                    </div>
                                    <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        Thực hiện quét khuôn mặt trên thiết bị
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div ng-show="stateIdentity == 0"
                             style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">

                                <div style="text-align: center; color: #9A9FA5; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 32px; word-wrap: break-word">
                                    Sẵn sàng quét thẻ CCCD
                                </div>

                                <div style="width: 101px; height: 101px; background: #58C27D; border-radius: 200px; border-left: 3px #B5E4CA solid; border-top: 3px #B5E4CA solid; border-right: 3px #B5E4CA solid; border-bottom: 3px #B5E4CA solid; justify-content: center; align-items: center; display: inline-flex">
                                    <img style="width: 117px; height: 117px"
                                         src="<%=request.getContextPath()%>/static/image/icon-mkserver/mk-device-icon.png"/>
                                </div>

                                <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 28px; display: flex">
                                    <div class="citizen-verify-scanning-text">Hãy đảm bảo thẻ CCCD <br/>được đặt đúng vị
                                        trí đặt nhé
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div ng-show="stateIdentity == 1 || stateIdentity == 2"
                             style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">

                                <div style="text-align: center; color: #9A9FA5; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 32px; word-wrap: break-word">
                                    Sẵn sàng kiểm tra <br>dấu vân tay
                                </div>

                                <div style="width: 101px; height: 101px; background: #58C27D; border-radius: 200px; border-left: 3px #B5E4CA solid; border-top: 3px #B5E4CA solid; border-right: 3px #B5E4CA solid; border-bottom: 3px #B5E4CA solid; justify-content: center; align-items: center; display: inline-flex">
                                    <img style="width: 117px; height: 117px"
                                         src="<%=request.getContextPath()%>/static/image/icon-mkserver/mk-device-icon.png"/>
                                </div>

                                <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 16px; display: flex">
                                    <%--                                    <div style="text-align: center; color: #6F767E; font-size: 14px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">Đang xác thực, giữ nguyên thiết bị</div>--%>
                                    <div style="justify-content: flex-start; align-items: flex-end; gap: 8px; display: inline-flex">
                                        <img style="height: 20px"
                                             src="<%=request.getContextPath()%>/static/image/icon-mkserver/loading.svg"/>
                                    </div>
                                    <%--<div data-dismiss="modal" ng-click="closeWebSocket();" style="cursor: pointer; padding-left: 20px; padding-right: 20px; padding-top: 12px; padding-bottom: 12px; background: #FCFCFC; border-radius: 12px; border-left: 1px #EFEFEF solid; border-top: 1px #EFEFEF solid; border-right: 1px #EFEFEF solid; border-bottom: 1px #EFEFEF solid; justify-content: center; align-items: center; gap: 8px; display: inline-flex">
                                        <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 700; line-height: 24px; word-wrap: break-word;">
                                            Hủy bỏ
                                        </div>
                                    </div>--%>
                                </div>

                            </div>
                        </div>

                        <%--<div ng-show="stateIdentity == 2" style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">
                            <div style="flex-direction: column; justify-content: flex-start; align-items: center; gap: 32px; display: flex">

                                <div style="text-align: center; color: #9A9FA5; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 32px; word-wrap: break-word">Sẵn sàng quét</div>

                                <div style="width: 100%; height: 101px; border-radius: 200px; justify-content: center; align-items: center; display: inline-flex">
                                    <img style="width: 117px; height: 117px" src="data:image/png;base64,{{webSocketData.image}}" />
                                </div>

                            </div>
                        </div>--%>

                    </div>
                </div>

                <%-- success --%>
                <div ng-show="stateIdentity == 3" class="modal-body">
                    <div style="width: 100%; padding: 24px; background: #FCFCFC; box-shadow: 0px 32px 48px -8px rgba(0, 0, 0, 0.10); border-radius: 20px; backdrop-filter: blur(32px); flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 24px; display: inline-flex">
                        <div class="show-verify-number-available">
                            Còn
                            <span ng-if="verify_number_available.verify_number_total > 0"
                                  class="citizen-verify-number-more0">{{verify_number_available.verify_number_total}}</span>
                            <span ng-if="verify_number_available.verify_number_total == 0"
                                  class="citizen-verify-number-0">{{verify_number_available.verify_number_total}}</span>
                            lượt xác thực
                        </div>
                        <div style="align-self: stretch; justify-content: flex-start; align-items: flex-start; gap: 48px; display: inline-flex">
                            <div style="justify-content: flex-start; align-items: flex-start; gap: 8px; display: flex">
                                <div style="width: 24px; height: 24px; position: relative">
                                    <div style="width: 24px; height: 24px; left: 0px; top: 0px; position: absolute">
                                        <div style="width: 24px; height: 24px; left: 2px; top: 2px; position: absolute; background-image: url(<%=request.getContextPath()%>/static/image/icon-mkserver/check-ok.png)"></div>
                                        <div style="width: 24px; height: 24px; left: 24px; top: 24px; position: absolute; transform: rotate(-180deg); transform-origin: 0 0; opacity: 0"></div>
                                    </div>
                                </div>
                                <div style="text-align: center; color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                    Xác thực danh tính thành công!
                                </div>
                            </div>
                        </div>
                        <div style="width: 100%; height: 396px; position: relative; background: linear-gradient(291deg, #AFE5E7 0%, #FCFCFC 100%); border-radius: 12px; overflow: hidden; border-left: 1px #BAE7EF solid; border-top: 1px #BAE7EF solid; border-right: 1px #BAE7EF solid; border-bottom: 1px #BAE7EF solid">
                            <img style="width: 100%; top: 0px; position: absolute; opacity: 0.40"
                                 src="<%=request.getContextPath()%>/static/image/icon-mkserver/bg-scan-success.png"/>

                            <img style="width: 158px; height: 212px; left: 24px; top: 158px; position: absolute; border-radius: 8px"
                                 src="data:image/png;base64,{{citizenInformation.avatar_img}}"/>

                            <div style="left: 24px; top: 24px; position: absolute; flex-direction: column; justify-content: center; align-items: flex-start; gap: 12px; display: inline-flex">
                                <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Số CCCD
                                    </div>
                                    <div style="color: #2A85FF; font-size: 20px; font-family: Inter; font-weight: 600; line-height: 28px; word-wrap: break-word">
                                        {{citizenInformation.cccd_number}}
                                    </div>
                                </div>
                                <div style="width: 52px; height: 2px; position: relative; background: #BAE7EF; border-radius: 1px"></div>
                                <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Số CMND đã cấp
                                    </div>
                                    <div style="color: #272B30; font-size: 20px; font-family: Inter; font-weight: 600; line-height: 28px; word-wrap: break-word">
                                        {{citizenInformation.cmnd_number}}
                                    </div>
                                </div>
                            </div>
                            <div style="left: 206px; top: 24px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                <div style="align-self: stretch; justify-content: space-between; align-items: flex-start; gap: 32px; display: inline-flex">
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Họ và tên
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.full_name}}
                                            </div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Quốc tịch
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.country}}
                                            </div>
                                        </div>
                                    </div>
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Ngày sinh
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.date_of_birth}}
                                            </div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Dân tộc
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.ethnic}}
                                            </div>
                                        </div>
                                    </div>
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 12px; display: inline-flex">
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Giới tính
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.sex}}
                                            </div>
                                        </div>
                                        <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                            <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                                Tôn giáo
                                            </div>
                                            <div style="color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                                {{citizenInformation.religion}}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="align-self: stretch; height: 44px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Quê quán
                                    </div>
                                    <div style="align-self: stretch; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        {{citizenInformation.hometown}}
                                    </div>
                                </div>
                                <div style="align-self: stretch; height: 44px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Địa chỉ thường trú
                                    </div>
                                    <div style="align-self: stretch; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        {{citizenInformation.permanent_address}}
                                    </div>
                                </div>
                                <div style="align-self: stretch; justify-content: flex-start; align-items: flex-start; gap: 39px; display: inline-flex">
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: inline-flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                            Ngày cấp
                                        </div>
                                        <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            {{citizenInformation.date_issuance}}
                                        </div>
                                    </div>
                                    <div style="flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: inline-flex">
                                        <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                            Ngày hết hạn
                                        </div>
                                        <div style="color: #1A1D1F; font-size: 14px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                            {{citizenInformation.date_expiration}}
                                        </div>
                                    </div>
                                </div>
                                <div style="align-self: stretch; height: 68px; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: flex">
                                    <div style="color: #6F767E; font-size: 13px; font-family: Inter; font-weight: 500; line-height: 16px; word-wrap: break-word">
                                        Đặc điểm nhận dạng
                                    </div>
                                    <div style="width: 354px; color: #1A1D1F; font-size: 15px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
                                        {{citizenInformation.identification_characteristics}}
                                    </div>
                                </div>
                            </div>
                            <img class="icon-quochuy"
                                 src="<%=request.getContextPath()%>/static/image/icon-mkserver/quoc-huy-viet-nam.png"/>
                        </div>
                        <div class="form-group" style="width: 100%">
                            <label class="col-md-3 control-label label-bam-trai">Tải file xác thực</label>
                            <div class="col-md-5 themfile">
                                <input class="prevent-file_upload myFile" type="file" id="faceId_file" name="multipartFile">
<%--                                <div class="error_tooltip">Folder url: C:\ProgramData\Microsoft\Crypto\Mobile-ID\CheckID Client v2.0\Daily Export Data\2024-11-06\PDF</div>--%>
                            </div>
                            <div class="col-md-4">
                                <a class="btn-primary btn-xs" style="float: right" onclick="themFile();">Lưu file</a>
                            </div>
                        </div>
                        <div ng-show="errorIdentity.code==0"
                             style="color: #71717A; font-size: 14px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
                            *Các thông tin cá nhân đã xác thực định danh thành công sẽ được lưu lại và gợi ý theo số
                            CCCD tại chức năng nhập/soạn thảo thông tin văn bản công chứng!
                        </div>
                        <div style="height: 1px; position: relative; background: #EFEFEF; border-radius: 1px"></div>
                        <div style="width: 100%; justify-content: space-between; align-items: flex-start; gap: 24px; display: flex">
                            <button ng-click="showDialogNew('buyNumberVerifyOrVerify','buyNumberVerify')"
                                    data-dismiss="modal" class="btn-white">Mua thêm lượt
                            </button>
                            <button ng-if="verify_number_available.verify_number_total > 0"
                                    ng-click="devices(false, true);" class="btn-blue">Tiếp tục xác thực
                            </button>
                            <button disabled
                                    ng-if="verify_number_available.verify_number_total == '' || verify_number_available.verify_number_total == 0"
                                    class="btn-blue-disable">Tiếp tục xác thực
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="buyNumberVerifyOrVerify" role="dialog" data-backdrop="static" style="width:auto;">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>
                <main style="height: 300px !important;">
                    <div class="main">
                        <div class="main_container">
                            <div class="main_content">
                                <h5 style="color: #83BF6E ">Còn {{verify_number_available.verify_number_total}} lượt xác thực</h5>
                                <span>Anh chị muốn xác thực ngay </span>
                                <span>hay mua thêm lượt xác thực mới</span>
                            </div>
                            <div class="main_btn">
                                <%--                                data-toggle="modal" data-target="#buyNumberVerify"--%>
                                <%--    showDialogNew('buyNumberVerifyOrVerify','popupIdentification')--%>
                                <button class="btn1"
                                        ng-click="showDialogNew('buyNumberVerifyOrVerify','buyNumberVerify');">
                                    <span style="font-weight: bold">+   </span>Mua thêm
                                    lượt
                                </button>
                                <button class="btn2" ng-click="devices(false, true);" style="background-color: #2CA9E0">
                                    <img src="<%=request.getContextPath()%>/static/image/scan.png"
                                         alt="" style="width: 22px">
                                        Xác thực ngay</button>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmClosePopupVerify" role="dialog" style="width:auto;">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content modal-sm">
                <div class="modal-header">
                    <button data-dismiss="modal" type="button" class="close">&times;</button>
                    <h4 class="modal-title">Xác nhận dừng xác thực</h4>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <div class="row">
                            <span>Anh chị xác nhận dừng quá trình xác thực danh tính</span>
                        </div>

                    </div>
                </div>
                <div class="modal-footer truong-text-center">
                    <button style="background-color: #FFFFFF !important; color: black !important;border-radius: 5px"
                            data-dismiss="modal"
                            type="button" class="button-box huybo">Hủy bỏ
                    </button>
                    <button style="background-color: #0054D1 !important; border-radius: 5px"
                            ng-click="closeCitizenVerifyPopup();"
                            data-dismiss="#popupIdentification" class="button-box luu">Xác nhận
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="buyNumberVerify" role="dialog" data-backdrop="static" style="width:auto;">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content" style="width:850px">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="ClosePopupPurchase(true)">&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>
                <%--<div id="errorUnitPrice">
                    <div class="status-error" ng-if="error_unit_price != '' ">
                        <img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">
                        {{error_unit_price}}
                    </div>
                </div>--%>
                <div class="modal-body" style="height: unset; overflow-y: unset">
                    <h5 class="title-buy-more-verify-number">Mua thêm lượt xác thực</h5>
                    <main>
                        <div class="main">
                            <div class="main_container_add_verify_citizen">
                                <div class="main_price" style="    justify-content: left;margin-left: 15px;font-weight: bold;color: var(--neutral-04, #6F767E);">
                                    <span>Số lượt xác thực </span>
                                    <span class="star">*</span>
                                </div>
                                <div class="main_content_add_verify_citizen">

                                    <div class="main_content_number">
                                        <div class="btn_decrease enable-action">
                                            <i class="fa fa-minus icon-button disabled"
                                               style="background-color:  var(--neutral-02, #F4F4F4); !important;"
                                               ng-if="turnsVerifyCitizen.verify_number == 1">
                                            </i>

                                            <i class="fa fa-minus icon-button"
                                               ng-if="turnsVerifyCitizen.verify_number > 1"
                                               ng-click="handleTurnsVerify('minus');">

                                            </i>
                                            <%--                                        <button style="border: none;" ng-if="turnsVerifyCitizen.verify_number == 1"><i class="fa-solid fa-minus"></i></button>--%>
                                            <%--                                        <button style="background: var(--primary-01, #2A85FF);border: none;" ng-if="turnsVerifyCitizen.verify_number > 1" ng-click="handleTurnsVerify('minus');"><i class="fa-solid fa-minus"></i></button>--%>
                                        </div>

                                        <div class="number_count" style="position: relative; z-index: 1">
                                            <div id="loadingQrCode" class="loading-circle"
                                                 style="display: none; position: absolute; z-index: 2; margin-top: 128%"></div>
                                            <input class="verify-number" type="text" id="verifyNumber"
                                                   ng-model="turnsVerifyCitizen.verify_number" maxlength="2"
                                                   ng-change="changeVerifyNumber()">
                                        </div>
                                        <div class="btn_increase enable-action">

                                            <%--<span class="icon-button"
                                                    ng-if="turnsVerifyCitizen.verify_number >= 1 && turnsVerifyCitizen.verify_number <= 99"
                                                  ng-click="handleTurnsVerify('plus');">+</span>--%>
                                            <i class="fa fa-plus icon-button"
                                               ng-if="turnsVerifyCitizen.verify_number >= 1 && turnsVerifyCitizen.verify_number <= 99"
                                               ng-click="handleTurnsVerify('plus');"></i>

                                            <%--                                        <button ng-if="turnsVerifyCitizen.verify_number > 99" style="background: var(--neutral-02, #F4F4F4);border: none;"><i class="fa-solid fa-plus"></i> </button>--%>
                                            <i class="fa fa-plus icon-button"
                                               style="background: var(--neutral-02, #F4F4F4);border: none;"
                                               ng-if="turnsVerifyCitizen.verify_number > 99">

                                            </i>
                                        </div>

                                    </div>

                                </div>
                                <div class="main_price">
                                    <div class="price">
                                        <div class="unit_price">
                                            <span>Đơn giá (VND) </span>
                                            <span class="star">*</span>
                                        </div>
                                        <div class="unit_input">
                                            <input class="input_text_unit_price"
                                                   placeholder="Nhập đơn giá là bội số của 10.000 và tối thiểu là 20.000 VNĐ"
                                                   id="inputPrice"
                                            <%--                                               ng-model="turnsVerifyCitizen.unit_price"--%>
                                                   ng-keyup="countTotalPrice()"
                                                   ng-blur="checkValidateInputPrice()"
                                            <%--                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"--%>
                                                   oninput="this.value = formatNumber(this.value)"
                                                   type="text">
                                        </div>
                                        <div style="color: red">{{error_unit_price}}</div>
                                        <div style="padding-top: 15px;">
                                            <p style="color: var(--neutral-04, #6F767E);
                                                font-family: Arial, Helvetica, sans-serif;
                                                font-size: 14px;
                                                font-style: normal;
                                                font-weight: 600;">Tổng tiền (VNĐ)</p>
                                            <span id="totalPrice" style="color: red;font-weight: 600;"></span>
                                            <%--<p style="margin: 0 0 0px -75px">Tổng tiền</p>
                                            <span id="totalPrice">0 VNĐ</span>--%>
                                        </div>


                                    </div>
                                </div>

                                <div class="main_btn_add_verify_citizen">
                                    <div class="btn_add_verify_citizen">
                                        <button class="btn1_add_verify_citizen" ng-click="ClosePopupPurchase(true)" class="close" >Huỷ
                                            bỏ
                                        </button>
                                        <button class="btn2_add_verify_citizen" ng-click="handlePaymentTurnsVerify();">
                                            Thanh toán
                                        </button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </main>

                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="paymentTransaction" role="dialog" data-backdrop="static" style="width:auto;">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content" style="width:870px;">
                <div class="modal-header">
                    <button type="button" class="close" data-toggle="modal" data-target="#confirmClosePopupPurchase" >&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>
                <div class="modal-body">
                    <main class="main_content_payment">
                        <div class="main_title">
                            <h5>Thanh toán phí xác thực danh tính</h5>
                            <div class="main_title_transaction">
                                <span class="body1">Giao dịch hết hạn sau</span>
                                <span class="body2" id="timeoutToPayment"></span>
                            </div>
                        </div>
                        <div class="main_container_payment_transaction">
                            <div class="main_content_1">
                                <div class="header_content">
                                    <span>CÁCH 1: THANH TOÁN BẰNG MÃ QR</span>
                                </div>
                                <div class="main_pay">
                                    <div class="main_pay_1_1">
                                        <span>Quét mã với app ngân hàng có hỗ trợ</span>
                                        <div>
                                            <img src="<%=request.getContextPath()%>/static/image/citizenVerify/vietqr api - payment kit.png"
                                                 alt="">
                                        </div>
                                    </div>
                                    <div class="main_pay_2_1">
                                        <canvas id="qrcode-canvas"></canvas>
                                        <%--<img src="data:image/png;base64,{{resultCode.data.imageQRCode}}" alt="">--%>
                                        <%--                                <img src="<%=request.getContextPath()%>/static/image/citizenVerify/group.png" alt="">--%>
                                    </div>
                                    <div class="main_pay_3_1">
                                        <span>Hoặc quét mã ngân hàng bằng ví</span>
                                        <div class="logo_container">
                                            <div class="logo">
                                                <div>
                                                    <img class="momo"
                                                         src="<%=request.getContextPath()%>/static/image/citizenVerify/Logo-MoMo-Square.webp"
                                                         alt="">
                                                </div>
                                                <div>
                                                    <img class="zaloPay"
                                                         src="<%=request.getContextPath()%>/static/image/citizenVerify/Logo-ZaloPay-Square.webp"
                                                         alt="">
                                                </div>
                                                <div>
                                                    <img class="viettelPay"
                                                         src="<%=request.getContextPath()%>/static/image/citizenVerify/viettelpay.png"
                                                         alt="">
                                                </div>
                                                <div class="logo_more">+24</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="main_content_2">
                                <div class="header_content">
                                    <span>CÁCH 2: CHUYỂN KHOẢN THỦ CÔNG</span>
                                </div>
                                <div class="main_pay">
                                    <div class="main_pay_1_2">
                                        <span class="enjoyment_bank">Ngân hàng hưởng thụ</span> <br>
                                        <div class="name_bank">
                                            <span>{{resultCode.data.bankName}}</span>
                                            <%--                                    <br>--%>
                                            <%--                                    <span>(Ngân hàng TMCP Ngoại Thương)</span>--%>
                                        </div>
                                    </div>
                                    <div class="main_pay_2_2">
                                        <span>Số tài khoản thụ hưởng</span>
                                        <div class="account_number">
                                            <span id="paymentBankAccount">{{resultCode.data.bankAccount}}</span> <br>
                                            <span><img class="enable-action" title="Sao chép"
                                                       onclick="copyText('paymentBankAccount')"
                                                       src="<%=request.getContextPath()%>/static/image/citizenVerify/vuesax_linear_copy.png"
                                                       alt=""></span>
                                        </div>
                                    </div>
                                    <div class="main_pay_2_2">
                                        <span>Tên người thụ hưởng</span>
                                        <div class="account_number">
                                            <span id="paymentUserBankName">{{resultCode.data.userBankName}}</span> <br>
                                            <span><img class="enable-action" title="Sao chép"
                                                       onclick="copyText('paymentUserBankName')"
                                                       src="<%=request.getContextPath()%>/static/image/citizenVerify/vuesax_linear_copy.png"
                                                       alt=""></span>
                                        </div>
                                    </div>
                                    <div class="main_pay_2_2">
                                        <span>Số tiền</span>
                                        <div class="account_number">
                                            <span>{{formatAmount(resultCode.data.amount)}}đ</span>
                                        </div>
                                    </div>
                                    <div class="main_pay_2_2">
                                        <span>Nội dung</span>
                                        <div class="account_number">
                                            <span id="paymentBankContent"
                                                  class="qr_code">{{resultCode.data.content}}</span> <br>
                                            <span><img class="enable-action" title="Sao chép"
                                                       onclick="copyText('paymentBankContent')"
                                                       src="<%=request.getContextPath()%>/static/image/citizenVerify/vuesax_linear_copy.png"
                                                       alt=""></span>
                                        </div>
                                    </div>
                                    <div class="note_container">
                                        <span>Lưu ý: Giao dịch thanh toán phí xác thực sẽ không được hoàn tiền. Vui lòng kiểm tra số tiền và nội dung trước khi thanh toán.</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </main>
                </div>
                <%--                <div class="modal-footer">--%>
                <%--                    <div class="btn_container">--%>
                <%--                        <div class="btn">--%>
                <%--                            <button class="btn2_add_verify_citizen" ng-click="checkOrderOfTransaction()">Khách hàng đã thanh toán</button>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>


            </div>
        </div>
    </div>

    <div class="modal fade confirm-popup" id="confirmClosePopupPurchase" role="dialog" style="width:auto;">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content modal-sm" style="top: 250px; left: 250px;">
                <div class="modal-header">
                    <button data-dismiss="modal" type="button" class="close">&times;</button>
                    <h4 class="modal-title">Xác nhận đóng thanh toán phí xác thực</h4>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <div class="row">
                            <span>Anh chị xác nhận đóng quá trình thanh toán</span>
                        </div>

                    </div>
                </div>
                <div class="modal-footer truong-text-center">
                    <button style="background-color: #FFFFFF !important; color: black !important;border-radius: 5px"
                            data-dismiss="modal"
                            type="button" class="button-box huybo">Hủy bỏ
                    </button>
                    <button style="background-color: #0054D1 !important; border-radius: 5px"
                            ng-click="ClosePopupPurchase();"
                            data-dismiss="#paymentTransaction" class="button-box luu">Xác nhận
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="showPaymentTransactionSuccess" role="dialog" style="width:auto;">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content" style="width:850px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>

                <main class="main_payment_success">
                    <div class="main_title_payment_success">
                        <h5>Thanh toán thành công</h5>
                        <div class="main_title_1_payment_success">
                            <span>Tự động chuyển hướng đến trang xác thực danh tính trong&nbsp;</span>
                            <p class="body2" style="margin: 0px !important;" id="timeCountdown"></p>
                            <%--                            <p class="timeCountdown">5s</p>--%>
                        </div>
                    </div>
                    <div class="main_container_payment_success">
                        <div class="img_icon_payment_success">
                            <img src="<%=request.getContextPath()%>/static/image/citizenVerify/frame_37256.png" alt="">
                        </div>
                    </div>
                    <div class="main_btn_payment_success">
                        <div class="btn_payment_success">
                            <button class="btn_1_payment_success" ng-click="devices(false, true);">
                                <img src="<%=request.getContextPath()%>/static/image/citizenVerify/vuesax_outline_scan.png"
                                     alt="">
                                <span>Xác thực danh tính</span>
                            </button>

                        </div>
                    </div>
                </main>

            </div>
        </div>
    </div>

    <div class="modal fade" id="showPaymentTransactionError" role="dialog" style="width:auto;">
        <div class="modal-dialog modal-xl">
            <!-- Modal content-->
            <div class="modal-content" style="width:850px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xác thực danh tính công dân</h4>
                </div>

                <main class="main_payment_error">
                    <div class="main_title_payment_error">
                        <h5>Thanh toán thất bại!</h5>
                        <div class="main_title_1">
                            <span >Đã hết thời gian chờ thanh toán của giao dịch hoặc</span>
                            <br>
                            <span >số tiền cần thanh toán chưa đủ</span>
                        </div>
                    </div>
                    <div class="main_container_payment_error">
                        <div class="img_icon">
                            <img src="<%=request.getContextPath()%>/static/image/citizenVerify/59.png" alt="">
                        </div>
                    </div>
                    <div class="main_btn_payment_error">
                        <div class="btn_payment_error">
                            <button class="btn_1_payment_error" ng-click="showDlgBuyNumberVerify(true);">
                                <i class="fa fa-arrow-left"></i>
                                <span>Quay lại</span>
                            </button>
                            <button class="btn_2_payment_error" ng-click="handlePaymentTurnsVerify();">
                                <i class="fa fa-rotate-right rotate_right_custom"></i>
                                <span>Tải lại trang thanh toán</span>
                            </button>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </div>

</div>

<button type="button" id="announcementPopup" class="btn btn-primary btn-lg" data-toggle="modal"
        data-target="#myModalannouncementPopup" style="display: none"></button>

<!-- Modal -->
<div class="modal fade" id="myModalannouncementPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <c:forEach items="${homeForm.announcementPopup}" var="item">
            <div class="panel-heading" style="background-color: #2e9ad0 ">
                <h5 class="panel-title truong-text-colorwhite truong-modal-heading"
                    style="padding-left: 15px !important;">
                        ${item.title}


                </h5>
                <button type="button" class="close truong-button-xoa" data-dismiss="modal" style="margin-bottom: 5px">
                    <img
                            src="<%=request.getContextPath()%>/static/image/close.png"
                            class="control-label truong-imagexoa-fix"></button>
            </div>
            <div class="panel-body" style="padding-bottom: 0px !important;">

                    <%--<span class="sender-info" style="padding-bottom: 7px !important;">Đăng bởi: ${homeForm.latest.sender_info}, ngày ${homeForm.latest.entry_date_time}</span></br>--%>
                <span class="sender-info"
                      style="padding-bottom: 7px !important;">Đăng bởi: ${item.sender_info}, ngày ${item.entry_date_time}</span></br>


                <span class="col-md-12 truong-padding-rightdelete"> ${homeForm.contentHtml} </span>

            </div>

            <div class="modal-footer" style="padding-left: 30px !important;">
                <div class="col-md-12">
                    <label class="control-label label-bam-trai" style="float: left">File đính kèm: </label>
                </div>
                <c:if test="${item.attach_file_path == null}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${item.attach_file_path.equals('')}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${!item.attach_file_path.equals('') && item.attach_file_path != null}">
                    <div class="col-md-12">
                        <c:forEach items="${listFileNameTCCC}" var="listFileNameTCCC" varStatus="count">
                    <span style="float: left">${count.index + 1} : <a class="truong-small-linkbt"
                                                                      href="${downloadUrlTCCC}/${item.aid}/${count.index}">${listFileNameTCCC}</a></span><br>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <c:forEach items="${homeForm.stpPopupAnnouncement}" var="item">
            <div class="panel-heading" style="background-color: #2e9ad0 ">
                <h5 class="panel-title truong-text-colorwhite truong-modal-heading"
                    style="padding-left: 15px !important;">
                        ${item.title}

                </h5>
                <button type="button" class="close truong-button-xoa" data-dismiss="modal" style="margin-bottom: 5px">
                    <img
                            src="<%=request.getContextPath()%>/static/image/close.png"
                            class="control-label truong-imagexoa-fix"></button>


            </div>

            <div class="panel-body" style="padding-bottom: 0px !important;">
                <span class="sender-info"
                      style="padding-bottom: 7px !important;">Đăng bởi: ${item.sender_info}, ngày ${item.entryDateTimeConver}</span></br>
                <span class="col-md-12 truong-padding-rightdelete"> ${homeForm.contentHtmlFromSTP} </span>

            </div>

            <div class="modal-footer" style="padding-left: 30px !important;">
                <div class="col-md-12">
                    <label class="control-label label-bam-trai" style="float: left">File đính kèm: </label>
                </div>
                <c:if test="${item.attach_file_path == null}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${item.attach_file_path.equals('')}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${!item.attach_file_path.equals('') && item.attach_file_path != null}">
                    <div class="col-md-12">
                        <c:forEach items="${listFileName}" var="listFileName" varStatus="count">
                    <span style="float: left">${count.index + 1} : <a class="truong-small-linkbt"
                                                                      href="<%=SystemProperties.getProperty("url_config_server_stp_api")%>/announcement/download-from-stp-api/${item.aid}/${count.index}">${listFileName}</a></span><br>
                        </c:forEach>
                    </div>
                </c:if>
            </div>


        </div>
        </c:forEach>

    </div>
</div>

<%--End Modal--%>


<!-- Modal -->
<div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <c:forEach items="${homeForm.announcementPopup}" var="item">
            <div class="panel-heading" style="background-color: #2e9ad0 ">
                <h5 class="panel-title truong-text-colorwhite truong-modal-heading"
                    style="padding-left: 15px !important;">
                        ${item.title}


                </h5>
                <button type="button" class="close truong-button-xoa" data-dismiss="modal" style="margin-bottom: 5px">
                    <img
                            src="<%=request.getContextPath()%>/static/image/close.png"
                            class="control-label truong-imagexoa-fix"></button>
            </div>
            <div class="panel-body" style="padding-bottom: 0px !important;">

                    <%--<span class="sender-info" style="padding-bottom: 7px !important;">Đăng bởi: ${homeForm.latest.sender_info}, ngày ${homeForm.latest.entry_date_time}</span></br>--%>
                <span class="sender-info"
                      style="padding-bottom: 7px !important;">Đăng bởi: ${item.sender_info}, ngày ${item.entry_date_time}</span></br>


                <span class="col-md-12 truong-padding-rightdelete"> ${homeForm.contentHtml} </span>

            </div>
                <%--<div class="modal-footer" style="padding-left: 30px !important;">

                    <c:if test="${item.attach_file_path == null}">
                        <label class="control-label label-bam-trai" style="float: left">File đính kèm :</label>
                        <span style="float: left">Không có file đính kèm </span>
                    </c:if>
                    <c:if test="${item.attach_file_path.equals('')}">
                        <label class="control-label label-bam-trai" style="float: left">File đính kèm :</label>
                        <span style="float: left">Không có file đính kèm </span>
                    </c:if>
                    <c:if test="${item.attach_file_path != null && item.attach_file_path.equals('') == false}">
                        <label class="control-label label-bam-trai" style="float: left">File đính kèm :</label>
                        <div class="truong-image-tablexanh"></div>
                        <a style="float: left" href="${downloadUrl}/${item.aid}">${item.attach_file_name}</a>
                    </c:if>


                </div>--%>
            <div class="modal-footer" style="padding-left: 30px !important;">
                <div class="col-md-12">
                    <label class="control-label label-bam-trai" style="float: left">File đính kèm: </label>
                </div>
                <c:if test="${item.attach_file_path == null}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${item.attach_file_path.equals('')}">
                    <span style="float: left">Không có file đính kèm</span>
                </c:if>
                <c:if test="${!item.attach_file_path.equals('') && item.attach_file_path != null}">
                    <div class="col-md-12">
                        <c:forEach items="${listFileNameTCCC}" var="listFileNameTCCC" varStatus="count">
                    <span style="float: left">${count.index + 1} : <a class="truong-small-linkbt"
                                                                      href="${downloadUrlTCCC}/${item.aid}/${count.index}">${listFileNameTCCC}</a></span><br>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
        </c:forEach>

    </div>
</div>
<%--End Modal--%>

<%--<div class="col-md-12 content">
    <div class="col-md-8 col-item">
        <div class="col-md-6">
            <div class="col-md-2">
                <img src="${pageContext.request.contextPath}/static/image/ico_stop_large.png"/>
            </div>
            <div style="float: left">
                <ul class="ul-data">
                    <li class="title">THÔNG TIN NGĂN CHẶN</li>
                    <li><a href="#">Tra cứu thông tin ngăn chặn</a></li>
                </ul>
            </div>
        </div>

        <div class="col-md-6">
            <div class="col-md-2">
                <img src="${pageContext.request.contextPath}/static/image/ico_temp_large.png"/>
            </div>
            <div style="float: left">
                <ul class="ul-data">
                    <li class="title">HỢP ĐỒNG CÔNG CHỨNG</li>
                    <li><a href="#">Danh sách hợp đồng công chứng</a></li>
                    <li><a href="#">Thêm mới hợp đồng công chứng</a></li>
                    <li><a href="#">Hợp đồng mẫu</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-8 col-item">
        <div class="col-md-6">
            <div class="col-md-2">
                <img src="${pageContext.request.contextPath}/static/image/ico_chart_large.png"/>
            </div>
            <div style="float: left">
                <ul class="ul-data">
                    <li class="title">BÁO CÁO THỐNG KÊ</li>
                    <li><a href="#">Báo cáo theo thông tư 20</a></li>
                    <li><a href="#">Báo cáo theo nhóm hợp đồng</a></li>
                    <li><a href="#">Báo cáo theo công chứng viên</a></li>
                    <li><a href="#">Báo cáo theo chuyên viên soạn thảo</a></li>
                    <li><a href="#">Báo cáo theo ngân hàng </a></li>
                </ul>
            </div>
        </div>

        <div class="col-md-6">
            <div style="float: left">
                <ul class="ul-data-not-title">
                    <li><a href="#">Báo cáo hợp đồng lỗi</a></li>
                    <li><a href="#">Báo cáo hợp đồng cần bổ sung</a></li>
                    <li><a href="#">Thống kê tổng hợp</a></li>
                    <li><a href="#">In sổ công chứng</a></li>
                </ul>
            </div>
        </div>
    </div>

</div>--%>


<script type="text/javascript">
    if (${homeForm.stpPopupAnnouncement.size() == 1}) {
        $(window).on('load', function () {
            $('#myModal').modal('show');
        });

    }
    if (${homeForm.announcementPopup.size() == 1}) {
        $(window).on('load', function () {
            $('#myModalannouncementPopup').modal('show');
            //$('#announcementPopup').click();
        });
    }
</script>
<script>
    $(document).ready(function () {
        loadMenu();
    });

    function loadMenu() {
        $(".sidebar-nav > li > #trang-chu").addClass("father-menu");
    }

    function addChildNotParent(note) {
        var check = note.className.indexOf("on-expandabledatatableCustum");
        var id = note.id;

        $.ajax({
            type: "GET",
            url: '${FindContractTempListByParentId}',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                idTemp: id
            },
            success: function (response) {
                console.log(response.result);

                var result = response.result;
                var template = result.split(";");
                if (check == -1) {//add
                    note.classList.remove("off-expandabledatatableCustum");
                    note.classList.add("on-expandabledatatableCustum");
                    note.classList.remove("fa-plus-square-o");   //bỏ dấu +
                    note.classList.add("fa-minus-square-o");     //add dấu -

                    if (result != null && result != "") {
                        var html = "";
                        for (var i = 0; i < template.length; i++) {
                            var temp = template[i].split(",");
                            if (i == 0) {
                                html += "<br class='on-expandabledatatableCustum" + temp[0] + "'>";
                            }
                            html += "<a style='padding-left: 10%;' class='on-expandabledatatableCustum" + temp[0] + "' href='<%=request.getContextPath()%>/template/contract/edit/" + temp[0] + "' style='margin-top:3px;margin-bottom: 3px;'>";
                            html += temp[3];
                            html += "</a><br class='on-expandabledatatableCustum" + temp[0] + "'>";
                        }
                        $(".addChildNotParent" + id).after(html);
                    }
                } else {//delete
                    note.classList.remove("on-expandabledatatableCustum");
                    note.classList.add("off-expandabledatatableCustum");
                    note.classList.remove("fa-minus-square-o");   //bỏ dấu -
                    note.classList.add("fa-plus-square-o");     //add dấu +

                    if (result != null && result != "") {
                        for (var i = 0; i < template.length; i++) {
                            var temp = template[i].split(",");
                            $(".on-expandabledatatableCustum" + temp[0]).remove();                     //remove chiled node
                        }
                    }
                }
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });

    }

    function changContractkind(e) {
        var kind_code = $(e).val();
        $.ajax({
            type: "GET",
            url: '${getKindUrl}',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                kind_code: kind_code,
            },
            success: function (response) {
                var result = response.result;

                var template = result.split(";");
                var html = "";
                for (var i = 0; i < template.length; i++) {
                    var temp = template[i].split(",");
                    //html += "<a href='${downloadUrl}" + "?filename=" + temp[1] + "&filepath=" + temp[2] + "'>";
                    html += "<i onclick='addChildNotParent(this)' id='" + temp[0] + "' class='fa fa-plus-square-o off-expandabledatatableCustum'></i> <a class='addChildNotParent" + temp[0] + "' href='<%=request.getContextPath()%>/template/contract/edit/" + temp[0] + "' style='margin-top:3px;margin-bottom: 3px;'>";
                    html += temp[3];
                    html += "</a><br>";
                }
                $("#contract-template").html(html);
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    }

    $(document).ready(function () {
        var kind_code = $("#changContractkind").val();
        $.ajax({
            type: "GET",
            url: '${getKindUrl}',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                kind_code: kind_code,
            },
            success: function (response) {
                var result = response.result;

                var template = result.split(";");
                var html = "";
                for (var i = 0; i < template.length; i++) {
                    var temp = template[i].split(",");
                    //html += "<a href='${downloadUrl}" + "?filename=" + temp[1] + "&filepath=" + temp[2] + "'>";
                    html += "<i onclick='addChildNotParent(this)' id='" + temp[0] + "' class='fa fa-plus-square-o off-expandabledatatableCustum'></i> <a class='addChildNotParent" + temp[0] + "' href='<%=request.getContextPath()%>/template/contract/edit/" + temp[0] + "' style='margin-top:3px;margin-bottom: 3px; '>";
                    html += temp[3];
                    html += "</a><br>";
                }
                $("#contract-template").html(html);
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        })
    });

</script>

<style>
    .home-fast-icon {
        margin-top: 5% !important;
        margin-bottom: 5% !important;
    }
</style>
