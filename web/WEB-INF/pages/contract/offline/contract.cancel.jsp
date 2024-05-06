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
    var from = '${contract.jsonstring}';
    var code = '${contract.bank_code}';
    var template_id = '${contract.contract_template_id}';
    var sub_template_id = '${contract.sub_template_id}';
    var notary_id = '${contract.notary_id}';
    var drafter_id = '${contract.drafter_id}';
    var number_contract = '${contract.contract_number}';
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
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/offline/contract.cancel.js"
        type="text/javascript"></script>


<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Hủy hợp đồng số ${contract.contract_number}</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="contractEditController">

    <div class="panel-group" id="accordion">
        <div class="form-horizontal" method="post">
            <form class="panel panel-default" id="panel1" name="myForm">
                <div class="panel-heading">
                    <h4 class="panel-title">Thông tin hợp đồng hủy</h4>
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
                        <c:if test="${contract.contract_template_id != null}">
                        <div class="form-group">
                            <label class="col-md-3 control-label  label-bam-trai required">Nhóm hợp đồng</label>
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
                            <label class="col-md-3 control-label  label-bam-trai required">Tên hợp đồng</label>
                            <div class="col-md-3">
                                <select class="selectpicker select2 col-md-12 no-padding"
                                        ng-model="contract.contract_template_id"
                                        ng-change="changeTemplate(contract.contract_template_id)"
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
                                                ng-model="contract.sub_template_id"
                                                ng-change="changeTemplate_Apiece_Select(contract.sub_template_id)"
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
                            <label class="col-md-3 control-label  label-bam-trai required">Số <%=hopDong%></label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.contract_number"
                                       ng-model="contract.contract_number">
                                <span class="truong-text-colorred"
                                      ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>
                                <span class="truong-text-colorred">{{contract_number_}}</span>
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

                            <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--Nếu là phường xã--%>
                                <label class="col-md-3 control-label  label-bam-trai required">Ngày thụ lý</label>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="contract.received_date"
                                           ng-model="contract.received_date" id="drafterDate" onkeypress="return restrictCharacters(this, event, forDate);" required/>
                                    <span class="truong-text-colorred">{{received_date_}}</span>
                                    <%--<span class="truong-text-colorred"  ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                </div>
                            </c:if>
                            <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--Nếu làtccc--%>
                                <label class="col-md-3 control-label  label-bam-trai">Ngày thụ lý</label>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="contract.received_date"
                                           ng-model="contract.received_date" id="drafterDate" onkeypress="return restrictCharacters(this, event, forDate);" required/>
                                    <%--<span class="truong-text-colorred"  ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                </div>
                            </c:if>

                            <label class="col-md-3 control-label required">Ngày <%=congchung%>
                            </label>
                            <div class="col-md-3 ">
                                <input type="text" class="form-control" name="notary_date"
                                       ng-model="contract.notary_date" id="notaryDate"
                                       ng-change="changeDateNotary(contract.notary_date)" minlength="10" maxlength="10"
                                       onkeypress="return restrictCharacters(this, event, forDate);" required/>
                                <span class="truong-text-colorred"
                                      ng-show="myForm.notary_date.$touched && myForm.notary_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>

                            </div>


                        </div>

                    </div>

                    <c:if test="${SystemProperties.getProperty('org_type')!=1}"> <%--Nếu k phải là phường xã--%>
                        <div class="row truong-inline-field">
                            <div class="form-group">

                                <label class="col-md-3 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                <div class="col-md-3">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.drafter_id"
                                            ng-options="item.userId as item.family_name  +' ' + item.first_name  for item in drafters">
                                    </select>
                                </div>

                                <label class="col-md-3 control-label required"><%=congchungH%> viên</label>
                                <div class="col-md-3">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.notary_id"
                                            ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.notary_id.$touched && myForm.notary_id.$invalid">Trường không được bỏ trống.</span>

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
                                        <input maxlength="255" type="text" class="form-control" ng-model="contract.request_recipient">
                                    </div>
                                    <label class="col-md-3 control-label label-bam-phai required">Người
                                        ký <%=congchung%>
                                    </label>
                                    <div class="col-md-3">
                                        <input maxlength="255" type="text" class="form-control" name="contract.contract_signer"
                                               ng-model="contract.contract_signer">
                                        <span class="truong-text-colorred">{{contract_signer_}}</span>
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
                                    <textarea class="form-control" name="contract.summary"
                                              ng-model="contract.summary"></textarea>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <label class="col-md-3 control-label label-bam-trai required">Giá trị hợp đồng</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="contract.contract_value"
                                       ng-model="contract.contract_value"
                                       onkeypress="return restrictCharacters(this, event, digitsOnly);" format="number">
                                <span class="truong-text-colorred">{{contract_value_}}</span>
                            </div>

                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <%--<div class="col-md-12">--%>
                            <label class="col-sm-3 control-label label-bam-trai">Địa điểm <%=congchung%>
                            </label>
                            <div class="col-md-9">
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
        </div>


        <%--<div ng-switch on="contract.kindhtml.length>0">--%>
        <div ng-show="contract.kindhtml.length>0">
            <div class="panel panel-default">
                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                    <h4 class=" panel-title">Nội dung hợp đồng</h4>
                </header>
                <div class="panel-body">
                    <div id="copyContract"></div>

                    <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                         data-target="#editor" style="margin:auto;width:800px;">
                        <div style="margin:auto;vertical-align: middle;display:table">

                            <div class="btn-group"><a class="btn btn-default btn-sm" data-edit="bold"
                                                      title="Bold (Ctrl/Cmd+B)">
                                <i class="fa fa-bold"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i
                                        class="fa fa-italic"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="strikethrough" title="Strikethrough"> <i
                                        class="fa fa-strikethrough"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)">
                                    <i class="fa fa-underline"></i></a>
                            </div>
                            <div class="btn-group">
                                <a class="btn btn-default btn-sm" data-edit="insertunorderedlist" title="Bullet list">
                                    <i class="fa fa-list-ul"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="Number list">
                                    <i class="fa fa-list-ol"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="outdent" title="Reduce indent (Shift+Tab)">
                                    <i class="fa fa-dedent"></i></a>
                                <a class="btn btn-default btn-sm" data-edit="indent" title="Indent (Tab)">
                                    <i class="fa fa-indent"></i></a>
                            </div>
                            <div class="btn-group">
                                <a class="btn btn-default btn-sm" data-edit="justifyleft"
                                   title="Align Left (Ctrl/Cmd+L)">
                                    <i class="fa fa-align-left"></i>
                                </a>
                                <a class="btn btn-default btn-sm" data-edit="justifycenter"
                                   title="Center (Ctrl/Cmd+E)"><i
                                        class="fa fa-align-center"></i>
                                </a>
                                <a class="btn btn-default btn-sm" data-edit="justifyright"
                                   title="Align Right (Ctrl/Cmd+R)"><i
                                        class="fa fa-align-right"></i>
                                </a>
                                <a class="btn btn-default btn-sm" data-edit="justifyfull"
                                   title="Justify (Ctrl/Cmd+J)"><i class="fa fa-align-justify"></i>
                                </a>
                            </div>
                            <%--<div class="btn-group">--%>
                            <%--<a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="Hyperlink">--%>
                            <%--<i class="fa fa-link"></i>--%>
                            <%--</a>--%>
                            <%--<div class="dropdown-menu">--%>
                            <%--<div class="input-group m-l-xs m-r-xs">--%>
                            <%--<input class="form-control input-sm" placeholder="URL" type="text" data-edit="createLink"/>--%>
                            <%--<div class="input-group-btn">--%>
                            <%--<button class="btn btn-default btn-sm" type="button">--%>
                            <%--Add--%>
                            <%--</button>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <%--<a class="btn btn-default btn-sm" data-edit="unlink"--%>
                            <%--title="Remove Hyperlink"><i class="fa fa-cut"></i></a></div>--%>
                            <div class="btn-group"><a class="btn btn-default btn-sm"
                                                      data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
                                    class="fa fa-undo"></i></a> <a class="btn btn-default btn-sm"
                                                                   data-edit="redo"
                                                                   title="Redo (Ctrl/Cmd+Y)"><i
                                    class="fa fa-repeat"></i></a></div>

                            <%--<div class="btn-group ">
                                <a ng-click="viewAsDoc()" style="margin:0px 0px;" class="btn btn-sm btn-info">Xem online</a>
                                <a ng-click="downloadWord()"style="margin:0px 2px;" class="btn btn-sm btn-info">Xuất file word</a>
                                <div class="btn-group" style="margin-top:0px;">
                                    <button class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown"><i class="fa fa-plus"></i>đương sự-tài sản<span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        <li><a data-toggle="modal"  ng-click="initPrivyInput()" data-target="#addPrivysDialog" ><i class="fa fa-plus"></i>Đương sự</a></li>
                                        <li><a data-toggle="modal"  ng-click="initPropertyInput()" data-target="#addPropertyDialog"><i class="fa fa-plus"></i>Tài sản</a></li>
                                    </ul>
                                </div>
                            </div>--%>

                            <br><br>
                            <div class="form-group">
                                <div id="textboxofp"></div>
                            </div>

                        </div>
                        <!-- <div id="editor" class="form-control" style="font-size:14px;width: 595px;height:842px;overflow:scroll;line-height: 2.5px;font-family: 'Times New Roman';"> -->

                        <div class="contractContent" id="editor" style="margin:auto;width:800px;">
                            <div id="divcontract" class="divcontract" class=" pull-right "
                                 style="margin:auto!important;align-content:center;width:745px;padding:20px 54px;background: #fff;height:800px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                                <div dynamic="contract.kindhtml" id="contentKindHtml"></div>

                            </div>
                        </div>
                    </div>

                    <textarea hidden="true" name="contentText" id="contentText"></textarea>

                    <div id="sourcecontract" contenteditable="true"
                         style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>
                </div>
            </div>

        </div>
        <div ng-show="!contract.kindhtml.length>0">
            <div class="panel panel-default">
                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                    <h4 class=" panel-title">Thông tin bên liên quan</h4>
                </header>
                <c:if test="${contract.json_person.length()>0}">
                <div class="panel-body">
                    <section class="panel panel-default" ng-repeat="(itemIndex,item) in privys.privy track by $index">
                        <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                            <label class="control-label  label-bam-trai" style="color:#2a2aff">
                                Bên <label ng-model="item.action" editspan="item.action" class="inputcontract"
                                           contenteditable="true"
                                           style="font-size: 15px !important;">{{item.action}}</label> (sau đây gọi là
                                {{item.name}}):
                            </label>
                        </header>
                        <div class="panel-body">
                            <section class="panel panel-default" ng-repeat="item1 in item.persons track by $index">
                                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                                    <label class=" control-label  label-bam-trai" style="color:#2a2aff">Cá nhân/tổ chức
                                        {{$index+1}}</label>
                                </header>
                                <div class="panel-body" ng-switch on="item1.template==2"
                                     ng-if="item1.template==1 || item1.template==2">
                                    <div ng-switch-when=true>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label label-bam-trai">Tên công ty</label>
                                            <div class="col-sm-9">
                                                <input maxlength="200" type="text" class="form-control" ng-model="item1.org_name"
                                                       disabled/>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label label-bam-trai">Mã số thuế</label>
                                            <div class="col-sm-9">
                                                <input maxlength="100" type="text" class="form-control" ng-model="item1.org_code"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label  label-bam-trai">Đăng kí lần đầu
                                                ngày</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control"
                                                       ng-model="item1.first_registed_date" disabled="true"
                                                       maxlength="10" minlength="10" onkeypress="return restrictCharacters(this, event, forDate);"/>
                                            </div>

                                            <label class="col-sm-3 control-label ">Đăng kí thay đổi lần thứ</label>
                                            <div class="col-sm-3">
                                                <input maxlength="50" type="text" class="form-control"
                                                       ng-model="item1.number_change_registed" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label  label-bam-trai">Ngày đăng kí thay
                                                đổi</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control"
                                                       ng-model="item1.change_registed_date" disabled="true"
                                                       onkeypress="return restrictCharacters(this, event, forDate)"/>
                                            </div>

                                            <label class="col-sm-3 control-label ">Theo</label>
                                            <div class="col-sm-3">
                                                <input maxlength="100" type="text" class="form-control"
                                                       ng-model="item1.department_issue" disabled="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label label-bam-trai">Địa chỉ công ty</label>
                                            <div class="col-sm-9">
                                                <input maxlength="255" type="text" class="form-control" ng-model="item1.org_address"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label label-bam-trai">Họ tên người đại
                                                diện</label>
                                            <div class="col-sm-9">
                                                <input maxlength="200" type="text" class="form-control" ng-model="item1.name" disabled/>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label label-bam-trai">Chức vụ</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" ng-model="item1.position"
                                                       disabled/>
                                            </div>

                                        </div>
                                    </div>
                                    <div ng-switch-default>
                                        <div class="form-group">
                                                <%--<label class="col-sm-3 control-label label-bam-trai">Họ tên</label>--%>
                                            <select class="col-sm-1 control-label  label-bam-trai"
                                                    ng-options="option.name for option in dataSelectedSex.availableOptions track by option.id"
                                                    ng-model="item1.sex">
                                            </select>
                                            <div class="col-sm-2"></div>
                                            <div class="col-sm-9">
                                                <input maxlength="200" type="text" class="form-control"
                                                       ng-model="item1.name" disabled/>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label label-bam-trai">Ngày sinh</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" ng-model="item1.birthday"
                                                   id="birthday{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)" disabled/>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label label-bam-trai">CMND/Hộ chiếu/CCCD</label>
                                        <div class="col-sm-9 ">
                                            <input maxlength="50" type="text" class="form-control"
                                                   ng-model="item1.passport" disabled/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label  label-bam-trai">Ngày cấp</label>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" ng-model="item1.certification_date"
                                                   id="certification{{itemIndex}}-{{$index}}"
                                                   onkeypress="return restrictCharacters(this, event, forDate);" disabled="true"/>
                                        </div>

                                        <label class="col-sm-3 control-label ">Nơi cấp</label>
                                        <div class="col-sm-3">
                                            <input maxlength="100" type="text" class="form-control"
                                                   ng-model="item1.certification_place" disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label label-bam-trai">Địa chỉ</label>
                                        <div class="col-sm-9">
                                            <input maxlength="200" type="text" class="form-control" ng-model="item1.address"
                                                   disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label label-bam-trai">Mô tả</label>
                                        <div class="col-sm-9 ">
                                            <input maxlength="500" type="text" class="form-control"
                                                   ng-model="item1.description" disabled="true"/>
                                        </div>
                                    </div>

                                </div>

                                <div class="panel-body" ng-if="item1.template==3">
                                    <div id='parent_1'>
                                        <div class="form-group">
                                            <div class="col-md-3">
                                                <label class="col-sm-12 control-label label-bam-trai">Tìm kiếm</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input maxlength="200" type="text" class="form-control org_name"
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
                                                <label class="col-sm-12 control-label label-bam-trai">Mã số doanh
                                                    nghiệp</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input maxlength="100" type="text" class="form-control org_code"
                                                       ng-model="item1.org_code"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-3">
                                                <label class="col-sm-12 control-label label-bam-trai">Địa chỉ trụ sở
                                                    chính</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input maxlength="255" type="text" class="form-control org_address"
                                                       ng-model="item1.org_address"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-3">
                                                <label class="col-sm-12 control-label label-bam-trai">Đơn vị trực tiếp
                                                    quản lý khách hàng</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input maxlength="255" type="text"
                                                       class="form-control customer_management_unit"
                                                       ng-model="item1.customer_management_unit"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-3">
                                                <label class="col-sm-12 control-label label-bam-trai">Địa chỉ</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input maxlength="255" type="text" class="form-control org_address"
                                                       ng-model="item1.address"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-6">
                                                <label class="col-md-6 control-label  label-bam-trai">Điện thoại</label>
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
                                                <label class="col-sm-12 control-label label-bam-trai">Giấy chứng nhận
                                                    đăng ký hoạt động Chi nhánh/Phòng giao dịch</label>
                                            </div>
                                            <div class="col-sm-9" style="padding-right: 30px;">
                                                <input type="text" class="form-control registration_certificate"
                                                       ng-model="item1.registration_certificate"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-6">
                                                <label class="col-md-6 control-label  label-bam-trai">Họ tên người đại
                                                    diện</label>
                                                <div class="col-md-6">
                                                    <input maxlength="200" type="text" class="form-control phone"
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
                    <section class="panel panel-default" ng-repeat="item in listProperty.properties track by $index">
                        <header class="panel-heading font-bold">
                            <label class=" control-label  label-bam-trai" style="color:#2a2aff">Tài sản
                                {{$index+1}}</label>

                        </header>
                        <div class="panel-body">
                            <div class="form-group" style="padding-right: 20px;padding-left: 20px">
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

                            </div>

                            <div ng-show="!showDetails">
                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin tài sản</label>
                                    <div class="col-sm-9 input-group">
                                        <textarea maxlength="1000" class="form-control" rows="5" name="propertyInfo"
                                                  ng-model="item.property_info" disabled="true"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div ng-show="showDetails">
                                <div ng-show="item.type=='01'">
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Địa chỉ</label>
                                        <div class="col-sm-9 input-group">
                                            <input maxlength="200" type="text" class="form-control"
                                                   ng-model="item.land.land_address" disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Số giấy chứng nhận</label>
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
                                            <input type="text" class="form-control" ng-model="item.land.land_issue_date"
                                                   id="landDate{{$index}}" disabled="true"/>
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
                                        <label class="col-sm-3 control-label label-bam-trai">Diện tích xây dựng</label>
                                        <div class="col-sm-9 input-group">
                                            <input type="text" class="form-control"
                                                   ng-model="item.land.construction_area" disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Diện tích sàn </label>
                                        <div class="col-sm-9 input-group">
                                            <input type="text" class="form-control" ng-model="item.land.building_area"
                                                   disabled="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                        <label class="col-sm-3 control-label label-bam-trai">Hình thức sở hữu</label>
                                        <div class="col-sm-9 input-group">
                                            <input type="text" class="form-control" ng-model="item.land.land_use_type"
                                                   disabled="true"/>
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
                                            <input type="text" class="form-control" ng-model="item.land.land_use_period"
                                                   disabled="true"/>
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
                                        <label class="col-sm-3 control-label label-bam-trai">Thông tin tài sản</label>
                                        <div class="col-sm-9 input-group">
                                            <textarea maxlength="1000" type="text" class="form-control" rows="5"
                                                      ng-model="item.property_info" disabled="true"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                                    <label class="col-sm-3 control-label label-bam-trai">Thông tin chủ sở hữu</label>
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
                            </div>

                        </div>
                    </section>
                </div>
            </div>--%>

            <jsp:include page="/WEB-INF/pages/contract/offline/formPropertyDisable.jsp"/>
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
                                        <textarea rows="3" ng-model="contract.addition_description" class="form-control"
                                                  placeholder=""></textarea>
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
                                        <textarea rows="3" ng-model="contract.error_description" class="form-control"
                                                  placeholder=""></textarea>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Tên ngân hàng</label>
                                    <div class="col-lg-8">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.bank_code"
                                                ng-options="bank.code as bank.name for bank in banks">
                                        </select>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Cán bộ tín dụng</label>
                                    <div class="col-lg-8">
                                        <input maxlength="200" type="text" class="form-control" ng-model="contract.crediter_name"
                                               placeholder=""/>
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
                                        <input type="text" class="form-control" ng-model="contract.number_of_sheet"
                                               placeholder=""
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Số trang HĐ</label>
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control" ng-model="contract.number_of_page"
                                               placeholder=""
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
                                        <input type="text" class="form-control" ng-model="contract.original_store_place"
                                               placeholder=""
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
                                    <label class="col-lg-4 control-label label-bam-trai">Phí <%=congchung%>
                                    </label>
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control" ng-model="contract.cost_tt91"
                                               ng-change="calculateTotal()" format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                    <%--<a ng-click="suggestNotaryFee()" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>--%>
                                </div>
                                <%--<div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Phí <%=congchung%></label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control" ng-model="contract.cost_tt91" ng-change="calculateTotal()"  format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                    <a ng-click="suggestNotaryFee()" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>
                                </div>--%>
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
                                               ng-change="calculateTotal()" format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Dịch vụ <%=congchung%>
                                        ngoài</label>
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control" ng-model="contract.cost_notary_outsite"
                                               ng-change="calculateTotal()" format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Dịch vụ xác minh khác</label>
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control" ng-model="contract.cost_other_determine"
                                               ng-change="calculateTotal()" format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4 control-label label-bam-trai">Tổng phí</label>
                                    <div class="col-lg-8">
                                        <input type="text" ng-model="contract.cost_total" class="form-control"
                                               placeholder="" format="number"
                                               onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
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
    <div class="panel-body">
        <div class="list-buttons" style="text-align: center;">
            <%
                if (ValidationPool.checkRoleDetail(request, "11", Constants.AUTHORITY_THEM)) {
            %>
            <a data-toggle="modal" data-target="#myModal" class="btn btn-s-md btn-success">Xác nhận</a>
            <%
                }
            %>
            <a href="<%=request.getContextPath()%>/contract/temporary/list" ng-show="checkOnline"
               class="btn btn-s-md btn-default">Về danh sách</a>
            <a href="<%=request.getContextPath()%>/contract/list" ng-show="!checkOnline"
               class="btn btn-s-md btn-default">Quay về danh sách</a>
        </div>
    </div>

</div>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Biên bản hủy hợp đồng</h4>
            </div>
            <div class="modal-body">
                <p>Bạn chắc chắn thêm biên bản này để hủy hợp đồng số '{{number_contract_old}}'? </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="cancelContract()">Đồng ý
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
<div class="modal fade" id="checkValidate" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Thiếu thông tin cần thiết!</h4>
            </div>
            <div class="modal-body">
                <p>Hãy điền đầy đủ thông tin vào các trường bắt buộc(có dấu <span class="truong-text-colorred">*</span>)
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
                <p>Ngày thụ lý không thể sau ngày <%=congchung%>. Ngày <%=congchung%> không thể sau ngày hiện tại. </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="errorAdd" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Lỗi!</h4>
            </div>
            <div class="modal-body">
                <p>Có lỗi xảy ra.Bạn hãy thử lại sau. </p>
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


<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/demo.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $("#editor").bind('click', function (e) {
        if (e.target.className == "simple" || e.target.className.split(" ")[0] == "inputcontract") {
            $("#editor").removeAttr("contenteditable");
            $(e.target).attr("contenteditable", "true");
            $(e.target).focus();
        } else {
            $(this).attr("contenteditable", "true");
            $(e.target).focus();
        }

    });

    $(document).ready(function () {
        //load menu
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#ds-hd-cong-chung").addClass("child-menu");

    });


</script>