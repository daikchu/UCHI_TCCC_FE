<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %><%--
  Created by IntelliJ IDEA.
  User: TienManh
  Date: 5/18/2017
  Time: 2:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<script type="text/javascript">
    var id = '${contract.id}';
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var mortage_cancel_flag = '${contract.mortage_cancel_flag}';
    var from = '${contract.jsonstring}';
    var code = '${contract.bank_code}';
    var template_id = '${contract.contract_template_id}';
    var sub_template_id = '${contract.sub_template_id}';
    var notary_id = '${contract.notary_id}';
    var drafter_id = '${contract.drafter_id}';
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath = '<%=request.getContextPath()%>';
    var updateUserName = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>';
    var updateUserId = '<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>';
    var contract_id = '${contract.id}';
    var org_type =<%=SystemProperties.getProperty("org_type")%>;
    var typeHD = '${Constants.CERTIFICATE_TYPE_CONTRACT}';
</script>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String congchungHOA = checkcongchung.equals("1") ? "CHỨNG THỰC" : "CÔNG CHỨNG";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
    String soHopDong = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/offline/contract.edit.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>


<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Sửa thông tin hợp đồng</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="contractEditController">

    <div class="panel-group" id="accordion">
        <div class="form-horizontal bs-example">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">Thông tin hợp đồng</h4>
                </div>
                <div class="panel-body">
                    <input type="hidden" ng-model="contract.update_user_id"
                           ng-init="contract.update_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
                    <input type="hidden" ng-model="contract.update_user_name"
                           ng-init="contract.update_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <c:if test="${contract.contract_template_id != null}">
                        <div class="row truong-inline-field">

                            <div class="form-group">
                                <label class="col-md-3 control-label  label-bam-trai">Nhóm hợp đồng</label>
                                <div class="col-md-3">
                                    <select disabled="true" class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contractKind.contract_kind_code"
                                            ng-change="myFunc(contractKind.contract_kind_code)"
                                            ng-options="option.contract_kind_code as option.name for option in contractKinds">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <label class="col-md-3 control-label  label-bam-trai">Tên hợp đồng</label>
                                <div class="col-md-3">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.contract_template_id" disabled="true"
                                            ng-options="item.code_template as item.name for item in contractTemplates">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div ng-show="contract.kindhtml.length>0">
                            <div ng-show="contractTemplatesApiece != '' && contractTemplatesApiece != null">
                                <div class="row truong-inline-field">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label  label-bam-trai">Tên mẫu hợp đồng</label>
                                        <div class="col-md-3">
                                            <select class="selectpicker select2 col-md-12 no-padding"
                                                    ng-model="contract.sub_template_id" disabled="true"
                                                    ng-options="item.code_template as item.name for item in contractTemplatesApiece">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${contract.contract_template_id == null}">
                        <div class="form-group">
                            <label class="col-md-3 control-label  label-bam-trai">Tên hợp đồng cũ</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="transactionProperty.contract_name"
                                       ng-model="transactionProperty.contract_name" disabled="true"/>

                            </div>
                        </div>
                        <%--load hop dong--%>
                        <div class="row truong-inline-field">
                            <div class="form-group">

                                <label class="col-md-3 control-label  label-bam-trai required">Nhóm hợp đồng</label>
                                <div class="col-md-6">
                                    <select ng-model="contractKindValue" name="contractKind"
                                            class="selectpicker select2 col-md-12 no-padding"
                                            ng-change="myFunc(contractKindValue)" required>
                                        <option value="">--Chọn--</option>
                                        <option ng-repeat="item in contractKinds" value="{{item.contract_kind_code}}">
                                            {{item.name}}
                                        </option>
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.contractKind.$touched && myForm.contractKind.$invalid">Nhóm hợp đồng không thể bỏ trống.</span>
                                </div>

                            </div>
                        </div>
                        <div class="row truong-inline-field">
                            <div class="form-group">

                                <label class="col-md-3 control-label  label-bam-trai required">Tên hợp đồng</label>
                                <div class="col-md-6">
                                    <select name="template" ng-model="contract.contract_template_id"
                                            class="selectpicker select2 col-md-12 no-padding" required
                                            ng-change="myFuncLoadMortage(contract.contract_template_id)">
                                        <option value="">--Chọn--</option>
                                        <option ng-repeat="item in contractTemplates" value="{{item.code_template}}">
                                            {{item.name}}
                                        </option>
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.template.$touched && myForm.template.$invalid">Tên hợp đồng không thể bỏ trống.</span>
                                </div>

                            </div>
                        </div>

                    </c:if>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-3 control-label  label-bam-trai">Số <%=hopDong%></label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.contract_number"
                                       ng-model="contract.contract_number" disabled="true">
                            </div>
                            <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--neu la phường xã--%>
                                <label class="col-md-3 control-label  label-bam-phai required">Sổ <%=congchung%></label>
                            </c:if>
                            <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la tccc--%>
                                <label class="col-md-3 control-label  label-bam-phai ">Sổ <%=congchung%></label>
                            </c:if>
                            <div class="col-md-3">
                                <select name="notary_book_valid" ng-model="contract.notary_book"
                                        class="selectpicker select2 col-md-12 no-padding" required>
                                    <option>--Chọn sổ <%=congchung%>--</option>
                                    <option ng-repeat="item in notaryBook" value="{{item.notary_book}}">
                                        {{item.notary_book}}
                                    </option>
                                </select>
                                <span class="truong-text-colorred">{{notary_book_valid}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">

                            <label class="col-md-3 control-label  label-bam-trai">Ngày thụ lý</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.received_date"
                                       ng-model="contract.received_date" id="drafterDate" disabled="true">
                            </div>

                            <label class="col-md-3 control-label ">Ngày <%=congchung%>
                            </label>
                            <div class="col-md-3 ">
                                <input type="text" class="form-control" name="contract.notary_date"
                                       ng-model="contract.notary_date" id="notaryDate" disabled="true">
                            </div>
                        </div>

                    </div>
                    <c:if test="${SystemProperties.getProperty('org_type')!=1}"> <%--Nếu k phải là phường xã--%>
                        <div class="row truong-inline-field">
                            <div class="form-group">

                                <label class="col-md-3 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                <div class="col-md-3">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.drafter_id" disabled="true"
                                            ng-options="item.userId as item.family_name  +' ' + item.first_name  for item in drafters">
                                    </select>
                                </div>
                                <div ng-show="notaryIdSaveBackUp == notaryIdBackUp">
                                    <label class="col-md-3 control-label "><%=congchungH%> viên</label>
                                    <div class="col-md-3">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.notary_id"
                                                ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                        </select>
                                    </div>
                                </div>
                                <div ng-show="notaryIdSaveBackUp != notaryIdBackUp">
                                    <label class="col-md-3 control-label "><%=congchungH%> viên</label>
                                    <div class="col-md-3">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.notary_id" disabled="true"
                                                ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--Nếu là phường xã--%>
                        <input type="hidden" ng-model="contract.notary_id"
                               ng-init="contract.notary_id=userEntryId">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="">
                                    <label class="col-md-3 control-label label-bam-trai">Người tiếp nhận hồ sơ</label>
                                    <div class="col-md-3">
                                        <input maxlength="255" type="text" class="form-control" ng-model="contract.request_recipient"
                                               disabled>
                                    </div>

                                    <label class="col-md-3 control-label label-bam-phai required">Người
                                        ký <%=congchung%>
                                    </label>
                                    <div class="col-md-3">
                                        <input maxlength="255" type="text" class="form-control" name="contract.contract_signer"
                                               ng-model="contract.contract_signer" disabled="true">
                                    </div>
                                </div>

                            </div>

                        </div>
                    </c:if>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="">
                                <label class="col-md-3 control-label  label-bam-trai">Tóm tắt nội dung</label>
                                <div class="col-md-9">
                                    <textarea class="form-control" name="contract.summary" ng-model="contract.summary"
                                              disabled="true"></textarea>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-3 control-label  label-bam-trai">Giá trị hợp đồng</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.contract_value"
                                       ng-model="contract.contract_value"
                                       onkeypress="return restrictCharacters(this, event, digitsOnly);" format="number"
                                       disabled="true">
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <%--<div ng-init="contract.notary_place_flag=1" />--%>
                        <div class="form-group" ng-init="contract.notary_place_flag=1">
                            <%--<div class="col-md-12">--%>
                            <label class="col-sm-3 control-label label-bam-trai">Địa điểm <%=congchung%>
                            </label>
                            <div class="col-md-9">
                                <input maxlength="200" type="text" class="form-control" name="contract.notary_place"
                                       ng-model="contract.notary_place" disabled="true"/>
                            </div>
                            <%--</div>--%>

                            <%--<div class="col-md-12">--%>

                            <label class="col-sm-3 control-label label-bam-trai"></label>
                            <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--Nếu là tccc--%>
                                <div class="radio col-md-2">
                                    <label>
                                        <input type="radio" ng-model="contract.notary_place_flag" ng-value="1"
                                               disabled="true"/>
                                        Tại văn phòng
                                    </label>
                                </div>
                                <div class="radio col-md-2">
                                    <label>
                                        <input type="radio" ng-model="contract.notary_place_flag" ng-value="0"
                                               disabled="true"/>
                                        Ngoài văn phòng
                                    </label>
                                </div>
                            </c:if>
                            <%--</div>--%>

                        </div>
                    </div>

                    <%-- <div class="row truong-inline-field">
                         <div class="form-group">
                             <label class="col-sm-3 control-label label-bam-trai">Địa điểm <%=congchung%></label>
                             <div class="col-sm-9" >

                                 <div ng-init="contract.notary_place_flag=1" />
                                 <div class="radio">
                                     <label>
                                         <input type="radio"  ng-model="contract.notary_place_flag"  ng-value="1" disabled="true">
                                         Tại văn phòng
                                     </label>
                                 </div>
                                 <div class="radio">
                                     <label>
                                         <input type="radio"  ng-model="contract.notary_place_flag"  ng-value="0" disabled="true">
                                         Ngoài văn phòng
                                     </label>
                                     <input type="text" class="form-control" name="contract.notary_place" ng-model="contract.notary_place" disabled="true">
                                 </div>
                             </div>
                         </div>
                     </div>--%>

                    <div class="row truong-inline-field" ng-if="template.period_flag==1">
                        <div class="form-group">
                            <label class="col-md-3 control-label  label-bam-trai">Thời hạn</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.contract_period"
                                       ng-model="contract.contract_period" id="periodDate"/>
                            </div>
                        </div>
                    </div>

                    <div ng-if="template.mortage_cancel_func==1">

                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <label class="col-sm-3 control-label label-bam-trai">Giải chấp</label>
                                <div class="col-sm-9">
                                    <label>
                                        <input type="checkbox" ng-model="contract.mortage_cancel_flag"
                                               ng-click="showMor= !showMor" ng-true-value="1" ng-false-value="0"/>
                                        Chọn nếu giải chấp hợp đồng.
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row truong-inline-field" ng-show="showMor">
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Ngày giải chấp</label>
                                    <div class="col-md-6">
                                        <%--<input type="text" class="form-control" name="drafter.family_name"  ng-model="contract.mortage_cancel_func" />--%>
                                        <input type="text" class="form-control" ng-model="contract.mortage_cancel_date"
                                               id="mortageCancelDate"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label ">Lý do</label>
                                    <div class="col-md-6 ">
                                        <input type="text" class="form-control"
                                               ng-model="contract.mortage_cancel_note"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%--<div ng-switch on="contract.kindhtml.length>0">--%>
            <div ng-show="!contract.kindhtml.length>0">
                <div class="panel panel-default">
                    <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                        <h4 class="panel-title">Thông tin bên liên quan</h4>
                    </header>
                    <c:if test="${contract.json_person != null && contract.json_person.length() > 0}">
                        <div class="panel-body">
                            <section class="panel panel-default"
                                     ng-repeat="(itemIndex,item) in privys.privy track by $index">
                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                    <label class="control-label  label-bam-trai" style="color:#2a2aff">Bên
                                        {{item.action}} (sau đây gọi là {{item.name}}):</label>
                                </header>
                                <div class="panel-body">
                                    <section class="panel panel-default"
                                             ng-repeat="item1 in item.persons track by $index">
                                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                            <label class="control-label  label-bam-trai" style="color:#2a2aff">Cá nhân/tổ chức
                                                {{$index+1}}</label>
                                        </header>
                                        <div class="panel-body" ng-switch on="item1.template==2"
                                             ng-if="item1.template==1 || item1.template==2">
                                            <div ng-switch-when=true>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tên công
                                                            ty</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item1.org_name" disabled/>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Mã số
                                                            thuế</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control"
                                                               ng-model="item1.org_code" disabled/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Đăng kí
                                                            lần đầu ngày</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="text" class="form-control"
                                                               ng-model="item1.first_registed_date"
                                                               id="first_registed_date{{itemIndex}}-{{$index}}"
                                                               disabled="true" maxlength="10" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);"/>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label">Đăng kí thay đổi lần
                                                            thứ</label>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item1.number_change_registed" disabled="true"/>
                                                    </div>


                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Ngày đăng
                                                            kí thay đổi</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="text" class="form-control"
                                                               ng-model="item1.change_registed_date"
                                                               id="change_registed_date{{itemIndex}}-{{$index}}"
                                                               disabled="true" onkeypress="return restrictCharacters(this, event, forDate)"/>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label">Theo</label>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item1.department_issue" disabled="true"/>
                                                    </div>


                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Địa chỉ
                                                            công ty</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="255" type="text" class="form-control"
                                                               ng-model="item1.org_address" disabled/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Họ tên
                                                            người đại diện</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="200" type="text" class="form-control" ng-model="item1.name"
                                                               disabled/>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Chức
                                                            vụ</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control"
                                                               ng-model="item1.position" disabled/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div ng-switch-default>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">{{item1.sex.name}}</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="200" type="text" class="form-control" ng-model="item1.name"
                                                               disabled/>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Ngày
                                                        sinh</label>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" ng-model="item1.birthday"
                                                           id="birthday{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)" disabled/>
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">CMND/Hộ
                                                        chiếu/CCCD</label>
                                                </div>

                                                <div class="col-sm-9 ">
                                                    <input maxlength="50" type="text" class="form-control"
                                                           ng-model="item1.passport" disabled="true"/>
                                                    <span class="truong-text-colorred"
                                                          id="CMT-{{itemIndex}}-{{$index}}" hidden>CMND/Hộ chiếu/CCCD không chứa ký tự đặc biệt</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Ngày
                                                        cấp</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control"
                                                           ng-model="item1.certification_date"
                                                           id="certification{{itemIndex}}-{{$index}}"
                                                           onkeypress="return restrictCharacters(this, event, forDate);" disabled="true"/>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label">Nơi cấp</label>
                                                </div>

                                                <div class="col-md-3">
                                                    <input maxlength="100" type="text" class="form-control"
                                                           ng-model="item1.certification_place" disabled="true"/>
                                                </div>


                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Địa
                                                        chỉ</label>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input maxlength="200" type="text" class="form-control" ng-model="item1.address"
                                                           disabled="true"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Mô tả</label>
                                                </div>
                                                <div class="col-sm-9 ">
                                                    <input maxlength="500" type="text" class="form-control"
                                                           ng-model="item1.description" disabled="true"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="panel-body" ng-if="item1.template==3">
                                            <div id='parent_1'>
                                                    <%--<div class="form-group">
                                                        <div class="col-md-3">
                                                            <label class="col-sm-12 control-label label-bam-trai">Tìm kiếm</label>
                                                        </div>
                                                        <div class="col-sm-9" style="padding-right: 30px;">
                                                            <input type="text" class="form-control org_name"
                                                                   ng-model="item1.org_code"
                                                                   placeholder="Nhập mã số doanh nghiệp để tìm kiếm"
                                                                   id="credit_code{{itemIndex}}-{{$index}}"
                                                                   ng-keypress="getsuggest_Credit(itemIndex,$index);"
                                                                   ng-paste="getsuggest_Credit(itemIndex,$index);"/>
                                                        </div>
                                                    </div>--%>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tên ngân
                                                            hàng</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="200" type="text" class="form-control org_name"
                                                               ng-model="item1.org_name" disabled/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Mã số
                                                            doanh nghiệp</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="100" type="text" class="form-control org_code"
                                                               ng-model="item1.org_code" disabled/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Địa chỉ
                                                            trụ sở chính</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="255" type="text"
                                                               class="form-control org_address"
                                                               ng-model="item1.org_address" disabled/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Đơn vị
                                                            trực tiếp quản lý khách hàng</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="255" type="text"
                                                               class="form-control customer_management_unit"
                                                               ng-model="item1.customer_management_unit" disabled/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Địa
                                                            chỉ</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="255" type="text"
                                                               class="form-control org_address"
                                                               ng-model="item1.address" disabled/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label  label-bam-trai">Điện
                                                            thoại</label>
                                                        <div class="col-md-6">
                                                            <input maxlength="20" type="text" class="form-control phone"
                                                                   ng-model="item1.phone" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label ">Fax </label>
                                                        <div class="col-md-6">
                                                            <input maxlength="20" type="text" class="form-control fax"
                                                                   ng-model="item1.fax" disabled/>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Giấy chứng
                                                            nhận đăng ký hoạt động Chi nhánh/Phòng giao dịch</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input type="text" class="form-control registration_certificate"
                                                               ng-model="item1.registration_certificate" disabled/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label  label-bam-trai">Họ tên
                                                            người đại diện</label>
                                                        <div class="col-md-6">
                                                            <input maxlength="200" type="text"
                                                                   class="form-control phone"
                                                                   ng-model="item1.name" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label ">Chức vụ </label>
                                                        <div class="col-md-6">
                                                            <input maxlength="255" type="text" class="form-control fax"
                                                                   ng-model="item1.position" disabled/>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Văn bản ủy
                                                            quyền</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input type="text" class="form-control authorization_document"
                                                               ng-model="item1.authorization_document" disabled/>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>

                                    </section>

                                </div>

                            </section>
                        </div>
                    </c:if>
                    <c:if test="${contract.json_person== null || contract.json_person == ''}">
                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                            <label class="col-sm-3 control-label label-bam-trai">Thông tin bên liên quan</label>
                            <div class="col-sm-9 input-group" style="padding-left:15px;padding-right:10px">
                                <textarea class="form-control" rows="5" name="contract.relation_object_a"
                                          ng-model="contract.relation_object_a" disabled="true"></textarea>
                            </div>
                        </div>
                    </c:if>
                </div>

                <%--<div class="panel panel-default">
                    <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                        <h4 class="   panel-title">Thông tin tài sản</h4>
                    </header>
                    <div class="panel-body">
                        <section class="panel panel-default"
                                 ng-repeat="item in listProperty.properties track by $index">
                            <header class="panel-heading font-bold">
                                <label class=" control-label  label-bam-trai" style="color:#2a2aff">Tài sản
                                    {{$index+1}}</label>
                            </header>
                            <div class="panel-body">
                                &lt;%&ndash;<div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                    <label class="col-sm-3 control-label  label-bam-trai">Loại tài sản</label>
                                    <div class="col-sm-4 input-group">
                                        <select class="form-control" ng-model="item.type" disabled="true"
                                                ng-options="pro.id as pro.name for pro in proTypes">
                                        </select>
                                        <span class="input-group-btn">
                                                <a class="btn btn-primary btn-sm" style="margin-left:10px;"
                                                   ng-click="showDetails= !showDetails">
                                                    <div ng-switch on="showDetails">
                                                        <div ng-switch-when=true>
                                                            Thông tin đơn giản
                                                        </div>
                                                        <div ng-switch-default>
                                                            Thông tin chi tiết
                                                        </div>
                                                    </div>
                                                </a>
                                             </span>
                                    </div>
                                </div>&ndash;%&gt;

                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-md-2 control-label  label-bam-trai">Loại tài sản</label>
                                        <div class="col-md-4">
                                            <select name="type" ng-model="item.type"
                                                    class="form-control truong-selectbox-padding"
                                                    ng-change="changeTypeProperty($index,item.type)"
                                                    disabled>
                                                <option value="01">Nhà đất</option>
                                                <option value="02">Ôtô-xe máy</option>
                                                <option value="99">Tài sản khác</option>
                                            </select>
                                        </div>
                                        <span class="input-group-btn ">
                                        <button class="btn btn-primary btn-sm" style="margin-left:10px;"
                                                ng-click="showDetails= !showDetails" type="button">
                                            <div ng-switch on="showDetails">
                                                <div ng-switch-when=true>
                                                    <a style="color:white;">Thông tin đơn giản</a>
                                                </div>
                                                <div ng-switch-default>
                                                    <a style="color:white;">Thông tin chi tiết</a>
                                                </div>
                                            </div>
                                        </button>
                                </span>

                                    </div>

                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-md-2 control-label  label-bam-trai"></label>
                                        <div class="col-md-4">
                                            <select ng-model="item.template" class="form-control"
                                                    ng-change="changTemplateProperty($index,item.template)"
                                                    ng-options="temp1.id as temp1.name for temp1 in getList($index)" disabled>

                                            </select>

                                        </div>

                                    </div>

                                <div ng-show="!showDetails">
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-2 control-label label-bam-trai">Thông tin tài sản</label>
                                        <div class="col-sm-10 input-group">
                                            <textarea maxlength="1000" class="form-control" rows="5" name="propertyInfo"
                                                      ng-model="item.property_info" disabled="true"></textarea>
                                        </div>
                                    </div>
                                </div>

                                &lt;%&ndash;<div ng-show="showDetails">
                                    <div ng-show="item.type=='01'">
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Địa chỉ</label>
                                            <div class="col-sm-9 input-group">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="item.land.land_address" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Số giấy chứng
                                                nhận</label>
                                            <div class="col-sm-9 input-group">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.land.land_certificate" disabled="true"/>
                                            </div>
                                        </div>

                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label  label-bam-trai">Nơi cấp</label>
                                            <div class="col-sm-3" style="padding: 0px 0px!important;">
                                                <input maxlength="100" type="text" class="form-control"
                                                       ng-model="item.land.land_issue_place" disabled>
                                            </div>

                                            <label class="col-sm-3 control-label ">Ngày cấp</label>
                                            <div class="col-sm-3 " style="padding: 0px 0px!important;">
                                                <input type="text" class="form-control"
                                                       ng-model="item.land.land_issue_date" id="landDate{{$index}}"
                                                       disabled="true"/>
                                            </div>
                                        </div>


                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                            <label class="col-md-3 control-label  label-bam-trai">Thửa đất số</label>
                                            <div class="col-md-3" style="padding: 0px 0px!important;">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.land.land_number" disabled="true"/>
                                            </div>

                                            <label class="col-md-3 control-label ">Tờ bản đồ số</label>
                                            <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.land.land_map_number" disabled="true"/>
                                            </div>


                                        </div>

                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Tài sản gắn liền với
                                                đất</label>
                                            <div class="col-sm-9 input-group">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="item.land.land_associate_property" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Loại nhà ở</label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control" ng-model="item.land.land_type"
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Diện tích xây
                                                dựng</label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control"
                                                       ng-model="item.land.construction_area" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Diện tích sàn </label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control"
                                                       ng-model="item.land.building_area" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Hình thức sở
                                                hữu</label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control"
                                                       ng-model="item.land.land_use_type" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Cấp nhà ở</label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control" ng-model="item.land.land_sort"
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Thời hạn sở hữu</label>
                                            <div class="col-sm-9 input-group">
                                                <input type="text" class="form-control"
                                                       ng-model="item.land.land_use_period" disabled="true"/>
                                            </div>
                                        </div>

                                    </div>
                                    <div ng-show="item.type=='02'">
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Biển kiểm soát</label>
                                            <div class="col-sm-9 input-group">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.vehicle.car_license_number" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Số giấy đăng ký</label>
                                            <div class="col-sm-9 input-group">
                                                <input maxlength="100" type="text" class="form-control"
                                                       ng-model="item.vehicle.car_regist_number" disabled="true"/>
                                            </div>
                                        </div>

                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                            <label class="col-md-3 control-label  label-bam-trai">Nơi cấp</label>
                                            <div class="col-md-3" style="padding: 0px 0px!important;">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="item.vehicle.car_issue_place" disabled="true"/>
                                            </div>

                                            <label class="col-md-3 control-label ">Ngày cấp</label>
                                            <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                <input type="text" class="form-control"
                                                       ng-model="item.vehicle.car_issue_date" id="carDate{{$index}}"
                                                       disabled="true"/>
                                            </div>

                                        </div>


                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                            <label class="col-md-3 control-label  label-bam-trai">Số khung</label>
                                            <div class="col-md-3" style="padding: 0px 0px!important;">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.vehicle.car_frame_number" disabled="true"/>
                                            </div>

                                            <label class="col-md-3 control-label ">Số máy</label>
                                            <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item.vehicle.car_machine_number" disabled="true"/>
                                            </div>
                                        </div>

                                    </div>

                                    <div ng-show="item.type=='99'">
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-3 control-label label-bam-trai">Thông tin tài
                                                sản</label>
                                            <div class="col-sm-9 input-group">
                                                <textarea maxlength="1000" type="text" class="form-control" rows="5"
                                                          ng-model="item.property_info" disabled="true"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Thông tin chủ sở
                                            hữu</label>
                                        <div class="col-sm-9 input-group">
                                            <input maxlength="500" type="text" class="form-control"
                                                   ng-model="item.owner_info" disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Thông tin khác</label>
                                        <div class="col-sm-9 input-group">
                                            <input maxlength="1000" type="text" class="form-control"
                                                   ng-model="item.other_info" disabled="true"/>
                                        </div>
                                    </div>
                                </div>&ndash;%&gt;

                                    <div ng-show="showDetails">


                                        <div class="col-md-12 panel-body "
                                             ng-show="item.type=='01' && item.template=='8' && item.myProperty">

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                &lt;%&ndash;<h3><b>THÔNG TIN CHUNG CƯ</b></h3>&ndash;%&gt;
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                        kiếm</label>
                                                    <div class="col-sm-10">
                                                        <input maxlength="50" type="text"
                                                               class="form-control name autocomplete_land_certificate{{$index}}"
                                                               ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}"
                                                               placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                                        nhận số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_certificate"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="100" type="text"
                                                               ng-model="item.land.land_issue_place"
                                                               class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp
                                                        ngày</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_issue_date"
                                                               class="form-control" id="landIssueDate{{$index}}"
                                                               onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa
                                                        chỉ </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.apartment.apartment_address"
                                                                  class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Căn hộ
                                                        số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.apartment.apartment_number"
                                                               class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-trai">Tầng </label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.apartment.apartment_floor"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tổng diện tích
                                                        sử dụng</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.apartment.apartment_area_use"
                                                               class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích xây
                                                        dựng</label>
                                                    <div class="col-sm-4">
                                                        <input type="text"
                                                               ng-model="item.apartment.apartment_area_build"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Kết cấu
                                                        nhà </label>
                                                    <div class="col-md-10">
                                                        <textarea cols="3" ng-model="item.apartment.apartment_structure"
                                                                  class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Số tầng nhà
                                                        chung cư</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.apartment.apartment_total_floor"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                        số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                                        số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_map_number"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                                        đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện
                                                        tích</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_area"
                                                               ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                                               class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                                        chữ </label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_area_text"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                        riêng</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_private_area"
                                                               class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                        chung</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_public_area"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_purpose"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_period"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_origin"
                                                               class="form-control">
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                        quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.restrict"
                                                               class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                        khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        &lt;%&ndash;chú thích bắt đầu tài sản nhà đất &ndash;%&gt;
                                        <div class="col-md-12 panel-body "
                                             ng-show="item.type=='01' && item.template=='1' && item.myProperty">

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                &lt;%&ndash;<h3><b>THÔNG TIN TÀI SẢN ĐẤT</b></h3>&ndash;%&gt;
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                        kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text"
                                                               class="form-control name autocomplete_land_certificate{{$index}}"
                                                               ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}"
                                                               placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"
                                                               disabled/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                                        nhận số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_certificate"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="100" type="text"
                                                               ng-model="item.land.land_issue_place"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp
                                                        ngày</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_issue_date"
                                                               class="form-control" id="landIssueDate2{{$index}}"
                                                               onkeypress="return restrictCharacters(this, event, forDate)"
                                                               disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                        số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_number" class="form-control"
                                                               disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                                        số</label>
                                                    <div class="col-sm-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_map_number"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                                        đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2" disabled></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện
                                                        tích</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_area"
                                                               ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                                        chữ </label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_area_text"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                        riêng</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_private_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                        chung</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" ng-model="item.land.land_public_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_purpose"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_period"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_origin"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                        quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.restrict"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                                        liền với đất </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text"
                                                               ng-model="item.land.land_associate_property"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                        sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="500" type="text" ng-model="item.owner_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                        khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        &lt;%&ndash; chú thích bắt đầu đất, nhà ở gắn liền với đất &ndash;%&gt;

                                        <div class="col-md-12 panel-body "
                                             ng-show="item.type=='01' && item.template=='10' && item.myProperty">

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                &lt;%&ndash;<h3><b>THÔNG TIN TÀI SẢN ĐẤT , NHÀ Ở GẮN LIỀN VỚI ĐẤT</b></h3>&ndash;%&gt;
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                        kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text"
                                                               class="form-control name autocomplete_land_certificate{{$index}}"
                                                               ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}"
                                                               placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"
                                                               disabled/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                                        nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_certificate"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text"
                                                               ng-model="item.land.land_issue_place"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp
                                                        ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_issue_date"
                                                               class="form-control" id="landIssueDate3{{$index}}"
                                                               disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                        số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_number" class="form-control"
                                                               disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                                        số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.land.land_map_number"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                                        đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2" disabled></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện
                                                        tích</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_area"
                                                               ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                                        chữ </label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_area_text"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                        riêng</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_private_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                        chung</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_public_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_purpose"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sở
                                                        hữu</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_period"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_origin"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                        quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.restrict"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                                        liền với đất </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text"
                                                               ng-model="item.land.land_associate_property"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                        sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="500" type="text" ng-model="item.owner_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                        khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Loại nhà
                                                        ở</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_type"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích xây
                                                        dựng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.construction_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                        sàn</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.building_area"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hình thức sử
                                                        dụng</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_use_type"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Cấp (hạng) nhà
                                                        ở</label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="item.land.land_sort"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        &lt;%&ndash; chú thích bắt đầu ô-to xe máy&ndash;%&gt;
                                        <div class="col-md-12 panel-body "
                                             ng-show="item.type=='02' && item.template=='6' && item.myProperty">

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                &lt;%&ndash; <h3><b>THÔNG TIN TÀI SẢN Ô TÔ XE MÁY</b></h3>&ndash;%&gt;
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                        kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text"
                                                               class="form-control name autocomplete_car_frame_number{{$index}}"
                                                               ng-model="item.vehicle.car_frame_number"
                                                               id="car_frame_number{{$index}}"
                                                               placeholder="Nhập số khung để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="" disabled/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Biển kiếm
                                                        soát </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.vehicle.car_license_number"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Số giấy đăng
                                                        ký </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text"
                                                               ng-model="item.vehicle.car_regist_number"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nơi
                                                        cấp </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.vehicle.car_issue_place"
                                                                  class="form-control"
                                                                  rows="2" disabled></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Ngày
                                                        cấp</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.vehicle.car_issue_date"
                                                               class="form-control" id="carIssueDate{{$index}}"
                                                               disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Số
                                                        khung</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.vehicle.car_frame_number"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phải">Số máy</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text"
                                                               ng-model="item.vehicle.car_machine_number"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                        sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="500" type="text" ng-model="item.owner_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                        khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        &lt;%&ndash;chú thích bắt đầu tài sản khác &ndash;%&gt;
                                        <div class="col-md-12 panel-body "
                                             ng-show="item.type=='99' && item.template=='3' && item.myProperty">

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                &lt;%&ndash;<h3><b>THÔNG TIN TÀI SẢN KHÁC</b></h3>&ndash;%&gt;

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin tài
                                                        sản </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text"
                                                               ng-model="item.property_info" class="form-control"
                                                               disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                        sở hữu </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="500" type="text" ng-model="item.owner_info"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                        khác </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="1000" cols="3" ng-model="item.other_info"
                                                                  class="form-control" disabled
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>

                                    </div>

                            </div>
                        </section>
                    </div>
                </div>--%>

                <jsp:include page="/WEB-INF/pages/contract/offline/formPropertyDisable.jsp"/>
            </div>
            <div ng-show="contract.kindhtml.length>0">
                <div class="panel panel-default">
                    <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                        <h4 class=" panel-title">Nội dung hợp đồng</h4>
                    </header>
                    <div class="panel-body">
                        <div id="copyContract"></div>

                        <div class="contractContent" style="margin:auto;width:800px;">
                            <div id="divcontract" class="divcontract" class=" pull-right "
                                 style="margin:auto!important;align-content:center;width:745px;padding:20px 54px;background: #fff;height:800px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                                <div dynamic="contract.kindhtml" id="contentKindHtml"></div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <%--</div>--%>


            <section class="panel panel-default">
                <header class="panel-heading font-bold">
                    <h4 class="control-label required label-bam-trai">Thông tin khác</h4>
                </header>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <section class="panel panel-default">
                                <header class="panel-heading font-bold">Ngân hàng</header>
                                <div class="panel-body">
                                    <form class="bs-example form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label label-bam-trai">Tình trạng hợp
                                                đồng</label>
                                            <div class="col-sm-8">

                                                <div class="radio">
                                                    <label>
                                                        <input type="checkbox" ng-model="checkBank"
                                                               ng-click="showDescrip=!showDescrip">
                                                        Hợp đồng cần bổ sung hồ sơ
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" ng-show="showDescrip">
                                            <label class="col-lg-4 control-label label-bam-trai">Mô tả</label>
                                            <div class="col-lg-8">
                                                <textarea rows="3" ng-model="contract.addition_description"
                                                          class="form-control" placeholder=""></textarea>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-4 control-label label-bam-trai"></label>
                                            <div class="col-sm-8">

                                                <div class="radio">
                                                    <label>
                                                        <input type="checkbox" ng-model="checkError"
                                                               ng-click="showError=!showError">
                                                        Hợp đồng lỗi
                                                    </label>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group" ng-show="showError">
                                            <label class="col-lg-4 control-label label-bam-trai">Mô tả lỗi</label>
                                            <div class="col-lg-8">
                                                <textarea rows="3" ng-model="contract.error_description"
                                                          class="form-control" placeholder=""></textarea>
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Tên ngân hàng</label>
                                            <div class="col-lg-8">
                                                <select class="selectpicker select2 col-md-12 no-padding"
                                                        ng-model="contract.bank_code" disabled="true"
                                                        ng-options="bank.code as bank.name for bank in banks">
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Cán bộ tín dụng</label>
                                            <div class="col-lg-8">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="contract.crediter_name" placeholder=""
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <%--<div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Chiết khấu</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" ng-model="contract.bank_service_fee" placeholder="" format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);" disabled="true"/>
                                            </div>
                                        </div>--%>

                                    </form>
                                </div>
                            </section>
                            <section class="panel panel-default">
                                <header class="panel-heading font-bold">Thông tin lưu trữ</header>
                                <div class="panel-body">
                                    <form class="bs-example form-horizontal">
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Số tờ HĐ</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.number_of_sheet" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Số trang HĐ</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.number_of_page" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Số bản <%=congchung%>
                                            </label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.number_copy_of_contract" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">File đính kèm</label>
                                            <div class="col-lg-8" ng-switch on="contract.file_name.length>0">
                                                <div ng-switch-when="true">
                                                    <a class="underline" ng-click="downloadFile()">{{contract.file_name}}</a>
                                                </div>
                                                <div ng-switch-default>
                                                    <span>Không có file đính kèm</span>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Lưu trữ bản gốc</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.original_store_place" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       disabled="true"/>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </section>
                        </div>
                        <div class="col-sm-6">
                            <section class="panel panel-default">
                                <header class="panel-heading font-bold">Thu phí (VNĐ)</header>
                                <div class="panel-body">
                                    <form class="bs-example form-horizontal">
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Phí <%=congchung%>
                                            </label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" ng-model="contract.cost_tt91"
                                                       ng-change="calculateTotal()"
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number" disabled="true"/>
                                            </div>
                                            <%-- <a ng-click="suggestNotaryFee()" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>--%>
                                        </div>
                                        <%-- <span class=" truong-warning-text" style="margin-left: 17px !important;" >{{announcement.notaryFee}}</span>--%>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Thù lao <%=congchung%>
                                            </label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" ng-model="contract.cost_draft"
                                                       ng-change="calculateTotal()"
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Dịch vụ <%=congchung%>
                                                ngoài</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.cost_notary_outsite"
                                                       ng-change="calculateTotal()"
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Dịch vụ xác minh
                                                khác</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.cost_other_determine"
                                                       ng-change="calculateTotal()"
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Tổng phí</label>
                                            <div class="col-lg-8">
                                                <input type="text" ng-model="contract.cost_total" class="form-control"
                                                       placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Ghi chú</label>
                                            <div class="col-lg-8">
                                                <textarea rows="4" ng-model="contract.note" class="form-control"
                                                          placeholder="" disabled></textarea>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </section>
                        </div>


                    </div>

                </div>
            </section>


            <div class="panel-body">

                <div ng-switch on="contract.kindhtml.length>0">
                    <div ng-switch-when="true">
                        <div class="list-buttons" style="text-align: center;">
                            <%
                                if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_SUA)) {
                            %>
                            <a data-toggle="modal" data-target="#editContract" class="btn btn-s-md btn-info">Lưu</a>
                            <%
                                }
                            %>
                            <a ng-click="viewAsDoc()" class="btn btn-s-md btn-primary">Xem online</a>
                            <a ng-click="downloadWord()" class="btn btn-s-md btn-primary">Xuất file word</a>
                            <a href="<%=request.getContextPath()%>/contract/temporary/list" ng-show="checkOnline"
                               class="btn btn-s-md btn-default">Hủy bỏ</a>
                            <a href="<%=request.getContextPath()%>/contract/list" ng-show="!checkOnline"
                               class="btn btn-s-md btn-default">Hủy bỏ</a>
                        </div>
                    </div>
                    <div ng-switch-default>
                        <div class="list-buttons" style="text-align: center;">
                            <%
                                if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_SUA)) {
                            %>
                            <a data-toggle="modal" data-target="#editContract" class="btn btn-s-md btn-info">Lưu</a>
                            <%
                                }
                            %>
                            <a href="<%=request.getContextPath()%>/contract/temporary/list" ng-show="checkOnline"
                               class="btn btn-s-md btn-default">Hủy bỏ</a>
                            <a href="<%=request.getContextPath()%>/contract/list" ng-show="!checkOnline"
                               class="btn btn-s-md btn-default">Hủy bỏ</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="viewContentAsWord" role="dialog" style="width:auto;">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content"
                 style="margin:auto!important;align-content:center;width:810px;background: #fff;height:100%;min-height:500px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <%--<h4 class="modal-title">Hợp đồng</h4>--%>
                </div>
                <div class="modal-body">
                    <div style="float: right">
                        <div class="advanPrint nut-in"><img
                                src="<%=request.getContextPath()%>/static/image/btn-print.gif"
                                alt="Them moi"></div>
                    </div>

                    <div id="viewHtmlAsWord" style="width: 595px;margin-left: 2.5cm;margin-right: 1.5cm;">

                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="errorEdit" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Error</h4>
                </div>
                <div class="modal-body">
                    <p>Có lỗi xảy ra. Hãy thử lại sau! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="checkDate" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Nhập thông tin sai!</h4>
                </div>
                <div class="modal-body">
                    <p>Ngày thụ lý và ngày <%=congchung%> phải là định dạng dd/MM/yyyy. </p>
                    <p>Ngày thụ lý không thể sau ngày <%=congchung%>. Ngày <%=congchung%> không thể sau ngày hiện
                        tại. </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="editContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sửa thông tin hợp đồng</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận sửa hợp đồng này? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="editContract()">Đồng
                        ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="checkContractNumber" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Trùng số hợp đồng!</h4>
                </div>
                <div class="modal-body">
                    <p>Số <%=hopDong%> này đã tồn tại. Bạn hãy thay số <%=hopDong%> khác. </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="checkCodeTemplate" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Chưa chọn Tên hợp đồng!</h4>
                </div>
                <div class="modal-body">
                    <p>Hợp đồng cũ bạn muốn thay đổi phải chọn Tên hợp đồng. </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>

</div>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script>
    $("#divcontract").bind('click', function (e) {
        $(this).attr("contenteditable", "false");
        $(e.target).attr("contenteditable", "false");

        /*if (e.target.className == "inputcontract") {
            $("#divcontract").removeAttr("contenteditable");
            $(e.target).focus();
        } else {
            $(this).attr("contenteditable", "false");
            $(e.target).focus();
        }*/
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
        $('#landDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#carDate').datepicker({
            format: "dd/mm/yyyy",
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#periodDate').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#mortageCancelDate').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });


    });
    $(document).ready(function () {
        //load menu
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#ds-hd-cong-chung").addClass("child-menu");

    });
    $(function () {
        $(".nut-in").on('click', function () {

            $("#viewHtmlAsWord").print({

// Use Global styles
                globalStyles: false,

// Add link with attrbute media=print
                mediaPrint: false,

//Custom stylesheet
                stylesheet: "<%=request.getContextPath()%>/static/css/contract/print/print.css",

//Print in a hidden iframe
                iframe: false,

// Don't print this
                noPrintSelector: ".avoid-this",

// Add this on top
                append: "",

// Add this at bottom
                prepend: "",

// Manually add form values
                manuallyCopyFormValues: true,

// resolves after print and restructure the code for better maintainability
                deferred: $.Deferred(),

// timeout
                timeout: 250,

// Custom title
                title: null,

// Custom document type
                doctype: '<!doctype html>'

            });
        });
    });

</script>