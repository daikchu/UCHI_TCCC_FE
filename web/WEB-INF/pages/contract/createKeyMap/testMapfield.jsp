<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp"/>
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />

<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css" />
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/createKeyMap/testMapField.js" type="text/javascript"></script>

<script  type="text/javascript">
    $("#uchi-status").show();
    setTimeout(function() {
        $("#uchi-status").hide();
        $('#status-success-3').css("display","none");
    }, 3000);

    var contextPath = '<%=request.getContextPath()%>';

    var contract = {};
    contract.contract_template_id = "${contract.contract_template_id}";
    contract.contract_number = "${contract.contract_number}";
    contract.contract_value = "${contract.contract_value}";
    contract.relation_object_a = "${contract.relation_object_a}";
    contract.relation_object_b = "${contract.relation_object_b}";
    contract.relation_object_c = "${contract.relation_object_c}";
    contract.notary_id = "${contract.notary_id}";
    contract.drafter_id = "${contract.drafter_id}";
    contract.received_date = "${contract.received_date}";
    contract.notary_date = "${contract.notary_date}";
    contract.user_require_contract = "${contract.user_require_contract}";
    contract.number_copy_of_contract = "${contract.number_copy_of_contract}";
    contract.number_of_sheet = "${contract.number_of_sheet}";
    contract.number_of_page = "${contract.number_of_page}";
    contract.cost_tt91 = "${contract.cost_tt91}";
    contract.cost_draft = "${contract.cost_draft}";
    contract.cost_notary_outsite = "${contract.cost_notary_outsite}";
    contract.cost_other_determine = "${contract.cost_other_determine}";
    contract.id = "${contract.cost_total}";
    contract.cost_total = "${contract.notary_place_flag}";
    contract.notary_place = "${contract.notary_place}";
    contract.bank_id = "${contract.bank_id}";
    contract.bank_service_fee = "${contract.bank_service_fee}";
    contract.crediter_name = "${contract.crediter_name}";
    contract.file_name = "${contract.file_name}";
    contract.file_path = "${contract.file_path}";
    contract.error_status = "${contract.error_status}";
    contract.error_user_id = "${contract.error_user_id}";
    contract.error_description = "${contract.error_description}";
    contract.addition_status = "${contract.addition_status}";
    contract.addition_description = "${contract.addition_description}";
    contract.cancel_status = "${contract.cancel_status}";
    contract.cancel_description = "${contract.cancel_description}";
    contract.cancel_relation_contract_id = "${contract.cancel_relation_contract_id}";
    contract.contract_period = "${contract.contract_period}";
    contract.mortage_cancel_flag = "${contract.mortage_cancel_flag}";
    contract.mortage_cancel_date = "${contract.mortage_cancel_date}";
    contract.mortage_cancel_note = "${contract.mortage_cancel_note}";
    contract.original_store_place = "${contract.original_store_place}";
    contract.note = "${contract.note}";
    contract.summary = "${contract.summary}";
    contract.entry_user_id = "${contract.entry_user_id}";
    contract.entry_user_name = "${contract.entry_user_name}";
    contract.entry_date_time = "${contract.entry_date_time}";
    contract.update_user_id = "${contract.update_user_id}";
    contract.update_user_name = "${contract.update_user_name}";
    contract.update_date_time = "${contract.update_date_time}";
    contract.bank_name = "${contract.bank_name}";
    contract.jsonstring = "${contract.jsonstring}";
    contract.kindhtml = "${contract.kindhtml}";
    contract.content = "${contract.content}";
    contract.title = "${contract.title}";
    contract.bank_code = "${contract.bank_code}";
    contract.json_property = ${contract.json_property}== "" ? "" : ${contract.json_property};
    contract.json_person = ${contract.json_person} == "" ? "" : ${contract.json_person};
    contract.sub_template_id = "${contract.sub_template_id}";
</script>

<%
    String checkcongchung=SystemProperties.getProperty("org_type");
    String congchung=checkcongchung.equals("1")?"chứng thực":"công chứng";
    String congchungH=checkcongchung.equals("1")?"Chứng thực":"Công chứng";
%>

<style>
    .panel-heading a:after{
        background-image:none;
    }
    .nav-tabs.nav-justified> .active{
        border-top:3px solid #2ca9e0;
    }
    .panel{
        webkit-box-shadow:none;
        box-shadow:none;
    }
    .popover-content {
        height: 200px;
        overflow-y: auto;
    }

</style>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách dòng file word</span>
</div>
<div class="truong-form-chinhpq" ng-app="osp"  ng-controller="contractListController">
    <div id="uchi-status">

    </div>

    <div class="panel-group">
        <form class="form-horizontal" id="search-frm" name="myForm" >
            <div class="col-md-12">
                <a data-toggle="modal" data-target="#addKeyMap" class="btn btn-success btn-sm dropdown-toggle">Dữ liệu bóc tách</a>
            </div>
            <div class="col-md-12">
                <div class="panel-group truong-margin-footer0px">
                    <section class="panel panel-default">
                        <div class="panel-body" style="padding: 0px;">
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <table class="table" style="margin-bottom:0%;table-layout: fixed;">

                                        <tr class="border-table">
                                            <th class=" ann-title border-table table-giua" style="width: 50px;">STT</th>
                                            <th class=" ann-title border-table table-giua">Dữ liệu dòng</th>
                                        </tr>

                                        <c:if test="${contract.fields_ == null || contract.fields_ == '' || contract.fields_ == []}">
                                            <tr>
                                                <td colspan="2" style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 365%">
                                                    Chưa có dữ liệu
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${contract.fields_ != null || contract.fields_ != '' || contract.fields_ != []}">
                                            <c:forEach items="${contract.fields_}" var="item" varStatus="index">
                                                <c:if test="${item.trim() != ''}">
                                                    <tr class="highlight-content" style="height:50px!important;">
                                                        <td class="border-table align-giua">${index.index +1}</td>
                                                        <td class="border-table align-giua">${item}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                    </table>
                                </div>

                            </div>
                        </div>
                    </section>
                </div>
            </div>

        </form>

    </div>

    <div class="modal fade bd-example-modal-lg" id="addKeyMap" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Dữ liệu bóc tách</h4>
                </div>
                <div class="modal-body">
                    <div class="panel-group" id="accordion">
                        <form class="form-horizontal" name="myForm">
                            <div class="panel panel-default" id="panel1">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Thông tin hợp đồng</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label  label-bam-trai required">Nhóm hợp đồng</label>
                                                <div class="col-md-6">
                                                    <select  class="selectpicker select2 col-md-12 no-padding" ng-model="contractKindValue"
                                                             ng-change="myFunc(contractKindValue)"
                                                             ng-options="option.contract_kind_code as option.name for option in contractKinds">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label  label-bam-trai required">Tên hợp đồng</label>
                                                <div class="col-md-6">
                                                    <select  class="selectpicker select2 col-md-12 no-padding" ng-model="contract.contract_template_id" ng-change="changeTemplate(contract.contract_template_id)"
                                                             ng-options="item.code_template as item.name for item in contractTemplates">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label  label-bam-trai required">Số hợp đồng</label>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control" name="contract_number"  ng-model="contract.contract_number" >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label  class="col-md-3 control-label  label-bam-trai required">Ngày thụ lý</label>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control" name="received_date"  ng-model="contract.received_date" ng-minlength="10" maxlength="10" onkeypress="return restrictCharacters(this, event, forDate);" id="fromDate" >
                                                </div>


                                                <label class="col-md-3 control-label required">Ngày <%=congchung%></label>
                                                <div class="col-md-3 ">
                                                    <input type="text" class="form-control" name="notary_date" ng-model="contract.notary_date" id="toDate" ng-change="changeDateNotary(contract.notary_date)" maxlength="10" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);"   />
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label label-bam-trai">Chuyên viên soạn thảo</label>
                                                <div class="col-md-3">
                                                    <select name="drafter_id"ng-model="contract.drafter_id" class="selectpicker select2 col-md-12 no-padding" required>
                                                        <option value="">--Chọn chuyên viên--</option>
                                                        <option  ng-repeat="item in drafters" value="{{item.userId}}">{{item.family_name}} {{item.first_name}}</option>
                                                    </select>
                                                </div>
                                                <label class="col-md-3 control-label required"><%=congchungH%> viên</label>
                                                <div class="col-md-3">
                                                    <select name="notary_id"ng-model="contract.notary_id" class="selectpicker select2 col-md-12 no-padding" required
                                                        ng-options="item.userId as item.family_name+ ' '+item.first_name for item in notarys">
                                                    </select>
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="row truong-inline-field">
                                        <div class="form-group" >
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label  label-bam-trai">Tóm tắt nội dung</label>
                                                <div class="col-md-9" style="padding-right: 30px;">
                                                    <textarea class="form-control" name="contract.summary" ng-model="contract.summary"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row truong-inline-field">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <label class="col-md-3 control-label  label-bam-trai required">Giá trị hợp đồng</label>
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control" name="contract.contract_value" ng-model="contract.contract_value" onkeypress="return restrictCharacters(this, event, digitsOnly);" format="number">

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-md-3">
                                            <label class="col-sm-12 control-label label-bam-trai">Địa điểm <%=congchung%></label>
                                        </div>
                                        <div class="col-sm-9"  style="padding-right: 30px;padding-left:22px !important;">

                                            <div ng-init="contract.notary_place_flag=1" />
                                            <div class="radio">
                                                <label>
                                                    <input type="radio"  ng-model="contract.notary_place_flag"  ng-value="1">
                                                    Tại văn phòng
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio"  ng-model="contract.notary_place_flag"  ng-value="0">
                                                    Ngoài văn phòng
                                                </label>
                                                <input type="text" class="form-control" name="contract.notary_place" ng-model="contract.notary_place">
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="panel panel-default">
                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                    <h4 class=" panel-title">Thông tin đương sự</h4>
                                </header>
                                <div class="panel-body">
                                    <section class="panel panel-default" ng-repeat="(itemIndex,item) in privys.privy track by $index">
                                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                            <label class="control-label  label-bam-trai" style="color:#2a2aff">
                                                Bên <label ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true" style="font-size: 15px !important;">{{item.action}}</label> (sau đây gọi là {{item.name}}):
                                            </label>
                                            <div class="pull-right" style="margin-right:-25px;">
                                                <div class="btn-group" style="margin-top:-8px;margin-right:15px;">
                                                    <button class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown"><i class="fa fa-plus"></i>Đương sự<span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li><a ng-click="addPerson($index)" ><i class="fa fa-plus"></i>Cá nhân</a></li>
                                                        <li><a ng-click="addCompany($index)"><i class="fa fa-plus"></i>Công ty</a></li>
                                                    </ul>
                                                </div>
                                                <a class="pull-right" data-toggle="tooltip" title="Xóa bên liên quan" style="background-image:none;"><i class="fa fa-trash-o"  ng-click="removePrivy($index)"  style="font-size:20px;color:red;"></i></a>
                                            </div>
                                        </header>
                                        <div class="panel-body">
                                            <section class="panel panel-default" ng-repeat="item1 in item.persons track by $index">
                                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                                    <label class=" control-label  label-bam-trai" style="color:#2a2aff">Đương sự {{$index+1}}</label>
                                                    <div class="pull-right">
                                                        <a data-toggle="tooltip" title="Xóa bên đương sự" style="background-image:none;"><i class="fa fa-trash-o"  ng-click="removePerson(itemIndex,$index)"   style="font-size:20px;color:red;"></i></a>
                                                    </div>

                                                </header>
                                                <div class="panel-body" ng-switch on="item1.template==2">
                                                    <div ng-switch-when=true  id='parent_1'>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Tìm kiếm</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input maxlength="100" type="text" class="form-control org_name" ng-model="item1.org_code" placeholder="Nhập mã số thuế để tìm kiếm"
                                                                       id="org_name{{itemIndex}}-{{$index}}" ng-keypress="getsuggest_org(itemIndex,$index);" ng-paste="getsuggest_org(itemIndex,$index);" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Tên công ty</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input maxlength="200" type="text" class="form-control org_name" ng-model="item1.org_name" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Mã số thuế</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input maxlength="100" type="text" class="form-control org_code" ng-model="item1.org_code"  />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <div class="col-md-6">
                                                                <label class="col-md-6 control-label  label-bam-trai">Đăng kí lần đầu ngày </label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control first_registed_date" ng-model="item1.first_registed_date" id="first_registed_date{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"  />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="col-md-6 control-label ">Đăng kí thay đổi lần thứ </label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control number_change_registed" ng-model="item1.number_change_registed" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-6">
                                                                <label class="col-md-6 control-label  label-bam-trai">Ngày đăng kí thay đổi </label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control change_registed_date" ng-model="item1.change_registed_date" id="change_registed_date{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"   />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="col-md-6 control-label ">Theo </label>
                                                                <div class="col-md-6">
                                                                    <input maxlength="100" type="text" class="form-control department_issue" ng-model="item1.department_issue" />
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Địa chỉ công ty</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input type="text" class="form-control org_address" ng-model="item1.org_address"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Họ tên người đại diện</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input  type="text" class="form-control name" ng-model="item1.name" placeholder="Nhập CMND/Hộ chiếu/CCCD để tìm kiếm"
                                                                        id="name{{itemIndex}}-{{$index}}" ng-keypress="getsuggest(itemIndex,$index);" ng-paste="getsuggest(itemIndex,$index);" />

                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Chức vụ</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input type="text" class="form-control org_address" ng-model="item1.position"  />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div ng-switch-default>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <label class="col-sm-12 control-label label-bam-trai">Tìm kiếm</label>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input maxlength="50" type="text" class="form-control name" ng-model="item1.passport" placeholder="Nhập CMND/Hộ chiếu để tìm kiếm"
                                                                       id="name{{itemIndex}}-{{$index}}" ng-keypress="getsuggest(itemIndex,$index);" ng-paste="getsuggest(itemIndex,$index);"   />
                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-3">
                                                                <%--<label class="col-sm-12 control-label label-bam-trai">Họ tên</label>--%>
                                                                <select ng-init="item1.sex.id = 1; item1.sex.name = 'Ông'" class="col-sm-12 control-label  label-bam-trai"
                                                                        ng-options="option.name for option in dataSelectedSex.availableOptions track by option.id"
                                                                        ng-model="item1.sex">
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-9"  style="padding-right: 30px;">
                                                                <input maxlength="200" type="text" class="form-control name" ng-model="item1.name" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-3">
                                                            <label class="col-sm-12 control-label label-bam-trai">Ngày sinh</label>
                                                        </div>
                                                        <div class="col-sm-9"  style="padding-right: 30px;">
                                                            <input  type="text" class="form-control birthday" ng-model="item1.birthday" id="birthday{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)" />
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-3">
                                                            <label class="col-sm-12 control-label label-bam-trai">CMND/Hộ chiếu/CCCD</label>
                                                        </div>
                                                        <div class="col-sm-9"  style="padding-right: 30px;">
                                                            <input maxlength="50" type="text" class="form-control passport" ng-model="item1.passport" />
                                                        </div>

                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-md-6">
                                                            <label class="col-md-6 control-label  label-bam-trai">Ngày cấp</label>
                                                            <div class="col-md-6">
                                                                <input type="text" class="form-control certification_date" ng-model="item1.certification_date" id="certification{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"  />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="col-md-6 control-label ">Nơi cấp</label>
                                                            <div class="col-md-6">
                                                                <input maxlength="100" type="text" class="form-control certification_place" ng-model="item1.certification_place" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-3">
                                                            <label class="col-sm-12 control-label label-bam-trai">Địa chỉ</label>
                                                        </div>
                                                        <div class="col-sm-9"  style="padding-right: 30px;">
                                                            <input type="text" class="form-control address" ng-model="item1.address" id="address{{itemIndex}}-{{$index}}" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-3">
                                                            <label class="col-sm-12 control-label label-bam-trai">Mô tả</label>
                                                        </div>
                                                        <div class="col-sm-9"  style="padding-right: 30px;">
                                                            <input maxlength="500" type="text" class="form-control description" ng-model="item1.description" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </section>

                                        </div>

                                    </section>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                    <h4 class="panel-title">Thông tin tài sản</h4>
                                </header>
                                <div class="panel-body">
                                    <section class="panel panel-default" ng-repeat="item in listProperty.properties track by $index">
                                        <header class="panel-heading font-bold">
                                            <label class=" control-label  label-bam-trai" style="color:#2a2aff">Tài sản {{$index+1}}</label>
                                            <div class="pull-right">
                                                <a data-toggle="tooltip" title="Xóa tài sản" style="background-image:none;"><i class="fa fa-trash-o"  ng-click="removeProperty($index)"   style="font-size:20px;color:red;"></i></a>
                                            </div>
                                        </header>
                                        <div class="panel-body">
                                            <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                <label class="col-sm-3 control-label  label-bam-trai">Loại tài sản</label>
                                                <div class="col-sm-4 input-group" >
                                                    <select name="type" ng-model="item.type" class="form-control truong-selectbox-padding" >
                                                        <option value="01">Nhà đất</option>
                                                        <option value="02">Ôtô-xe máy</option>
                                                        <option value="99">Tài sản khác</option>
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-primary btn-sm" style="margin-left:10px;" ng-click="showDetails= !showDetails" type="button">
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

                                            </div>

                                            <div  ng-show="!showDetails">
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin tài sản</label>
                                                    <div class="col-sm-9 input-group">
                                                        <textarea maxlength="1000" class="form-control" rows="5" name="propertyInfo" ng-model="item.property_info"></textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            <div ng-show="showDetails">
                                                <div ng-show="item.type=='01'">
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Tìm kiếm</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="50" type="text" class="form-control"  ng-model="item.land.land_certificate"
                                                                   id="land_certificate{{$index}}" placeholder="Nhập số giấy chứng nhận để được gợi ý" ng-keypress="getsuggestproperty($index,item.type);" ng-paste="getsuggestproperty($index,item.type);"  />
                                                            <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                        </div>

                                                    </div>

                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px" >
                                                        <label class="col-sm-3 control-label label-bam-trai">Địa chỉ</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="200" type="text" class="form-control" ng-model="item.land.land_address"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Số giấy chứng nhận</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="50" type="text" class="form-control"  ng-model="item.land.land_certificate" />

                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label  class="col-sm-3 control-label  label-bam-trai">Nơi cấp</label>
                                                        <div class="col-sm-3" style="padding: 0px 0px!important;">
                                                            <input maxlength="100" type="text"  class="form-control"  ng-model="item.land.land_issue_place" >
                                                        </div>

                                                        <label class="col-sm-3 control-label ">Ngày cấp</label>
                                                        <div class="col-sm-3 " style="padding: 0px 0px!important;">
                                                            <input type="text" class="form-control" ng-model="item.land.land_issue_date" id="landDate{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"   />
                                                        </div>
                                                    </div>


                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">

                                                        <label class="col-md-3 control-label  label-bam-trai">Thửa đất số</label>
                                                        <div class="col-md-3" style="padding: 0px 0px!important;">
                                                            <input maxlength="50" type="text"class="form-control"   ng-model="item.land.land_number"   />
                                                        </div>

                                                        <label  class="col-md-3 control-label ">Tờ bản đồ số</label>
                                                        <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                            <input maxlength="50" type="text"  class="form-control"  ng-model="item.land.land_map_number"    />
                                                        </div>


                                                    </div>

                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Tài sản gắn liền với đất</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="200" type="text" class="form-control" ng-model="item.land.land_associate_property"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Loại nhà ở</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="255" type="text" class="form-control" ng-model="item.land.land_type"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Diện tích xây dựng</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="200" type="text" class="form-control" ng-model="item.land.construction_area"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Diện tích sàn </label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="255"  type="text" class="form-control" ng-model="item.land.building_area"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Hình thức sở hữu</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="255"  type="text" class="form-control" ng-model="item.land.land_use_type"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Cấp nhà ở</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="255"  type="text" class="form-control" ng-model="item.land.land_sort"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Thời hạn sở hữu</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="100" type="text" class="form-control" ng-model="item.land.land_use_period"   />
                                                        </div>
                                                    </div>


                                                </div>
                                                <div ng-show="item.type=='02'">

                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Tìm kiếm</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="50" type="text" class="form-control"  ng-model="item.vehicle.car_frame_number"
                                                                   id="car_frame_number{{$index}}" placeholder="Nhập số khung để được gợi ý" ng-keypress="getsuggestproperty($index,item.type);" ng-paste="getsuggestproperty($index,item.type);"  />
                                                            <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Biển kiểm soát</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="50" type="text" class="form-control"  ng-model="item.vehicle.car_license_number"   />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Số giấy đăng ký</label>
                                                        <div class="col-sm-9 input-group">
                                                            <input maxlength="100" type="text" class="form-control"  ng-model="item.vehicle.car_regist_number"  />
                                                        </div>
                                                    </div>

                                                    <div class="form-group"  style="padding-right: 20px;padding-left: 20px">

                                                        <label class="col-md-3 control-label  label-bam-trai">Nơi cấp</label>
                                                        <div class="col-md-3" style="padding: 0px 0px!important;">
                                                            <input maxlength="200" type="text" class="form-control"   ng-model="item.vehicle.car_issue_place"   />
                                                        </div>

                                                        <label  class="col-md-3 control-label ">Ngày cấp</label>
                                                        <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                            <input type="text" class="form-control" ng-model="item.vehicle.car_issue_date" id="carDate{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)"   />
                                                        </div>

                                                    </div>


                                                    <div class="form-group"  style="padding-right: 20px;padding-left: 20px">

                                                        <label  class="col-md-3 control-label  label-bam-trai">Số khung</label>
                                                        <div class="col-md-3" style="padding: 0px 0px!important;">
                                                            <input maxlength="50" type="text"class="form-control"   ng-model="item.vehicle.car_frame_number"   />
                                                        </div>

                                                        <label class="col-md-3 control-label ">Số máy</label>
                                                        <div class="col-md-3 " style="padding: 0px 0px!important;">
                                                            <input maxlength="50" type="text"  class="form-control"  ng-model="item.vehicle.car_machine_number"   />
                                                        </div>
                                                    </div>

                                                </div>

                                                <div ng-show="item.type=='99'">
                                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                        <label class="col-sm-3 control-label label-bam-trai">Thông tin tài sản</label>
                                                        <div class="col-sm-9 input-group">
                                                            <textarea maxlength="1000" type="text" class="form-control" rows="5" ng-model="item.property_info"   ></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin chủ sở hữu</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="200" type="text" class="form-control" ng-model="item.owner_info"   />
                                                    </div>
                                                </div>
                                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin khác</label>
                                                    <div class="col-sm-9 input-group">
                                                        <input maxlength="1000" type="text" class="form-control" ng-model="item.other_info"   />
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </section>
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
                                                            <label class="col-sm-4 control-label label-bam-trai">Tình trạng hợp đồng</label>
                                                            <div class="col-sm-8" >
                                                                <div class="radio" >
                                                                    <label>
                                                                        <input type="checkbox"  ng-model="checkBank"    ng-click="showDescrip=!showDescrip">
                                                                        Hợp đồng cần bổ sung hồ sơ
                                                                    </label>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="form-group" ng-show="showDescrip">
                                                            <label class="col-lg-4 control-label label-bam-trai">Mô tả</label>
                                                            <div class="col-lg-8">
                                                                <textarea  rows="3" ng-model="contract.addition_description" class="form-control" placeholder=""></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Tên ngân hàng</label>
                                                            <div class="col-lg-8">
                                                                <select ng-model="contract.bank_code" class="selectpicker select2 col-md-12 no-padding" >
                                                                    <option value="">--Chọn--</option>
                                                                    <option  ng-repeat="item in banks" value="{{item.code}}" >{{item.code}} - {{item.name}}</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Cán bộ tín dụng</label>
                                                            <div class="col-lg-8">
                                                                <input maxlength="200" type="text" class="form-control" ng-model="contract.crediter_name" placeholder="">
                                                            </div>
                                                        </div>
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
                                                                <input type="text" class="form-control" ng-model="contract.number_of_sheet" onkeypress="return restrictCharacters(this, event, digitsOnly);" placeholder="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Số trang HĐ</label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.number_of_page" onkeypress="return restrictCharacters(this, event, digitsOnly);" placeholder="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Số bản <%=congchung%></label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.number_copy_of_contract" onkeypress="return restrictCharacters(this, event, digitsOnly);" placeholder="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">File đính kèm (Tối đa 5MB)</label>
                                                            <div class="col-lg-8">
                                                                <input type="file" file-model="myFile"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Lưu trữ bản gốc</label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.original_store_place" onkeypress="return restrictCharacters(this, event, digitsOnly);" placeholder="">
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
                                                                <input type="text" class="form-control" ng-model="contract.cost_tt91" ng-change="calculateTotal()" onkeypress="return restrictCharacters(this, event, digitsOnly);" format="number">
                                                            </div>
                                                        </div>
                                                        <div class="form-group" id="fee-status" style="display: none;">
                                                            <div class="col-lg-4">
                                                            </div>
                                                            <div class="col-lg-8" >
                                                                <span class=" truong-warning-text" >{{announcement.notaryFee}}</span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Thù lao <%=congchung%></label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.cost_draft"  ng-change="calculateTotal()" onkeypress="return restrictCharacters(this, event, digitsOnly);"  format="number">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Dịch vụ <%=congchung%> ngoài</label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.cost_notary_outsite"  ng-change="calculateTotal()" onkeypress="return restrictCharacters(this, event, digitsOnly);"  format="number">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Dịch vụ xác minh khác</label>
                                                            <div class="col-lg-8">
                                                                <input type="text" class="form-control" ng-model="contract.cost_other_determine"  ng-change="calculateTotal()" onkeypress="return restrictCharacters(this, event, digitsOnly);"  format="number" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Tổng phí</label>
                                                            <div class="col-lg-8">
                                                                <input type="text" ng-model="contract.cost_total"  class="form-control" placeholder="" format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-4 control-label label-bam-trai">Ghi chú</label>
                                                            <div class="col-lg-8">
                                                                <textarea rows="4" ng-model="contract.note" class="form-control" placeholder=""></textarea>
                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<script>
    $(function () {
        $('body').on('click', function (e) {
            //did not click a popover toggle, or icon in popover toggle, or popover
            if ($(e.target).data('toggle') !== 'popover'
                && $(e.target).parents('[data-toggle="popover"]').length === 0
                && $(e.target).parents('.popover.in').length === 0) {
                $('[data-toggle="popover"]').popover('hide');
            }
        });
    });
</script>
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#list-key-map-contract").addClass("child-menu");
    });
</script>