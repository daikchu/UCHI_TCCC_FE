<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.service.QueryFactory" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.controller.HomeController" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String checkcongchung=SystemProperties.getProperty("org_type");
	String congchung=checkcongchung.equals("1")?"chứng thực":"công chứng";
	String congchungH=checkcongchung.equals("1")?"Chứng thực":"Công chứng";
	String congchungHOA=checkcongchung.equals("1")?"CHỨNG THỰC":"CÔNG CHỨNG";
	String nguoiCongChung_Name = checkcongchung.equals("1") ? "Người ký chứng thực" : "Công chứng viên";
	String nguoiCongChung_NameLower = checkcongchung.equals("1") ? "người ký chứng thực" : "công chứng viên";
%>
	<%--<script src="<%=request.getContextPath()%>/static/js/layout/body_top.js" type="text/javascript"></script>--%>
	<script>
		var ospApiUrl='<%=SystemProperties.getProperty("OSP_API_LINK_PUBLIC")%>';
		var tcccApiUrl='<%=SystemProperties.getProperty("url_config_server_api")%>';
		var typeQATCCC = ${Constants.type_QATCCC};
	</script>
<spring:url value="/logout" var="logoutUrl"/>
<spring:url value="/home" var="homeUrl"/>
<spring:url value="/contract/not-sync-list" var="notSynUrl"/>
<header>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid" style="background-color: #2ca9e0">
			<div class="navbar-header" style="display:flex;align-items: center">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="${homeUrl}"><img src="<%=request.getContextPath()%>/static/image/stp_logo.png" class="navbar-brand"/></a>
				<div id="office-department" <%--style="padding-top: 15px"--%>><%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getAgency()%></div>
				<div id="office_province" style="display: none;"><%=QueryFactory.getSystemConfigByKey("notary_office_province")%></div>
				<div id="notary_office_address" style="display: none;"><%=QueryFactory.getSystemConfigByKey("notary_office_address")%></div>
				<%if(ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_THEM)){%>
				<a href="${notSynUrl}"><img id="bell" src="<%=request.getContextPath()%>/static/image/bell.png">
					<%if(CommonContext.getNotSyncContract() > 0){%>
					<p id="bell-notice"><%=CommonContext.getNotSyncContract()%></p>
					<%}%>
				</a>
				<%
					}
				%>
				<img id="logout" title="Thoát hệ thống" onclick="showModal()" src="<%=request.getContextPath()%>/static/image/logout.png">
			</div>
		</div>
	</div>
	<style type="text/css">
		.popover-content {
			overflow-y : scroll;
			word-wrap: break-word;
			word-break: keep-all;
			min-height: 100px;
			max-height: 300px;
		}
	</style>
</header>

<body>

<div id="wrapper" <%--ng-app="osp" ng-controller="bodyTopController"--%>>

	<!-- Sidebar -->
	<div id="sidebar-wrapper" style="background-color: #2a2a2a">
		<ul class="sidebar-nav">
			<li class="sidebar-brand" style="background-color: #313131">
				<div class="profile">
					<a href="<%=request.getContextPath()%>/user-info" style="cursor: pointer;">
                        <div class="profile_pic" id="avatarImage">
                            <img style="height: 65px;width: 65px" src="<%=request.getContextPath()%><%=HomeController.checkFileShowView(((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()).getFile_name()%>" alt="..." class="img-circle profile_img">
                        </div>
						<div class="profile_info">
							<span style="color :white">  Xin chào </span>
							<img class="edit-profile" src="<%=request.getContextPath()%>/static/image/icon menu/edit-profile.png"/>
							<h2 style="color: white"><%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getFamily_name()%> <%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getFirst_name()%></h2>
						</div>
					</a>
				</div>
			</li>
			<li><a href="<%=request.getContextPath()%>/home" id="trang-chu"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/1.png">&nbsp&nbsp Trang chủ </a></li>
			<%
				if(ValidationPool.checkRoleDetail(request, "10", Constants.AUTHORITY_XEM)){
			%>
			<li>
				<a href="<%=request.getContextPath()%>/transaction/search" id="tra-cuu-thong-tin"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/2.png">&nbsp&nbsp Tra cứu thông tin</a>
			</li>
			<%
				}
				if(ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_XEM)){
			%>
			<li>
				<%--<a href="<%=request.getContextPath()%>/transaction/multi-search" id="tra-cuu-thong-tin-lien-tinh"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/2.png">&nbsp&nbsp Tra cứu thông tin</a>--%>
			</li>
			<%
				}
				if(ValidationPool.checkHasRoleInList(request, "11,14")){
			%>
			<li>
				<a href="#" class="dropdown" id="quan-ly-hop-dong"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/5.png" >&nbsp &nbsp Quản lý hợp đồng<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">
					<%
						if(ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2">
						<a href="<%=request.getContextPath()%>/contract/list" id="ds-hd-cong-chung">
							<img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">
							Danh sách hợp đồng <%=congchung%>
						</a>
					</li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/contract/temporary/list" id="ds-hd-online"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách hợp đồng online</a></li>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/contract/temporary/add" id="soan-hd-online"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Soạn hợp đồng online</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/contract/not-sync-list" id="ds-hd-chua-db"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách hợp đồng chưa đồng bộ</a></li>
					<%
						}
					%>
					<%--<li class="subitem2"><a href="<%=request.getContextPath()%>/system/office-list" id="ds-to-chuc"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách tổ chức công chứng / phường xã</a></li>--%>
				</ul>
			</li>
			<%
				} if(SystemProperties.getProperty("org_type").equals("1")){
					if(ValidationPool.checkHasRoleInList(request, "35,36")){
			%>
			<li>
				<a href="#" class="dropdown" id="quan-ly-chung-thuc"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/5.png" >&nbsp &nbsp Quản lý chứng thực<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">
					<%
						if(ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/certificate/list-${Constants.CERTIFICATE_TYPE_SIGNATURE}" id="quan-ly-chung-thuc-chu-ky"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Quản lý chứng thực chữ ký</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "35", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/certificate/list-${Constants.CERTIFICATE_TYPE_COPY}" id="quan-ly-chung-thuc-ban-sao"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Quản lý chứng thực bản sao</a></li>
					<%
						}
					%>
				</ul>
			</li>
			<%
				}} if(ValidationPool.checkHasRoleInList(request, "39")){
			%>
			<li>
				<a href="<%=request.getContextPath()%>/notarybook/list" id="quan-ly-so-chung-thuc"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/5.png" >&nbsp &nbsp Quản lý sổ <%=congchung%></a>
			</li>
			<%
				} if(ValidationPool.checkHasRoleInList(request, "19,20,21,22,23,24,33,35,36,37,38")){
			%>
			<li>
				<a href="#" class="dropdown" id="bao-cao-thong-ke"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/4.png">&nbsp &nbsp Báo cáo thống kê<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">
					<%
						if(ValidationPool.checkRoleDetail(request, "19", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/group" id="bao-cao-theo-nhom"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo nhóm</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "20", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/by-notary/" id="bao-cao-theo-vpcc"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo <%=nguoiCongChung_NameLower%></a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/by-draft/" id="bao-cao-theo-soan-thao"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo chuyên viên soạn thảo</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "26", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/contract-additional/" id="bao-cao-theo-hd-bo-sung"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo hợp đồng bổ sung</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "27", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/contract-error/" id="bao-cao-theo-hd-huy"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo hợp đồng lỗi</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "32", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/by-tt03" id="bao-cao-theo-tt03"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo TT 03</a></li>
					<%
						}if(ValidationPool.checkRoleDetail(request, "23", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/by-tt04" id="bao-cao-theo-tt20"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo TT 04</a></li>

					<%
						}
						if(ValidationPool.checkRoleDetail(request, "24", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/group-bank" id="bao-cao-theo-ngan-hang"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo ngân hàng</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "21", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/general-stastics" id="tk-tong-hop"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Thống kê tổng hợp</a></li>

					<%
						if(SystemProperties.getProperty("org_type").equals("0")){
					%>
						<li class="subitem2"><a href="<%=request.getContextPath()%>/report/sales" id="tk-doanh-thu"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Thống kê doanh thu</a></li>
						<%--<li class="subitem2"><a href="<%=request.getContextPath()%>/report/by-user" id="bao-cao-theo-cc-vien"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo theo công chứng viên</a></li>--%>
					<%
						}
					%>

					<%
						}
						if(ValidationPool.checkRoleDetail(request, "22", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/contract-certify" id="in-so-cong-chung"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">In sổ hợp đồng <%=congchung%></a></li>
					<%
						} if(SystemProperties.getProperty("org_type").equals("1")){
							if(ValidationPool.checkRoleDetail(request, "33", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/report/tinh-hinh-nhap-hd-phuong-xa" id="tinh-hinh-phuong-xa"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Tình trạng nhập HĐ phường/xã</a></li>
					<%
							}
						} if(SystemProperties.getProperty("org_type").equals("1")){
							if(ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM )){
					%>
                    <li class="subitem2"><a href="<%=request.getContextPath()%>/certificate/report-signature-cert" id="bao-cao-chung-thuc-chu-ky"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Sổ chứng thực chữ ký</a></li>
					<%
							}
						}if(SystemProperties.getProperty("org_type").equals("1")){
							if(ValidationPool.checkRoleDetail(request, "35", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/certificate/report-copy-cert" id="bao-cao-chung-thuc-ban-sao"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Sổ chứng thực bản sao</a></li>
					<%
							}
						}if(SystemProperties.getProperty("org_type").equals("1")){
						    if (ValidationPool.checkRoleDetail(request, "37", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/reportCertificate/tt03" id="bao-cao-chung-thuc-tt03"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo chứng thực TT 03</a></li>
					<%
							}
						}if(ValidationPool.checkRoleDetail(request, "38", Constants.AUTHORITY_XEM)){
					%>
						<li class="subitem2"><a href="<%=request.getContextPath()%>/report/luong-giao-dich-bds" id="bao-cao-luong-giao-dich-bds"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Báo cáo lượng giao dịch BĐS</a></li>
					<%
						}
					%>

				</ul>
			</li>
		<%
				}

			%>
			<li>
				<a href="#" class="dropdown" id="quan-ly-xac-thuc-danh-tinh"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/4.png">&nbsp &nbsp Quản lý xác thực danh tính<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">
					<li class="subitem2">
						<a href="<%=request.getContextPath()%>/xac-thuc-danh-tinh/danh-sach" id="danh-sach-luot-xac-thuc">
							<img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png"><span>Danh sách lượt xác thực</span>
						</a>
					</li>
					<li class="subitem2">
						<a href="<%=request.getContextPath()%>/giao-dich-phi-xac-thuc/danh-sach" id="danh-sach-giao-dich-phi-xac-thuc">
							<img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png"><span>Giao dịch phí xác thực</span>
						</a>
					</li>
				</ul>
			</li>
			<%

				if(ValidationPool.checkRoleDetail(request, "18", Constants.AUTHORITY_XEM)){
			%>
			<li>
				<a href="<%=request.getContextPath()%>/announcement/list" id="thong-bao"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/6.png">&nbsp &nbsp Thông báo</a>
			</li>
			<%
				}
			%>
            <%
                if(ValidationPool.checkRoleDetail(request, "08", Constants.AUTHORITY_XEM)){
            %>
            <li>
                <a href="<%=request.getContextPath()%>/manual/list" id="huong-dan" onclick="showImage()"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/hdsd.png">&nbsp &nbsp Quản lý tài liệu</a>
            </li>
            <%}%>
			<%
				if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_XEM)){

			%>
			<li>
				<a href="#" class="dropdown" id="mau-giao-dien"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/5.png" >&nbsp &nbsp Giao diện hiển thị<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">

					<li class="subitem2"><a href="<%=request.getContextPath()%>/template/contract/list" id="tenhopdong"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Tên Hợp đồng</a></li>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/template/privy/list" id="duongsu"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Đương sự</a></li>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/template/property/list" id="taisan"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Tài sản</a></li>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/fee/list" id="phihopdong"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Phí công chứng</a></li>


					<%--<li class="subitem2"><a href="<%=request.getContextPath()%>/system/office-list" id="ds-to-chuc"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách tổ chức công chứng / phường xã</a></li>--%>
				</ul>
			</li>
			<%
				}
			%>
			<%

				if(ValidationPool.checkHasRoleInList(request, "02,03,05,06,07,09,08,12")){
			%>
			<li>
				<a href="#" class="dropdown" id="quan-tri-he-thong"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/5.png" >&nbsp &nbsp Quản trị hệ thống<img class="ar2" src="<%=request.getContextPath()%>/static/image/icon menu/ar2.png"></a>
				<ul style="display: none">
					<%
						if(ValidationPool.checkRoleDetail(request, "02", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/user-list" id="ds-can-bo-stp"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách cán bộ</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "03", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/grouprole-list" id="ds-nhom-quyen"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách nhóm quyền</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "30", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/contract/list-key-map-contract" id="list-key-map-contract"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Danh sách từ khóa bóc tách</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "05", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/contract-history" id="ls-thay-doi-hop-dong"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Lịch sử thay đổi hợp đồng</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "06", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/access-history" id="ls-truy-cap-he-thong"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Lịch sử thao tác hệ thống</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "07", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/backup-view" id="ds-backup"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Cấu hình quản trị sao lưu</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "09", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/configuration" id="system-configuration"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Sao lưu dữ liệu từ Sở Tư Pháp</a></li>
					<%
						}
						if(ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/osp/contracttemplate-list" id="mau-hop-dong"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Quản lý mẫu hợp đồng</a></li>
					<% if(SystemProperties.getProperty("org_type").equals("1")){%>
						<li class="subitem2"><a href="<%=request.getContextPath()%>/attestation-template/list" id="mau-loi-chung"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Quản lý mẫu lời chứng</a></li>
					<%
							}
						}
						if(ValidationPool.checkRoleDetail(request, "28", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/osp/bank-list" id="ngan-hang"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Đồng bộ ngân hàng</a></li>

					<%
						}if(SystemProperties.getProperty("org_type").equals("1")){
						if(ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="<%=request.getContextPath()%>/system/district/list" id="quan-huyen"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Quản lý danh mục quận/huyện</a></li>

					<%
						}}
						if(ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_XEM)){
					%>
					<li class="subitem2"><a href="#" onclick="dong_bo_master_hiden()" class="dropdown" id="dong-bo-master"><img class="menu-dot" src="<%=request.getContextPath()%>/static/image/dot.png">Đồng bộ dữ liệu master</a>
						<ul id="dong_bo_master_hiden" style="display: none">
							<%
								if(ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_SUA)){
							%>
							<li class="subitem2"><a href="<%=request.getContextPath()%>/system/osp/config-db-master-view" id="config-db-master">Cấu hình DB</a></li>
							<%
								}
							%>
							<%
								if(ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_XEM)){
							%>
							<li class="subitem2"><a href="<%=request.getContextPath()%>/system/osp/data-master-view" id="data-master">Dữ liệu Master</a></li>
							<%
								}
							%>
						</ul>
					</li>
					<%
						}
					%>
				</ul>
			</li>
			<%
				}
			%>
			<li>
			<a href="#help" data-toggle="modal"
				data-target="#helpForm" id="tro-giup" onclick="getQA()" <%--onclick="showImage()"--%>><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/7.png">&nbsp &nbsp Trợ giúp</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/contact-us" id="lien-he"><img class="menu-logo"  src="<%=request.getContextPath()%>/static/image/icon menu/7.png">&nbsp &nbsp Liên hệ</a>
			</li>
		</ul>
		<div>Uchi Sở Tư Pháp v3.0</div>
	</div>
	<!-- /#sidebar-wrapper -->

	<!-- Page Content -->
	<div id="page-content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12" id="uchi-content">




					<div class="modal fade" id="myModalLogout" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="panel-heading" style="background-color: #2e9ad0 ">
									<h5 class="panel-title truong-text-colorwhite ">
										Thoát hệ thống

										<button type="button" class="close truong-button-xoa" data-dismiss="modal" style="margin-bottom: 5px"><img
												src="<%=request.getContextPath()%>/static/image/close.png" class="control-label truong-imagexoa-fix"></button>
									</h5>

								</div>

								<div class="panel-body">
									<div class="truong-modal-padding" style="padding-bottom: 7%;">
										<label class="col-md-12 control-label align-giua notification">Bạn có thực sự muốn thoát khỏi hệ thống ? </label>
									</div>
								</div>
								<div class="modal-footer">
									<div class="col-md-2 col-md-offset-4">
										<a href="${logoutUrl}" class="truong-small-linkbt"> <input type="button" data-toggle="modal" data-target="#myModalLogout"
											   class="form-control luu" name="" value="Đồng ý"> </a>
									</div>
									<div class="col-md-2 ">
										<input type="button" class="form-control huybo" name="" data-toggle="modal" data-target="#myModalLogout"
											   value="Hủy bỏ">
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="helpForm" role="dialog">
		<div class="modal-dialog" id="modal-qa">

		<!-- Modal content-->
			<div class="modal-content">

				<div class="panel-heading" style="background-color: #2ca9e0; height: 58px ">
				<h5 class="panel-title truong-text-colorwhite" style="text-align: center; font-size: 30px">
					<img src="<%=request.getContextPath()%>/static/image/faq.png" style="height: 43px"> Những câu hỏi thường gặp

					<%--<button type="button" class="close truong-button-xoa" data-dismiss="modal"
						style="margin-bottom: 5px"><img
						src="<%=request.getContextPath()%>/static/image/close.png"
						class="control-label truong-imagexoa-fix">
					</button>--%>


				</h5>

				</div>

				<div class="panel-body">

					<div class="panel-group" id="faqAccordion" style="margin-top: 0px !important;">

					</div>

				</div>

			<%--<div class="modal-footer">
			<div class="col-md-3 col-md-offset-3">
			<input type="button" onclick="multiDelete()" data-toggle="modal" data-target="#myModal"
			class="form-control luu" name="" value="Đồng ý">
			</div>
			<div class="col-md-3 ">
			<input type="button" class="form-control huybo" name="" data-toggle="modal" data-target="#myModal"
			value="Hủy bỏ">
			</div>

			</div>--%>
			</div>

		</div>
	</div>

	<%--End Modal--%>


<script>
	function showModal() {
		$("#myModalLogout").modal("show");
    };

	function dong_bo_master_hiden() {
		var display = $("#dong_bo_master_hiden").css("display");
		if(display == 'none'){
			$("#dong_bo_master_hiden").css("display","");
		}else {
			$("#dong_bo_master_hiden").css("display","none");
		}
	};

</script>

	<script>

	function getQA(){
		var urlRequest = ospApiUrl + "/question-help/search";
		$.ajax({
			type: "GET",
			url: urlRequest,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			data: {
				type: typeQATCCC,
			},
			success: function (response) {
		var html = "";
				var result = response;
				for(var i=0;i<result.length;i++){
					html += '<div class="panel panel-default ">\n'+
					'\t\t\t\t\t\t\t<div class="panel-heading accordion-toggle question-toggle collapsed" data-toggle="collapse"'+
					'data-parent="#faqAccordion" data-target="#question'+i+'">\n'+
					'\t\t\t\t\t\t\t\t<h4 class="panel-title">\n'+
					'\t\t\t\t\t\t\t\t\t<a href="#" class="ing">'+result[i].question+'</a>\n'+
					'\t\t\t\t\t\t\t\t</h4>\n'+
					'\t\t\t\t\t\t\t</div>\n'+
					'\t\t\t\t\t\t\t<div id="question'+i+'" class="panel-collapse collapse" style="height: 0px;">\n'+
					'\t\t\t\t\t\t\t\t<div class="panel-body">\n'+
					'\t\t\t\t\t\t\t\t<h5><span class="label label-primary" style="background-color: #2ca9e0">Trả lời</span></h5>\n'+
					'\t\t\t\t\t\t\t\t\t<p>'+result[i].answer+'</p>\n'+
					'\t\t\t\t\t\t\t\t</div>\n'+
					'\t\t\t\t\t\t\t</div>\n'+
					'\t\t\t\t\t\t</div>';
		}
				$("#faqAccordion").html("");
				$("#faqAccordion").append(html);

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
