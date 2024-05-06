
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="modal fade" id="addPrivysDialog" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content" style="width:900px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <button class="btn btn-s-md btn-primary pull-left "  ng-click="addPrivy()"  type="button">Thêm bên liên quan</button>
            </div>
            <div class="modal-body">
                <div class="tree well" >
                    <ul>
                        <li ng-repeat="(itemIndex,item) in privys.privy track by $index">
                            <span class="spanText"><i class="icon-folder-open"></i> {{item.name}}</span>
                            <a class="btn btn-sm btn-primary " ng-click="addPerson($index)" ><i class="fa fa-plus"></i>Thêm cá nhân/tổ chức tham gia</a>
                            <a class="btn btn-sm btn-danger " ng-click="removePrivy($index)" ><i class="fa fa-trash-o"></i>Xóa</a>
                            <label ng-switch on="item.type" class="checkbox m-n i-checks pull-right">
                                <label ng-switch-when="0" class="checkbox m-n i-checks pull-right"><input style="width:20px;margin-top:0px;" checked  type="checkbox" ng-click="checkRemoveActionPrivy($event,$index)"><i></i>Bỏ hiển thị tên bên liên quan</label>
                                <label ng-switch-default class="checkbox m-n i-checks pull-right"><input style="width:20px;margin-top:0px;"   type="checkbox" ng-click="checkRemoveActionPrivy($event,$index)"><i></i>Bỏ hiển thị tên bên liên quan</label>
                            </label>
                            <ul>
                                <li ng-repeat="user in item.persons track by $index">
                                    <div class="treeChild">
                                        <div class="col-md-2" ng-click="showPerson(itemIndex,$index)">
                                            <a class="btn btn-success btn-sm"><i class="icon-folder-open"></i>
                                                <span ng-switch on="user.template">
                                                    <span ng-switch-when="1">
                                                        <span ng-switch on="user.name.length>0"><i class="icon-minus-sign"></i>
                                                            <span ng-switch-when=true>
                                                                {{user.name}}
                                                            </span>
                                                            <span ng-switch-default>
                                                                {{$index+1}}
                                                            </span>
                                                        </span>
                                                    </span>
                                                    <span ng-switch-when="2">
                                                        <span ng-switch on="user.org_name.length>0"><i class="icon-minus-sign"></i>
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

                                        <%--<div class="col-md-7 " >

                                            <select ng-model="user.template" class="form-control" ng-change="changTemplatePrivy(itemIndex,$index,user.template)" >
                                                <option value="" >---Chọn mẫu hiển thị---</option>
                                                <option ng-repeat="temp in templatePrivys"  value="{{temp.id}}">{{temp.name}}</option>
                                            </select>

                                        </div>--%>
                                        <%--tự động chọn đương sự khi load--%>
                                        <br/>
                                        <div class="col-md-7 " style="padding-top: 7px">

                                            <select ng-model="user.template" class="form-control" ng-change="changTemplatePrivy(itemIndex,$index,user.template)"

                                                    ng-options="temp.id as temp.name for temp in templatePrivys">
                                            </select>

                                        </div>

                                        <div class="col-md-3" style="padding-top: 7px">
                                            <%--<a id="button-duongsu{{$index}}" class="btn btn-sm btn-info" data-toggle="popover" data-html="true" data-placement="bottom" data-content="<div class='scrollable' style='height:40px'>Hãy chọn loại mẫu  hiển thị.</div>" title="" data-original-title='<button type="button" class="close pull-right" data-dismiss="popover">&times;</button>Chi tiết mẫu'>Xem mẫu</a>--%>
                                            <a class="btn btn-sm btn-danger " ng-click="removePerson(itemIndex,$index)" ><i class="fa fa-trash-o"></i>Xóa</a>
                                        </div>

                                        <div class="col-md-2">
                                        </div>
                                        <div class="col-md-12 panel-body " >

                                            <div ng-show="user.template==1 && user.myPerson" class="bs-example form-horizontal ng-pristine ng-valid">
                                                <h3><b>THÔNG TIN CÁ NHÂN</b></h3>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text" class="form-control name" ng-model="user.passport" placeholder="Nhập CMND/Hộ chiếu/CCCD để tìm kiếm"
                                                               id="name{{itemIndex}}-{{$index}}" ng-keypress="getsuggest(itemIndex,$index,user.template);" ng-paste="getsuggest(itemIndex,$index,user.template);"   />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <%--<label class="col-md-2 control-label  label-bam-trai">Họ và tên</label>--%>
                                                    <select class="col-md-2 control-label  label-bam-trai"
                                                        ng-options="option.name for option in dataSelectedSex.availableOptions track by option.id"
                                                        ng-model="user.sex">
                                                    </select>

                                                    <div class="col-md-4">
                                                        <input maxlength="200" type="text" ng-model="user.name" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Ngày sinh</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="user.birthday" class="form-control" id="userBirthday{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy CMND/Hộ chiếu/CCCD số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="user.passport" class="form-control">
                                                        <span class="truong-text-colorred"
                                                              id="CMT-{{itemIndex}}-{{$index}}" hidden>CMND/Hộ chiếu/CCCD không chứa ký tự đặc biệt</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Cấp ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="user.certification_date" class="form-control" id="userCertificationDate{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)" >
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Nơi cấp</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="user.certification_place" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mô tả</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="500" type="text"
                                                               ng-model="user.description"
                                                               class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                            <div ng-show="user.template==2 && user.myPerson" class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%-- <h3><b>THÔNG TIN CÔNG TY</b></h3>--%>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" class="form-control name" ng-model="user.org_code" placeholder="Nhập mã số thuế để tìm kiếm"
                                                               id="org_name{{itemIndex}}-{{$index}}" ng-keypress="getsuggest(itemIndex,$index,user.template);" ng-paste="getsuggest(itemIndex,$index,user.template);"   />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tên công ty </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200" type="text" ng-model="user.org_name" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Mã số thuế </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="user.org_code" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ công ty </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.org_address" class="form-control"
                                                                  rows="2"></textarea>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Đăng kí lần đầu ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="user.first_registed_date" class="form-control" id="userFirstRegistedDate{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Đăng kí thay đổi lần thứ </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="user.number_change_registed" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Ngày đăng kí thay đổi </label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="user.change_registed_date" class="form-control" id="userChangeRegistedDate{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Theo </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="user.department_issue" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Họ tên người đại diện </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200" type="text" ng-model="user.name" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Chức danh</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="user.position" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">CMND/Hộ chiếu/CCCD số </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="user.passport" class="form-control">
                                                        <span class="truong-text-colorred"
                                                              id="CMT-{{itemIndex}}-{{$index}}" hidden>CMND/Hộ chiếu/CCCD không chứa ký tự đặc biệt</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Ngày cấp</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="user.certification_date" class="form-control" id="userCertificationDateComp{{itemIndex}}-{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Nơi cấp </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="user.certification_place" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="user.address" class="form-control"
                                                                  rows="2"></textarea>

                                                    </div>
                                                </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label  label-bam-trai">Mô tả</label>
                                                        <div class="col-md-10">
                                                            <input maxlength="500" type="text"
                                                                   ng-model="user.description"
                                                                   class="form-control">
                                                        </div>
                                                    </div>

                                            </div>

                                            <div ng-show="user.template==3 && user.myPerson" class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%-- <h3><b>THÔNG TIN TỔ CHỨC TÍN DỤNG</b></h3>--%>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" class="form-control name" ng-model="user.org_code" placeholder="Nhập mã số doanh nghiệp để tìm kiếm"
                                                               id="credit_code{{itemIndex}}-{{$index}}" ng-keypress="getsuggest(itemIndex,$index,user.template);" ng-paste="getsuggest(itemIndex,$index,user.template);"   />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tên ngân hàng </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="user.org_name" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mã số doanh nghiệp </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="user.org_code" class="form-control">

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ trụ sở chính </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255" type="text" ng-model="user.org_address" class="form-control">

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Đơn vị trực tiếp quản lý khách hàng </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255" type="text" ng-model="user.customer_management_unit" class="form-control">

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255" type="text" ng-model="user.address" class="form-control">

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Điện thoại </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="user.phone" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Fax</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="user.fax" class="form-control">
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng nhận đăng ký hoạt động Chi nhánh/Phòng giao dịch </label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="user.registration_certificate" class="form-control">

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Họ tên người đại diện </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200" type="text" ng-model="user.name" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Chức vụ</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="255" type="text" ng-model="user.position" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Văn bản ủy quyền </label>
                                                    <div class="col-md-10">
                                                        <input type="text" ng-model="user.authorization_document" class="form-control">

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
                <button type="button" class="btn btn-success" data-dismiss="modal" >Đóng</button>
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
                <a class="btn btn-s-md btn-primary pull-left "  ng-click="addProperty()"  type="button"><i class="fa fa-plus"></i>Thêm tài sản</a>
            </div>
            <div class="modal-body">
                <div class="tree well" >
                    <ul>
                        <li >
                            <a >DANH SÁCH TÀI SẢN</a>
                            <ul>
                                <li ng-repeat="item in listProperty.properties track by $index">
                                    <div class="treeChild">
                                        <div class="col-md-2" ng-click="showProperty($index)">
                                            <a class="btn btn-success btn-sm"><i class="icon-folder-open"></i> Tài sản {{$index+1}}: </a>
                                        </div>

                                        <div class="col-md-7 " style="margin-bottom:10px;">
                                            <select name="type" ng-model="item.type" class="form-control" ng-change="changeTypeProperty($index,item.type)">
                                                <option value="">--Chọn--</option>
                                                <option value="01" selected>Nhà đất</option>
                                                <option value="02">Phương tiện vận tải</option>
                                                <option value="99">Tài sản khác</option>
                                            </select>
                                        </div>
                                        <%--<div class="col-md-7 col-md-offset-2">
                                            <select  ng-model="item.template" class="form-control" ng-change="changTemplateProperty($index,item.template)" >
                                                <option value="">---Chọn mẫu hiển thị---</option>
                                                <option ng-repeat="item in getList($index)"  value="{{item.id}}">{{item.name}}</option>
                                            </select>
                                        </div>--%>
                                        <%--tự động chọn property khi load--%>
                                        <div class="col-md-7 col-md-offset-2" style="margin-bottom:10px;">
                                            <select  ng-model="item.template" class="form-control" ng-change="changTemplateProperty($index,item.template)"
                                                     ng-options="temp1.id as temp1.name for temp1 in getList($index)">

                                            </select>
                                        </div>

                                        <div class="col-md-7 col-md-offset-2" ng-show="item.type=='01'" style="margin-bottom:10px;">
                                            <select name="type" ng-model="item.type_real_estate"
                                                    class="form-control truong-selectbox-padding"
                                                    ng-change="changePropertyRealEstate($index,item.type_real_estate)"
                                                    ng-init="changePropertyRealEstate($index,item.type_real_estate)">
                                                <option ng-repeat="item in property_real_estate_type"
                                                        value="{{item.code}}">{{item.name}}
                                                </option>
                                            </select>

                                        </div>

                                        <div class="col-md-7 col-md-offset-2" ng-show="item.type=='01' && getListRealEstateTypeSubByIndex($index).length>0">
                                            <select name="type" ng-model="item.type_real_estate_sub"
                                                    class="form-control truong-selectbox-padding"
                                            <%--ng-init="getListRealEstateTypeSubByIndex($index)"--%>>
                                                <option ng-repeat="item in getListRealEstateTypeSubByIndex($index)"
                                                        value="{{item.code}}">{{item.name}}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="col-md-3">
                                            <%--<a id="button-taisan{{$index}}" class="btn btn-sm btn-info" data-toggle="popover" data-html="true" data-placement="bottom" data-content="<div class='scrollable' style='height:40px'>Hãy chọn loại mẫu tài sản hiển thị.</div>" title="" data-original-title='<button type="button" class="close pull-right" data-dismiss="popover">&times;</button>Chi tiết mẫu tài sản'>Xem mẫu</a>--%>
                                            <a class="btn btn-sm  btn-danger deleteTree" ng-click="removeProperty($index)" ><i class="fa fa-trash-o"></i>Xóa </a>
                                        </div>

                                        <div class="col-md-12 panel-body " ng-show="item.type=='01' && item.template=='8' && item.myProperty" >

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%--<h3><b>THÔNG TIN CHUNG CƯ</b></h3>--%>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text" class="form-control name autocomplete_land_certificate{{$index}}" ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}"   placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);" ng-paste="getsuggestproperty($index,item.type);"  />
                                                        <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate_number_input" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_issue_place" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_issue_date" class="form-control" id="landIssueDate{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.apartment.apartment_address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Căn hộ số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.apartment.apartment_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tầng </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.apartment.apartment_floor" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tổng diện tích sử dụng</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200"  type="text" ng-model="item.apartment.apartment_area_use" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích xây dựng</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200"  type="text" ng-model="item.apartment.apartment_area_build" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Kết cấu nhà </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.apartment.apartment_structure" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Số tầng nhà chung cư</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.apartment.apartment_total_floor" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_map_number" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.land.land_address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_area" ng-change="changelandAreaValue({{$index}},item.land.land_area)" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng chữ </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="255" type="text" ng-model="item.land.land_area_text" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng riêng</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_private_area" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng chung</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_public_area" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_purpose" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_period" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input  maxlength="200" type="text" ng-model="item.land.land_use_origin" class="form-control">
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.restrict" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info" class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <%--chú thích bắt đầu tài sản nhà đất --%>



                                        <div class="col-md-12 panel-body " ng-show="item.type=='01' && item.template=='1' && item.myProperty" >

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%--<h3><b>THÔNG TIN TÀI SẢN ĐẤT</b></h3>--%>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text" class="form-control name autocomplete_land_certificate{{$index}}" ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}" placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"  />
                                                        <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate_number_input" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_issue_place" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_issue_date" class="form-control" id="landIssueDate2{{$index}}" onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_map_number" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.land.land_address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_area" ng-change="changelandAreaValue({{$index}},item.land.land_area)" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng chữ </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="255" type="text" ng-model="item.land.land_area_text" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng riêng</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_private_area" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng chung</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_public_area" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_purpose" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_period" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200"  type="text" ng-model="item.land.land_use_origin" class="form-control">
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.restrict" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn liền với đất </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.land.land_associate_property" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.owner_info" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info" class="form-control">
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <%-- chú thích bắt đầu đất, nhà ở gắn liền với đất --%>

                                        <div class="col-md-12 panel-body " ng-show="item.type=='01' && item.template=='10' && item.myProperty" >

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%--<h3><b>THÔNG TIN TÀI SẢN ĐẤT , NHÀ Ở GẮN LIỀN VỚI ĐẤT</b></h3>--%>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text" class="form-control name autocomplete_land_certificate{{$index}}" ng-model="item.land.land_certificate"
                                                               id="land_certificate{{$index}}" placeholder="Nhập số giấy chứng nhận để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);"
                                                               ng-paste="getsuggestproperty($index,item.type);"  />
                                                        <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Vào sổ cấp giấy chứng nhận số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_certificate_number_input" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Do</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_issue_place" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Cấp ngày</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_issue_date" class="form-control" id="landIssueDate3{{$index}}"
                                                               onkeypress="return restrictCharacters(this, event, forDate)">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thửa đất số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Tờ bản đồ số</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.land.land_map_number" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Địa chỉ thửa đất </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="200" cols="3" ng-model="item.land.land_address" class="form-control"
                                                                  rows="2"></textarea>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.land.land_area" ng-change="changelandAreaValue({{$index}},item.land.land_area)" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Diện tích bằng chữ </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="255" type="text" ng-model="item.land.land_area_text" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Sử dụng riêng</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_private_area" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Sử dụng chung</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="20" type="text" ng-model="item.land.land_public_area" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Mục đích sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_purpose" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thời hạn sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="100" type="text" ng-model="item.land.land_use_period" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Nguồn gốc sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input  maxlength="200" type="text" ng-model="item.land.land_use_origin" class="form-control">
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hạn chế và quyền sử dụng đất</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.restrict" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tài sản gắn liền với đất </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.land.land_associate_property" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.owner_info" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Loại nhà ở</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255" type="text" ng-model="item.land.land_type" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích xây dựng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.land.construction_area" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Diện tích sàn</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255"  type="text" ng-model="item.land.building_area" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Hình thức sử dụng</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255"  type="text" ng-model="item.land.land_use_type" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Cấp (hạng) nhà ở</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="255"  type="text" ng-model="item.land.land_sort" class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                        <%-- chú thích bắt đầu ô-to xe máy--%>
                                        <div class="col-md-12 panel-body " ng-show="item.type=='02' && item.template=='6' && item.myProperty" >

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%-- <h3><b>THÔNG TIN TÀI SẢN Ô TÔ XE MÁY</b></h3>--%>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Tìm kiếm</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="50" type="text" class="form-control name autocomplete_car_frame_number{{$index}}" ng-model="item.vehicle.car_frame_number"
                                                               id="car_frame_number{{$index}}" placeholder="Nhập số khung để tìm kiếm"
                                                               ng-keypress="getsuggestproperty($index,item.type);" ng-paste=""  />
                                                        <span class="truong-warning-text" ng-show="item.land.land_street == '1'">Tài sản này đang được cảnh bảo từ thông tin ngăn chặn trên cơ sở dữ liệu của Sở</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Biển kiếm soát </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.vehicle.car_license_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Số giấy đăng ký </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="100" type="text" ng-model="item.vehicle.car_regist_number" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Ngày cấp</label>
                                                    <div class="col-md-4">
                                                        <input type="text" ng-model="item.vehicle.car_issue_date" class="form-control" id ="carIssueDate{{$index}}"
                                                               onkeypress="return restrictCharacters(this, event, forDate);">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phai">Nơi cấp </label>
                                                    <div class="col-md-4">
                                                        <input maxlength="200-" type="text" ng-model="item.vehicle.car_issue_place" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Số khung</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.vehicle.car_frame_number" class="form-control">
                                                    </div>
                                                    <label class="col-md-2 control-label  label-bam-phải">Số máy</label>
                                                    <div class="col-md-4">
                                                        <input maxlength="50" type="text" ng-model="item.vehicle.car_machine_number" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ sở hữu</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.owner_info" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin khác</label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.other_info" class="form-control">
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
                                                        <input maxlength="200" type="text"
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
                                        <div class="col-md-12 panel-body " ng-show="item.type=='99' && item.template=='3' && item.myProperty" >

                                            <div class="bs-example form-horizontal ng-pristine ng-valid">
                                                <%--<h3><b>THÔNG TIN TÀI SẢN KHÁC</b></h3>--%>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin tài sản </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="1000" type="text" ng-model="item.property_info" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin chủ sở hữu </label>
                                                    <div class="col-md-10">
                                                        <input maxlength="200" type="text" ng-model="item.owner_info" class="form-control">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label  label-bam-trai">Thông tin khác </label>
                                                    <div class="col-md-10">
                                                        <textarea maxlength="1000" cols="3" ng-model="item.other_info" class="form-control"
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
                <button type="button" class="btn btn-success" data-dismiss="modal" >Đóng</button>
            </div>
        </div>

    </div>
</div>