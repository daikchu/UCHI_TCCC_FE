<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/pages/layout/header.jsp" />
<jsp:include page="/WEB-INF/pages/layout/body_top.jsp" />
<%--
    Hướng dẫn tra cứu
--%>

<div id="menu-map">
    <a href="#menu-toggle" id="menu-toggle"><img src="<%=request.getContextPath()%>/static/image/menu-icon.png"></a>
    <span id="web-map">Hướng dẫn thêm mới từ khóa</span>
</div>
<div class="truong-form-chinhbtt panel-group">

    <form class="form-horizontal" action="" id="search-frm" method="get">
        <div class="panel panel-default" id="panel1">
            <div class="panel-heading">
                <h4 class="panel-title">

                    THỦ THUẬT UPLOAD FILE HỢP ĐỒNG

                </h4>

            </div>
            <div class="panel-body">

                <table class="truong-tableinv">
                    <td style="font-size: 14px">
                        <p>
                            Để upload file word hợp đồng lấy dữ liệu, người dùng có thể nhập nhập file word hợp đồng, kết quả sẽ bao gồm dữ liệu nhập: có trong file word hợp đồng. Để tiện ích hiệu quả, người dùng lưu ý sử dụng các thủ thuật thêm mới từ khóa sau:
                        </p>
                        <p><b>1. Ví dụ mẫu đương sự</b></p>
                        <p style="text-align:center;"><img style="border: blue solid 1px;width:100% !important;" src="<%=request.getContextPath()%>/static/image/key-map-contract-skill.png"></p>
                        <p><span style="color: red;font-weight: bold">Lưu ý:</span>Người dùng phải tạo từ khóa theo mẫu, kết hợp sử dụng các thủ thuật thêm kí tự bắt đầu và kết thúc phần thông tin.</p>
                    </td>
                </table>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />

<script>
    $(document).ready(function () {
        var parentItem = $("#quan-tri-he-thong");
        $(parentItem).click();
        $("#list-key-map-contract").addClass("child-menu");
    });
</script>



