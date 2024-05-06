<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />
<script  type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var urlstp='<%=SystemProperties.getProperty("url_config_server_stp_api")%>';
    var urlosp='<%=SystemProperties.getProperty("OSP_API_LINK_PUBLIC")%>';
    var contextPath='<%=request.getContextPath()%>';

    var userEntryId=<%=((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser().getUserId()%>;
    var org_type=<%=SystemProperties.getProperty("org_type")%>;
    $("#uchi-status").show();
    setTimeout(function() { $("#uchi-status").hide(); }, 3000);
</script>
<%--
    Danh sách Mẫu hợp đồng
--%>
<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css" />--%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<spring:url value="/attestation/list" var="attestationTempListUrl"/>
<spring:url value="/attestation/add" var="addUrll"/>
<spring:url value="/attestation/attestationtemplate-update" var="updateUrll"/>
<spring:url value="/system/osp/contracttemplate-update-select" var="selectUpdateUrll"/>
<spring:url value="/system/osp/contracttemplate-view" var="viewUrl"/>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Danh sách mẫu lời chứng</span>
</div>
<div class="truong-form-chinhds panel-group"  ng-app="osp" ng-controller="contractController">
    <div id="uchi-status">
        <%--<c:if test="${attestationTempList.action_status == '1'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Thêm mới Mẫu lời chứng thành công!
            </div>
        </c:if>
        <c:if test="${attestationTempList.action_status == '2'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Cập nhật Mẫu lời chứng thành công!
            </div>
        </c:if>
        <c:if test="${attestationTempList.action_status == '3'}">
            <div class="status-success"><img class="status-img" src="<%=request.getContextPath()%>/static/image/success.png">
                Xóa Mẫu lời chứng thành công!
            </div>
        </c:if>
        <c:if test="${attestationTempList.action_status == '4'}">
            <div class="status-error"><img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png">
                Đã xảy ra lỗi. Xin vui lòng thử lại!
            </div>
        </c:if>--%>
    </div>
    <form class="form-horizontal" action="${attestationTempListUrl}" id="search-frm" method="get">
        <%--<input type="hidden" name="page" id="page" value="${attestationTempList.page}">
        <input type="hidden" name="totalPage" id="totalPage" value="${attestationTempList.totalPage}">
        <input type="hidden" name="model_open" id="model_open" value="${attestationTempList.model_open}">--%>

        <div class="col-md-12 truong-margin-footer0px">
            <%
                if(ValidationPool.checkRoleDetail(request,"12", Constants.AUTHORITY_THEM)){
            %>

            <div class="truong-button-dong-bo export-button" style="width: 220px !important;margin-left: 5px;">
                <a class="truong-small-linkbt"> <input data-toggle="modal" data-target="#selectUpdateDialog" type="button" class="form-control luu"  name="" value="Cập nhật từng mẫu lời chứng" ></a>
            </div>
            <div class="float-right-button-table"></div>
            <div class="truong-button-dong-bo export-button" style="width: 220px !important;margin-left: 5px;">
                <a class="truong-small-linkbt"> <input data-toggle="modal" data-target="#_updateAllContract" type="button" class="form-control luu"  name="" value="Cập nhật toàn bộ mẫu lời chứng" ></a>
            </div>
            <div class="truong-button-dong-bo export-button" style="width: 220px !important;margin-left: 5px;">
                <a class="truong-small-linkbt" href="${addUrll}"> <input type="button" class="form-control luu"  name="" value="Thêm mới mẫu lời chứng" ></a>
            </div>
            <%
                }
            %>
            <table class="hidden table" style="margin-bottom:0%;" >

                <tr class="border-table">
                    <th class=" ann-title border-table table-giua">Loại mẫu lời chứng</th>
                    <th class=" ann-title border-table table-giua">Trạng thái</th>

                </tr>
                <c:if test="${attestationTempList.size() > 0}">
                    <c:forEach items="${attestationTempList}" var="item">
                        <tr>
                            <td class="border-table truong-text-verticel"><a href="${viewUrl}/${item.id}">${item.name}</a></td>
                            <td class="border-table truong-rstable-widthper15" style="color: black;">
                                <c:if test="${item.active_flg==true}"><div class="truong-online-fix"><div class="truong-creat-circlegr" ></div>Đang hoạt động</div></c:if>
                                <c:if test="${item.active_flg==false}"><div class="truong-offline-fix"><div class="truong-creat-circlesv" ></div>Ngừng hoạt động</div></c:if>
                            </td>

                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${attestationTempList.size() == 0}">
                    <tr>
                        <td colspan="7" style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                            Chưa có dữ liệu
                        </td>
                    </tr>
                </c:if>

            </table>

            <%--.................custum.........................--%>
            <table class="table" style="margin-bottom:0%;" id="expandabledatatableCustum">
                <thead>
                    <tr class="border-table">
                        <th colspan="3" class=" ann-title border-table table-giua">Loại mẫu lời chứng</th>
                        <th class=" ann-title border-table table-giua">Trạng thái</th>
                    </tr>
                </thead>
                <tbody class="tbody-expandabledatatableCustum" id="tbody-expandabledatatableCustum">
                    <c:if test="${attestationTempList.size() > 0}">
                        <c:forEach items="${attestationTempList}" var="item" varStatus="loop">
                            <tr id="custum-tr-expandabledatatableCustum${item.id}">
                                <td colspan="2" class="border-table truong-text-verticel"><i id="on-off-expandabledatatableCustum${item.id}" class="fa fa-plus-square-o off-expandabledatatableCustum${item.id}"
                                                                                             ng-click="expandabledatatableCustum(${item.id},'on-off-expandabledatatableCustum','expandabledatatableCustum');"></i></td>
                                    <%--ng-click="expandabledatatableCustum(${item.id},'on-off-expandabledatatableCustum','expandabledatatableCustum');"--%>
                                <td class="border-table truong-text-verticel"><a href="${viewUrl}/${item.id}"><strong>${item.name}</strong></a></td>
                                <td class="border-table truong-rstable-widthper15" style="color: black;">
                                    <c:if test="${item.active_flg==true}"><div class="truong-online-fix"><div class="truong-creat-circlegr" ></div>Đang hoạt động</div></c:if>
                                    <c:if test="${item.active_flg==false}"><div class="truong-offline-fix"><div class="truong-creat-circlesv" ></div>Ngừng hoạt động</div></c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${attestationTempList.size() == 0}">
                        <tr>
                            <td colspan="7" style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                                Chưa có dữ liệu
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <%--.................end.........................--%>

        </div>

    </form>

    <%--/////////modal-3///////////--%>
    <div class="modal fade bd-example-modal-lg" id="_updateAllContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cập nhật tất cả mẫu lời chứng</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn cập nhật tất cả mẫu lời chứng ? </p>
                    <p style="color: red">Tất cả mẫu lời chứng sẽ được cập nhật từ sở tư pháp</p>
                </div>
                <div class="modal-footer">
                    <a class="truong-small-linkbt" href="${updateUrll}"> <input type="button"  class="btn btn-danger"   name="" value="Cập nhật" ></a>
                    <%--<a ><button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="_updateAllContract()">Cập nhật</button></a>--%>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>
    <%--/////////end-modal-3///////////--%>


    <%--////////modal-1////////////--%>
    <div class="modal fade bd-example-modal-lg" id="selectUpdateDialog" role="dialog" tabindex="-1" data-focus-on="input:first">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content" style="width:100%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" action="${selectUpdateUrll}" id="search-frm-select" method="post">
                        <input type="hidden" id="listIdSelect" name="listIdSelect" style="width: 100%">
                        <div class="tree well">
                            <table class="table" style="margin-bottom:0%" id="expandabledatatableCustumPopup">
                                <thead>
                                    <tr class="border-table">
                                        <%--<th class=" ann-title border-table table-giua"></th>--%>
                                        <th class=" ann-title border-table table-giua"><input type="checkbox" onchange="select_all(this);" select="false"></th>
                                        <th class=" ann-title border-table table-giua">Tên hợp đồng</th>
                                        <th class=" ann-title border-table table-giua">Tên loại hợp đồng</th>
                                        <th class=" ann-title border-table table-giua">Trạng thái hoạt động</th>
                                    </tr>
                                </thead>
                                <tbody class="tbody-expandabledatatableCustumPopup" id="tbody-expandabledatatableCustumPopup">
                                    <c:if test="${attestationTempList.total > 0}">
                                        <c:forEach items="${attestationTempList.attestationTempListByKindNames}" var="item" varStatus="loop">
                                            <tr id="custum-tr-expandabledatatableCustumPopup${item.id}">
                                                    <%--<td class="border-table truong-text-verticel"><i id="on-off-expandabledatatableCustumPopup${item.id}" class="fa fa-plus-square-o off-expandabledatatableCustumPopup${item.id}" ></i></td>--%>
                                                    <%--ng-click="expandabledatatableCustumPopup(${item.id},'on-off-expandabledatatableCustumPopup','expandabledatatableCustumPopup');"--%>
                                                <td class="border-table truong-text-verticel"><center><input type="checkbox" value="${item.id}" class="custum-list-id-select-update" select="false" onchange="addIdSelect(this,'${item.id}');"></center></td>
                                                <td class="border-table truong-text-verticel"><a id="${item.id}" class="custum-popup-event-html" data-toggle="modal" data-target="#selectNameDialog"><strong>${item.name}</strong></a></td>
                                                <td class="border-table truong-rstable-widthper30 truong-text-verticel" style="color: black;">${item.contractKindName}</td>
                                                <td class="border-table truong-rstable-widthper15" style="color: black;">
                                                    <c:if test="${item.active_flg==true}"><div class="truong-online-fix"><div class="truong-creat-circlegr" ></div>Đang hoạt động</div></c:if>
                                                    <c:if test="${item.active_flg==false}"><div class="truong-offline-fix"><div class="truong-creat-circlesv" ></div>Ngừng hoạt động</div></c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr class="table-tr-xam">
                                            <th colspan="7"><div class="truong-padding-foot-table"> Tổng số <span style="color:red">${attestationTempList.total}</span> dữ liệu</div>
                                                <div class="align-phai">
                                                    <c:if test="${attestationTempList.page==1}">
                                                        <img
                                                                class="truong-pagging-icon"
                                                                src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                                        <img
                                                                class="truong-pagging-icon"
                                                                src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                                    </c:if>
                                                    <c:if test="${attestationTempList.page!=1}">
                                                        <img onclick="firstPage('1')"
                                                             class="pagging-icon"
                                                             src="<%=request.getContextPath()%>/static/image/pagging/icon1.png">

                                                        <img onclick="previewPage('1')"
                                                             class="pagging-icon"
                                                             src="<%=request.getContextPath()%>/static/image/pagging/icon2.png">
                                                    </c:if>
                                                        ${attestationTempList.page}
                                                    trên ${attestationTempList.totalPage}
                                                    <c:if test="${attestationTempList.page == attestationTempList.totalPage}">
                                                        <img
                                                                class="truong-pagging-icon"
                                                                src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                                        <img
                                                                class="truong-pagging-icon"
                                                                src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                                    </c:if>
                                                    <c:if test="${attestationTempList.page != attestationTempList.totalPage}">
                                                        <img onclick="nextPage('1')"
                                                             class="pagging-icon"
                                                             src="<%=request.getContextPath()%>/static/image/pagging/icon8.png">
                                                        <img onclick="lastPage('1')"
                                                             class="pagging-icon"
                                                             src="<%=request.getContextPath()%>/static/image/pagging/icon7.png">
                                                    </c:if>
                                                </div>
                                            </th>
                                        </tr>
                                    </c:if>
                                    <c:if test="${attestationTempList.total == 0}">
                                        <tr>
                                            <td colspan="7"
                                                style="height: 100%;background-color: #ececec; line-height: 5.429;text-align: center;font-size: 265%">
                                                Chưa có dữ liệu
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <%--<button class="btn btn-primary" type="button" onclick="searchfrmselect();">--%>
                    <%--Cập nhật mẫu đã chọn--%>
                    <%--</button>--%>
                    <a class="truong-small-linkbt"> <input data-toggle="modal" data-target="#_updateSelectedContract" type="button" class="btn btn-primary"  name="" value="Cập nhật mẫu đã chọn"></a>
                    <%--<input type="button" data-target="#_updateSelectedContract" class="btn btn-primary" name="" value="Cập nhật mẫu đã chọn"></input>--%>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" >Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <%--/////////end-modal-1///////////--%>


    <%--/////////modal-5///////////--%>
    <div class="modal fade bd-example-modal-lg" id="_updateSelectedContract" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cập nhật các mẫu hợp đồng đã chọn</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn cập nhật các mẫu hợp đồng đã chọn ? </p>
                    <p style="color: red">Các mẫu hợp đồng đã chọn sẽ được cập nhật từ sở tư pháp</p>
                </div>
                <div class="modal-footer">
                    <input type="button"  class="btn btn-danger"   name="" value="Cập nhật" onclick="searchfrmselect();">
                    <%--<a ><button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="_updateAllContract()">Cập nhật</button></a>--%>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>
    <%--/////////end-modal-5///////////--%>

    <%--/////////modal-2///////////--%>
    <div class="modal fade bd-example-modal-lg" id="selectNameDialog" role="dialog" tabindex="-1" data-focus-on="input:first">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content" style="width:100%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="panel-title">
                        Nội dung hợp đồng
                    </h4>

                </div>
                <div class="modal-body">
                    <form class="row-fluid">

                        <div class="span6" style="float: left;width: 50%;">
                            <p><center>Nội dung hợp đồng từ sở tử pháp</center></p>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar" data-target="#editor1">
                                    <div id="editor1" contenteditable="false" class="form-control" style="font-size:14pt!important;height:auto;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="span6" style="float: left;width: 50%;">
                            <p><center>Nội dung hợp đồng đang sử dụng</center></p>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar" data-target="#editor2">
                                    <div id="editor2" contenteditable="false" class="form-control" style="font-size:14pt!important;height:auto;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer" style="clear: both;">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%--/////////end-modal-2///////////--%>

    <div class="modal fade" id="errorInput" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Thông báo</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn chưa chọn bản ghi nào! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>


</div>


<script>
    function firstPage(model_open) {
        $('#page').val(1);
        $('#model_open').val(model_open);
        $("#search-frm").submit();
    }
    function previewPage(model_open) {
        var page = $('#page').val();
        $('#page').val(parseInt(page) - 1);
        $('#model_open').val(model_open);
        $("#search-frm").submit();
    }
    function nextPage(model_open) {
        var page = $('#page').val();
        $('#page').val(parseInt(page) + 1);
        $('#model_open').val(model_open);
        $("#search-frm").submit();
    }
    function lastPage(model_open) {
        var totalPage = $('#totalPage').val();
        $('#page').val(totalPage);
        $('#model_open').val(model_open);
        $("#search-frm").submit();
    }
    function clearText(){
        $('#name1').val("");
        $('#code').select2('val',['']);
        $('#active').select2('val',['']);

    }
    function addIdSelect(element, id) {
        var listIdSelect = document.getElementById("listIdSelect").value;
        if(listIdSelect == null || listIdSelect == "") {
            if (element.checked == true) {
                document.getElementById("listIdSelect").value = id;
            }
        } else {
            if (element.checked == true) {
                listIdSelect += ";" + id;
                document.getElementById("listIdSelect").value = listIdSelect;
            } else {
                var idRemove = id;
                var list = listIdSelect.split(";");

                var indexRemove;
                for(var i=0; i <= list.length; i++){
                    if(list[i] == idRemove){
                        indexRemove = i;
                        break;
                    }
                }

                list.splice(indexRemove,1); //xóa 1 phần tử tại vị trí indexRemove
                listIdSelect = list.join(";");
                document.getElementById("listIdSelect").value = listIdSelect;
            }
        }
    }
    function removeIdSelect(id) {
        var listIdSelect = document.getElementById("listIdSelect").value;
        if(listIdSelect != null && listIdSelect != "") {
            var idRemove = id;
            var list = listIdSelect.split(";");

            var indexRemove;
            for(var i=0; i <= list.length; i++){
                if(list[i] == idRemove){
                    indexRemove = i;
                    break;
                }
            }
            list.splice(indexRemove,1); //xóa 1 phần tử tại vị trí indexRemove
            listIdSelect = list.join(";");
            document.getElementById("listIdSelect").value = listIdSelect;
        }
    }
    function searchfrmselect(){
        if(_checkValidate_() == false){
            $("#errorInput").modal();
            return false;
        }
        return $('#search-frm-select').submit();
    }
    function select_all(element){
        var listId = document.getElementById("listIdSelect").value;
        var lisId__ = "";
        var check = element.checked;
        if(check){
            $('#search-frm-select .custum-list-id-select-update').prop('checked', true);
            $('input.custum-list-id-select-update:checkbox:checked').each(function () {
                if(listId != null || listId != ""){
                    listId += ";" + $(this).val();
                } else {
                    lisId__ += ";" + $(this).val();
                }
            });
            document.getElementById("listIdSelect").value = ((listId==null || listId == '') ? lisId__:listId);
        } else {
            document.getElementById("listIdSelect").value = "";
            $('#search-frm-select .custum-list-id-select-update').prop('checked', false);
        }
    }
    function _checkValidate_(){
        var id = document.getElementById("listIdSelect").value;
        if(id == null || id == ""){
            return false;
        }
        return true;
    }

    $('body').on('hidden.bs.modal', function() {
        if ($('.modal.in').length) {
            $('body').addClass('modal-open');
        }
    });
</script>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#mau-hop-dong").addClass("child-menu");

        var model_open = $('#model_open').val();
        if(model_open == '1'){
            $("#selectUpdateDialog").modal();
            $('#model_open').val("0");
        }
    });
</script>

<script>
    var myApp = angular.module('osp', []);

    myApp.controller('contractController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', function ($scope, $http, $filter, $window, $timeout, $q) {

        $scope.expandabledatatableCustum = function (id, status_index, tableName) {
            var td = document.getElementById(status_index + id);
            var rowIndex = document.getElementById("custum-tr-"+tableName+id).rowIndex;

            var check = td.className.indexOf("on-"+tableName+id);

            $http.post(url + "/ContractTemplate/FindContractTempListByParentId", id)
                .then(function (response) {

                    var data = response.data;
                    var row = response.data.length;

                    if(check == -1){
                        td.classList.remove("off-"+tableName+id);
                        td.classList.add("on-"+tableName+id);
                        td.classList.remove("fa-plus-square-o");   //bỏ dấu +
                        td.classList.add("fa-minus-square-o");     //add dấu -

                        var html = '';
                        for(var i=0;i<row;i++){
                            var name = data[i].name;
                            var active_flg = data[i].active_flg;
                            var note_id = data[i].id;

                            html += '<tr class="on-'+tableName+note_id+'">';
                            html += '<td colspan="4" class="border-table truong-text-verticel" style="padding-left: 10%;"><a href="${viewUrl}/'+note_id+'">'+name+'</a></td>';
                            html += '<td class="border-table truong-rstable-widthper15" style="color: black;">';
                            if(active_flg){
                                html += '<div class="truong-online-fix"><div class="truong-creat-circlegr" ></div>Đang hoạt động</div>';
                            }else{
                                html += '<div class="truong-offline-fix"><div class="truong-creat-circlesv" ></div>Ngừng hoạt động</div>';
                            }
                            html += '</td>';
                            html += '</tr>';
                        }
                        $('#' + tableName + ' > tbody.tbody-'+tableName+'  > tr').eq(rowIndex-1).after(html);   //add chiled node
                    } else {
                        td.classList.remove("on-"+tableName+id);
                        td.classList.add("off-"+tableName+id);
                        td.classList.remove("fa-minus-square-o");   //bỏ dấu -
                        td.classList.add("fa-plus-square-o");     //add dấu +

                        for(var i=0;i<row;i++){
                            var note_id = data[i].id;
                            $('table tbody.tbody-'+tableName+' > tr.on-'+tableName+note_id).remove();    //remove chiled node
                        }
                    }
                });
        };

        $scope.expandabledatatableCustumPopup = function (id, status_index, tableName) {
            var td = document.getElementById(status_index + id);
            var rowIndex = document.getElementById("custum-tr-"+tableName+id).rowIndex;

            var check = td.className.indexOf("on-"+tableName+id);

            $http.post(url + "/ContractTemplate/FindContractTempListByParentId", id)
                .then(function (response) {
                    $timeout(function() {
                        var data = response.data;
                        var row = response.data.length;

                        if(check == -1) {
                            td.classList.remove("off-"+tableName+id);
                            td.classList.add("on-"+tableName+id);
                            td.classList.remove("fa-plus-square-o");   //bỏ dấu +
                            td.classList.add("fa-minus-square-o");     //add dấu -

                            var html = '';
                            for(var i=0;i<row;i++){
                                var name = data[i].name;
                                var active_flg = data[i].active_flg;
                                var note_id = data[i].id;

                                html += '<tr class="on-'+tableName+note_id+'">';
                                html += '<td></td>';
                                html += '<td class="border-table truong-text-verticel"><center><input type="checkbox" value="'+note_id+'" class="custum-list-id-select-update" select="false" onchange="addIdSelect(this,'+note_id+');"></center></td>';
                                html += '<td colspan="2" class="border-table truong-text-verticel" style="padding-left: 10%;"><a id="'+note_id+'" class="custum-popup-event-html" data-toggle="modal" data-target="#selectNameDialog">'+name+'</a></td>';
                                html += '<td class="border-table truong-rstable-widthper15" style="color: black;">';
                                if(active_flg){
                                    html += '<div class="truong-online-fix"><div class="truong-creat-circlegr" ></div>Đang hoạt động</div>';
                                }else{
                                    html += '<div class="truong-offline-fix"><div class="truong-creat-circlesv" ></div>Ngừng hoạt động</div>';
                                }
                                html += '</td>';
                                html += '</tr>';
                            }
                            $('#' + tableName + ' > tbody.tbody-'+tableName+'  > tr').eq(rowIndex-1).after(html);  //add chiled node

                        } else {

                            td.classList.remove("on-"+tableName+id);
                            td.classList.add("off-"+tableName+id);
                            td.classList.remove("fa-minus-square-o");   //bỏ dấu -
                            td.classList.add("fa-plus-square-o");     //add dấu +

                            for(var i=0;i<row;i++){
                                var note_id = data[i].id;
                                $('table tbody.tbody-'+tableName+' > tr.on-'+tableName+note_id).remove();    //remove chiled node
                                removeIdSelect(note_id);
                            }
                        }
                        $scope.html = $("#expandabledatatableCustumPopup").html();
                    }, 0);
                });
        };

        $(document).on('click', '.custum-popup-event-html', function () {
            var id = this.id;
            $http.post(urlosp + "/ContractTemplate/getContractTempOsp", id)
                .then(function (response) {
                    console.log("tgian", response.data);
                    $scope.contract_template_trung_gian = response.data;
                    if(response.data.length > 0) {
                        $("#editor1").html($scope.contract_template_trung_gian[0].kind_html);

                        $('.text-duongsu').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a>');
                        $('.text-duongsu-ben-a').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a>');
                        $('.text-duongsu-ben-b').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a>');
                        $('.text-taisan').html('<a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a>');
                    } else {
                        $("#editor1").html("");
                    }
                });

            $http.post(url + "/ContractTemplate/getContractTempVpcc/", id)
                .then(function (response) {
                    console.log("dangsd", response.data);
                    $scope.contract_template_dang_su_dung = response.data;
                    if(response.data.length > 0) {
                        $("#editor2").html($scope.contract_template_dang_su_dung[0].kind_html);

                        $('.text-duongsu').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a>');
                        $('.text-duongsu-ben-a').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a>');
                        $('.text-duongsu-ben-b').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a>');
                        $('.text-taisan').html('<a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a>');
                    } else {
                        $("#editor2").html("");
                    }
                });
        });

    }]);
</script>

