<%--
  Created by IntelliJ IDEA.
  User: DaiCQ
  Date: 9/5/2020
  Time: 5:15 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="panel panel-default">
    <header class="panel-heading font-bold" style="margin-bottom: 20px;">
        <h4 class="panel-title">Thông tin tài sản</h4>
        <%--<div class="pull-right" style="margin-top:-25px"><button class="btn btn-s-md btn-primary " ng-click="addProperty()"  type="button">Thêm bên tài sản</button></div>--%>
        <%--<div class="pull-right" style="margin:-18px -25px 0px 0px;">
            <a data-toggle="tooltip" title="Thêm tài sản" style="background-image:none;"><i
                    class="fa fa-plus" ng-click="addProperty()"
                    style="font-size:20px;color:#65bd77;margin-right:15px;"></i></a>
        </div>--%>
    </header>
    <div class="panel-body">
        <section class="panel panel-default" ng-repeat="item in listProperty.properties track by $index">
            <header class="panel-heading font-bold">
                <label class=" control-label  label-bam-trai" style="color:#2a2aff">Tài sản
                    {{$index+1}}</label>
            </header>
            <div class="panel-body">
                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                    <label class="col-md-2 control-label  label-bam-trai">Loại tài sản</label>
                    <div class="col-md-4">
                        <select name="type" ng-model="item.type"
                                class="form-control truong-selectbox-padding"
                                ng-change="changeTypeProperty($index,item.type)"
                                ng-init="changeTypeProperty($index,item.type)"
                                disabled>
                            <option value="01">Nhà đất</option>
                            <option value="02">Ôtô-xe máy</option>
                            <option value="99">Tài sản khác</option>
                        </select>
                    </div>
                    <span class="input-group-btn ">
                                        <button class="btn btn-primary btn-sm" style="margin-left:10px;"
                                                ng-click="showDetails= !showDetails" type="button">
                                            <div ng-switch on="showDetails">
                                                <div ng-switch-when=true>
                                                    <a style="color:white;">Thông tin đơn giản</a>
                                                </div>
                                                <div ng-switch-default>
                                                    <a style="color:white;">Thông tin chi tiết</a>
                                                </div>
                                            </div>
                                        </button>
                                </span>

                </div>

                <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                    <label class="col-md-2 control-label  label-bam-trai"></label>
                    <div class="col-md-4">
                        <select ng-model="item.template" class="form-control"
                                ng-change="changTemplateProperty($index,item.template)"
                                ng-options="temp1.id as temp1.name for temp1 in getList($index)" disabled>

                        </select>

                    </div>

                </div>

                <div class="form-group" style="padding-right: 20px;padding-left: 20px" ng-show="item.type=='01'">
                    <label class="col-md-2 control-label  label-bam-trai"></label>
                    <div class="col-md-4">
                        <select name="type" ng-model="item.type_real_estate"
                                class="form-control truong-selectbox-padding"
                                ng-init="changePropertyRealEstate($index,item.type_real_estate)" disabled>
                            <option ng-repeat="item in property_real_estate_type" value="{{item.code}}">{{item.name}}</option>
                        </select>
                    </div>

                </div>

                <div class="form-group" style="padding-right: 20px;padding-left: 20px" ng-show="item.type=='01' && getListRealEstateTypeSubByIndex($index).length>0">
                    <label class="col-md-2 control-label  label-bam-trai"></label>
                    <div class="col-md-4" ng-show="getListRealEstateTypeSubByIndex($index).length>0">
                        <select name="type" ng-model="item.type_real_estate_sub"
                                class="form-control truong-selectbox-padding"
                        <%--ng-init="getListRealEstateTypeSubByIndex($index)"--%> disabled>
                            <option ng-repeat="item in getListRealEstateTypeSubByIndex($index)" value="{{item.code}}">{{item.name}}</option>
                        </select>
                    </div>

                </div>

                <div ng-show="!showDetails">
                    <div class="form-group" style="padding-right: 20px;padding-left: 20px">
                        <label class="col-sm-2 control-label label-bam-trai">Thông tin tài sản</label>
                        <div class="col-sm-10">
                                            <textarea maxlength="1000" class="form-control" rows="5" name="propertyInfo"
                                                      ng-model="item.property_info" disabled="true"></textarea>
                        </div>
                    </div>
                </div>

                <div ng-show="showDetails">

                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='01' && item.template=='8' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%--<h3><b>THÔNG TIN CHUNG CƯ</b></h3>--%>
                           <%-- <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-sm-10">
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

                            </div>--%>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                    nhận số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng
                                    nhận số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate_number_input"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                <div class="col-sm-4">
                                    <input maxlength="100" type="text"
                                           ng-model="item.land.land_issue_place"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Cấp
                                    ngày</label>
                                <div class="col-sm-4">
                                    <input type="text" ng-model="item.land.land_issue_date"
                                           class="form-control" id="landIssueDate{{$index}}"
                                           onkeypress="return restrictCharacters(this, event, forDate)" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Địa
                                    chỉ </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.apartment.apartment_address"
                                                                  class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Căn hộ
                                    số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.apartment.apartment_number"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-trai">Tầng </label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.apartment.apartment_floor"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tổng diện tích
                                    sử dụng</label>
                                <div class="col-sm-4">
                                    <input maxlength="200"  type="text" ng-model="item.apartment.apartment_area_use"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Diện tích xây
                                    dựng</label>
                                <div class="col-sm-4">
                                    <input type="text"
                                           ng-model="item.apartment.apartment_area_build"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Kết cấu
                                    nhà </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.apartment.apartment_structure"
                                                                  class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Số tầng nhà
                                    chung cư</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.apartment.apartment_total_floor"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                    số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_number" class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                    số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_map_number"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                    đất </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Diện
                                    tích</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_area"
                                           ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                    chữ </label>
                                <div class="col-sm-4">
                                    <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                    riêng</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                    chung</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="200"  type="text" ng-model="item.land.land_use_origin"
                                           class="form-control" disabled>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                    quyền sử dụng đất</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.restrict"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%--chú thích bắt đầu tài sản nhà đất --%>
                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='01' && item.template=='1' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%--<h3><b>THÔNG TIN TÀI SẢN ĐẤT</b></h3>--%>
                            <%--<div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-md-10">
                                    <input maxlength="50" type="text"
                                           class="form-control name autocomplete_land_certificate{{$index}}"
                                           ng-model="item.land.land_certificate"
                                           id="land_certificate{{$index}}"
                                           placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                           ng-keypress="getsuggestproperty($index,item.type);"
                                           ng-paste="getsuggestproperty($index,item.type);"
                                           disabled/>
                                    <span class="truong-warning-text"
                                          ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                </div>
                            </div>--%>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                    nhận số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng
                                    nhận số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate_number_input"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                <div class="col-sm-4">
                                    <input maxlength="100" type="text"
                                           ng-model="item.land.land_issue_place"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Cấp
                                    ngày</label>
                                <div class="col-sm-4">
                                    <input type="text" ng-model="item.land.land_issue_date"
                                           class="form-control" id="landIssueDate2{{$index}}"
                                           onkeypress="return restrictCharacters(this, event, forDate)"
                                           disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                    số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_number" class="form-control"
                                           disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                    số</label>
                                <div class="col-sm-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_map_number"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                    đất </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Diện
                                    tích</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_area"
                                           ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                    chữ </label>
                                <div class="col-sm-4">
                                    <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                    riêng</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                    chung</label>
                                <div class="col-sm-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input  maxlength="200" type="text" ng-model="item.land.land_use_origin"
                                           class="form-control" disabled>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                    quyền sử dụng đất</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.restrict"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                    liền với đất </label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text"
                                           ng-model="item.land.land_associate_property"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                    sở hữu</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.owner_info"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>


                        </div>
                    </div>
                    <%-- chú thích bắt đầu đất, nhà ở gắn liền với đất --%>

                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='01' && item.template=='10' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%--<h3><b>THÔNG TIN TÀI SẢN ĐẤT , NHÀ Ở GẮN LIỀN VỚI ĐẤT</b></h3>--%>
                            <%--<div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-md-10">
                                    <input maxlength="50" type="text"
                                           class="form-control name autocomplete_land_certificate{{$index}}"
                                           ng-model="item.land.land_certificate"
                                           id="land_certificate{{$index}}"
                                           placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                           ng-keypress="getsuggestproperty($index,item.type);"
                                           ng-paste="getsuggestproperty($index,item.type);"
                                           disabled/>
                                    <span class="truong-warning-text"
                                          ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                </div>
                            </div>--%>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Giấy chứng
                                nhận số</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng
                                    nhận số</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_certificate_number_input"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                <div class="col-md-4">
                                    <input maxlength="100" type="text"
                                           ng-model="item.land.land_issue_place"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Cấp
                                    ngày</label>
                                <div class="col-md-4">
                                    <input type="text" ng-model="item.land.land_issue_date"
                                           class="form-control" id="landIssueDate3{{$index}}"
                                           onkeypress="return restrictCharacters(this, event, forDate)"
                                           disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thửa đất
                                    số</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_number" class="form-control"
                                           disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ
                                    số</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.land.land_map_number"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa
                                    đất </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3"
                                                                  ng-model="item.land.land_address" class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Diện
                                    tích</label>
                                <div class="col-md-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_area"
                                           ng-change="changelandAreaValue({{$index}},item.land.land_area)"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng
                                    chữ </label>
                                <div class="col-md-4">
                                    <input maxlength="255" type="text" ng-model="item.land.land_area_text"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Sử dụng
                                    riêng</label>
                                <div class="col-md-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_private_area"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Sử dụng
                                    chung</label>
                                <div class="col-md-4">
                                    <input maxlength="20" type="text" ng-model="item.land.land_public_area"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Mục đích sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_purpose"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thời hạn sở
                                    hữu</label>
                                <div class="col-md-10">
                                    <input maxlength="100" type="text" ng-model="item.land.land_use_period"
                                           class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input  maxlength="200" type="text" ng-model="item.land.land_use_origin"
                                           class="form-control" disabled>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Hạn chế và
                                    quyền sử dụng đất</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.restrict"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn
                                    liền với đất </label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text"
                                           ng-model="item.land.land_associate_property"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                    sở hữu</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.owner_info"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Loại nhà
                                    ở</label>
                                <div class="col-md-10">
                                    <input maxlength="255" type="text" ng-model="item.land.land_type"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Diện tích xây
                                    dựng</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.land.construction_area"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Diện tích
                                    sàn</label>
                                <div class="col-md-10">
                                    <input maxlength="255"  type="text" ng-model="item.land.building_area"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Hình thức sử
                                    dụng</label>
                                <div class="col-md-10">
                                    <input maxlength="255"  type="text" ng-model="item.land.land_use_type"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Cấp (hạng) nhà
                                    ở</label>
                                <div class="col-md-10">
                                    <input  maxlength="255" type="text" ng-model="item.land.land_sort"
                                           class="form-control" disabled>
                                </div>
                            </div>

                        </div>
                    </div>

                    <%-- chú thích bắt đầu ô-to xe máy--%>
                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='02' && item.template=='6' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%-- <h3><b>THÔNG TIN TÀI SẢN Ô TÔ XE MÁY</b></h3>--%>
                            <%--<div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-md-10">
                                    <input maxlength="50" type="text"
                                           class="form-control name autocomplete_car_frame_number{{$index}}"
                                           ng-model="item.vehicle.car_frame_number"
                                           id="car_frame_number{{$index}}"
                                           placeholder="Nhập số khung để tìm kiếm"
                                           ng-keypress="getsuggestproperty($index,item.type);"
                                           ng-paste="" disabled/>
                                    <span class="truong-warning-text"
                                          ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                </div>
                            </div>--%>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Biển kiếm
                                    soát </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle.car_license_number"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Số giấy đăng
                                    ký </label>
                                <div class="col-md-4">
                                    <input maxlength="100" type="text"
                                           ng-model="item.vehicle.car_regist_number"
                                           class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Ngày
                                    cấp</label>
                                <div class="col-md-4">
                                    <input type="text" ng-model="item.vehicle.car_issue_date"
                                           class="form-control" id="carIssueDate{{$index}}" onkeypress="return restrictCharacters(this, event, forDate);"
                                           disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Nơi
                                    cấp </label>
                                <div class="col-md-4">
                                    <input type="text" ng-model="item.vehicle.car_issue_place"
                                           class="form-control"
                                           disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Số
                                    khung</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle.car_frame_number"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phải">Số máy</label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle.car_machine_number"
                                           class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                    sở hữu</label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.owner_info"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>


                        </div>
                    </div>

                    <%-- chú thích bắt đầu tài sản phương tiện tàu bay--%>
                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='02' && item.template=='11' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%-- <h3><b>THÔNG TIN TÀI SẢN TÀU BAY</b></h3>--%>
                            <%--<div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-md-10">
                                    <input maxlength="50" type="text"
                                           class="form-control name autocomplete_car_frame_number{{$index}}"
                                           ng-model="item.vehicle_airplane.airplane_engine_number"
                                           id="airplane_engine_number{{$index}}"
                                           placeholder="Nhập số động cơ để tìm kiếm"
                                           ng-keypress="getsuggestproperty($index,item.type);"
                                           ng-paste="" disabled/>
                                    <span class="truong-warning-text"
                                          ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                </div>
                            </div>--%>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tên phương
                                    tiện</label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_name"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phải">Số giấy đăng
                                    ký</label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_regist_number"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Kiểu loại </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_type"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phải">Số động cơ </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_engine_number"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Trọng lượng tối đa cho
                                    phép </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_max_weight"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phải">Tên nhà sản xuất và
                                    quốc gia sản xuất </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_producer"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Năm sản xuất </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_year_manufacture"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phải">Số xuất xưởng của nhà
                                    sản xuất </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_airplane.airplane_factory_number"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Số hiệu đăng ký tại
                                    Việt Nam</label>
                                <div class="col-md-10">
                                    <input maxlength="500" type="text"
                                           ng-model="item.vehicle_airplane.airplane_regist_number_vietnam"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>


                        </div>
                    </div>

                    <%-- chú thích bắt đầu tài sản phương tiện thủy nội địa--%>
                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='02' && item.template=='12' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%-- <h3><b>THÔNG TIN TÀI SẢN PHƯƠNG TIỆN THỦY NỘI ĐỊA</b></h3>--%>
                            <%--<div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tìm
                                    kiếm</label>
                                <div class="col-md-10">
                                    <input maxlength="50" type="text"
                                           class="form-control name autocomplete_car_frame_number{{$index}}"
                                           ng-model="item.vehicle_ship.ship_regist_number"
                                           id="airplane_engine_number{{$index}}"
                                           placeholder="Nhập số giấy đăng ký để tìm kiếm"
                                           ng-keypress="getsuggestproperty($index,item.type);"
                                           ng-paste=""/>
                                    <span class="truong-warning-text"
                                          ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                </div>
                            </div>--%>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Tên phương
                                    tiện</label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_name"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Số giấy đăng
                                    ký</label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_regist_number"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Chủ phương tiện </label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.owner_info"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Địa chỉ chủ phương tiện </label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.owner_info_address"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Cấp phương tiện </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_level"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Công dụng </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_function"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Năm và nơi đóng </label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_year_place_construction"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Chiều dài thiết kế </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_design_length"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Chiều dài lớn nhất </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_max_length"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Chiều rộng thiết kế </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_design_height"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Chiều rộng lớn nhất </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_max_height"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Chiều cao mạn </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_width"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Chiều chìm </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_dimension_sinking"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Mạn khô </label>
                                <div class="col-md-4">
                                    <input maxlength="50" type="text"
                                           ng-model="item.vehicle_ship.ship_freeboard"
                                           class="form-control" disabled>
                                </div>
                                <label class="col-md-2 control-label  label-bam-phai">Vật liệu vỏ </label>
                                <div class="col-md-4">
                                    <input maxlength="200" type="text"
                                           ng-model="item.vehicle_ship.ship_hull_material"
                                           class="form-control" disabled>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác</label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text" ng-model="item.other_info"
                                           class="form-control" disabled>
                                </div>
                            </div>


                        </div>
                    </div>

                    <%--chú thích bắt đầu tài sản khác --%>
                    <div class="col-md-12 panel-body "
                         ng-show="item.type=='99' && item.template=='3' && item.myProperty">

                        <div class="bs-example form-horizontal ng-pristine ng-valid">
                            <%--<h3><b>THÔNG TIN TÀI SẢN KHÁC</b></h3>--%>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin tài
                                    sản </label>
                                <div class="col-md-10">
                                    <input maxlength="1000" type="text"
                                           ng-model="item.property_info" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ
                                    sở hữu </label>
                                <div class="col-md-10">
                                    <input maxlength="200" type="text" ng-model="item.owner_info"
                                           class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label  label-bam-trai">Thông tin
                                    khác </label>
                                <div class="col-md-10">
                                                        <textarea maxlength="1000" cols="3" ng-model="item.other_info"
                                                                  class="form-control"
                                                                  rows="2" disabled></textarea>
                                </div>
                            </div>


                        </div>
                    </div>

                </div>

            </div>
        </section>
    </div>
</div>
