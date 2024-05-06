<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/index.css">
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<%--
    Thêm mói nhóm quyền
--%>
<spring:url value="/system/create-grouprole" var="addUrl"/>
<spring:url value="/announcement/announcement-detail-view" var="announcementUrl"/>
<spring:url value="/announcement/list" var="announcementListUrl"/>
<spring:url value="/announcement/popup" var="announcementPopup"/>

<spring:url value="/contract/search" var="searchUrl"/>
<spring:url value="/prevent/add-view" var="addUrl"/>
<spring:url value="/announcement/download" var="downloadUrl"/>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Thông báo </span>
</div>
<div class="truong-form-chinhbtt col-md-12 truong-margin-footer0px" id="home-wapper">
    <div class="col-md-12">
        <div class="home-header">THÔNG BÁO</div>
        <div class="home-content">
            <div id="lastest-anouncement">
                <c:if test="${announcementForm.checkNew == announcementForm.announcementDetail.aid}">
                <img id="home-new" src="<%=request.getContextPath()%>/static/image/new.png">
                </c:if>
                <span class="" style="font-weight: bold">${announcementForm.announcementDetail.title}</span>
                <span id="lastest-time">Đăng bởi: ${announcementForm.announcementDetail.sender_info}, ngày ${announcementForm.announcementDetail.entry_date_time}</span>
            </div>
            <c:if test="${announcementForm.announcementDetail.attach_file_name.equals('') == false && announcementForm.announcementDetail.attach_file_name != null}">
            <div>
                <div class="col-md-3">File đính kèm:</div>
                <div class="col-md-9">
                    <c:forEach items="${listFileName}" var="item" varStatus="count">
                                        <span>${count.index + 1} : <a class="truong-small-linkbt"
                                                                      href="${downloadUrl}/${announcementForm.announcementDetail.aid}/${count.index}">${item}</a></span><br>
                    </c:forEach>
                </div>
            </div>
            </c:if>


                <div id="latest-content" style="margin-top: 15px">
                        ${announcementForm.announcementDetail.content_display}
                </div>

        </div>
        <%--<div id="home-anouncement-other">Thông báo khác<span id="ann-see-all"><a href="${announcementListUrl}">Xem tất cả ></a></span>
        </div>--%>
        <div class="home-content">
            <span style="font-weight: bold;padding-left: 5px">Tin khác </span>
            <c:forEach items="${announcementForm.announcementArrayList}" var="item" varStatus="index">
                <div class="other-row">
                    <div class="other-title col-md-12">
                        <span class="other-cursor">${index.index + 1}</span>
                        <a class="truong-small-linkbt" href="${announcementUrl}/${item.aid}">${item.title}</a>
                        <c:if test="${item.importance_type == 2}">
                            <img style="height: 21px;float: top;padding-bottom: 7px;"
                                 src="<%=request.getContextPath()%>/static/image/flag.png">
                        </c:if>
                    </div>
                    <%--<c:if test="${item.attach_file_name.equals('') == false && item.attach_file_name != null}">
                        <div class="col-md-12">
                            <span style="margin-left: 22px;color: black;">File đính kèm :</span><a class="truong-small-linkbt"
                                href="${downloadUrl}/${item.aid}"> ${item.attach_file_name}</a>
                        </div>
                    </c:if>--%>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
