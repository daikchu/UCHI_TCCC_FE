<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page import="com.vn.osp.common.util.ValidationPool" %>
<%@ page import="com.vn.osp.common.global.Constants" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />

<script type="text/javascript">
    var url='<%=SystemProperties.getProperty("url_config_server_api")%>';
    var contextPath='<%=request.getContextPath()%>';
</script>
<%--
    Thông tin chi tiết mẫu hợp đồng
--%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/editor.css" />
<script src="<%=request.getContextPath()%>/static/js/system/synContract.js" type="text/javascript"></script>

<spring:url value="/system/osp/contracttemplate-list" var="backUrl" />
<spring:url value="/system/osp/contracttemplate-edit-view/${contractTempList.contractTempDetail.id}" var="editUrl" />
<spring:url value="/template/contract/delete/${contractTempList.contractTempDetail.id}" var="deleteUrl" />
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Chi tiết thông tin mẫu hợp đồng</span>
</div>


<div class="truong-form-chinhbtt"  ng-app="osp" ng-controller="contractAddController">

    <div class="panel-group" id="accordion">
        <form class="form-horizontal" action="${updateUrl}" method="post">
            <input type="hidden" name="id" value="${contractTempList.contractTempDetail.sid}">

            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">

                        THÔNG TIN MẪU HỢP ĐỒNG

                    </h4>

                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Tên hợp đồng</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="name" value="${contractTempList.parent_name_contractTempDetail==null?contractTempList.contractTempDetail.name:contractTempList.parent_name_contractTempDetail}" disabled>
                            <div class="error_tooltip"></div>
                        </div>

                        <label class="col-md-2 control-label required label-bam-phai">Loại Hợp đồng</label>
                        <div class="col-md-5">
                            <select name="code" class="form-control truong-selectbox-padding" disabled>
                                <option value="">Tất cả</option>
                                <c:forEach items="${contractTempList.listContractKind}" var="item">
                                    <option value="${item.contract_kind_code}" ${contractTempList.contractTempDetail.code==item.contract_kind_code?"selected":""}>${item.name}</option>
                                </c:forEach>
                            </select>
                            <div class="error_tooltip"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Tên mẫu hợp đồng</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="name" value="${contractTempList.parent_name_contractTempDetail==null?"":contractTempList.contractTempDetail.name}" disabled>
                            <div class="error_tooltip"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên A</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control " name="relate_object_A_display" value="${contractTempList.contractTempDetail.relate_object_A_display}" disabled>
                        </div>

                        <label class="col-md-2 control-label label-bam-phai">Mô tả Bên B</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="relate_object_B_display" value="${contractTempList.contractTempDetail.relate_object_B_display}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả Bên C</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="relate_object_C_display" value="${contractTempList.contractTempDetail.relate_object_C_display}" disabled>
                        </div>

                        <label class="col-md-2 control-label label-bam-phai">Trạng thái </label>
                        <div class="col-md-5 control-label label-bam-trai">
                            <input class="truong-check-fix" type="radio" name="active_flg" value="1" ${contractTempList.contractTempDetail.active_flg==1?"checked":""} disabled> Đang hoạt động &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            <input class="truong-check-fix" type="radio" name="active_flg" value="0" ${contractTempList.contractTempDetail.active_flg==0?"checked":""} disabled> Ngừng hoạt động
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Mô tả</label>

                        <div class="col-md-10">
                            <textarea name="description" rows="4" class="form-control" value="${contractTempList.contractTempDetail.description}" disabled >${contractTempList.contractTempDetail.description}</textarea>
                            <div class="error_tooltip"></div>
                        </div>

                    </div>
                    <%--<div class="form-group">--%>
                    <%--<label class="col-md-2 control-label label-bam-trai">Số bên liên quan</label>--%>
                    <%--<div class="col-md-3">--%>
                    <%--<input type="text" class="form-control " name="relate_object_number" value="${contractTempList.contractTempDetail.relate_object_number} "disabled>--%>
                    <%--<div class="error_tooltip"></div>--%>
                    <%--</div>--%>
                    <%--</div>--%>

                    <div class="form-group">
                        <label class="col-md-2"></label>
                        <div class="col-md-6">
                            <input type="checkbox" class="truong-margin-left15" name="mortage_cancel_func" value="1" ${contractTempList.contractTempDetail.mortage_cancel_func==1?"checked":""} disabled><span class="truong-font-chu" style="vertical-align: 2px;">Giải chấp</span>
                            <input type="hidden" name="mortage_cancel_func" value="0" ${contractTempList.contractTempDetail.mortage_cancel_func==0?"checked":""} disabled>


                            <input type="checkbox" class="truong-margin-left15" name="period_flag" value="1"${contractTempList.contractTempDetail.period_flag==1?"checked":""} disabled><span class="truong-font-chu" style="vertical-align: 2px;" >Thời hạn hợp đồng</span>
                            <input type="hidden" name="period_flag" value="0" ${contractTempList.contractTempDetail.period_flag==0?"checked":""} disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">Nội dung mẫu hợp đồng</label>

                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor">
                                <div id="editor" contenteditable="false" class="form-control" style="font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">
                                </div>
                            </div>
                            <div id="sourcecontract" contenteditable="false" style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>

                        </div>

                        <textarea hidden  class="col-md-12"  id="giatriKindHtml"  name="kind_html"  rows="4" value="${contractTemp.kind_html}" ></textarea>
                    </div>


                </div>
            </div>

            <div class="truong-prevent-btb" style="padding-bottom: 10px;">

                <div class="col-md-12" style="text-align: center;">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_SUA)){
                    %>
                    <a href="${editUrl}" class="btn btn-info btn-default btn-primary">Sửa</a>
                    <%
                        }
                    %>
                    <%
                        if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_XOA)){
                    %>
                    <a data-target="#deleteContractTemp" data-toggle="modal" class="btn btn-info btn-default btn-danger">Xóa</a>
                    <%
                        }
                    %>
                    <a href="${backUrl}" class="btn btn-default btn-warning">Quay lại danh sách</a>

                </div>

            </div>
        </form>
    </div>


    <div class="modal fade" id="deleteContractTemp" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa thông tin.</h4>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc muốn xóa ! </p>
                </div>
                <div class="modal-footer">
                    <%
                        if(ValidationPool.checkRoleDetail(request,"29", Constants.AUTHORITY_SUA)){
                    %>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="checkAndDeleteContractTemplate(${contractTempList.contractTempDetail.id}, ${contractTempList.contractTempDetail.code_template})">Xóa</button>
                    <%--<a href="${deleteUrl}" class="btn btn-info btn-default" style="background-color: #5bdec0;">Xóa</a>--%>
                    <%
                        }
                    %>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="errorDelete" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Xóa mẫu hợp đồng không thành công!</h4>
                </div>
                <div class="modal-body">
                    <p>Mẫu hợp đồng này đang được sử dụng. Bạn không thể xóa! </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>



</div>


<%--<div class="modal fade" id="_deleteContract" role="dialog">
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
                <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="_deleteContract(contract.id)">Xóa</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
            </div>
        </div>
    </div>
</div>--%>





<!-- Modal -->

<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/xeditable.min.css" />--%>
<%--<script src="<%=request.getContextPath()%>/static/js/contract/xeditable.min.js" type="text/javascript"></script>--%>
<%--End Modal--%>
<script>
    $(window).on('resize',function(){
        var win = $(this);
        if(win.width() < 1300){
            $('.truong-rs-bt3os').removeClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3os').addClass('col-md-4');
            $('.truong-rs-bt3').removeClass('col-md-2');
            $('.truong-rs-bt3').addClass('col-md-4');
        }else {
            $('.truong-rs-bt3os').removeClass('col-md-4');
            $('.truong-rs-bt3os').addClass('col-md-2 col-md-offset-3');
            $('.truong-rs-bt3').removeClass('col-md-4');
            $('.truong-rs-bt3').addClass('col-md-2');

        }
    });
</script>

<script>

    $("#editor").bind('click',function(e) {
        $(e.target).attr("contenteditable", "false");
        $("#editor").removeAttr("contenteditable");
    });
    $(document).ready(function () {
        $("#editor").html('${contractTempList.contractTempDetail.kind_html}');
        $('.text-duongsu').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự<<</a>');
        $('.text-duongsu-ben-a').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên a<<</a>');
        $('.text-duongsu-ben-b').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên b<<</a>');
        $('.text-duongsu-ben-c').html('<a class="btn btn-success">>>Khu vực hiển thị đương sự bên c<<</a>');
        $('.text-taisan').html('<a class="btn btn-primary">>>Khu vực hiển thị tài sản<<</a>');
        //var html = $("#editor").html( $("#contentKindHtml").text());

    });
    $(function () {
        $('#birthday').datepicker({
            format: "dd/mm/yyyy",
            forceParse : false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    });
</script>

<script>


</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />
<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#mau-hop-dong").addClass("child-menu");
    });
</script>


