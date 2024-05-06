<%----%>
<%--Sao chép các mẫu đương sự tài sản lưu khi cần. --%>
<%----%>
<%--mẫu công ty--%>
<p ng-if="user.org_name.length > 0 && user.org_name != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;">
    <font
            style="font-size: 14pt;">Công ty:
        <font style="text-transform: uppercase;">
            <b> <span class="inputcontract"
                      editspan="user.org_name"
                      ng-model="user.org_name"
                      placeholder="..."
                      contenteditable="true"></span>;
            </b>
        </font>
    </font>
</p>

<p ng-if="user.org_address.length > 0 && user.org_address != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;">
    <font style="font-size: 14pt;">Địa chỉ:
        <span class="inputcontract" editspan="user.org_address"
              ng-model="user.org_address" placeholder="..."
              contenteditable="true">

        </span>;
    </font>
</p>

<p class="MsoNormal" style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;">
    <font style="font-size: 14pt;">
        <span ng-if="user.org_code.length > 0 && user.org_code != null">
            Mã số doanh nghiệp:
            <span class="inputcontract" editspan="user.org_code"
                  ng-model="user.org_code" placeholder="..."
                  contenteditable="true">
            </span>
        </span>

        <span ng-if="user.first_registed_date.length > 0 && user.first_registed_date != null">
            , đăng ký lần đầu ngày:
            <span
                    class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date"
                    placeholder="..."
                    contenteditable="true">
            </span>
        </span>

        <span ng-if="user.number_change_registed.length > 0 && user.number_change_registed != null">
            , đăng ký thay đổi lần thứ:
            <span class="inputcontract"
                  editspan="user.number_change_registed"
                  ng-model="user.number_change_registed"
                  placeholder="..." contenteditable="true">

            </span>
        </span>

        <span ng-if="user.change_registed_date.length > 0 && user.change_registed_date != null">
            , ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date"
                        placeholder="..." contenteditable="true"></span>
        </span>
        <span ng-if="user.department_issue.length > 0 && user.department_issue != null">
            , theo: <span class="inputcontract"
                       editspan="user.department_issue"
                       ng-model="user.department_issue"
                       placeholder="..."
                       contenteditable="true"></span> ;
        </span>
    </font>
</p>

<p ng-if="user.name.length > 0 && user.name != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Họ và tên người đại diện:<font style="text-transform: uppercase;"><b> <span
        class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="..." contenteditable="true"></span></b>;</font></font>
</p>

<p ng-if="user.position.length > 0 && user.position != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Chức danh: <span class="inputcontract" editspan="user.position"
                                                  ng-model="user.position" placeholder="..."
                                                  contenteditable="true"></span>; </font></p>

<p ng-if="user.certification_date.length > 0 && user.certification_date != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Giấy chứng minh nhân dân số: <span placeholder="..." editspan="user.passport"
                                                                    ng-model="user.passport" class="inputcontract"
                                                                    contenteditable="true"></span> cấp ngày: <span
        placeholder="..." editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract"
        contenteditable="true"></span> tại: <span placeholder="..." editspan="user.certification_place"
                                                  ng-model="user.certification_place" class="inputcontract"
                                                  contenteditable="true"></span>; </font></p>

<p ng-if="user.org_name.length > 0 && user.org_name != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Quốc tịch: Việt Nam;</font></p>

<p ng-if="user.address.length > 0 && user.address != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Địa chỉ: <span placeholder="..." editspan="user.address" ng-model="user.address"
                                                class="inputcontract" contenteditable="true" style=""></span>;</font>
</p>


<%--mẫu cá nhân--%>


<p ng-if="user.name.length > 0 && user.name != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;"> <span ng-change="user_sex_name(user.sex.name,privyIndex,$index)" class="inputcontract" editspan="user.sex.name" ng-model="user.sex.name"
                                        contenteditable="false"></span>:
    <b> <span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="..."
              contenteditable="true"></span> </b>;</font></p>


<p ng-if="user.birthday.length > 0 && user.birthday != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Ngày sinh: <span class="inputcontract" editspan="user.birthday"
                                                  ng-model="user.birthday" placeholder="..."
                                                  style="text-indent: 1cm;" contenteditable="true"></span>; </font></p>


<p ng-if="user.passport.length > 0 && user.passport != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;">
    <font style="font-size: 14pt;"> Giấy chứng minh nhân dân số:
        <span class="inputcontract" editspan="user.passport"
              ng-model="user.passport" placeholder="..." contenteditable="true">
			</span>

        <span ng-if="user.certification_date.length > 0 && user.certification_date != null" style="text-indent: 1cm;">
        	<span style="text-indent: 1cm;">, cấp ngày: </span>
	        <span class="inputcontract" editspan="user.certification_date" ng-model="user.certification_date"
                  placeholder="..."
                  contenteditable="true"></span>
	    </span>

        <span ng-if="user.certification_place.length > 0 && user.certification_place != null">
	    	<span style="text-indent: 1cm;">, tại: </span>
	    	<span class="inputcontract" editspan="user.certification_place"
                  ng-model="user.certification_place" placeholder="..."
                  contenteditable="true"></span>;
	    </span>
    </font>
</p>


<p class="MsoNormal" style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Quốc tịch: Việt Nam;</font></p>

<p ng-if="user.address.length > 0 && user.address != null" class="MsoNormal"
   style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Nơi cư trú: <span class="inputcontract" editspan="user.address"
                                                   ng-model="user.address"
                                                   placeholder="..." contenteditable="true"></span>; </font></p>


<%--mẫu Tài sản đất--%>

<div ng-if="item.land.land_certificate.length > 0 && item.land.land_certificate != null" class="MsoNormal"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;">
    <font style="font-size: 14pt;"><span class="" style="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số
        <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate"
              placeholder="..." contenteditable="true" style=""></span>
        do <span class="inputcontract"
                 editspan="item.land.land_issue_place"
                 ng-model="item.land.land_issue_place"
                 placeholder="..." contenteditable="true"
                 style=""></span> cấp ngày <span
                class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date"
                placeholder="..." contenteditable="true" style=""></span> cụ thể như sau: </span>
    </font>
</div>

<div ng-if="item.land.land_number.length > 0 && item.land.land_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">- Thửa đất số: <span class="inputcontract" editspan="item.land.land_number"
                                                      ng-model="item.land.land_number" placeholder="..."
                                                      contenteditable="true"></span>, tờ bản đồ số: <span
        class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number"
        placeholder="..." contenteditable="true"></span>; </font></div>

<div ng-if="item.land.land_address.length > 0 && item.land.land_address != null" style=" text-align: justify; margin: 0pt 0cm 6pt;
     text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Địa chỉ thửa đất: <span class="inputcontract" editspan="item.land.land_address"
                                                           ng-model="item.land.land_address" placeholder="..."
                                                           contenteditable="true"></span>;</font></div>

<div ng-if="item.land.land_area.length > 0 && item.land.land_area != null" style=" text-align: justify; margin: 0pt 0cm 6pt;
     text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Diện tích: <span class="inputcontract" editspan="item.land.land_area"
                                                    ng-model="item.land.land_area" placeholder="..."
                                                    contenteditable="true"></span> m2 (bằng chữ: <span
        class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="..."
        contenteditable="true"></span> mét vuông); </font></div>

<div ng-if="item.land.land_private_area.length > 0 && item.land.land_private_area != null && item.land.land_public_area.length > 0 && item.land.land_public_area != null">
    <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Hình thức sử dụng: </font></div>

    <div>
        <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
            <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
                <div style=" text-align: justify;
                 margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;
            "><font
                        style="font-size: 14pt;">+Sử dụng riêng: <span class="inputcontract"
                                                                       editspan="item.land.land_private_area"
                                                                       ng-model="item.land.land_private_area"
                                                                       placeholder="..."
                                                                       contenteditable="true"></span>;</font></div>

                <div style=" text-align: justify; margin:
                 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;
            "><font
                        style="font-size: 14pt;">+Sử dụng chung: <span class="inputcontract"
                                                                       editspan="item.land.land_public_area"
                                                                       ng-model="item.land.land_public_area"
                                                                       placeholder=" ..."
                                                                       contenteditable="true"></span>;</font></div>
            </blockquote>
        </blockquote>
    </div>
</div>

<div ng-if="item.land.land_use_purpose.length > 0 && item.land.land_use_purpose != null" style=" text-align: justify; margin: 0pt 0cm
     6pt; text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Mục đích sử dụng: <span class="inputcontract" editspan="item.land.land_use_purpose"
                                                           ng-model="item.land.land_use_purpose" placeholder="..."
                                                           contenteditable="true"></span>; </font></div>

<div ng-if="item.land.land_use_period.length > 0 && item.land.land_use_period != null" style=" text-align: justify; margin: 0pt 0cm
     6pt; text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period"
                                                           ng-model="item.land.land_use_period" placeholder="..."
                                                           contenteditable="true"></span>;</font></div>

<div ng-if="item.land.land_use_origin.length > 0 && item.land.land_use_origin != null" style=" text-align: justify; margin: 0pt 0cm
     6pt; text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin"
                                                            ng-model="item.land.land_use_origin" placeholder="..."
                                                            contenteditable="true"></span>;</font></div>

<div ng-if="item.restrict.length > 0 && item.restrict != null" style=" text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm;
     line-height: 100%;
"><font
        style="font-size: 14pt;">- Hạn chế và quyền sử dụng đất: <span class="inputcontract" editspan="item.restrict"
                                                                       ng-model="item.restrict" placeholder="..."
                                                                       contenteditable="true"></span>;</font></div>

<div ng-if="item.land.land_associate_property.length > 0 && item.land.land_associate_property != null" style=" text-align: justify;
     margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;
"><font
        style="font-size: 14pt;">- Tài sản gắn liền với đất: <span class="inputcontract"
                                                                   editspan="item.land.land_associate_property"
                                                                   ng-model="item.land.land_associate_property"
                                                                   placeholder="..."
                                                                   contenteditable="true"></span>;</font></div>

<div ng-if="item.owner_info.length > 0 && item.owner_info != null" style=" text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm;
     line-height: 100%;
"><font
        style="font-size: 14pt;">- Thông tin chủ sở hữu: <span class="inputcontract" editspan="item.owner_info"
                                                               ng-model="item.owner_info" placeholder="..."
                                                               contenteditable="true"></span>;</font></div>

<div ng-if="item.other_info.length > 0 && item.other_info != null" style=" text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm;
     line-height: 100%;
">
    <font style="">
        <font style="font-size: 14pt;">- Thông tin khác : </font><span class="inputcontract" editspan="item.other_info"
                                                                       ng-model="item.other_info" placeholder="..."
                                                                       contenteditable="true"
                                                                       style="font-size: 14pt;"></span>;
    </font>
</div>


<%--mẫu tài sản--%>

<div ng-if="item.property_info.length > 0 && item.property_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Thông tin tài sản: <span class="inputcontract" editspan="item.property_info"
                                                          ng-model="item.property_info" placeholder="..."
                                                          contenteditable="true" style=""></span>;</font></div>

<div ng-if="item.owner_info.length > 0 && item.owner_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Thông tin chủ sở hữu: <span class="inputcontract" editspan="item.owner_info"
                                                             ng-model="item.owner_info" placeholder="..."
                                                             contenteditable="true"></span>;</font></div>

<div ng-if="item.other_info.length > 0 && item.other_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font style=""><font
        style="font-size: 14pt;">Thông tin khác: </font><span class="inputcontract" editspan="item.other_info"
                                                              ng-model="item.other_info" placeholder="..."
                                                              contenteditable="true"
                                                              style="font-size: 14pt;"></span>;</font></div>

<%--Ô tô xe máy--%>

<div ng-if="item.vehicle.car_license_number.length > 0 && item.vehicle.car_license_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Biển kiểm soát: <span class="inputcontract" editspan="item.vehicle.car_license_number"
                                                       ng-model="item.vehicle.car_license_number" placeholder="..."
                                                       contenteditable="true" style=""></span>;</font></div>
<div ng-if="item.vehicle.car_regist_number.length > 0 && item.vehicle.car_regist_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Số giấy đăng ký: <span class="inputcontract" editspan="item.vehicle.car_regist_number"
                                                        ng-model="item.vehicle.car_regist_number" placeholder="..."
                                                        contenteditable="true"></span>;</font></div>
<div ng-if="item.vehicle.car_issue_place.length > 0 && item.vehicle.car_issue_place != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Nơi cấp: <span class="inputcontract" editspan="item.vehicle.car_issue_place"
                                                ng-model="item.vehicle.car_issue_place" placeholder="..."
                                                contenteditable="true"></span>;</font></div>
<div ng-if="item.vehicle.car_issue_date.length > 0 && item.vehicle.car_issue_date != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Ngày cấp: <span class="inputcontract" editspan="item.vehicle.car_issue_date"
                                                 ng-model="item.vehicle.car_issue_date" placeholder="..."
                                                 contenteditable="true"></span>;</font></div>
<div ng-if="item.vehicle.car_frame_number.length > 0 && item.vehicle.car_frame_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Số khung: <span class="inputcontract" editspan="item.vehicle.car_frame_number"
                                                 ng-model="item.vehicle.car_frame_number" placeholder="..."
                                                 contenteditable="true"></span>;</font></div>
<div ng-if="item.vehicle.car_machine_number.length > 0 && item.vehicle.car_machine_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Số máy: <span class="inputcontract" editspan="item.vehicle.car_machine_number"
                                               ng-model="item.vehicle.car_machine_number" placeholder="..."
                                               contenteditable="true"></span>;</font></div>
<div ng-if="item.owner_info.length > 0 && item.owner_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Thông tin chủ sở hữu: <span class="inputcontract" editspan="item.owner_info"
                                                             ng-model="item.owner_info" placeholder="..."
                                                             contenteditable="true"></span>;</font></div>
<div ng-if="item.other_info.length > 0 && item.other_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
        style="font-size: 14pt;">Thông tin khác: </font><span class="inputcontract" editspan="item.other_info"
                                                              ng-model="item.other_info" placeholder="..."
                                                              contenteditable="true"></span>;
</div>


<%--Đất và tài sản gắn liền với đất--%>

<div style="margin-top:0.0pt;margin-right:0cm;margin-bottom:6.0pt; margin-left:0cm;text-indent:1.0cm;line-height:100%;">

    <div ng-if="item.land.land_certificate.length > 0 && item.land.land_certificate != null"
         style="text-align: justify;"><span
            style="font-size: 14pt; text-indent: 1cm;">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số </span><span
            class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate"
            placeholder="..." style="text-indent: 1cm;"></span><span
            style="font-size: 14pt; text-indent: 1cm;"> do </span><span class="inputcontract"
                                                                        editspan="item.land.land_issue_place"
                                                                        ng-model="item.land.land_issue_place"
                                                                        placeholder="..."
                                                                        style="text-indent: 1cm;"></span><span
            style="font-size: 14pt; text-indent: 1cm;"> cấp </span><font style="font-size: 14pt; text-indent: 1cm;">ngày
        <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date"
              placeholder="..."></span> cụ thể như sau:</font></div>

    <div ng-if="item.land.land_number.length > 0 && item.land.land_number != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Thửa đất số: <span class="inputcontract" editspan="item.land.land_number"
                                                          ng-model="item.land.land_number" placeholder="..."
                                                          contenteditable="true"></span>, tờ bản đồ số: <span
            class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number"
            placeholder="..." contenteditable="true"></span>; </font></div>

    <div ng-if="item.land.land_address.length > 0 && item.land.land_address != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Địa chỉ thửa đất: <span class="inputcontract" editspan="item.land.land_address"
                                                               ng-model="item.land.land_address" placeholder="..."
                                                               contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.land_area.length > 0 && item.land.land_area != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Diện tích: <span class="inputcontract" editspan="item.land.land_area"
                                                        ng-model="item.land.land_area" placeholder="..."
                                                        contenteditable="true"></span> m2 (bằng chữ: <span
            class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text"
            placeholder="..." contenteditable="true"></span> mét vuông) </font>;
    </div>
    <div ng-if="item.land.land_private_area.length > 0 && item.land.land_private_area != null && item.land.land_public_area.length > 0 && item.land.land_public_area != null">
        <div ng-if="item.land.land_use_type.length > 0 && item.land.land_use_type != null"
             style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
                style="font-size: 14pt;">- Hình thức sử dụng: <span class="inputcontract"
                                                                    editspan="item.land.land_use_type"
                                                                    ng-model="item.land.land_use_type" placeholder="..."
                                                                    contenteditable="true"></span>;</font></div>

        <div>
            <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
                <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
                    <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
                            style="font-size: 14pt;">+Sử dụng riêng: <span class="inputcontract"
                                                                           editspan="item.land.land_private_area"
                                                                           ng-model="item.land.land_private_area"
                                                                           placeholder="..."
                                                                           contenteditable="true"></span>;</font></div>
                    <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
                            style="font-size: 14pt;">+Sử dụng chung: <span class="inputcontract"
                                                                           editspan="item.land.land_public_area"
                                                                           ng-model="item.land.land_public_area"
                                                                           placeholder=" ..."
                                                                           contenteditable="true"></span>;</font></div>
                </blockquote>
            </blockquote>
        </div>
    </div>

    <div ng-if="item.land.land_use_purpose.length > 0 && item.land.land_use_purpose != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Mục đích sử dụng: <span class="inputcontract"
                                                               editspan="item.land.land_use_purpose"
                                                               ng-model="item.land.land_use_purpose" placeholder="..."
                                                               contenteditable="true"></span>; </font></div>

    <div ng-if="item.land.land_use_period.length > 0 && item.land.land_use_period != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Thời hạn sử dụng: <span class="inputcontract"
                                                               editspan="item.land.land_use_period"
                                                               ng-model="item.land.land_use_period" placeholder="..."
                                                               contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.land_use_origin.length > 0 && item.land.land_use_origin != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Nguồn gốc sử dụng: <span class="inputcontract"
                                                                editspan="item.land.land_use_origin"
                                                                ng-model="item.land.land_use_origin" placeholder="..."
                                                                contenteditable="true"></span>;</font></div>

    <div ng-if="item.restrict.length > 0 && item.restrict != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Hạn chế và quyền sử dụng đất: <span class="inputcontract"
                                                                           editspan="item.restrict"
                                                                           ng-model="item.restrict" placeholder="..."
                                                                           contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.land_associate_property.length > 0 && item.land.land_associate_property != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Tài sản gắn liền với đất: <span class="inputcontract"
                                                                       editspan="item.land.land_associate_property"
                                                                       ng-model="item.land.land_associate_property"
                                                                       placeholder="..." contenteditable="true"></span>;</font>
    </div>

    <div ng-if="item.owner_info.length > 0 && item.owner_info != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Thông tin chủ sở hữu: <span class="inputcontract" editspan="item.owner_info"
                                                                   ng-model="item.owner_info" placeholder="..."
                                                                   contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.land_type.length > 0 && item.land.land_type != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Loại nhà ở: <span class="inputcontract" editspan="item.land.land_type"
                                                         ng-model="item.land.land_type" placeholder="..."
                                                         contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.construction_area.length > 0 && item.land.construction_area != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Diện tích xây dựng: <span class="inputcontract"
                                                                 editspan="item.land.construction_area"
                                                                 ng-model="item.land.construction_area"
                                                                 placeholder="..."
                                                                 contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.building_area.length > 0 && item.land.building_area != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Diện tích sàn: <span class="inputcontract" editspan="item.land.building_area"
                                                            ng-model="item.land.building_area" placeholder="..."
                                                            contenteditable="true"></span>;</font></div>

    <div ng-if="item.land.land_sort.length > 0 && item.land.land_sort != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font
            style="font-size: 14pt;">- Cấp (hạng) nhà ở: <span class="inputcontract" editspan="item.land.land_sort"
                                                               ng-model="item.land.land_sort" placeholder="..."
                                                               contenteditable="true"></span>;</font></div>

    <div ng-if="item.other_info.length > 0 && item.other_info != null"
         style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;"><font style=""><font
            style="font-size: 14pt;">- Thông tin khác : </font><span class="inputcontract" editspan="item.other_info"
                                                                     ng-model="item.other_info" placeholder="..."
                                                                     contenteditable="true"
                                                                     style="font-size: 14pt;"></span>;</font></div>
</div>


<%--mẫu trung cư--%>

<div ng-if="item.land.land_certificate.length > 0 && item.land.land_certificate != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;"><font
        style="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract"
                                                                                   editspan="item.land.land_certificate"
                                                                                   ng-model="item.land.land_certificate"
                                                                                   placeholder="..."
                                                                                   contenteditable="true"
                                                                                   style=""></span> do <span
        class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place"
        placeholder="..." contenteditable="true" style=""></span> cấp ngày <span class="inputcontract"
                                                                                 editspan="item.land.land_issue_date"
                                                                                 ng-model="item.land.land_issue_date"
                                                                                 placeholder="..."
                                                                                 contenteditable="true"
                                                                                 style=""></span> , </font><font
        style="">cụ thể như sau: </font></div>

<div ng-if="item.apartment.apartment_address.length > 0 && item.apartment.apartment_address != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Địa chỉ:
    <span class="inputcontract" editspan="item.apartment.apartment_address"
          ng-model="item.apartment.apartment_address" placeholder="..." contenteditable="true"></span>;
</div>

<div ng-if="item.apartment.apartment_number.length > 0 && item.apartment.apartment_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Căn hộ số:
    <span class="inputcontract" editspan="item.apartment.apartment_number"
          ng-model="item.apartment.apartment_number" placeholder="..."
          contenteditable="true"></span> tầng: <span class="inputcontract"
                                                     editspan="item.apartment.apartment_floor"
                                                     ng-model="item.apartment.apartment_floor"
                                                     placeholder="..." contenteditable="true"></span>;
</div>

<div ng-if="item.apartment.apartment_area_use.length > 0 && item.apartment.apartment_area_use != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Tổng diện
    tích sử dụng: <span class="inputcontract" editspan="item.apartment.apartment_area_use"
                        ng-model="item.apartment.apartment_area_use" placeholder="..."
                        contenteditable="true"></span>;
</div>

<div ng-if="item.apartment.apartment_area_build.length > 0 && item.apartment.apartment_area_build != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Diện tích
    xây dựng: <span class="inputcontract" editspan="item.apartment.apartment_area_build"
                    ng-model="item.apartment.apartment_area_build" placeholder="..."
                    contenteditable="true"></span>;
</div>

<div ng-if="item.apartment.apartment_structure.length > 0 && item.apartment.apartment_structure != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Kết cấu
    nhà:<span class="inputcontract" editspan="item.apartment.apartment_structure"
              ng-model="item.apartment.apartment_structure" placeholder="..." contenteditable="true"></span>;
</div>

<div ng-if="item.apartment.apartment_total_floor.length > 0 && item.apartment.apartment_total_floor != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Số tầng
    nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor"
                        ng-model="item.apartment.apartment_total_floor" placeholder="..."
                        contenteditable="true"></span> tầng;
</div>

<div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">Căn hộ nêu
    trên là tài sản gắn liền với thửa đất sau:
</div>

<div ng-if="item.land.land_map_number.length > 0 && item.land.land_map_number != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Thửa đất
    số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number"
              placeholder="..." contenteditable="true"></span>, tờ bản đồ số: <span class="inputcontract"
                                                                                    editspan="item.land.land_map_number"
                                                                                    ng-model="item.land.land_map_number"
                                                                                    placeholder="..."
                                                                                    contenteditable="true"></span>;
</div>

<div ng-if="item.land.land_address.length > 0 && item.land.land_address != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Địa chỉ
    thửa đất: <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address"
                    placeholder="..." contenteditable="true"></span>;
</div>

<div ng-if="item.land.land_area_text.length > 0 && item.land.land_area_text != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Diện tích:
    <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area"
          placeholder="..." contenteditable="true"></span> m2 (bằng chữ: <span class="inputcontract"
                                                                               editspan="item.land.land_area_text"
                                                                               ng-model="item.land.land_area_text"
                                                                               placeholder="..."
                                                                               contenteditable="true"></span> mét
    vuông);
</div>

<div ng-if="(item.land.land_private_area.length > 0 && item.land.land_private_area != null) || (item.land.land_public_area.length > 0 && item.land.land_public_area != null)">
    <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Hình
        thức
        sử dụng:
    </div>

    <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
        <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;">
            <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size: 14pt;">
                + Sử dụng riêng: <span class="inputcontract" editspan="item.land.land_private_area"
                                       ng-model="item.land.land_private_area" placeholder="..."
                                       contenteditable="true"></span>;
            </div>
            <div style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size: 14pt;">
                + Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area"
                                       ng-model="item.land.land_public_area" placeholder=" ..."
                                       contenteditable="true"></span>;
            </div>
        </blockquote>
    </blockquote>
</div>

<div ng-if="item.land.land_use_purpose.length > 0 && item.land.land_use_purpose != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Mục đích
    sử dụng: <span class="inputcontract" editspan="item.land.land_use_purpose"
                   ng-model="item.land.land_use_purpose" placeholder="..."
                   contenteditable="true"></span> ;
</div>

<div ng-if="item.land.land_use_period.length > 0 && item.land.land_use_period != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size: 14pt;">- Thời hạn
    sử dụng:
    <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period"
          placeholder="..."
          contenteditable="true"></span>;
</div>

<div ng-if="item.land.land_use_origin.length > 0 && item.land.land_use_origin != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;">- Nguồn gốc
    sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin"
                   ng-model="item.land.land_use_origin" placeholder="..." contenteditable="true"></span>;
</div>

<div ng-if="item.restrict.length > 0 && item.restrict != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;"><font
        style="">- Hạn chế về quyền sử dụng đất: </font><span class="inputcontract" editspan="item.restrict"
                                                              ng-model="item.restrict" placeholder="..."
                                                              contenteditable="true"></span>;
</div>

<div ng-if="item.other_info.length > 0 && item.other_info != null"
     style="text-align: justify; margin: 0pt 0cm 6pt; text-indent: 1cm; line-height: 100%;font-size:14pt;"><font
        style="font-size: 14pt;">- Thông tin khác : </font><span class="inputcontract" editspan="item.other_info"
                                                                 ng-model="item.other_info" placeholder="..."
                                                                 contenteditable="true" style="font-size: 14pt;"></span>;
</div>