<%@ page import="com.vn.osp.context.CommonContext" %>
<%@ page import="com.vn.osp.common.util.SystemProperties" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" errorPage="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vn.osp.service.QueryFactory" %>
<%--
    Xem bản in hợp đồng, giao dịch đã công chứng
--%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Style-Type" content="text/css"/>
    <meta http-equiv="Content-Script-Type" content="text/javascript"/>
    <title></title>
    <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/static/image/osp.ico"/>


</head>

<body>
    <style>
        .tbl-list-print, .tbl-list-print th, .tbl-list-print td {
            border: 1px solid black;
        }

        .tbl-list-print {
            border-collapse: collapse;
        }

        #content li {
            list-style-type: none;
        }

        * {
            font-family: "Tahoma, sans-serif";
            font-size: 14px;
        }
    </style>
    <table style="width: 774px">
        <tbody>
            <tr>
                <td valign="top">

                    <div id="content" class="clearfix" style="width:733px">

                        <div id="navigator">
                            <ul class="clearfix" style="text-align: center;">
                                <li><strong style="font-size: 15px;">KẾT QUẢ TRA CỨU</strong></li>
                            </ul>
                        </div>
                        <br>


                        <div style="width: 600px;">


                        </div>
                        <form name="preventListForm" id="form" method="post" action="/UCHI_STP_BG/preventlistsearch.do"
                              onsubmit="javascript: search();">
                            <input type="hidden" name="isHidePanelSearch" value="false" id="isHidePanelSearch">
                            <input type="hidden" name="isAdvanceSearch" value="false" id="isAdvanceSearch">
                            <input type="hidden" name="displayPreventList" value="true" id="displayPreventList">
                            <input type="hidden" name="keyHighLight" value="" id="keyHighLight">
                            <div id="searchTime"><strong style="vertical-align: middle;">Thời gian :</strong> &nbsp;&nbsp;&nbsp;
                                ${preventContractList.searchTime}
                            </div>
                            <div id="preventListPrint">
                                <div style="float: right">
                                    <div class="advanPrint"><a href="javascript:printts()"><img
                                            src="<%=request.getContextPath()%>/static/image/btn-print.gif"
                                            alt="Them moi"></a></div>
                                </div>
                            </div>
                            <table>
                                <tbody>
                                    <tr style="height: 10px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div id="searchShow"><strong style="vertical-align: middle;">Điều kiện tìm kiếm :</strong>
                            </div>
                            <c:if test="${!preventContractList.isAdvanceSearch.equals('true')}">
                                <div id="keySearchPanel" class="keySearch" style="padding-left: 25px;"><span
                                        style="vertical-align: middle;">Từ khóa :</span> ${preventContractList.stringKey}
                                </div>
                            </c:if>
                            <c:if test="${preventContractList.isAdvanceSearch.equals('true')}">
                                <table id="tblSearch" class="advanceSearch tbl-search">
                                    <tbody>
                                        <tr>
                                                <%--<td style="padding-left: 25px; line-height: 1.5;">Loại tài sản :
                                                    <c:if test="${preventContractList.propertyType.equals('00')}">
                                                        Tất cả
                                                    </c:if>
                                                    <c:if test="${preventContractList.propertyType.equals('01')}">
                                                        Nhà đất
                                                    </c:if>
                                                    <c:if test="${preventContractList.propertyType.equals('02')}">
                                                        Ô tô - Xe máy
                                                    </c:if>
                                                    <c:if test="${preventContractList.propertyType.equals('99')}">
                                                        Tài sản khác
                                                    </c:if>
                                                </td>--%>
                                            <td colspan="3" style="padding-left: 25px; line-height: 1.5;">Thông
                                                tin tài sản : ${preventContractList.propertyInfo}
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                Bên liên quan / Chủ sở hữu : ${preventContractList.ownerInfo}
                                            </td>

                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </c:if>
                            <table>
                                <tbody>
                                    <tr style="height: 10px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div id="preventListId">
                                <strong style="vertical-align: middle;">1. Danh sách thông tin ngăn chặn (
                                    Tổng số : <strong>${preventContractList.daDuyetListNumber}</strong> dữ liệu
                                    <span> - Trang&nbsp;
						     ${preventContractList.daDuyetPage}
							 /${preventContractList.daDuyetTotalPage}
						</span>
                                    )
                                </strong>
                            </div>
                            <!-- prevent list-->
                            <table>
                                <tbody>
                                    <tr style="height: 3px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="preventList" class="tbl-list-print" style="width:733px;">
                                <tbody>
                                    <tr>
                                        <th nowrap="nowrap">Phân loại</th>
                                        <th nowrap="nowrap">Giải tỏa</th>
                                        <th>Loại tài sản</th>
                                        <th>Thông tin tài sản</th>
                                        <th>Đơn vị gửi yêu cầu ngăn chặn</th>
                                        <th>Ngày văn bản đến</th>
                                    </tr>
                                </tbody>
                                <tbody id="preventListContent">
                                    <c:forEach items="${preventContractList.daDuyetList}" var="item">
                                        <c:forEach var="thisProperty" items="${item.propertyPrevents}"
                                                   varStatus="loop">
                                            <tr>
                                                <c:if test="${loop.index==0}">
                                                    <td style="text-align: center;" rowspan="${item.propertyPrevents.size()}">

                                                        <c:if test="${item.origin_kind.equals('01')}">
                                                            Ngăn chặn
                                                        </c:if>
                                                        <c:if test="${item.origin_kind.equals('02')}">
                                                            Tham khảo
                                                        </c:if>


                                                    </td>
                                                </c:if>
                                                <td style="text-align: center;">
                                                    <c:if test="${thisProperty.release_flg==1}">
                                                        Đã giải tỏa
                                                    </c:if>
                                                </td>
                                                <td nowrap="nowrap">
                                                        ${thisProperty.loaiTaiSan()}
                                                </td>
                                                <td>Thông tin tài sản : ${thisProperty.property_info}
                                                </td>
                                                <c:if test="${loop.index==0}">
                                                    <td rowspan="${item.propertyPrevents.size()}">${item.prevent_person_info}</td>
                                                    <td style="text-align: center;" rowspan="${item.propertyPrevents.size()}">${item.prevent_doc_receive_date}</td>
                                                </c:if>


                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div id="preventAdd"></div>

                            <table>
                                <tbody>
                                    <tr style="height: 10px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <%--Danh sách thông tin tham khảo--%>
                            <div id="preventListIdThamKhao">
                                <strong style="vertical-align: middle;">2. Danh sách thông tin tham khảo(
                                    Tổng số: <strong>${preventContractList.thamKhaoListNumber}</strong> dữ liệu

                                    <span> - Trang&nbsp;
						     ${preventContractList.thamKhaoPage}
							 /${preventContractList.thamKhaoTotalPage}
						</span>

                                    )
                                </strong>
                            </div>
                            <!-- prevent list-->


                            <table>
                                <tbody>
                                    <tr style="height: 3px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="preventListThamKhao" class="tbl-list-print" style="width:733px;">
                                <tbody>
                                    <tr>
                                        <th nowrap="nowrap">Phân loại</th>
                                        <th nowrap="nowrap">Giải tỏa</th>
                                        <th>Loại tài sản</th>
                                        <th>Thông tin tài sản</th>
                                        <th>Đơn vị gửi yêu cầu ngăn chặn</th>
                                        <th>Ngày văn bản đến</th>
                                    </tr>
                                </tbody>
                                <tbody id="preventListContentThamKhao">
                                    <c:forEach items="${preventContractList.thamKhaoList}" var="item">
                                        <c:forEach var="thisProperty" items="${item.propertyPrevents}"
                                                   varStatus="loop">
                                            <tr>
                                                <c:if test="${loop.index==0}">
                                                    <td style="text-align: center;" rowspan="${item.propertyPrevents.size()}">

                                                        <c:if test="${item.origin_kind.equals('01')}">
                                                            Ngăn chặn
                                                        </c:if>
                                                        <c:if test="${item.origin_kind.equals('02')}">
                                                            Tham khảo
                                                        </c:if>


                                                    </td>
                                                </c:if>
                                                <td style="text-align: center;">
                                                    <c:if test="${thisProperty.release_flg==1}">
                                                        Đã giải tỏa
                                                    </c:if>
                                                </td>
                                                <td nowrap="nowrap">
                                                        ${thisProperty.loaiTaiSan()}
                                                </td>
                                                <td>Thông tin tài sản : ${thisProperty.property_info}
                                                </td>
                                                <c:if test="${loop.index==0}">
                                                    <td rowspan="${item.propertyPrevents.size()}">${item.prevent_person_info}</td>
                                                    <td style="text-align: center;" rowspan="${item.propertyPrevents.size()}">${item.prevent_doc_receive_date}</td>
                                                </c:if>


                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div id="preventAdd"></div>

                            <%--<%if (QueryFactory.getSystemConfigByKey("display_contract_list").equals("1")) {%>--%>
                            <table>
                                <tbody>
                                    <tr style="height: 10px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>

                            <div id="preventListId">
                                <strong style="vertical-align: middle;">3. Danh sách hợp đồng, giao dịch đã công chứng (
                                    Tổng số: <strong>${preventContractList.hopDongListNumber}</strong> dữ liệu

                                    <span> - Trang&nbsp;
					        ${preventContractList.hopDongPage}
							/${preventContractList.hopDongTotalPage}
						</span>

                                    )
                                </strong>
                            </div>


                            <!-- property list-->


                            <table>
                                <tbody>
                                    <tr style="height: 3px">
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="propertyList" class="tbl-list-print" style="width:733px;">
                                <tbody>
                                    <tr class="">
                                        <th>Ngày công chứng</th>
                                        <th>Số hợp đồng</th>
                                        <th>Tên hợp đồng</th>
                                        <th>Bên liên quan</th>
                                        <th>Nội dung</th>
                                        <c:if test="${SystemProperties.getProperty('org_type')!=1}"> <%--Nếu k phải là phường xã--%>
                                            <th>Công chứng viên</th>
                                            <th>Tổ chức công chứng</th>
                                        </c:if>
                                        <c:if test="${SystemProperties.getProperty('org_type')==1}"> <%--Nếu là phường xã--%>
                                            <th>Người ký chứng thực</th>
                                            <th>Tổ chức chứng thực</th>
                                        </c:if>
                                    </tr>

                                </tbody>
                                <tbody id="propertyListContent">
                                    <c:forEach items="${preventContractList.hopDongList}" var="item">
                                        <tr>
                                            <td nowrap="nowrap" style="text-align: center;">${item.notary_date}</td>
                                            <td>${item.contract_number}</td>
                                            <td style="min-width: 40px">${item.contract_name}</td>
                                            <td style="word-wrap: break-word">
                                                    ${item.relation_object.replace('\\n', '<br>')}
                                            </td>
                                            <td style="text-align: left;vertical-align: top">
                                                    ${item.transaction_content.replace('\\n', '<br>')}
                                            </td>
                                            <%--<c:if test="${SystemProperties.getProperty('org_type')!=1}"> &lt;%&ndash;Nếu k phải là phường xã&ndash;%&gt;--%>
                                                <td style="text-align: center;word-wrap: break-word">${item.notary_person}</td>
                                                <td style="text-align: center;word-wrap: break-word">
                                                        ${item.notary_office_name}
                                                </td>
                                            <%--</c:if>--%>
                                            <%--<c:if test="${SystemProperties.getProperty('org_type')==1}"> &lt;%&ndash;Nếu là phường xã&ndash;%&gt;
                                                <td style="text-align: center;word-wrap: break-word">${item.contract_signer}</td>
                                                <td style="text-align: center;word-wrap: break-word">
                                                        ${item.notary_person}
                                                </td>
                                            </c:if>--%>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <%--<%}%>--%>
                            <div style="width:735px;float: left;">
                                <div style="width: 100px;float: left;">
                                    <br>
                                    <b>Ghi chú:</b>
                                </div>
                                <div style="width:700px;float: left;">
                                    <span>.................................................................................................................................................................................................................</span>
                                    <p>
                                        .................................................................................................................................................................................................................</p>
                                </div>
                                <div style="width: 200px;float: right;">
                                    <p style="text-align: center;font-weight: bold;font-size: 16px">Chữ ký của người tra cứu</p>
                                    <br>
                                    <br>
                                    <br>
                                    <p style="text-align: center"><%=((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getUser().getFamily_name()%> <%=((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getUser().getFirst_name()%>
                                    </p>
                                    <br>
                                    <br>
                                    <br>
                                </div>
                            </div>
                            <input type="hidden" name="direction" value="">
                            <input type="hidden" name="sortType" value="true" id="sortType">
                        </form>
                        <br>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</body>

<script type="text/javascript">
    if (window.ActiveXObject)//IE
    {
        $('#content').css({
            "width": "100%"
        });
    }

    function printts() {
        if (window.ActiveXObject) {
            var OLECMDID = 7;
            /* OLECMDID values:
             * 6 - print
             * 7 - print preview
             * 1 - open window
             * 4 - Save As
             */
            var PROMPT = 1; // 2 DONTPROMPTUSER
            var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
            document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
            WebBrowser1.ExecWB(OLECMDID, PROMPT);
            WebBrowser1.outerHTML = "";
        } else {
            print();
        }
    }

    changeSearch($('#isAdvanceSearch').val());

    function changeSearch(value) {
        $('#isAdvanceSearch').val(value);
        if (value == 'true') {
            $('.advanceSearch').show();
            $('.keySearch').hide();
        } else {
            $('.keySearch').show();
            $('.advanceSearch').hide();
        }
    }

    var checkPaging = 0;
    var pageNumber;
    var pageNumber2;

    function paging(data) {
        checkPaging = 1;
        pageNumber = data;

    }

    function pagingProperty(data) {
        checkPaging = 2;
        pageNumber2 = data;

    }

</script>



