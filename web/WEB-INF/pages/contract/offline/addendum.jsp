<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<script type="text/javascript">var id = '${contract.id}';
var mortage_cancel_flag = '${contract.mortage_cancel_flag}';
var from = '${contract.jsonstring}';
var code = '${contract.bank_code}';
var template_id = '${contract.contract_template_id}';
var notary_id = '${contract.notary_id}';
var drafter_id = '${contract.drafter_id}';
var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
var contextPath = '<%=request.getContextPath()%>';

var userEntryId =<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
var org_type =<%=SystemProperties.getProperty("org_type")%>;
var contract_id = '${contract.id}';
var typeHD = '${Constants.CERTIFICATE_TYPE_CONTRACT}';
</script>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String congchungHOA = checkcongchung.equals("1") ? "CHỨNG THỰC" : "CÔNG CHỨNG";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
%>


<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/offline/addendum.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Thêm mới hợp đồng</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="contractEditController">

    <div class="panel-group" id="accordion">
        <div class="form-horizontal bs-example">

            <form class="panel panel-default" name="myForm" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">Thông tin hợp đồng</h4>
                </div>
                <div class="panel-body">
                    <input type="hidden" ng-model="contract.entry_user_id"
                           ng-init="contract.entry_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
                    <input type="hidden" ng-model="contract.entry_user_name"
                           ng-init="contract.entry_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <input type="hidden" ng-model="contract.update_user_id"
                           ng-init="contract.update_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
                    <input type="hidden" ng-model="contract.update_user_name"
                           ng-init="contract.update_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Nhóm hợp đồng</label>
                                <div class="col-md-6">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contractKind.contract_kind_code"
                                            ng-change="myFunc(contractKind.contract_kind_code)" disabled
                                            ng-options="option.contract_kind_code as option.name for option in contractKinds">
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.contractKind.$touched && myForm.contractKind.$invalid">Nhóm hợp đồng không thể bỏ trống.</span>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Tên hợp đồng</label>
                                <div class="col-md-6">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.contract_template_id" disabled
                                            ng-options="item.code_template as item.name for item in contractTemplates">
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.template.$touched && myForm.template.$invalid">Tên hợp đồng không thể bỏ trống.</span>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Số <%=hopDong%></label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contract_number"
                                           ng-model="contract.contract_number" required/>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--neu la phường xã--%>
                                    <label class="col-md-6 control-label  label-bam-phai required">Sổ <%=congchung%></label>
                                </c:if>
                                <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la tccc--%>
                                    <label class="col-md-6 control-label  label-bam-phai ">Sổ <%=congchung%></label>
                                </c:if>
                                <div class="col-md-6">
                                    <select name="notary_book_valid" ng-model="contract.notary_book"
                                            class="selectpicker select2 col-md-12 no-padding" required>
                                        <option >--Chọn sổ <%=congchung%>--</option>
                                        <option ng-repeat="item in notaryBook" value="{{item.notary_book}}">
                                            {{item.notary_book}}
                                        </option>
                                    </select>
                                    <span class="truong-text-colorred">{{notary_book_valid}}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Ngày thụ lý</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="received_date"
                                           ng-model="contract.received_date" id="drafterDate" minlength="10"
                                           maxlength="10" onkeypress="return restrictCharacters(this, event, forDate);"
                                           required/>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="col-md-6 control-label required">Ngày <%=congchung%>
                                </label>
                                <div class="col-md-6 ">
                                    <input type="text" class="form-control" name="notary_date"
                                           ng-model="contract.notary_date" id="notaryDate"
                                           ng-change="changeDateNotary(contract.notary_date)" minlength="10"
                                           maxlength="10" onkeypress="return restrictCharacters(this, event, forDate);"
                                           required/>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.notary_date.$touched && myForm.notary_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                <div class="col-md-6">
                                    &lt;%&ndash;<input type="text" class="form-control" name="drafter_id"   ng-model="drafter.family_name" required/>&ndash;%&gt;
                                    <select class="selectpicker select2 col-md-12 no-padding" ng-model="contract.drafter_id" required
                                            ng-options="item.userId as item.family_name +' ' + item.first_name  for item in drafters">
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="col-md-6 control-label required"><%=congchungH%> viên</label>
                                <div class="col-md-6">
                                    <select class="selectpicker select2 col-md-12 no-padding" ng-model="contract.notary_id" required
                                            ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                    </select>
                                    &lt;%&ndash;<input type="text" class="form-control" name="notary_id"  ng-model="notary.family_name" required />&ndash;%&gt;
                                    <span class="truong-text-colorred"  ng-show="myForm.notary_id.$touched && myForm.notary_id.$invalid">Trường không được bỏ trống.</span>
                                </div>
                            </div>

                        </div>

                    </div>--%>

                    <c:if test="${SystemProperties.getProperty('org_type')!=1}"> <%--Nếu k phải là phường xã--%>
                        <div class="row truong-inline-field">

                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                    <div class="col-md-6">
                                        <%--<input type="text" class="form-control" name="drafter_id"
                                                           ng-model="drafter.family_name" required/>--%>
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.drafter_id" required
                                                ng-options="item.userId as item.family_name +' ' + item.first_name  for item in drafters">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label required"><%=congchungH%> viên</label>
                                    <div class="col-md-6">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.notary_id" required
                                                ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                        </select>
                                        <%--<input type="text" class="form-control" name="notary_id"
                                                           ng-model="notary.family_name" required/>--%>
                                        <span class="truong-text-colorred"
                                              ng-show="myForm.notary_id.$touched && myForm.notary_id.$invalid">Trường không được bỏ trống.</span>
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
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label label-bam-trai">Người tiếp nhận hồ sơ
                                    </label>
                                    <div class="col-md-6">
                                        <input maxlength="255" type="text" class="form-control" ng-model="contract.request_recipient">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label label-bam-phai required">Người
                                        ký <%=congchung%>
                                    </label>
                                    <div class="col-md-6">
                                        <input maxlength="255" type="text" class="form-control" name="contract_signer"
                                               ng-model="contract.contract_signer" required>
                                        <span class="truong-text-colorred"
                                              ng-show="myForm.contract_signer.$touched && myForm.contract_signer.$invalid">Trường không được bỏ trống.</span>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </c:if>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-3">
                                <label class="col-md-12 control-label  label-bam-trai">Tóm tắt nội dung</label>
                            </div>
                            <div class="col-md-9" style="padding-right: 30px;">
                                <textarea class="form-control" name="contract.summary"
                                          ng-model="contract.summary"></textarea>
                            </div>
                        </div>

                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="col-md-3 control-label  label-bam-trai required">Giá trị hợp đồng</label>
                                <div class="col-md-3" style="padding-left: 7px !important;">
                                    <input type="text" class="form-control" name="contract.contract_value"
                                           ng-model="contract.contract_value" format="number"
                                           onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    <span class="truong-text-colorred">{{contract_value_}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <%--<div class="col-md-12">--%>
                            <div class="col-md-3">
                                <label class="col-md-12 control-label label-bam-trai">Địa điểm <%=congchung%>
                                </label>
                            </div>

                            <div class="col-md-9" style="padding-right: 30px;">
                                <input maxlength="200" type="text" class="form-control" name="contract.notary_place"
                                       ng-model="contract.notary_place">
                            </div>
                            <%--</div>--%>

                            <%--<div class="col-md-12" style="padding-right: 30px;padding-left:22px !important;">--%>
                            <div ng-init="contract.notary_place_flag=1"/>
                            <label class="col-sm-3 control-label label-bam-trai"></label>
                            <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--Nếu là tccc--%>
                                <div class="radio col-md-2">
                                    <label>
                                        <input type="radio" ng-model="contract.notary_place_flag" ng-value="1">
                                        Tại văn phòng
                                    </label>
                                </div>
                                <div class="radio col-md-2">
                                    <label>
                                        <input type="radio" ng-model="contract.notary_place_flag" ng-value="0">
                                        Ngoài văn phòng
                                    </label>
                                </div>
                            </c:if>
                            <%--</div>--%>

                        </div>
                    </div>


                </div>
            </form>


            <div ng-switch on="contract.kindhtml.length>0">
                <div ng-switch-when="false">
                    <div class="panel panel-default">
                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                            <h4 class="  panel-title">Thông tin bên liên quan</h4>
                            <div class="pull-right" style="margin:-18px -25px 0px 0px;">
                                <a data-toggle="tooltip" title="Thêm bên liên quan" style="background-image:none;"><i
                                        class="fa fa-plus" ng-click="addPrivy()"
                                        style="font-size:20px;color:#65bd77;margin-right:15px;"></i></a>
                            </div>
                        </header>
                        <div class="panel-body">
                            <section class="panel panel-default"
                                     ng-repeat="(itemIndex,item) in privys.privy track by $index">
                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                    <label class="control-label  label-bam-trai" style="color:#2a2aff">
                                        Bên <label ng-model="item.action" editspan="item.action" class="inputcontract"
                                                   contenteditable="true" style="font-size: 15px !important;">{{item.action}}</label>
                                        (sau đây gọi là {{item.name}}):
                                    </label>
                                    <div class="pull-right" style="margin-right:-25px;">
                                        <div class="btn-group" style="margin-top:-8px;margin-right:15px;">
                                            <button class="btn btn-primary btn-sm dropdown-toggle "
                                                    data-toggle="dropdown"><i class="fa fa-plus"></i> Cá nhân/tổ chức tham gia<span
                                                    class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li><a ng-click="addPerson($index)"><i class="fa fa-plus"></i>Cá
                                                    nhân</a></li>
                                                <li><a ng-click="addCompany($index)"><i class="fa fa-plus"></i>Công
                                                    ty</a></li>
                                                <li><a ng-click="addCreditInstitution($index)"><i
                                                        class="fa fa-plus"></i>Tổ chức tín dụng</a></li>
                                            </ul>
                                        </div>
                                        <a class="pull-right" data-toggle="tooltip" title="Xóa bên liên quan"
                                           style="background-image:none;"><i class="fa fa-trash-o"
                                                                             ng-click="removePrivy($index)"
                                                                             style="font-size:20px;color:red;"></i></a>
                                    </div>
                                </header>
                                <div class="panel-body">
                                    <section class="panel panel-default"
                                             ng-repeat="item1 in item.persons track by $index">
                                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                            <label class=" control-label  label-bam-trai" style="color:#2a2aff">Cá nhân/tổ chức
                                                {{$index+1}}</label>
                                            <div class="pull-right">
                                                <a data-toggle="tooltip" title="Xóa bên đương sự"
                                                   style="background-image:none;"><i class="fa fa-trash-o"
                                                                                     ng-click="removePerson(itemIndex,$index)"
                                                                                     style="font-size:20px;color:red;"></i></a>
                                            </div>
                                        </header>
                                        <div class="panel-body" ng-switch on="item1.template==2"
                                             ng-if="item1.template==1 || item1.template==2">
                                            <div ng-switch-when=true id='parent_1'>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tìm
                                                            kiếm</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="100" type="text" class="form-control org_name"
                                                               ng-model="item1.org_code"
                                                               placeholder="Nhập mã số thuế để tìm kiếm"
                                                               id="org_name{{itemIndex}}-{{$index}}"
                                                               ng-keypress="getsuggest_org(itemIndex,$index);"
                                                               ng-paste="getsuggest_org(itemIndex,$index);"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tên công
                                                            ty</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="200" type="text" class="form-control"
                                                               ng-model="item1.org_name"/>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Mã số
                                                            thuế</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item1.org_code"/>
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
                                                               maxlength="10" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);"/>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label">Đăng kí thay đổi lần
                                                            thứ</label>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item1.number_change_registed"/>
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
                                                               onkeypress="return restrictCharacters(this, event, forDate)"/>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label">Theo</label>
                                                    </div>

                                                    <div class="col-md-3">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item1.department_issue"/>
                                                    </div>


                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Địa chỉ
                                                            công ty</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="255" type="text" class="form-control"
                                                               ng-model="item1.org_address"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Họ tên
                                                            người đại diện</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="200" type="text" class="form-control name"
                                                               ng-model="item1.name"
                                                               placeholder="Nhập CMND/Hộ chiếu/CCCD để tìm kiếm"
                                                               id="name{{itemIndex}}-{{$index}}"
                                                               ng-keypress="getsuggest(itemIndex,$index);"
                                                               ng-paste="getsuggest(itemIndex,$index);"/>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Chức
                                                            vụ</label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control"
                                                               ng-model="item1.position"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div ng-switch-default>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tìm
                                                            kiếm</label>
                                                    </div>
                                                    <div class="col-sm-9" >
                                                        <input maxlength="50" type="text" class="form-control name"
                                                               ng-model="item1.passport"
                                                               placeholder="Nhập CMND/Hộ chiếu/CCCD để tìm kiếm"
                                                               id="name{{itemIndex}}-{{$index}}"
                                                               ng-keypress="getsuggest(itemIndex,$index);"
                                                               ng-paste="getsuggest(itemIndex,$index);"/>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <%--<label class="col-sm-12 control-label label-bam-trai">Họ tên</label>--%>
                                                        <select class="col-sm-12 control-label  label-bam-trai"
                                                                ng-options="option.name for option in dataSelectedSex.availableOptions track by option.id"
                                                                ng-model="item1.sex"
                                                                ng-init="item1.sex.id = 1; item1.sex.name = 'Ông'">
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <input maxlength="200" type="text" class="form-control"
                                                               ng-model="item1.name"/>
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
                                                           id="birthday{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"/>
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">CMND/Hộ
                                                        chiếu/CCCD</label>
                                                </div>

                                                <div class="col-sm-9 ">
                                                    <input maxlength="50" type="text" class="form-control"
                                                           ng-model="item1.passport"/>
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
                                                           onkeypress="return restrictCharacters(this, event, forDate);"/>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label">Nơi cấp</label>
                                                </div>

                                                <div class="col-md-3">
                                                    <input maxlength="100" type="text" class="form-control"
                                                           ng-model="item1.certification_place"/>
                                                </div>


                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Địa
                                                        chỉ</label>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input maxlength="200" type="text" class="form-control" ng-model="item1.address"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="col-sm-12 control-label label-bam-trai">Mô tả</label>
                                                </div>
                                                <div class="col-sm-9 ">
                                                    <input maxlength="500" type="text" class="form-control"
                                                           ng-model="item1.description"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="panel-body" ng-if="item1.template==3">
                                            <div id='parent_1'>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tìm
                                                            kiếm</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="100" type="text" class="form-control org_name"
                                                               ng-model="item1.org_code"
                                                               placeholder="Nhập mã số doanh nghiệp để tìm kiếm"
                                                               id="credit_code{{itemIndex}}-{{$index}}"
                                                               ng-keypress="getsuggest_Credit(itemIndex,$index);"
                                                               ng-paste="getsuggest_Credit(itemIndex,$index);"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Tên ngân
                                                            hàng</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="200" type="text" class="form-control org_name"
                                                               ng-model="item1.org_name"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-3">
                                                        <label class="col-sm-12 control-label label-bam-trai">Mã số
                                                            doanh nghiệp</label>
                                                    </div>
                                                    <div class="col-sm-9" style="padding-right: 30px;">
                                                        <input maxlength="100" type="text" class="form-control org_code"
                                                               ng-model="item1.org_code"/>
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
                                                               ng-model="item1.org_address"/>
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
                                                               ng-model="item1.customer_management_unit"/>
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
                                                               ng-model="item1.address"/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label  label-bam-trai">Điện
                                                            thoại</label>
                                                        <div class="col-md-6">
                                                            <input maxlength="20" type="text" class="form-control phone"
                                                                   ng-model="item1.phone"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label ">Fax </label>
                                                        <div class="col-md-6">
                                                            <input maxlength="20" type="text" class="form-control fax"
                                                                   ng-model="item1.fax"/>
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
                                                               ng-model="item1.registration_certificate"/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label  label-bam-trai">Họ tên
                                                            người đại diện</label>
                                                        <div class="col-md-6">
                                                            <input maxlength="200" type="text"
                                                                   class="form-control phone"
                                                                   ng-model="item1.name"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="col-md-6 control-label ">Chức vụ </label>
                                                        <div class="col-md-6">
                                                            <input maxlength="255" type="text" class="form-control fax"
                                                                   ng-model="item1.position"/>
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
                                                               ng-model="item1.authorization_document"/>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>

                                    </section>

                                </div>

                            </section>
                        </div>
                    </div>

                    <%--<div class="panel panel-default">
                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                            <h4 class="  panel-title">Thông tin tài sản</h4>
                            <div class="pull-right" style="margin:-18px -25px 0px 0px;">
                                <a data-toggle="tooltip" title="Thêm tài sản" style="background-image:none;"><i
                                        class="fa fa-plus" ng-click="addProperty()"
                                        style="font-size:20px;color:#65bd77;margin-right:15px;"></i></a>
                            </div>
                        </header>
                        <div class="panel-body">
                            <section class="panel panel-default"
                                     ng-repeat="item in listProperty.properties track by $index">
                                <header class="panel-heading font-bold">
                                    <label class="control-label  label-bam-trai" style="color:#2a2aff">Tài sản
                                        {{$index+1}}</label>
                                    <div class="pull-right">
                                        <a data-toggle="tooltip" title="Xóa tài sản" style="background-image:none;"><i
                                                class="fa fa-trash-o" ng-click="removeProperty($index)"
                                                style="font-size:20px;color:red;"></i></a>
                                    </div>


                                </header>
                                <div class="panel-body">
                                    &lt;%&ndash;<div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label  label-bam-trai">Loại tài sản</label>
                                        <div class="col-sm-4 input-group" >
                                            <select class="form-control" ng-model="item.type"
                                                    ng-options="pro.id as pro.name for pro in proTypes">
                                            </select>
                                            <span class="input-group-btn">
                                                <a class="btn btn-primary btn-sm" style="margin-left:10px;"  ng-click="showDetails= !showDetails" >
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
                                                    ng-change="changeTypeProperty($index,item.type)">
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
                                                    ng-options="temp1.id as temp1.name for temp1 in getList($index)">

                                            </select>

                                        </div>

                                    </div>

                                    <div ng-show="!showDetails">
                                        <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                            <label class="col-sm-2 control-label label-bam-trai">Thông tin tài
                                                sản</label>
                                            <div class="col-sm-10 input-group">
                                                <textarea maxlength="1000" class="form-control" rows="5"
                                                          name="propertyInfo" ng-model="item.property_info"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                        &lt;%&ndash;<div ng-show="showDetails">
                                            <div ng-show="item.type=='01'">
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}"
                                                               placeholder="Nhập số giấy chứng nhận để được gợi ý"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>

                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Địa chỉ</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="200" type="text" class="form-control"
                                                               ng-model="item.land.land_address"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Số giấy chứng
                                                        nhận</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.land.land_certificate"/>
                                                    </div>
                                                </div>

                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label  label-bam-trai">Nơi cấp</label>
                                                    <div class="col-sm-3" style="padding: 0px 0px!important;">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item.land.land_issue_place">
                                                    </div>

                                                    <label class="col-sm-3 control-label ">Ngày cấp</label>
                                                    <div class="col-sm-3 " style="padding: 0px 0px!important;">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.land_issue_date"
                                                               id="landDate{{$index}}"/>
                                                    </div>
                                                </div>


                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                                    <label class="col-md-3 control-label  label-bam-trai">Thửa đất
                                                        số</label>
                                                    <div class="col-md-3" style="padding: 0px 0px!important;">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.land.land_number"/>
                                                    </div>

                                                    <label class="col-md-3 control-label ">Tờ bản đồ số</label>
                                                    <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.land.land_map_number"/>
                                                    </div>


                                                </div>

                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Tài sản gắn liền
                                                        với đất</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="200" type="text" class="form-control"
                                                               ng-model="item.land.land_associate_property"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Loại nhà ở</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.land_type"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Diện tích xây
                                                        dựng</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.construction_area"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Diện tích
                                                        sàn </label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.building_area"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Hình thức sở
                                                        hữu</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.land_use_type"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Cấp nhà ở</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.land_sort"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Thời hạn sở
                                                        hữu</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.land.land_use_period"/>
                                                    </div>
                                                </div>

                                            </div>
                                            <div ng-show="item.type=='02'">
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_frame_number"
                                                               id="car_frame_number{{$index}}"
                                                               placeholder="Nhập số khung để được gợi ý"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"/>
                                                        <span class="truong-warning-text"
                                                              ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Biển kiểm
                                                        soát</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_license_number"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Số giấy đăng
                                                        ký</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="100" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_regist_number"/>
                                                    </div>
                                                </div>

                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                                    <label class="col-md-3 control-label  label-bam-trai">Nơi cấp</label>
                                                    <div class="col-md-3" style="padding: 0px 0px!important;">
                                                        <input maxlength="200" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_issue_place"/>
                                                    </div>

                                                    <label class="col-md-3 control-label ">Ngày cấp</label>
                                                    <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                        <input type="text" class="form-control"
                                                               ng-model="item.vehicle.car_issue_date"
                                                               id="carDate{{$index}}"/>
                                                    </div>

                                                </div>


                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                                    <label class="col-md-3 control-label  label-bam-trai">Số khung</label>
                                                    <div class="col-md-3" style="padding: 0px 0px!important;">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_frame_number"/>
                                                    </div>

                                                    <label class="col-md-3 control-label ">Số máy</label>
                                                    <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                        <input maxlength="50" type="text" class="form-control"
                                                               ng-model="item.vehicle.car_machine_number"/>
                                                    </div>
                                                </div>

                                            </div>

                                            <div ng-show="item.type=='99'">
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin tài
                                                        sản</label>
                                                    <div class="col-sm-9 input-group">
                                                        <textarea maxlength="1000" type="text" class="form-control" rows="5"
                                                                  ng-model="item.property_info"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                <label class="col-sm-3 control-label label-bam-trai">Thông tin chủ sở
                                                    hữu</label>
                                                <div class="col-sm-9 input-group">
                                                    <input maxlength="500" type="text" class="form-control"
                                                           ng-model="item.owner_info"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                <label class="col-sm-3 control-label label-bam-trai">Thông tin khác</label>
                                                <div class="col-sm-9 input-group">
                                                    <input maxlength="1000" type="text" class="form-control"
                                                           ng-model="item.other_info"/>
                                                </div>
                                            </div>
                                        </div>&ndash;%&gt;

                                        <div ng-show="showDetails">
                                            <div class="col-md-12 panel-body "
                                                 ng-show="item.type=='01' && item.template=='8' && item.myProperty">

                                                <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                    &lt;%&ndash;<h3><b>THÔNG TIN CHUNG CƯ</b></h3>&ndash;%&gt;
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
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
                                                                   class="form-control" id="landIssueDate2{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                                            liền với đất </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text"
                                                                   ng-model="item.land.land_associate_property"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                            sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text" ng-model="item.owner_info"
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
                                                                   ng-paste="getsuggestproperty($index,item.type);"/>
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
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text"
                                                                   ng-model="item.land.land_issue_place"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Cấp
                                                            ngày</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="item.land.land_issue_date"
                                                                   class="form-control" id="landIssueDate3{{$index}}">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                            số</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.land.land_number" class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                                            số</label>
                                                        <div class="col-md-4">
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
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="item.land.land_area"
                                                                   ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                                            chữ </label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="item.land.land_area_text"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                            riêng</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="item.land.land_private_area"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                            chung</label>
                                                        <div class="col-md-4">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                                            liền với đất </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text"
                                                                   ng-model="item.land.land_associate_property"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                            sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text" ng-model="item.owner_info"
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
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Loại nhà
                                                            ở</label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="item.land.land_type"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích xây
                                                            dựng</label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="item.land.construction_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            sàn</label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="item.land.building_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Hình thức sử
                                                            dụng</label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="item.land.land_use_type"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Cấp (hạng) nhà
                                                            ở</label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="item.land.land_sort"
                                                                   class="form-control">
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
                                                                   ng-paste=""/>
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
                                                                   class="form-control">
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
                                                                  rows="2"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Ngày
                                                            cấp</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="item.vehicle.car_issue_date"
                                                                   class="form-control" id="carIssueDate{{$index}}">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Số
                                                            khung</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.vehicle.car_frame_number"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phải">Số máy</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.vehicle.car_machine_number"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                            sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text" ng-model="item.owner_info"
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
                                                                   ng-model="item.property_info" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                                            sở hữu </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text" ng-model="item.owner_info"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            khác </label>
                                                        <div class="col-md-10">
                                                        <textarea maxlength="1000" cols="3" ng-model="item.other_info"
                                                                  class="form-control"
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
                    <jsp:include page="/WEB-INF/pages/contract/offline/formProperty.jsp"/>
                </div>
                <div ng-switch-default>
                    <div class="panel panel-default">
                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                            <h4 class=" panel-title">Nội dung hợp đồng</h4>
                            <div class="btn-group  pull-right" style="margin-top:-25px;">
                                <button class="btn btn-primary btn-md dropdown-toggle " data-toggle="dropdown"><i
                                        class="fa fa-plus"></i>Thêm đương sự/tài sản<span class="caret"></span></button>
                                <ul class="dropdown-menu">
                                    <li><a data-toggle="modal" data-target="#addPrivysDialog"><i class="fa fa-plus"></i>Đương
                                        sự</a></li>
                                    <li><a data-toggle="modal" data-target="#addPropertyDialog"><i
                                            class="fa fa-plus"></i>Tài sản</a></li>
                                </ul>
                            </div>
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
            </div>


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
                                                <%--<select class="selectpicker select2 col-md-12 no-padding"
                                                        ng-model="contract.bank_code"
                                                        ng-options="bank.code as bank.name for bank in banks">
                                                </select>--%>

                                                <select ng-model="contract.bank_code"
                                                        class="selectpicker select2 col-md-12 no-padding">
                                                    <option value="">--Chọn--</option>
                                                    <option ng-repeat="item in banks" value="{{item.code}}">
                                                        {{item.code}} - {{item.name}}
                                                    </option>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Cán bộ tín dụng</label>
                                            <div class="col-lg-8">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="contract.crediter_name" placeholder=""/>
                                            </div>
                                        </div>
                                        <%--<div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Chiết khấu</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" ng-model="contract.bank_service_fee" placeholder="" format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);" />
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
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Số trang HĐ</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.number_of_page" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Số bản <%=congchung%>
                                            </label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.number_copy_of_contract" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                            </div>
                                        </div>
                                        <%--<div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">File đính kèm</label>
                                            <div class="col-lg-8">
                                                <input type="file" file-model="myFile"/>
                                            </div>
                                        </div>--%>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">File đính kèm 2</label>
                                            <div class="col-lg-8" ng-switch on="contract.file_name.length>0">
                                                <div ng-switch-when="true">
                                                <span>
                                                    <a class="underline" ng-click="downloadFile()">{{contract.file_name}}</a>
                                                    <a style="margin-left: 20px" ng-click="removeFile_()"
                                                       class="removeFile">Gỡ bỏ</a>
                                                </span><br>
                                                </div>
                                                <div ng-switch-default>
                                                    <input type="file" file-model="myFile.file"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Lưu trữ bản gốc</label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control"
                                                       ng-model="contract.original_store_place" placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
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
                                            <label class="col-lg-4 control-label label-bam-trai">Phí <%=congchung%></label>
                                            <div class="col-lg-4">
                                                <input type="text" class="form-control" ng-model="contract.cost_tt91" ng-change="calculateTotal()" onkeypress="return restrictCharacters(this, event, digitsOnly);" format="number" />
                                            </div>

                                            <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                                <a ng-click="suggestNotaryFee()" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>
                                            </c:if>
                                            <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                                <a ng-init="suggestCertFee(${Constants.FEE_CERT_HDGD})" ng-click="suggestCertFee(${Constants.FEE_CERT_HDGD})" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>
                                            </c:if>
                                        </div>
                                        <div class="form-group" id="fee-status" style="display: none;">
                                            <div class="col-lg-4">
                                            </div>
                                            <div class="col-lg-8">
                                                <span class=" truong-warning-text">{{announcement.notaryFee}}</span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Thù lao <%=congchung%>
                                            </label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" ng-model="contract.cost_draft"
                                                       ng-change="calculateTotal()"
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number"/>
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
                                                       format="number"/>
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
                                                       format="number"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Tổng phí</label>
                                            <div class="col-lg-8">
                                                <input type="text" ng-model="contract.cost_total" class="form-control"
                                                       placeholder=""
                                                       onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                                       format="number"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label label-bam-trai">Ghi chú</label>
                                            <div class="col-lg-8">
                                                <textarea rows="4" ng-model="contract.note" class="form-control"
                                                          placeholder=""></textarea>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </section>
                        </div>
                    </div>

                </div>
            </section>

            <div class="panel-body" ng-switch on="contract.kindhtml.length>0">
                <div ng-switch-when="true">
                    <div class="list-buttons" style="text-align: center;">
                        <%
                            if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_THEM)) {
                        %>
                        <a data-toggle="modal" data-target="#addContract" class="btn btn-s-md btn-info">Lưu</a>
                        <%
                            }
                        %>
                        <a ng-click="viewAsDoc()" class="btn btn-s-md btn-info">Xem online</a>
                        <a ng-click="downloadWord()" class="btn btn-s-md btn-info">Xuất file word</a>
                        <a href="<%=request.getContextPath()%>/contract/temporary/list" ng-show="checkOnline"
                           class="btn btn-s-md btn-default">Hủy bỏ</a>
                        <a href="<%=request.getContextPath()%>/contract/list" ng-show="!checkOnline"
                           class="btn btn-s-md btn-default">Hủy bỏ</a>
                    </div>
                </div>
                <div ng-switch-default>
                    <div class="list-buttons" style="text-align: center;">
                        <%
                            if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_THEM)) {
                        %>
                        <a data-toggle="modal" data-target="#addContract" class="btn btn-s-md btn-info">Lưu</a>
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

    <div class="modal fade" id="addContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Thêm mới hợp đồng</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận thêm hợp đồng ? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="addContractWrapper()">
                        Đồng ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="viewContentAsWord" role="dialog" style="width:auto;">
        <div class="modal-dialog">
            <div class="modal-content"
                 style="margin:auto!important;align-content:center;width:810px;background: #fff;height:100%;min-height:500px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
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
    <div class="modal fade" id="errorMaxFile" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Dung lượng file đính kèm quá lớn!</h4>
                </div>
                <div class="modal-body">
                    <p>File đính kèm không vượt quá 5MB.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
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
    <div class="modal fade" id="checkValidate" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Thiếu thông tin</h4>
                </div>
                <div class="modal-body">
                    <p>Hãy nhập đủ thông tin vào các trường bắt buộc(có dấu <span class="truong-text-colorred">*</span>)
                    </p>
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


    <div class="modal fade" id="addPrivysDialog" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <button class="btn btn-s-md btn-primary pull-left " ng-click="addPrivy()" type="button">Thêm bên
                        liên quan
                    </button>
                </div>
                <div class="modal-body">
                    <div class="tree well">
                        <ul>
                            <li ng-repeat="(itemIndex,item) in privys.privy track by $index">
                                <span><i class="icon-folder-open"></i> {{item.name}}</span>
                                <a class="btn btn-xs btn-success " ng-click="addPerson($index)"><i
                                        class="fa fa-plus"></i>Thêm cá nhân</a>
                                <a class="btn btn-xs btn-success " ng-click="addOrg($index)"><i class="fa fa-plus"></i>Thêm
                                    tổ chức</a>
                                <a class="btn btn-xs btn-danger " ng-click="removePrivy($index)"><i
                                        class="fa fa-trash-o"></i>Xóa {{item.name}}</a>
                                <ul>
                                    <li ng-repeat="user in item.persons track by $index">
                                            <span ng-switch on="user.name.length>0"><i class="icon-minus-sign"></i>
                                                <div ng-switch-when=true>
                                                     {{user.name}}
                                                </div>
                                                <div ng-switch-default>
                                                     {{$index+1}}
                                                </div>
                                            </span> <a class="btn btn-xs btn-danger "
                                                       ng-click="removePerson(itemIndex,$index)"><i
                                            class="fa fa-trash-o"></i>Xóa</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Đóng</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="addPropertyDialog" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width:900px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <a class="btn btn-s-md btn-primary pull-left " ng-click="addProperty()" type="button"><i
                            class="fa fa-plus"></i>Thêm tài sản</a>

                </div>
                <div class="modal-body">
                    <div class="tree well">
                        <ul>
                            <li>
                                <a>DANH SÁCH TÀI SẢN</a>
                                <ul>
                                    <li ng-repeat="item in listProperty.properties track by $index">
                                        <div class="treeChild">
                                            <div class="col-md-2">
                                                <a class="btn btn-success btn-sm"><i class="icon-folder-open"></i> Tài
                                                    sản {{$index+1}}: </a>
                                            </div>
                                            <div class="col-md-7 " style="margin-bottom:10px;">
                                                <select name="type" ng-model="item.type" class="form-control">
                                                    <option value="01">Nhà đất</option>
                                                    <option value="02">Ôtô-xe máy</option>
                                                    <option value="99">Tài sản khác</option>
                                                </select>
                                            </div>
                                            <div class="col-md-7 col-md-offset-2">
                                                <select ng-model="item.type_view" class="form-control"
                                                        ng-change="changTypeViewProperty($index,item.type_view)">
                                                    <option ng-repeat="item in listTypeTaiSan" value="{{item.id}}">
                                                        {{item.name}}
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <%--<a id="button-taisan{{$index}}" class="btn btn-sm btn-info" data-toggle="popover" data-html="true" data-placement="bottom" data-content="<div class='scrollable' style='height:40px'>Hãy chọn loại mẫu tài sản hiển thị.</div>" title="" data-original-title='<button type="button" class="close pull-right" data-dismiss="popover">&times;</button>Chi tiết mẫu tài sản'>Xem mẫu</a>--%>
                                                <a class="btn btn-sm  btn-danger deleteTree"
                                                   ng-click="removeProperty($index)"><i class="fa fa-trash-o"></i>Xóa
                                                </a>
                                            </div>

                                        </div>
                                    </li>
                                </ul>

                            </li>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Đóng</button>
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
        if (e.target.className == "inputcontract") {
            $("#divcontract").removeAttr("contenteditable");
            $(e.target).focus();
        } else {
            $(this).attr("contenteditable", "true");
            $(e.target).focus();
        }
    });
    $(function () {

//        $('#drafterDate').datepicker({
//            format: "dd/MM/yyyy",
//            language: 'vi'
//        }).on('changeDate', function (ev) {
//            $(this).datepicker('hide');
//        });
//        $('#notaryDate').datepicker({
//            format: "dd/MM/yyyy",
//            language: 'vi'
//        }).on('changeDate', function (ev) {
//            $(this).datepicker('hide');
//        });
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
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#mortageCancelDate').datepicker({
            format: "dd/mm/yyyy",
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