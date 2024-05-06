<%--
  Created by IntelliJ IDEA.
  User: TienManh
  Date: 6/4/2017
  Time: 10:01 AM
  To change this template use File | Settings | File Templates.
--%>
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
<script type="text/javascript">var id = '${contract.tcid}';
var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
var code = '${contract.bank_code}';
var template_id = '${contract.contract_template_id}';
var sub_template_id = '${contract.sub_template_id}';

var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
var contextPath = '<%=request.getContextPath()%>';
var org_type =<%=SystemProperties.getProperty("org_type")%>;
var userEntryId =<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
var typeHD = ${Constants.CERTIFICATE_TYPE_CONTRACT};
</script>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
    String soHopDong = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
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
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/temporary/edit.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Sửa thông tin hợp đồng
        <c:if test="${contract.type==0}">
            chờ ký
        </c:if>
        <c:if test="${contract.type==1}">
            đã ký
        </c:if>
        <c:if test="${contract.type==3}">
            lưu tạm
        </c:if>
        <c:if test="${contract.type==2}">
            trả về
        </c:if>
    </span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" ng-controller="temporaryDetailController">

    <div class="panel-group" id="accordion">
        <div class="form-horizontal" method="post">
            <form class="panel panel-default" name="myForm" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">Thông tin hợp đồng</h4>
                </div>
                <div class="panel-body">
                    <input type="hidden" ng-model="contract.update_user_id"
                           ng-init="contract.update_user_id='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>'">
                    <input type="hidden" ng-model="contract.update_user_name"
                           ng-init="contract.update_user_name='<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getName()%>'">
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Nhóm hợp đồng</label>
                                <div class="col-md-6">
                                    <%--<input type="text" class="form-control" name="contractKind"  ng-model="contractKind.name"  disabled="true" />--%>
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contractKind.contract_kind_code" name="contractKind"
                                            ng-change="myFunc(contractKind.contract_kind_code)" required
                                            ng-options="item.contract_kind_code as item.name for item in contractKinds">
                                    </select>
                                        <span class="truong-text-colorred">{{contract_kind_}}</span>
                                    <%--<span class="truong-text-colorred"
                                          ng-show="myForm.contractKind.$touched && myForm.contractKind.$invalid">Nhóm hợp đồng không thể bỏ trống.</span>--%>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Tên hợp đồng</label>
                                <div class="col-md-6">
                                    <%--<input type="text" class="form-control" name="template"  ng-model="contractTemplate.name"  disabled="true" />--%>
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.contract_template_id" name="template"
                                            ng-change="changeTemplate(contract.contract_template_id)" required
                                            ng-options="item.code_template as item.name for item in contractTemplates">
                                    </select>
                                        <span class="truong-text-colorred">{{contract_template_}}</span>
                                    <%--<span class="truong-text-colorred"
                                          ng-show="myForm.template.$touched && myForm.template.$invalid">Tên hợp đồng không thể bỏ trống.</span>--%>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div ng-show="contractTemplatesApiece != '' && contractTemplatesApiece != null">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Tên mẫu hợp đồng</label>
                                    <div class="col-md-6">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.sub_template_id" name="template"
                                                ng-change="changeTemplate_Apiece_Select(contract.sub_template_id)"
                                                ng-options="item.code_template as item.name for item in contractTemplatesApiece">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la tccc--%>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Số <%=hopDong%></label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="contract_number"
                                               ng-model="contract.contract_number" required/>
                                        <%--<span class="truong-text-colorred"  ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>--%>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--neu la phường xã--%>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai required">Số <%=hopDong%></label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="contract.contract_number"
                                               ng-model="contract.contract_number" required/>
                                        <span class="truong-text-colorred"
                                              ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>
                                        <span class="truong-text-colorred">{{contract_number_}}</span>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>--%>
                                    </div>

                                </div>

                            </c:if>
                            <a ng-click="getContractNumber()" class="btn btn-s-md btn-info"
                               style="height: 30px !important;">Lấy số</a>

                        </div>
                    </div>
                     <%--Sổ chứng thực--%>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--neu la phường xã--%>
                                    <label class="col-md-6 control-label  label-bam-trai required">Sổ <%=soHopDong%></label>
                                </c:if>
                                <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la tccc--%>
                                    <label class="col-md-6 control-label  label-bam-trai ">Sổ <%=soHopDong%></label>
                                </c:if>
                                <div class="col-md-6">
                                    <select class="selectpicker select2 col-md-12 no-padding"
                                            ng-model="contract.notary_book"
                                            ng-options="item.notary_book as item.notary_book for item in notaryBook">
                                    </select>
                                    <span class="truong-text-colorred">{{notary_book_valid}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la tccc--%>
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Ngày thụ lý</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="received_date"
                                               ng-model="contract.received_date" id="drafterDate" minlength="10"
                                               maxlength="10"
                                               onkeypress="return restrictCharacters(this, event, forDate);"/>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label ">Ngày <%=congchung%>
                                    </label>
                                    <div class="col-md-6 ">
                                        <input type="text" class="form-control" name="notary_date"
                                               ng-model="contract.notary_date" id="notaryDate"
                                               ng-change="changeDateNotary(contract.notary_date)" minlength="10"
                                               maxlength="10" onkeypress="return restrictCharacters(this, event, forDate);"
                                               ng-change="changeContractValue(contract.contract_value)"/>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.notary_date.$touched && myForm.notary_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--neu la phường xã--%>
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai required">Ngày thụ lý</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="received_date"
                                               ng-model="contract.received_date" id="drafterDate" minlength="10"
                                               maxlength="10"
                                               onkeypress="return restrictCharacters(this, event, forDate);"/>
                                        <span class="truong-text-colorred">{{received_date_}}</span>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
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
                                               ng-change="changeContractValue(contract.contract_value)"/>
                                        <span class="truong-text-colorred">{{notary_date_}}</span>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.notary_date.$touched && myForm.notary_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </div>

                    <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la to chuc cong chung--%>
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                    <div class="col-md-6">
                                            <%--<input type="text" class="form-control" name="drafter_id"   ng-model="drafter.family_name" required/>--%>
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.drafter_id"
                                                ng-options="item.userId as item.family_name +' ' + item.first_name for item in drafters">
                                        </select>
                                            <%--<span class="truong-text-colorred"  ng-show="myForm.drafter_id.$touched && myForm.drafter_id.$invalid">Trường không được bỏ trống.</span>--%>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label">Công chứng viên</label>
                                    <div class="col-md-6">
                                        <select class="selectpicker select2 col-md-12 no-padding"
                                                ng-model="contract.notary_id"
                                                ng-change="changeNotary(contract.notary_id)"
                                                ng-options="item.userId as item.family_name +' ' + item.first_name  for item in notarys">
                                        </select>
                                            <%--<input type="text" class="form-control" name="notary_id"  ng-model="notary.family_name" required />--%>
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
                                    <label class="col-md-6 control-label label-bam-trai">Người tiếp nhận hồ sơ</label>
                                    <div class="col-md-6">
                                        <input maxlength="255" type="text" class="form-control" ng-model="contract.request_recipient">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label label-bam-phai required">Người
                                        ký <%=congchung%>
                                    </label>
                                    <div class="col-md-6">
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
                            <div class="col-md-3">
                                <label class="col-md-12 control-label  label-bam-trai">Tóm tắt nội dung</label>
                            </div>
                            <div class="col-md-9" style="padding-right:30px;">
                                <textarea maxlength="1000" class="form-control" name="contract.summary"
                                          ng-model="contract.summary"></textarea>
                            </div>
                        </div>

                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label label-bam-trai required">Giá trị hợp đồng</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contract.contract_value"
                                           ng-model="contract.contract_value" format="number"
                                           onkeypress="return restrictCharacters(this, event, digitsOnly);"
                                           ng-change="changeContractValue(contract.contract_value)"/>
                                    <span class="truong-text-colorred">{{contract_value_}}</span>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="col-md-3 control-label label-bam-trai">Địa điểm <%=congchung%>
                                </label>
                                <div class="col-md-9" style="padding-left: 7px !important;">
                                    <input maxlength="200" type="text" class="form-control" name="contract.notary_place"
                                           ng-model="contract.notary_place"/>
                                </div>
                            </div>

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


            <section class="panel panel-default">
                <header class="panel-heading font-bold" style="margin-bottom: 20px;">
                    <h4 class="panel-title ">Nội dung hợp đồng</h4>
                    <div ng-show="contract.type!='1'">

                        <div class="btn-group  pull-right" style="margin-top:-25px;">
                            <button class="btn btn-primary btn-md dropdown-toggle " data-toggle="dropdown"><i
                                    class="fa fa-plus"></i>Thêm bên liên quan/tài sản<span class="caret"></span></button>
                            <ul class="dropdown-menu">
                                <li><a data-toggle="modal" data-target="#addPrivysDialog"
                                       ng-click="onloadDateFormat();"><i class="fa fa-plus"></i>Bên liên quan</a></li>
                                <li><a data-toggle="modal" data-target="#addPropertyDialog"><i class="fa fa-plus"></i>Tài
                                    sản</a></li>
                            </ul>
                        </div>
                    </div>


                </header>
                <div class="panel-body" style="margin:auto;width:800px;">

                    <div id="copyContract"></div>

                    <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                         data-target="#editor" style="margin:auto;width:800px;">
                        <div style="margin:auto;text-align: center;">
                            <c:if test="${contract.type==2 || contract.type==3}">


                                <div class="btn-group"><a class="btn btn-default btn-sm" data-edit="bold"
                                                          title="Bold (Ctrl/Cmd+B)">
                                    <i class="fa fa-bold"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i
                                            class="fa fa-italic"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="strikethrough" title="Strikethrough">
                                        <i class="fa fa-strikethrough"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="underline"
                                       title="Underline (Ctrl/Cmd+U)"> <i class="fa fa-underline"></i></a>
                                </div>
                                <div class="btn-group">
                                    <a class="btn btn-default btn-sm" data-edit="insertunorderedlist"
                                       title="Bullet list">
                                        <i class="fa fa-list-ul"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="Number list">
                                        <i class="fa fa-list-ol"></i></a>
                                    <a class="btn btn-default btn-sm" data-edit="outdent"
                                       title="Reduce indent (Shift+Tab)">
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

                                <div class="btn-group"><a class="btn btn-default btn-sm"
                                                          data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
                                        class="fa fa-undo"></i></a> <a class="btn btn-default btn-sm"
                                                                       data-edit="redo"
                                                                       title="Redo (Ctrl/Cmd+Y)"><i
                                        class="fa fa-repeat"></i></a></div>

                                <div class="btn-group ">
                                    <a ng-click="viewAsDoc()" style="margin:0px 0px;" class="btn btn-sm btn-info">Xem
                                        online</a>
                                    <a ng-click="downloadWord()" style="margin:0px 2px;" class="btn btn-sm btn-info">Xuất
                                        file word</a>
                                    <div class="btn-group" style="margin-top:0px;">
                                        <button class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown">
                                            <i class="fa fa-plus"></i>bên liên quan-tài sản<span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a data-toggle="modal" ng-click="initPrivyInput()"
                                                   data-target="#addPrivysDialog"><i class="fa fa-plus"></i>Bên liên quan</a>
                                            </li>
                                            <li><a data-toggle="modal" ng-click="initPropertyInput()"
                                                   data-target="#addPropertyDialog"><i class="fa fa-plus"></i>Tài
                                                sản</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </c:if>
                            <br><br>
                            <div class="form-group">
                                <div id="textboxofp"></div>
                            </div>

                        </div>
                        <!-- <div id="editor" class="form-control" style="font-size:14px;width: 595px;height:842px;overflow:scroll;line-height: 2.5px;font-family: 'Times New Roman';"> -->
                        <div ng-show="contract.type!='1'">
                            <div class="contractContent" id="editor" style="float:left;">
                                <div id="divcontract" class="divcontract" class=" pull-right "
                                     style="margin:auto!important;align-content:center;width:745px;padding:20px 54px;background: #fff;height:800px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">
                                    <div dynamic="contract.kindhtml" id="contentKindHtml"></div>

                                </div>
                            </div>
                        </div>
                        <%--<div ng-show="contract.type=='1'">--%>
                            <%--<div class="contractContent" style="float:left;">--%>
                                <%--<div id="divcontract" class="divcontract divcontract1" class=" pull-right "--%>
                                     <%--style="margin:auto!important;align-content:center;width:745px;padding:20px 54px;background: #fff;height:800px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;">--%>
                                    <%--<div dynamic="contract.kindhtml" id="contentKindHtml"></div>--%>

                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </div>
                    <%-- doan sau--%>

                    <%--<div class="contractContent" style="float:left;">
                        <div id="divcontract"  class="divcontract" class=" pull-right " style="margin:auto!important;align-content:center;width:745px;padding:20px 54px;background: #fff;height:800px;overflow: auto; float:left;font-size: 14pt;line-height:1.5;font-family: times new roman;" >
                            <div dynamic="contract.kindhtml" id="contentKindHtml"></div>

                        </div>
                    </div>--%>

                </div>
            </section>


            <section class="panel panel-default">
                <header class="panel-heading font-bold">
                    <h4 class="control-label required label-bam-trai">Thông tin khác</h4>
                </header>
                <div class="panel-body">

                    <div class="col-sm-6">


                        <section class="panel panel-default">
                            <header class="panel-heading font-bold">Ngân hàng</header>
                            <div class="panel-body">
                                <form class="bs-example form-horizontal">

                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Tên ngân hàng</label>
                                        <div class="col-md-8">
                                            <select class="selectpicker select2 col-md-12 no-padding"
                                                    ng-model="contract.bank_code"
                                                    ng-options="bank.code as bank.name for bank in banks">
                                            </select>
                                            <%--<div ng-switch on="contract.bank_code.length>0">--%>
                                            <%--<div ng-switch-when="true">--%>

                                            <%--</div>--%>
                                            <%--<div ng-switch-default>--%>
                                            <%--<select ng-model="contract.bank_code" class="selectpicker select2 col-md-12 no-padding">--%>
                                            <%--<option  value="" >--Chọn--</option>--%>
                                            <%--<option  ng-repeat="bank in banks" value="{{bank.code}}" >{{bank.name}}</option>--%>
                                            <%--</select>--%>
                                            <%--</div>--%>
                                            <%--</div>--%>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Cán bộ tín dụng</label>
                                        <div class="col-md-8">
                                            <input maxlength="200" type="text" class="form-control" ng-model="contract.crediter_name"
                                                   placeholder=""/>
                                        </div>
                                    </div>
                                    <%--<div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Chiết khấu</label>
                                        <div class="col-md-8">
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
                                        <label class="col-md-4 control-label label-bam-trai">Số tờ HĐ</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" ng-model="contract.number_of_sheet"
                                                   placeholder=""
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Số trang HĐ</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" ng-model="contract.number_of_page"
                                                   placeholder=""
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Số bản <%=congchung%>
                                        </label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control"
                                                   ng-model="contract.number_copy_of_contract" placeholder=""
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4 control-label label-bam-trai">File đính kèm</label>
                                        <div class="col-lg-8" ng-switch on="contract.file_name.length>0">
                                            <div ng-switch-when="true">
                                                <a class="underline"
                                                   ng-click="downloadFile()">{{contract.file_name}}</a>
                                                <a style="margin-left:10px;" class="btn btn-danger btn-xs"
                                                   data-toggle="modal" data-target="#removeFile">Gỡ bỏ</a>
                                            </div>
                                            <div ng-switch-default>
                                                <input type="file" file-model="myFile.file"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Lưu trữ bản gốc</label>
                                        <div class="col-md-8">
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
                                    <%--<div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Phí <%=congchung%>
                                        </label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" ng-model="contract.cost_tt91"
                                                   ng-change="calculateTotal()" format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>--%>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Phí <%=congchung%></label>
                                        <div class="col-md-4">
                                            <input type="text" class="form-control" ng-model="contract.cost_tt91"
                                                   ng-change="calculateTotal()"  format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"  />
                                        </div>

                                        <c:if test="${SystemProperties.getProperty('org_type')==0}">
                                            <a ng-click="suggestNotaryFee()" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>
                                        </c:if>
                                        <c:if test="${SystemProperties.getProperty('org_type')==1}">
                                            <a ng-click="suggestCertFee(${Constants.FEE_CERT_HDGD})" class="btn btn-s-md btn-info" style="height: 30px !important;">Lấy gợi ý</a>
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
                                        <label class="col-md-4 control-label label-bam-trai">Thù lao <%=congchung%>
                                        </label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" ng-model="contract.cost_draft"
                                                   ng-change="calculateTotal()" format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Dịch vụ <%=congchung%>
                                            ngoài</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control"
                                                   ng-model="contract.cost_notary_outsite" ng-change="calculateTotal()"
                                                   format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Dịch vụ xác minh
                                            khác</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control"
                                                   ng-model="contract.cost_other_determine" ng-change="calculateTotal()"
                                                   format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Tổng phí</label>
                                        <div class="col-md-8">
                                            <input type="text" ng-model="contract.cost_total" class="form-control"
                                                   placeholder="" format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label label-bam-trai">Ghi chú</label>
                                        <div class="col-md-8">
                                            <textarea rows="4" ng-model="contract.note" class="form-control"
                                                      placeholder=""></textarea>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </section>
                    </div>

                </div>
            </section>

            <div class="panel-body" style="margin-bottom:30px; text-align:center;">
                <div class="list-buttons" style="text-align: center;">
                    <%
                        if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_SUA)) {
                    %>
                    <c:if test="${SystemProperties.getProperty('org_type')==1}">
                        <a ng-dissable="checkLoad" data-toggle="modal" data-target="#addContract"
                           class="btn btn-s-md btn-success">Đăng tải hợp đồng</a>
                    </c:if>
                    <c:if test="${SystemProperties.getProperty('org_type')==0}">
                        <a ng-dissable="checkLoad" data-toggle="modal" data-target="#CCVKyContract"
                           class="btn btn-s-md btn-success">Chuyển CCV ký</a>
                    </c:if>
                    <a ng-dissable="checkLoad" data-toggle="modal" data-target="#editContract"
                       class="btn btn-s-md btn-success">Lưu</a>
                    <%
                        }
                        if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_THEM)) {
                    %>
                    <a href="<%=request.getContextPath()%>/contract/temporary/addCoppy/{{contract.tcid}}"
                       class="btn btn-s-md btn-info">Sao chép HĐ</a>
                    <%
                        }
                        if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_XOA)) {
                    %>
                    <a ng-dissable="checkLoad" data-toggle="modal" data-target="#deleteContract"
                       class="btn btn-s-md btn-danger">Xóa</a>
                    <%
                        }
                    %>
                    <a ng-click="viewAsDoc()" class="btn btn-s-md btn-primary">Xem online</a>
                    <a ng-click="downloadWord()" class="btn btn-s-md btn-primary">Xuất file word</a>
                    <a href="<%=request.getContextPath()%>/contract/temporary/list" class="btn btn-s-md btn-default">Quay
                        lại sanh sách</a>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="deleteContract" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa Hợp đồng</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn xóa hợp đồng này ? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="deleteContract()">Xóa
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="removeFile" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa File đính kèm</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn xóa file này ? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="removeFile()">Xóa
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="CCVKyContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Chuyển CCV ký</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận chuyển CCV Ký? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="ccvKyTemporary()">Đồng
                        ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
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
                    <h4 class="modal-title">Thêm hợp đồng</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận thêm hợp đồng? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="ccvKyTemporary()">
                        Đồng ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
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
                    <h4 class="modal-title">Sửa thông tin</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận lưu thông tin thay đổi ? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="editTemporary()">Đồng
                        ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
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

    <jsp:include page="/WEB-INF/pages/contract/temporary/formPersonPropertyEdit.jsp"/>
   <%-- <div class="modal fade" id="addPrivysDialog" role="dialog" ng-init="$scope.onloadDateFormat()">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width:900px;">
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
                                <span class="spanText"><i class="icon-folder-open"></i> {{item.name}}</span>
                                <a class="btn btn-sm btn-primary " ng-click="addPerson($index)"><i
                                        class="fa fa-plus"></i>Thêm đương sự</a>
                                <a class="btn btn-sm btn-danger " ng-click="removePrivy($index)"><i
                                        class="fa fa-trash-o"></i>Xóa</a>
                                <label ng-switch on="item.type" class="checkbox m-n i-checks pull-right">
                                    <label ng-switch-when="0" class="checkbox m-n i-checks pull-right"><input
                                            style="width:20px;margin-top:0px;" checked type="checkbox"
                                            ng-click="checkRemoveActionPrivy($event,$index)"><i></i>Bỏ hiển thị tên bên
                                        liên quan</label>
                                    <label ng-switch-default class="checkbox m-n i-checks pull-right"><input
                                            style="width:20px;margin-top:0px;" type="checkbox"
                                            ng-click="checkRemoveActionPrivy($event,$index)"><i></i>Bỏ hiển thị tên bên
                                        liên quan</label>
                                </label>

                                <ul>
                                    <li ng-repeat="user in item.persons track by $index">
                                        <div class="treeChild">
                                            <div class="col-md-2" ng-click="showPerson(itemIndex,$index)">
                                                <a class="btn btn-success btn-sm"><i class="icon-folder-open"></i>
                                                    <span ng-switch on="user.template">
                                                    <span ng-switch-when="1">
                                                        <span ng-switch on="user.name.length>0"><i
                                                                class="icon-minus-sign"></i>
                                                            <span ng-switch-when=true>
                                                                {{user.name}}
                                                            </span>
                                                            <span ng-switch-default>
                                                                {{$index+1}}
                                                            </span>
                                                        </span>
                                                    </span>
                                                    <span ng-switch-when="2">
                                                        <span ng-switch on="user.org_name.length>0"><i
                                                                class="icon-minus-sign"></i>
                                                            <span ng-switch-when=true>
                                                                {{user.org_name}}
                                                            </span>
                                                            <span ng-switch-default>
                                                                {{$index+1}}
                                                            </span>
                                                        </span>
                                                    </span>
                                                        <span ng-switch-when="3">
                                                        <span ng-switch on="user.org_name.length>0"><i
                                                                class="icon-minus-sign"></i>
                                                            <span ng-switch-when=true>
                                                                {{user.org_name}}
                                                            </span>
                                                            <span ng-switch-default>
                                                                {{$index+1}}
                                                            </span>
                                                        </span>
                                                    </span>
                                                    <span ng-switch-default>
                                                        {{$index+1}}
                                                    </span>


                                                </span>
                                                </a>
                                            </div>

                                            <div class="col-md-7 ">

                                                <select ng-model="user.template" class="form-control"
                                                        ng-change="changTemplatePrivy(itemIndex,$index,user.template)">
                                                    <option value="">---Chọn mẫu hiển thị---</option>
                                                    <option ng-repeat="temp in templatePrivys" value="{{temp.id}}">
                                                        {{temp.name}}
                                                    </option>
                                                </select>
                                            </div>

                                            <div class="col-md-3">
                                                &lt;%&ndash;<a id="button-duongsu{{$index}}" class="btn btn-sm btn-info" data-toggle="popover" data-html="true" data-placement="bottom" data-content="<div class='scrollable' style='height:40px'>Hãy chọn loại mẫu hiển thị.</div>" title="" data-original-title='<button type="button" class="close pull-right" data-dismiss="popover">&times;</button>Chi tiết mẫu'>Xem mẫu</a>&ndash;%&gt;
                                                <a class="btn btn-sm btn-danger "
                                                   ng-click="removePerson(itemIndex,$index)"><i
                                                        class="fa fa-trash-o"></i>Xóa</a>
                                            </div>

                                            <div class="col-md-2">
                                            </div>
                                            <div class="col-md-12 panel-body ">

                                                <div ng-show="user.template==1 && user.myPerson"
                                                     class="bs-example form-horizontal ng-pristine ng-valid">
                                                    <h3><b>THÔNG TIN CÁ NHÂN</b></h3>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                            kiếm</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="50" type="text" class="form-control name"
                                                                   ng-model="user.passport"
                                                                   placeholder="Nhập CMND/Hộ chiếu để tìm kiếm"
                                                                   id="name{{itemIndex}}-{{$index}}"
                                                                   ng-keypress="getsuggest(itemIndex,$index,user.template);"
                                                                   ng-paste="getsuggest(itemIndex,$index,user.template);"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        &lt;%&ndash;<label class="col-md-2 control-label  label-bam-trai">Họ và tên</label>&ndash;%&gt;
                                                        <select class="col-md-2 control-label  label-bam-trai"
                                                                ng-options="option.name for option in dataSelectedSex.availableOptions track by option.id"
                                                                ng-model="user.sex">
                                                        </select>
                                                        <div class="col-md-4">
                                                            <input maxlength="200" type="text" ng-model="user.name"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Ngày
                                                            sinh</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="user.birthday"
                                                                   class="form-control"
                                                                   id="userBirthday{{itemIndex}}-{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Giấy
                                                            CMND/Hộ chiếu/CCCD
                                                            số</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text" ng-model="user.passport"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Cấp
                                                            ngày</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="user.certification_date"
                                                                   class="form-control"
                                                                   id="userCertificationDate{{itemIndex}}-{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Nơi
                                                            cấp</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text"
                                                                   ng-model="user.certification_place"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Nơi cư
                                                            trú </label>
                                                        <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.address"
                                                                  class="form-control"
                                                                  rows="2"></textarea>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div ng-show="user.template==2 && user.myPerson"
                                                     class="bs-example form-horizontal ng-pristine ng-valid">
                                                    &lt;%&ndash; <h3><b>THÔNG TIN CÔNG TY</b></h3>&ndash;%&gt;


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                            kiếm</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" class="form-control name"
                                                                   ng-model="user.org_code"
                                                                   placeholder="Nhập mã số thuế để tìm kiếm"
                                                                   id="org_name{{itemIndex}}-{{$index}}"
                                                                   ng-keypress="getsuggest(itemIndex,$index,user.template);"
                                                                   ng-paste="getsuggest(itemIndex,$index,user.template);"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Công
                                                            ty </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="200" type="text" ng-model="user.org_name"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Mã số
                                                            doanh nghiệp</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text" ng-model="user.org_code"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa
                                                            chỉ </label>
                                                        <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.org_address"
                                                                  class="form-control"
                                                                  rows="2"></textarea>

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Đăng kí
                                                            lần đầu ngày</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="user.first_registed_date"
                                                                   class="form-control"
                                                                   id="userFirstRegistedDate{{itemIndex}}-{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Đăng kí
                                                            thay đổi lần thứ </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="user.number_change_registed"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Ngày đăng
                                                            kí thay đổi </label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="user.change_registed_date"
                                                                   class="form-control"
                                                                   id="userChangeRegistedDate{{itemIndex}}-{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Theo </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text"
                                                                   ng-model="user.department_issue"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Họ và tên
                                                            người đại diện </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="200" type="text" ng-model="user.name"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Chức
                                                            danh</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text" ng-model="user.position"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Giấy
                                                            CMND/Hộ chiếu/CCCD
                                                            số </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text" ng-model="user.passport"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Ngày
                                                            cấp</label>
                                                        <div class="col-md-4">
                                                            <input type="text" ng-model="user.certification_date"
                                                                   class="form-control"
                                                                   id="userCertificationDateComp{{itemIndex}}-{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Nơi
                                                            cấp </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="100" type="text"
                                                                   ng-model="user.certification_place"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa
                                                            chỉ </label>
                                                        <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.address"
                                                                  class="form-control"
                                                                  rows="2"></textarea>

                                                        </div>
                                                    </div>

                                                </div>

                                                <div ng-show="user.template==3 && user.myPerson"
                                                     class="bs-example form-horizontal ng-pristine ng-valid">
                                                    &lt;%&ndash; <h3><b>THÔNG TIN TỔ CHỨC TÍN DỤNG</b></h3>&ndash;%&gt;


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tìm
                                                            kiếm</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" class="form-control name"
                                                                   ng-model="user.org_code"
                                                                   placeholder="Nhập mã số doanh nghiệp để tìm kiếm"
                                                                   id="credit_code{{itemIndex}}-{{$index}}"
                                                                   ng-keypress="getsuggest(itemIndex,$index,user.template);"
                                                                   ng-paste="getsuggest(itemIndex,$index,user.template);"/>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tên ngân
                                                            hàng </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" ng-model="user.org_name"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Mã số
                                                            doanh nghiệp </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="user.org_code"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa chỉ
                                                            trụ sở chính </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255" type="text"
                                                                   ng-model="user.org_address"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Đơn vị
                                                            trực tiếp quản lý khách hàng </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255" type="text"
                                                                   ng-model="user.customer_management_unit"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa
                                                            chỉ </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255" type="text" ng-model="user.address"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Điện
                                                            thoại </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="user.phone"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Fax</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="user.fax"
                                                                   class="form-control">
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                                            nhận đăng ký hoạt động Chi nhánh/Phòng giao dịch </label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="user.registration_certificate"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Họ tên
                                                            người đại diện </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="200" type="text" ng-model="user.name"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Chức
                                                            vụ</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="255" type="text" ng-model="user.position"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Văn bản ủy
                                                            quyền </label>
                                                        <div class="col-md-10">
                                                            <input type="text" ng-model="user.authorization_document"
                                                                   class="form-control">

                                                        </div>
                                                    </div>

                                                </div>

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
                                            <div class="col-md-2" ng-click="showProperty($index)">
                                                <a class="btn btn-success btn-sm"><i class="icon-folder-open"></i> Tài
                                                    sản {{$index+1}}: </a>
                                            </div>

                                            <div class="col-md-7 " style="margin-bottom:10px;">
                                                <select name="type" ng-model="item.type" class="form-control"
                                                        ng-change="changeTypeProperty($index,item.type)">
                                                    <option value="">--Chọn--</option>
                                                    <option value="01">Nhà đất</option>
                                                    <option value="02">Ôtô-xe máy</option>
                                                    <option value="99">Tài sản khác</option>
                                                </select>
                                            </div>
                                            <div class="col-md-7 col-md-offset-2">
                                                <select ng-model="item.template" class="form-control"
                                                        ng-change="changTemplateProperty($index,item.template)">
                                                    <option value="">---Chọn mẫu hiển thị---</option>
                                                    <option ng-repeat="item in getList($index)" value="{{item.id}}">
                                                        {{item.name}}
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                &lt;%&ndash;<a id="button-taisan{{$index}}" class="btn btn-sm btn-info" data-toggle="popover" data-html="true" data-placement="bottom" data-content="<div class='scrollable' style='height:40px'>Hãy chọn loại mẫu tài sản hiển thị.</div>" title="" data-original-title='<button type="button" class="close pull-right" data-dismiss="popover">&times;</button>Chi tiết mẫu tài sản'>Xem mẫu</a>&ndash;%&gt;
                                                <a class="btn btn-sm  btn-danger deleteTree"
                                                   ng-click="removeProperty($index)"><i class="fa fa-trash-o"></i>Xóa
                                                </a>
                                            </div>

                                            <div class="col-md-12 panel-body "
                                                 ng-show="item.type=='01' && item.template=='8' && item.myProperty">

                                                <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                    &lt;%&ndash;<h3><b>THÔNG TIN CHUNG CƯ</b></h3>&ndash;%&gt;
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
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.apartment.apartment_number"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-trai">Tầng </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.apartment.apartment_floor"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tổng diện
                                                            tích sử dụng</label>
                                                        <div class="col-md-4">
                                                            <input type="text"
                                                                   ng-model="item.apartment.apartment_area_use"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Diện tích
                                                            xây dựng</label>
                                                        <div class="col-md-4">
                                                            <input type="text"
                                                                   ng-model="item.apartment.apartment_area_build"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Kết cấu
                                                            nhà </label>
                                                        <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.apartment.apartment_structure"
                                                                  class="form-control"
                                                                  rows="2"></textarea>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Số tầng
                                                            nhà chung cư</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.apartment.apartment_total_floor"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                            số</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.land.land_number"
                                                                   class="form-control">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa chỉ
                                                            thửa đất </label>
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            bằng chữ </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                            riêng</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                            chung</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Mục đích
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thời hạn
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input  maxlength="200" type="text" ng-model="item.land.land_use_origin"
                                                                   class="form-control">
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                            quyền sử dụng đất</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" ng-model="item.restrict"
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
                                                                   class="form-control" id="landIssueDate2{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                            số</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.land.land_number"
                                                                   class="form-control">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa chỉ
                                                            thửa đất </label>
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            bằng chữ </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                            riêng</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                            chung</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Mục đích
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thời hạn
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input  maxlength="200" type="text" ng-model="item.land.land_use_origin"
                                                                   class="form-control">
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                            quyền sử dụng đất</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" ng-model="item.restrict"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            &lt;%&ndash; chú thích bắt đầu thông tin đất , nhà ở gắn liền với đất &ndash;%&gt;
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
                                                                   class="form-control" id="landIssueDate3{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                                            số</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.land.land_number"
                                                                   class="form-control">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Địa chỉ
                                                            thửa đất </label>
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            bằng chữ </label>
                                                        <div class="col-md-4">
                                                            <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                                            riêng</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                                                   class="form-control">
                                                        </div>
                                                        <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                                            chung</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Mục đích
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thời hạn
                                                            sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input  maxlength="200" type="text" ng-model="item.land.land_use_origin"
                                                                   class="form-control">
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                                            quyền sử dụng đất</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" ng-model="item.restrict"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Tài sản
                                                            gắn liền với đất </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text"
                                                                   ng-model="item.land.land_associate_property"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            chủ sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text"
                                                                   ng-model="item.owner_info" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            khác</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="1000" type="text"
                                                                   ng-model="item.other_info" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Loại nhà
                                                            ở</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255" type="text" ng-model="item.land.land_type"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            xây dựng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="200" type="text" ng-model="item.land.construction_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                                            sàn</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255"  type="text" ng-model="item.land.building_area"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Hình thức
                                                            sử dụng</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255"  type="text" ng-model="item.land.land_use_type"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Cấp (hạng)
                                                            nhà ở</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="255"  type="text" ng-model="item.land.land_sort"
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
                                                                   ng-paste="getsuggestproperty($index,item.type);"/>
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Số giấy
                                                            đăng ký </label>
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
                                                                   class="form-control" id="carIssueDate{{$index}}"
                                                                   onkeypress="return restrictCharacters(this, event, forDate)">
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
                                                        <label class="col-md-2 control-label  label-bam-phải">Số
                                                            máy</label>
                                                        <div class="col-md-4">
                                                            <input maxlength="50" type="text"
                                                                   ng-model="item.vehicle.car_machine_number"
                                                                   class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            chủ sở hữu</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text"
                                                                   ng-model="item.owner_info" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            khác</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="1000" type="text"
                                                                   ng-model="item.other_info" class="form-control">
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
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            tài sản </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="1000" type="text"
                                                                   ng-model="item.property_info" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                                            chủ sở hữu </label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text"
                                                                   ng-model="item.owner_info" class="form-control">
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
    </div>--%>

</div>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/bootstrap-wysiwyg.js"></script>
<script src="<%=request.getContextPath()%>/static/js/wysiwyg/demo.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/app.js"></script>
<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script>

    if (${contract.type!=1}) {
        $("#editor").on('click', function (e) {

            if (e.target.className == "simple" || e.target.className.split(" ")[0] == "inputcontract") {
                $("#editor").removeAttr("contenteditable");
                $(e.target).attr("contenteditable", "true");
                $(e.target).focus();
            } else {
                $(this).attr("contenteditable", "true");
                $(e.target).focus();
            }

        });
    }


    $(".divcontract1").bind('click', function (e) {

        if (${contract.type==1}) {

            $(e.target).attr("contenteditable", "false");
            $(".divcontract1").removeAttr("contenteditable");
        }


    });


    $(function () {
//        $('#notaryDate').datepicker({
//            format: "dd/mm/yyyy",
//            language: 'vi'
//        }).on('changeDate', function (ev) {
//            $(this).datepicker('hide');
//        });
//        $('#drafterDate').datepicker({
//            format: "dd/mm/yyyy",
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
    });

    $(document).ready(function () {
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#ds-hd-online").addClass("child-menu");
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