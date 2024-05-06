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

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/contract/uchi.css"/>
<script src="<%=request.getContextPath()%>/static/ckeditor/ckeditor.js"></script>

<spring:url value="/template/property/list" var="backUrl"/>
<spring:url value="/template/property/update" var="update"/>
<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Sửa thông tin mẫu tài sản</span>
</div>
<div class="truong-form-chinhbtt">
    <div id="uchi-status">
        <c:if test="${list_msg.msg != null}">
            <div class="status-error">
                <img class="status-img" src="<%=request.getContextPath()%>/static/image/error.png"> ${list_msg.msg}
            </div>
        </c:if>
    </div>
    <div class="panel-group" id="accordion">
        <form class="form-horizontal" action="${update}" id="formSubmit" method="post">
            <div class="panel panel-default" id="panel1">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse">
                            THÔNG TIN MẪU TÀI SẢN
                        </a>
                    </h4>
                </div>
                <div class="panel-body">
                    <input type="hidden" class="form-control " name="entry_user" value="${propertyTemplate.entry_user}">
                    <input type="hidden" class="form-control " name="type" value="${propertyTemplate.type}">
                    <input type="hidden" class="form-control " name="id" value="${propertyTemplate.id}">
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Tên mẫu</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control ${list_msg.msgName != null ?"error_input":""}"
                                   name="name" value="${propertyTemplate.name}">
                            <div class="error_tooltip">${list_msg.msgName}</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Loại tài sản</label>
                        <div class="col-md-10">
                            <select name="type" class="form-control truong-selectbox-padding">
                                <option value="">--Chọn--</option>
                                <option value="01" ${propertyTemplate.type.equals("01") ?"selected":""}>Nhà đất</option>
                                <option value="02" ${propertyTemplate.type.equals("02") ?"selected":""}>Xe cộ</option>
                                <option value="99" ${propertyTemplate.type.equals("99") ?"selected":""}>Tài sản khác
                                </option>
                            </select>
                            <div class="error_tooltip">${list_msg.msgType}</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Mô tả</label>
                        <div class="col-md-10">
                            <input type="text"
                                   class="form-control  ${list_msg.msgDescription != null ?"error_input":""}"
                                   name="description" value="${propertyTemplate.description}">
                            <div class="error_tooltip">${list_msg.msgDescription}</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label required label-bam-trai">Trạng thái</label>
                        <div class="col-md-10">
                            <label class="checkbox-inline"><input type="checkbox" name="disable"
                                                                  style="margin-top:0px" ${propertyTemplate.disable== true ?"checked":""} >Ngừng
                                hoạt động</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label label-bam-trai">HTML</label>
                        <div class="col-md-10">
                            <div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar"
                                 data-target="#editor">
                                <button type='button' id="cke_inputcontract" class="btn btn-success btn-sm "
                                        title="Thêm text để gán đối tượng"><i class="fa fa-plus"></i>Text Item
                                </button>
                                <%--<button type='button' id="viewsource" class="btn btn-success btn-sm"
                                        title="Xem code dạng HTML"><i class="fa fa-plus"></i>ViewSource
                                </button>--%>
                                <%--<button type='button' id="addTextBoxSimple"  class="btn btn-primary btn-sm " title="Thêm text trống không liên kết đối tượng" ><i class="fa fa-plus"></i>Add text</button>--%>
                                <br><br>
                                <%--<div class="btn-group">
                                    <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"
                                       title="Font Size"><i class="fa fa-text-height"></i>&nbsp;<b
                                            class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a data-edit="fontSize 5"><font size="5">18</font></a></li>
                                        <li><a data-edit="fontSize 4"><font size="4">14</font></a></li>
                                        <li><a data-edit="fontSize 3"><font size="3">12</font></a></li>
                                    </ul>
                                </div>
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
                                <br><br>--%>
                                <div class="form-group" style="margin-top: 10px;">
                                    <div id="textboxofp"></div>
                                </div>
                                <div id="editor" <%--contenteditable="true"--%> class="form-control"
                                     style="font-size:14pt!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;">

                                </div>
                            </div>
                            <div id="sourcecontract" contenteditable="true"
                                 style="display:none;font-size:14px!important;width: 742px!important;height:842px;overflow:scroll;font-family: 'Times New Roman';padding:20px 20px!important;"></div>
                        </div>
                        <textarea hidden class="col-md-12" id="giatriKindHtml" name="html" rows="4"
                                  value="${item.html}"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-group" style="text-align: center;margin:20px 0px;">
                <a class="btn btn-primary" style="min-width:130px;" id="submitform"
                   onclick="return BeforeSubmit();">Lưu</a>
                <a class="btn btn-default" style="min-width:130px;" href="${backUrl}">Quay lại danh sách</a>
            </div>
        </form>
    </div>


</div>
<script src="<%=request.getContextPath()%>/static/js/jquery.hotkeys.js"></script>
<script src="<%=request.getContextPath()%>/static/js/bootstrap-wysiwyg.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/wysiwyg/demo.js"></script>--%>
<%--<script src="<%=request.getContextPath()%>/static/js/app.js"></script>--%>

<script type="text/javascript">
    try {
        CKEDITOR.instances['editor'].destroy(true);
    } catch (e) { }
    var editor = CKEDITOR.replace('editor', {
        placeholder: 'some value',

        fullPage: true,
        // extraPlugins: 'docprops',
        // // Disable content filtering because if you use full page mode, you probably
        // // want to  freely enter any HTML content in source mode without any limitations.
        // allowedContent: true,
        width: '742px',
        height: '842px',
        resize_enabled: true
    });

</script>

<%--
<script>
    $(window).on('resize', function () {
        var win = $(this);
        if (win.width() < 1200) {
            $('.truong-rs-bt2os').removeClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2os').addClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2').removeClass('col-md-2');
            $('.truong-rs-bt2').addClass('col-md-3');
        } else {
            $('.truong-rs-bt2os').removeClass('col-md-3 col-md-offset-3');
            $('.truong-rs-bt2os').addClass('col-md-2 col-md-offset-4');
            $('.truong-rs-bt2').removeClass('col-md-3');
            $('.truong-rs-bt2').addClass('col-md-2');
        }
    });
</script>
--%>

<script>
    $(document).ready(function () {
        loadMenu();
        $("#editor").html('${propertyTemplate.html}');
    });

    function loadMenu() {
        $(".sidebar-nav > li > #mau-giao-dien").addClass("father-menu");
        $(".sidebar-nav > li > #duongsu").addClass("child-menu");
    }

    function BeforeSubmit(){
    var htmlEditor = CKEDITOR.instances['editor'].getData();
        $("#giatriKindHtml").html(htmlEditor);
    //$("#giatriKindHtml").html($("#editor").html());
        $("#formSubmit").submit();
    }

</script>

<script type="text/javascript">
    /*$("#viewsource").click(function () {
        var clss = $("#viewsource").attr("class");
        if (clss == 'btn btn-success btn-sm') {
            $("#editor").css("display", "none");
            $("#sourcecontract").css("display", "block");
            $("#sourcecontract").text($("#editor").html());
            $(this).addClass("active");
            $("#action_area").css("display", "none");
        }
        if (clss == 'btn btn-success btn-sm active') {
            $("#editor").css("display", "block");
            $("#sourcecontract").css("display", "none");
            $(this).removeClass("active");
            $("#action_area").css("display", "none");
            $("#editor").html($("#sourcecontract").text());
            $("#action_area").css("display", "block");
        }
    });*/


    function setEndOfContenteditable(contentEditableElement) {
        var range, selection;
        if (document.createRange) //Firefox, Chrome, Opera, Safari, IE 9+
        {
            range = document.createRange(); //Create a range (a range is a like the selection but invisible)
            range.selectNodeContents(contentEditableElement); //Select the entire contents of the element with the range
            range.collapse(false); //collapse the range to the end point. false means collapse to end rather than the start
            selection = window.getSelection(); //get the selection object (allows you to change selection)
            selection.removeAllRanges(); //remove any selections already made
            selection.addRange(range); //make the range you have just created the visible selection
        } else if (document.selection) //IE 8 and lower
        {
            range = document.body.createTextRange(); //Create a range (a range is a like the selection but invisible)
            range.moveToElementText(contentEditableElement); //Select the entire contents of the element with the range
            range.collapse(false); //collapse the range to the end point. false means collapse to end rather than the start
            range.select(); //Select the range (make it the visible selection
        }
    }

    function elementContainsSelection(el) {
        var sel;
        if (window.getSelection) {
            sel = window.getSelection();
            if (sel.rangeCount > 0) {
                for (var i = 0; i < sel.rangeCount; ++i) {
                    if (!isOrContains(sel.getRangeAt(i).commonAncestorContainer, el)) {
                        return false;
                    }
                }
                return true;
            }
        } else if ((sel = document.selection) && sel.type != "Control") {
            return isOrContains(sel.createRange().parentElement(), el);
        }
        return false;
    }

    function isOrContains(node, container) {
        while (node) {
            if (node === container) {
                return true;
            }
            node = node.parentNode;
        }
        return false;
    }

    function pasteHtmlAtCaret(html, el) {

        /*DaiCQ add html vào ckeditor*/
        var editor = CKEDITOR.instances.editor;
        var domHTML = CKEDITOR.dom.element.createFromHtml(html);
        //editor.setAttribute("placeholder","...");
        editor.insertElement(domHTML);
        //  CKEDITOR.instances.editor.insertElement(domHTML);
        /*END DaiCQ add html vào ckeditor*/

    }

    /*function pasteHtmlAtCaret(html, el) {
        var sel, range;
        if (window.getSelection) {
            // IE9 and non-IE
            sel = window.getSelection();
            if (elementContainsSelection(el)) {
                if (sel.getRangeAt && sel.rangeCount) {
                    range = sel.getRangeAt(0);
                    range.deleteContents();

                    // Range.createContextualFragment() would be useful here but is
                    // non-standard and not supported in all browsers (IE9, for one)
                    var el = document.createElement("div");
                    el.innerHTML = html;
                    var frag = document.createDocumentFragment(),
                        node, lastNode;
                    while ((node = el.firstChild)) {
                        lastNode = frag.appendChild(node);
                    }
                    range.insertNode(frag);

                    // Preserve the selection
                    if (lastNode) {
                        range = range.cloneRange();
                        range.setStartAfter(lastNode);
                        range.collapse(true);
                        sel.removeAllRanges();
                        sel.addRange(range);
                    }
                } else if (document.selection && document.selection.type != "Control") {
                    // IE < 9
                    document.selection.createRange().pasteHTML(html);
                }
            } else {
                setEndOfContenteditable(el);
                pasteHtmlAtCaret(html, el);
            }
        }

    }*/

    var el = document.getElementById("editor");

    //Add span chỉ để hiển thị mà không liên quan editable
    $("#addTextBoxSimple").click(function () {
        var sel;
        sel = window.getSelection();
        if (typeof (sel.focusNode.data) != 'undefined') {
//            $("#spantext").text(sel.focusNode.data);
            pasteHtmlAtCaret('<span class="simple" <!--contenteditable="true"-->></span> ', el);
        } else
            pasteHtmlAtCaret('<span class="simple" <!--contenteditable="true"-->></span> ', el);
//            pasteHtmlAtCaret("<span class='simple' placeholder='' contenteditable='true'></span> ",el);

    });

    //Add span để mapping với editable
    $("#cke_inputcontract").click(function () {
        var sel;
        sel = window.getSelection();
        if (typeof (sel.focusNode.data) != 'undefined') {
//            $("#spantext").text(sel.focusNode.data);
//            pasteHtmlAtCaret("<span class='inputcontract' editable-text='newtextbox' placeholder='"+ sel.focusNode.data +"' contenteditable='true'></span> ");
            pasteHtmlAtCaret('<span class="inputcontract" editspan="newtextbox" ng-model="" placeholder="...">[Giá trị]</span>', el);
        } else
            pasteHtmlAtCaret('<span class="inputcontract" editspan="newtextbox" ng-model="" placeholder="...">[Giá trị]</span>', el);
//            pasteHtmlAtCaret("<span class='inputcontract' editable-text='newtextbox' placeholder='.....' contenteditable='true'></span> ",el);

    });

    //Bắt sự kiện onclick trên ckeditor (vì ckeditor không cho phép bắt sự kiện bên ngoài nên dùng cách này)
    editor.on('contentDom', function () {
        var editable = editor.editable();

        editable.attachListener(editable, 'click', function (ev) {
            var domEvent = ev.data/*.getTarget()*/;
            var target = domEvent.getTarget();
            //get tag name
            var tagName = target.$.tagName;
            //get class name of tag
            var className = target.$.className;
            //Nếu thẻ là SPAN
            if (tagName == "SPAN") {
                if (className == "inputcontract" || className == "inputcontract textforcus") {
                    /*$("#editor *").removeClass("spanactive");
                    $("#editor *").removeClass("textforcus");*/
                    target.addClass("textforcus");
                    $("#textboxofp").html("");
                    $("#textboxofp").css("display", "block");

                    var html = '';
                    $("#textboxofp").append('editspan : <input class="idoftextbox" value="' + target.getAttribute("editspan") + '"></input>    Mặc định :<input class="placeholdertext" value="' + target.getAttribute("placeholder") + '"></input> <a class="deleteiteminput btn btn-danger btn-xs" style="float:none; padding: 1px 5px !important;" href="javascript:void(0)">Xóa</a>');

                    $('.idoftextbox').change(function () {

                        target.setAttribute("editspan", $(this).val());
                        target.setAttribute("ng-model", $(this).val());

                    });

                    $('.placeholdertext').keyup(function () {
                        target.attr("placeholder", $(this).val());

                    });
                    $('.deleteiteminput').click(function () {
                        var r = confirm("Bạn có chắc chắn muốn xóa!");
                        if (r == true) {
                            target.remove();
                            $("#textboxofp").html("");
                        } else {
                            return false;
                        }

                    });


                }
                //for span simple
                if (className == "simple" || className == "simple textforcus") {
                    /*$("#editor *").removeClass("spanactive");
                    $("#editor *").removeClass("textforcus");*/
                    target.addClass("textforcus");
                    $("#textboxofp").html("");

                }
            } else {
                /*domEvent.getTarget().setAttribute("contenteditable", "true");*/
                /*$("#editor *").removeClass("textforcus");*/
            }
            // $(e.target).attr("editspan")
            //var domEvent = ev.data.target.nodeName;
            console.log('The editable was clicked.');
        });
    });


    /*$("#editor").click(function (e) {

        //Nếu thẻ là SPAN
        if (e.target.nodeName == "SPAN") {
            if (e.target.className == "inputcontract" || e.target.className == "inputcontract textforcus") {
                $("#editor *").removeClass("spanactive");
                $("#editor *").removeClass("textforcus");
                $(e.target).addClass("textforcus");
                $("#editor").removeAttr("contenteditable");
                $("#textboxofp").html("");
                $("#textboxofp").css("display", "block");
                $("#textboxofp").append('editspan : <input class="idoftextbox" value="' + $(e.target).attr("editspan") + '"></input>    Mặc định :<input class="placeholdertext" value="' + $(e.target).attr("placeholder") + '"></input> <a class="deleteiteminput btn btn-danger btn-xs" style="float:none;" href="javascript:void(0)">Xóa</a>');
                $('.idoftextbox').keyup(function () {

                    $(e.target).attr("editspan", $(this).val());
                    $(e.target).attr("ng-model", $(this).val());
                });
                $('.placeholdertext').keyup(function () {
                    $(e.target).attr("placeholder", $(this).val());

                });
                $('.deleteiteminput').click(function () {
                    var r = confirm("Bạn có chắc chắn muốn xóa!");
                    if (r == true) {
                        $(e.target).remove();
                        $("#textboxofp").html("");
                    } else {
                        return false;
                    }

                });


            }
            //for span simple
            if (e.target.className == "simple" || e.target.className == "simple textforcus") {
                $("#editor *").removeClass("spanactive");
                $("#editor *").removeClass("textforcus");
                $(e.target).addClass("textforcus");
                $("#editor").removeAttr("contenteditable");
                $("#textboxofp").html("");

            }
        } else {
            $(this).attr("contenteditable", "true");
            $("#editor *").removeClass("textforcus");

        }

    });*/

    //for wysiwyg
    /*$('#editor').wysiwyg();*/


</script>


<jsp:include page="/WEB-INF/pages/layout/footer.jsp"/>
<script>
    $(document).ready(function () {
        var parentItem = $("#mau-giao-dien");
        $(parentItem).click();
        $("#taisan").addClass("child-menu");
    });

    function loadMenu() {
        var parentItem = $("#mau-giao-dien");
        $(parentItem).click();
        $("#taisan").addClass("child-menu");
    }
</script>