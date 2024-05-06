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

<spring:url value="/system/osp/contracttemplate-add-custum" var="conTractTemPlatePostCustumAddJS"/>
<spring:url value="/system/osp/contracttemplate-update-custum" var="conTractTemPlatePostCustumUpdateJS"/>
<script type="text/javascript">
    var url = '<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp = '<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var contextPath = '<%=request.getContextPath()%>';

    var userEntryId =<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
    var org_type =<%=SystemProperties.getProperty("org_type")%>;
    var conTractTemPlatePostCustumAddJS = '${conTractTemPlatePostCustumAddJS}';
    var conTractTemPlatePostCustumUpdateJS = '${conTractTemPlatePostCustumUpdateJS}';
    var typeHD = '${Constants.CERTIFICATE_TYPE_CONTRACT}';
</script>
<%
    String checkcongchung = SystemProperties.getProperty("org_type");
    String congchung = checkcongchung.equals("1") ? "chứng thực" : "công chứng";
    String congchungH = checkcongchung.equals("1") ? "Chứng thực" : "Công chứng";
    String hopDong = checkcongchung.equals("1") ? "chứng thực" : "hợp đồng";
%>

<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/curency.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/autocomplete/style.css"/>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/static/js/autocomplete/jquery.autocomplete.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/temporary/addFromFile.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/tree/tree.css" type="text/css"/>
<script src="<%=request.getContextPath()%>/static/js/tree/tree.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/FileSaver.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/exportWord/jquery.wordexport.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css"/>
<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath()%>/static/js/contract/print/jQuery.print.js"></script>


<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Thêm mới hợp đồng online</span>
</div>
<div class="truong-form-chinhbtt" ng-app="osp" id="temporaryAddFromFileController"
     ng-controller="temporaryAddFromFileController">

    <div class="panel-group" id="accordion">

        <div class="form-horizontal" action="${addUrl}" method="post">
            <form name="myForm" class="panel panel-default" id="panel1">
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

                    <div id="alertNhanDienKey" class="error_tooltip"></div>
                    <div class="panel-body">
                        <div class="list-buttons col-md-12" style="text-align: center;padding: 0px;">
                            <input type="file" class="btn btn-s-md btn-info col-md-4 pull-left"
                                   file-model="myFileImport" style="max-height: 34px;">
                            <input type=button class="btn btn-s-md btn-info pull-left" ng-click="importFileWord()"
                                   value="Upload" style="margin-left: 5px;">
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="col-md-3 control-label  label-bam-trai required">Nhóm hợp đồng</label>
                                <div class="col-md-6" style="padding-left: 7px !important;">
                                    <select id="contractKindValue_valid" ng-model="contractKindValue"
                                            name="contractKind" class="selectpicker select2 col-md-12 no-padding"
                                            ng-change="myFunc(contractKindValue)" required
                                            ng-options="item.contract_kind_code as item.name for item in contractKinds">
                                    </select>
                                    <span class="truong-text-colorred"
                                          ng-show="myForm.contractKind.$touched && myForm.contractKind.$invalid">Nhóm hợp đồng không thể bỏ trống.</span>
                                    <span class="truong-text-colorred">{{contractKindValue_valid}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="col-md-3 control-label  label-bam-trai required">Tên hợp đồng</label>
                                <div class="col-md-6" style="padding-left: 7px !important;">
                                    <select id="contract_template_id_valid" ng-model="contract.contract_template_id"
                                            name="template" class="selectpicker select2 col-md-12 no-padding"
                                            ng-change="changeTemplate(contract.contract_template_id)" required
                                            ng-options="item.code_template as item.name for item in contractTemplates">
                                        <%--<option value="">--Chọn--</option>
                                        <option  ng-repeat="item in contractTemplates" value="{{item.code_template}}">{{item.name}}</option>--%>
                                    </select>
                                    <span class="truong-text-colorred">{{contract_template_id_valid}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div ng-show="contractTemplatesApiece != '' && contractTemplatesApiece != null">
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="col-md-3 control-label  label-bam-trai">Tên mẫu hợp đồng</label>
                                    <div class="col-md-6" style="padding-left: 7px !important;">
                                        <select ng-model="contract.sub_template_id" name="template"
                                                class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changeTemplate_Apiece_Select(contract.sub_template_id)">
                                            <option value="">--Chọn--</option>
                                            <option ng-repeat="item in contractTemplatesApiece"
                                                    value="{{item.code_template}}">{{item.name}}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai">Số <%=hopDong%></label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="contract_number"
                                           ng-model="contract.contract_number" required>
                                    <%--<span class="truong-text-colorred"  ng-show="myForm.contract_number.$touched && myForm.contract_number.$invalid">Trường không được bỏ trống.</span>--%>
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
                                        <option value="">--Chọn sổ <%=congchung%>--</option>
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
                                <label class="col-md-6 control-label  label-bam-trai ">Ngày thụ lý</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="received_date"
                                           ng-model="contract.received_date" id="fromDate" minlength="10" maxlength="10"
                                           onkeypress="return restrictCharacters(this, event, forDate);"/>
                                    <%--<span class="truong-text-colorred"  ng-show="myForm.received_date.$touched && myForm.received_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="col-md-6 control-label ">Ngày <%=congchung%>
                                </label>
                                <div class="col-md-6 ">
                                    <input type="text" class="form-control" name="notary_date"
                                           ng-model="contract.notary_date" id="toDate"
                                           ng-change="changeDateNotary(contract.notary_date)" minlength="10"
                                           maxlength="10"
                                           onkeypress="return restrictCharacters(this, event, forDate);"/>
                                    <%--<span class="truong-text-colorred"  ng-show="myForm.notary_date.$touched && myForm.notary_date.$invalid">Trường không được bỏ trống và theo định dạng dd/MM/yyyy.</span>--%>
                                </div>
                            </div>

                        </div>

                    </div>

                    <c:if test="${SystemProperties.getProperty('org_type')==0}"> <%--neu la to chuc cong chung--%>
                        <div class="row truong-inline-field">
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label  label-bam-trai">Chuyên viên soạn thảo</label>
                                    <div class="col-md-6">
                                        <select name="drafter_id" ng-model="contract.drafter_id"
                                                class="selectpicker select2 col-md-12 no-padding" required>
                                            <option value="">--Chọn chuyên viên--</option>
                                            <option ng-repeat="item in drafters" value="{{item.userId}}">
                                                {{item.family_name}} {{item.first_name}}
                                            </option>
                                        </select>
                                        <span class="truong-text-colorred">{{drafter_id_valid}}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="col-md-6 control-label ">Công chứng viên</label>
                                    <div class="col-md-6">

                                        <select name="notary_id" ng-model="contract.notary_id"
                                                class="selectpicker select2 col-md-12 no-padding"
                                                ng-change="changeNotary(contract.notary_id)" required
                                                ng-options="item.userId as item.family_name+ ' '+item.first_name for item in notarys">
                                                <%-- <option value="">--Chọn công chứng viên--</option>
                                                 <option  ng-repeat="item in notarys" value="{{item.userId}}">{{item.family_name}} {{item.first_name}}</option>--%>
                                        </select>
                                        <span class="truong-text-colorred">{{notary_id_valid}}</span>
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
                            <div class="col-md-9" style="padding-right: 30px;">
                                <textarea class="form-control" name="contract.summary"
                                          ng-model="contract.summary"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row truong-inline-field">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label class="col-md-6 control-label  label-bam-trai required">Giá trị hợp đồng</label>
                                <div class="col-md-6">
                                    <input id="contract_value_" type="text" class="form-control"
                                           name="contract.contract_value" ng-model="contract.contract_value"
                                           format="number"
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
                                <label class="col-sm-3 control-label label-bam-trai">Địa điểm <%=congchung%>
                                </label>
                                <div class="col-md-9" style="padding-left: 7px !important;">
                                    <input maxlength="200" type="text" class="form-control" name="contract.notary_place"
                                           ng-model="contract.notary_place">
                                </div>
                            </div>

                            <div class="col-md-12" style="padding-right: 30px;!important;">
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
                            </div>

                        </div>
                    </div>


                </div>
            </form>

            <%--</div>--%>

            <%--<div class="panel panel-default">--%>
            <%--<header class="panel-heading font-bold" style="margin-bottom: 20px;">--%>
            <%--<h4 class="panel-title">Nội dung hợp đồng</h4>--%>

            <%--<div class="btn-group  pull-right" style="margin-top:-25px;">--%>
            <%--<button class="btn btn-primary btn-md dropdown-toggle " data-toggle="dropdown"><i class="fa fa-plus"></i>Thêm đương sự/tài sản<span class="caret"></span></button>--%>
            <%--<ul class="dropdown-menu">--%>
            <%--<li><a data-toggle="modal"  data-target="#addPrivysDialog" ><i class="fa fa-plus"></i>Đương sự</a></li>--%>
            <%--<li><a data-toggle="modal"  data-target="#addPropertyDialog"><i class="fa fa-plus"></i>Tài sản</a></li>--%>
            <%--</ul>--%>
            <%--</div>--%>

            <%--</header>--%>

            <div class="panel-body">
                <div id="copyContract"></div>

                <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                     data-target="#editor" style="margin:auto;width:800px;">
                    <div style="margin:auto;text-align: center;width:770px;">

                        <div class="btn-group"><a class="btn btn-default btn-sm" data-edit="bold"
                                                  title="Bold (Ctrl/Cmd+B)">
                            <i class="fa fa-bold"></i></a>
                            <a class="btn btn-default btn-sm" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i
                                    class="fa fa-italic"></i></a>
                            <a class="btn btn-default btn-sm" data-edit="strikethrough" title="Strikethrough"> <i
                                    class="fa fa-strikethrough"></i></a>
                            <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)"> <i
                                    class="fa fa-underline"></i></a>
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
                            <a class="btn btn-default btn-sm" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)">
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

                        <div class="btn-group ">
                            <a ng-click="viewAsDoc()" style="margin:0px 0px;" class="btn btn-sm btn-info">Xem online</a>
                            <a ng-click="downloadWord()" style="margin:0px 2px;" class="btn btn-sm btn-info">Xuất file
                                word</a>
                            <div class="btn-group" style="margin-top:0px;">
                                <button class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown"><i
                                        class="fa fa-plus"></i>bên liên quan-tài sản<span class="caret"></span></button>
                                <ul class="dropdown-menu">
                                    <%-- <li><a data-toggle="modal"  ng-click="initPrivyInput()" data-target="#addPrivysDialog" ><i class="fa fa-plus"></i>Đương sự</a></li>
                                     <li><a data-toggle="modal"  ng-click="initPropertyInput()" data-target="#addPropertyDialog"><i class="fa fa-plus"></i>Tài sản</a></li>--%>

                                    <li><a data-toggle="modal" data-target="#addPrivysDialog"
                                           ng-click="onloadDateFormat();"><i class="fa fa-plus"></i>Bên liên quan</a></li>
                                    <li><a data-toggle="modal" data-target="#addPropertyDialog"><i
                                            class="fa fa-plus"></i>Tài sản</a></li>
                                </ul>
                            </div>
                        </div>

                        <br><br>
                        <div class="form-group">
                            <div id="textboxofp"></div>
                        </div>

                    </div>
                    <!-- <div id="editor" class="form-control" style="font-size:14px;width: 595px;height:842px;overflow:scroll;line-height: 2.5px;font-family: 'Times New Roman';"> -->
                    <span style="padding:20px 20px!important;" class="truong-text-colorred">{{HTML_valid}}</span>
                    <div id="editor" class="form-control"
                         style="margin:auto;font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">
                        <div dynamic="contract.kindhtml" id="contentKindHtml"></div>
                    </div>
                </div>

                <textarea hidden="true" name="contentText" id="contentText"></textarea>

                <div id="sourcecontract" contenteditable="true"
                     style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>
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
                                        <label class="col-lg-4 control-label label-bam-trai">Tên ngân hàng</label>
                                        <div class="col-lg-8">
                                            <select ng-model="contract.bank_code"
                                                    class="selectpicker select2 col-md-12 no-padding">
                                                <option value="">--Chọn--</option>
                                                <option ng-repeat="item in banks" value="{{item.code}}">{{item.name}}
                                                </option>
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
                                            <input type="text" class="form-control" ng-model="contract.bank_service_fee" placeholder="" format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
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
                                    <div class="form-group">
                                        <label class="col-lg-4 control-label label-bam-trai">File đính kèm</label>
                                        <div class="col-lg-8">
                                            <input type="file" file-model="myFile"/>
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
                                            <input type="text" class="form-control" ng-model="contract.cost_tt91" ng-change="calculateTotal();checkphi(contract.cost_tt91);"  format="number" onkeypress="return restrictCharacters(this, event, digitsOnly);" />
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
                                                   ng-change="calculateTotal()" format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4 control-label label-bam-trai">Dịch vụ <%=congchung%>
                                            ngoài</label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control"
                                                   ng-model="contract.cost_notary_outsite" ng-change="calculateTotal()"
                                                   format="number"
                                                   onkeypress="return restrictCharacters(this, event, digitsOnly);"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4 control-label label-bam-trai">Dịch vụ xác minh
                                            khác</label>
                                        <div class="col-lg-8">
                                            <input type="text" class="form-control"
                                                   ng-model="contract.cost_other_determine" ng-change="calculateTotal()"
                                                   format="number"
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


        <div class="panel-body" style="text-align: center;">
            <%
                if (ValidationPool.checkRoleDetail(request, "14", Constants.AUTHORITY_THEM)) {
            %>
            <c:if test="${SystemProperties.getProperty('org_type')==0}">
                <a data-toggle="modal" data-target="#addContract" ng-dissable="checkLoad"
                   class="btn btn-s-md btn-success">Chuyển
                    CCV ký</a>
            </c:if>
            <c:if test="${SystemProperties.getProperty('org_type')==1}">
                <a data-toggle="modal" data-target="#addContract" ng-dissable="checkLoad"
                   class="btn btn-s-md btn-success">Lưu</a>
            </c:if>

            <%
                }
            %>
            <a data-toggle="modal" data-target="#addContractStore" ng-dissable="checkLoad"
               class="btn btn-s-md btn-success">Lưu tạm</a>
            <%--<a  data-toggle="modal"  data-target="#updateContractTemplate" ng-dissable="checkLoad" class="btn btn-s-md btn-success">Lưu làm mẫu</a>--%>
            <a href="<%=request.getContextPath()%>/contract/temporary/list" class="btn btn-s-md btn-default">Hủy bỏ</a>

        </div>

    </div>

    <div class="modal fade" id="updateContractTemplate" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lưu mẫu</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn có muốn lưu hợp đồng này làm mẫu? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="addContractTemplate()">
                        Tạo mẫu Hợp đồng mới
                    </button>
                    <button type="button" class="btn btn-success" data-dismiss="modal"
                            ng-click="updateContractTemplate()">Cập nhật mẫu cũ
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updateContractTemplateSucces" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lưu mẫu</h4>
                </div>
                <div class="modal-body">
                    <p>Lưu mẫu hợp đồng thành công</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Đồng ý</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ErorUpdateContractTemplate" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Error</h4>
                </div>
                <div class="modal-body">
                    <p>Hợp đồng soạn bị lỗi ! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="errorLog" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lưu dạng chỉnh sửa</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chưa chọn <%=congchung%> viên, có muốn lưu hợp đồng dạng "Lưu tạm" không? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="addContract()">Đồng ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
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
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="addContractWrapper()">
                        Đồng ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="addContractStore" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Thêm hợp đồng ở trạng thái lưu tạm</h4>
                </div>
                <div class="modal-body">
                    <p>Xác nhận thêm hợp đồng lưu tạm? </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" ng-click="addContract()">Đồng ý
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>

        </div>
    </div>


    <jsp:include page="/WEB-INF/pages/contract/temporary/formPersonPropertyAddFromFile.jsp"/>


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

</div>

<%--<link   href="<%=request.getContextPath()%>/static/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">--%>
<%--<script src="<%=request.getContextPath()%>/static/bootstrap-select/bootstrap-select.min.js"></script>--%>

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
    $('body').on('click', function (e) {
        //did not click a popover toggle, or icon in popover toggle, or popover
        if ($(e.target).data('toggle') !== 'popover'
            && $(e.target).parents('[data-toggle="popover"]').length === 0
            && $(e.target).parents('.popover.in').length === 0) {
            $('[data-toggle="popover"]').popover('hide');
        }
    });
    $(function () {


        $('#fromDate').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        $('#toDate').datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
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
    });
    $(document).ready(function () {
        var parentItem = $("#quan-ly-hop-dong");
        $(parentItem).click();
        $("#soan-hd-online").addClass("child-menu");
    });
    $('#addPropertyDialog').on('shown.bs.modal', function () {
        // will only come inside after the modal is shown
        angular.element(document.getElementById('contractAddController')).scope().setDateProperty();
    });
    $('#addPrivysDialog').on('shown.bs.modal', function () {
        // will only come inside after the modal is shown
        angular.element(document.getElementById('contractAddController')).scope().setDatePrivy();
    });
    /*alert("truong 1");
    alert("truong"+$('#addPrivysDialog').hasClass('in'));
    if($('#addPrivysDialog').hasClass('in')) {
        alert("truong1");
        angular.element(document.getElementById('contractAddController')).scope().myfunction('setDateProperty');
    }*/

    /*$(function() {
        $("#viewHtmlAsWord").find('.print').on('click', function() {
            $.print("#viewHtmlAsWord");
        });
    });*/
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
