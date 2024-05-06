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
    <span id="web-map">Hướng dẫn tra cứu</span>
</div>
<div class="truong-form-chinhbtt panel-group">

    <form class="form-horizontal" action="" id="search-frm" method="get">
        <div class="panel panel-default" id="panel1">
            <div class="panel-heading">
                <h4 class="panel-title">

                    THỦ THUẬT TÌM KIẾM VỚI UCHI

                </h4>

            </div>
            <div class="panel-body">

                <table class="truong-tableinv">
                    <td style="font-size: 14px">
                        <p>
                            Để tìm kiếm dữ liệu, người dùng có thể nhập bất cứ thông tin gì vào ô tìm kiếm, kết quả sẽ bao gồm dữ liệu nhập: không phân biệt chữ hoa, chữ thường, không phân biệt dấu. Để tìm kiếm hiệu quả, người dùng lưu ý sử dụng các thủ thuật sau:
                        </p>
                        <p><b>1. Tìm kiếm chính xác theo một cụm từ</b></p>
                        <p>Khi người dùng biết chính xác cụm từ hãy đặt cụm từ trong dấu nháy kép <b>“”</b>.
                        <p><span style="font-weight: bold">Ví dụ:</span> Để tìm kiếm dữ liệu có chứa chính xác cụm từ , nhập vào “<span style="font-weight: bold">Nguyễn Trung Dũng</span>”. Hệ thống sẽ hiển thị tất cả các bản ghi có chứa chính xác cụm từ <span style="font-weight: bold">Nguyễn Trung Dũng</span>, không phân biệt chữ hoa, chữ thường, không phân biệt dấu. Do đó, bản ghi có chứa <span style="color: red">Nguyễn Trung Dung</span>; <span style="color: red">Nguyễn Trung Dựng</span> hoặc <span style="color:red">Nguyễn Trung Dụng</span> cũng sẽ được tìm ra.</p>
                        <p><span style="font-weight: bold">Trường hợp:</span> Không để từ khoá trong dấu nháy kép thì bản ghi có chứa các từ trong cụm từ sẽ được tìm kiếm ra. Ví dụ, bản ghi có chứa <span style="color:red">Nguyễn Trung</span> Sơn hoặc Lê Xuân <span style="color:red">Dũng</span> cũng sẽ được tìm ra.</p>
                        <p><b>2. Tìm kiếm mở rộng</b></p>
                        <p>Khi người dùng không nhớ chính xác một hay một vài ký tự có trong từ khoá, sử dụng dấu <span style="font-weight: bold;color: red">*</span> để tìm kiếm mở rộng về phía trái, phải hoặc 2 bên.</p>
                        <p>-	Nếu nhập *<span style="color: red">3</span>, kết quả tìm kiếm sẽ bao gồm những dữ liệu chứa số 3 ở cuối từ, ví dụ 12<span style="color: red">3</span>.</p>
                        <p>-	Nếu nhập <span style="color: red">3</span>*, kết quả tìm kiếm sẽ bao gồm những dữ liệu chứa số 3 ở đầu từ, ví dụ <span style="color: red">3</span>41.</p>
                        <p>-	Nếu nhập *<span style="color: red">3</span>*, kết quả tìm kiếm sẽ bao gồm những dữ liệu chứa số 3, ví dụ 12<span style="color: red">3</span>45.</p>
                        <p><b>3. Tìm kiếm kết hợp nhiều điều kiện</b></p>
                        <p>Khi người dùng biết càng nhiều thông tin tìm kiếm, thì phạm vi tìm kiếm càng được giới hạn, kết quả tìm kiếm càng sát với mong muốn.</p>
                        <p>-	Nếu biết địa chỉ cụ thể, ví dụ ở <b>115 Lê Thanh Nghị, Hai Bà Trưng</b>, người dùng nhập vào <span style="color: red">115 “Lê Thanh Nghị” “Hai Bà Trưng”</span>. Tại sao không nhập <span style="color: red">“115 Lê Thanh Nghị” “Hai Bà Trưng”</span>? Vì như vậy, những bản ghi chứa <span style="color: red">115 đường</span> (phường,...) <span style="color: red">Lê Thanh Nghị</span> sẽ không được tìm ra.</p>
                        <p>-	Nếu người dùng sử dụng tìm kiếm nâng cao, hãy nhập từ khoá vào chính xác trường Thông tin tài sản hoặc Bên liên quan/ Chủ sở hữu.</p>
                        <p style="text-align:center;"><img style="border: blue solid 1px;width:650px !important;" src="<%=request.getContextPath()%>/static/image/search_skill.png"></p>
                        <p><span style="color: red;font-weight: bold">Lưu ý:</span>Người dùng nên tra cứu theo nhiều trường dữ liệu, kết hợp sử dụng các thủ thuật tra cứu.</p>
                    </td>
                </table>
            </div>
        </div>
    </form>
</div>






<jsp:include page="/WEB-INF/pages/layout/footer.jsp" />



