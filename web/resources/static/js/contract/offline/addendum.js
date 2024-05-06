/**
 * Created by TienManh on 7/12/2017.
 */

// var myApp = angular.module('osp', ["xeditable","ngSanitize"]);
myApp.run(function (editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
myApp.controller('contractEditController', ['$scope', '$http', '$filter', '$sce', '$window', '$q', '$timeout', 'fileUpload', function ($scope, $http, $filter, $sce, $window, $q, $timeout, fileUpload) {
    $scope.checkOnline = false;
    if (from != null && from == "1") {
        $scope.checkOnline = true;
    }

    $scope.privys = {};
    $scope.listProperty = {};
    $scope.temporary = {
        tcid: "",
        type: "0",
        contract_template_id: "",
        contract_number: "",
        contract_value: "",
        relation_object_a: "",
        relation_object_b: "",
        relation_object_c: "",
        notary_id: "",
        drafter_id: "",
        received_date: "",
        notary_date: "",
        user_require_contract: "",
        property_type: "",
        property_info: "",
        owner_info: "",
        other_info: "",
        land_certificate: "",
        land_issue_place: "",
        land_issue_date: "",
        land_map_number: "",
        land_number: "",
        land_address: "",
        land_area: "",
        land_public_area: "",
        land_private_area: "",
        land_use_purpose: "",
        land_use_period: "",
        land_use_origin: "",
        land_associate_property: "",
        land_street: "",
        land_district: "",
        land_province: "",
        land_full_of_area: "",
        car_license_number: "",
        car_regist_number: "",
        car_issue_place: "",
        car_issue_date: "",
        car_frame_number: "",
        car_machine_number: "",
        number_copy_of_contract: "",
        number_of_sheet: "",
        number_of_page: "",
        cost_tt91: "",
        cost_draft: "",
        cost_notary_outsite: "",
        cost_other_determine: "",
        cost_total: "",
        notary_place_flag: "",
        notary_place: "",
        bank_id: "",
        bank_service_fee: "",
        crediter_name: "",
        file_name: "",
        file_path: "",
        original_store_place: "",
        note: "",
        summary: "",
        entry_user_id: "",
        entry_user_name: "",
        entry_date_time: "",
        update_user_id: "",
        update_user_name: "",
        update_date_time: "",
        jsonstring: "",
        kindhtml: "",
        json_property: "",
        json_person: "",
        bank_code: "",
        sub_template_id: "",
        contract_signer: "",
        request_recipient: ""
    };
    $scope.announcement = {notaryFee: ""};
    $scope.myFile = {file: ""};

    //Bổ sung các loại tài sản thuộc bất động sản
    $scope.property_real_estate_type = [];
    $scope.property_real_estate_type_sub = [];
    $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: 0}})
        .then(function (response) {

            $scope.property_real_estate_type = response.data;
        });

    $scope.changePropertyRealEstate = function(index, parent_code){
        if(isNullOrEmpty(parent_code)) parent_code = 1;
        $scope.listProperty.properties[index].type_real_estate = String(parent_code);
        $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: parent_code}})
            .then(function (response) {
                $scope["property_real_estate_type_sub" + index] = response.data;
                if($scope["property_real_estate_type_sub" + index] != null && $scope["property_real_estate_type_sub" + index].length>0){
                    $scope.listProperty.properties[index].type_real_estate_sub = String($scope["property_real_estate_type_sub" + index][0].code);
                }
            });
    };

    $scope.getListRealEstateTypeSubByIndex = function(index){
        return $scope["property_real_estate_type_sub" + index];
    };
    //END Bổ sung các loại tài sản thuộc bất động sản
    /*danh sách sổ công chứng*/
    $http.get(url + "/notaryBook/listSattusNotarybook",{
        params: {
            type: typeHD
        }
    })
        .then(function (response) {
            $scope.notaryBook = response.data;
        });
    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
            $http.get(url + "/contract/get-contract-kind-by-contract-template-code", {params: {code: template_id}})
                .then(function (response) {
                    $scope.contractKind = response.data;
                });
        });

    $scope.myFunc = function (code) {
        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: code}})
            .then(function (response) {
                $scope.contractTemplates = response.data;
                $scope.contractTemplatesApiece = "";
            });
    };


    $http.get(url + "/contract/list-contract-template-same-kind", {params: {code_temp: template_id}})
        .then(function (response) {
            $scope.contractTemplates = response.data;
        });

    // $http.get(url+"/contract/get-contract-template-by-code-template", {params: { code_temp: template_id }})
    //     .then(function(response) {
    //         $scope.template=response.data;
    //
    //         $(function () {
    //             $('#periodDate').datepicker({
    //                 format: "dd/mm/yyyy",
    //                 startDate: "01/01/1900",
    //                 endDate: endDate,
    //                 language: 'vi'
    //             }).on('changeDate', function (ev) {
    //                 $(this).datepicker('hide');
    //             });
    //             $('#mortageCancelDate').datepicker({
    //                 format: "dd/mm/yyyy",
    //                 startDate: "01/01/1900",
    //                 endDate: endDate,
    //                 language: 'vi'
    //             }).on('changeDate', function (ev) {
    //                 $(this).datepicker('hide');
    //             });
    //         });
    //
    //     });

    //DaiCQ added 19/05/2020 đồng bộ trường tài sản offline và online

    /*load template duong su+tai san*/
    /*$http.get(url + "/ContractTemplate/privy-template")
        .then(function (response) {
            $scope.templatePrivys = response.data;
            $scope.formatDuongSu();
            $scope.formatDuongSuBenA();
            $scope.formatDuongSuBenB();
            return response;
        });*/
    $http.get(url + "/ContractTemplate/property-template")
        .then(function (response) {
            $scope.templateProperties = response.data;
            /*$scope.formatTaiSan();*/
            return response;
        });

    $scope.getList = function (index) {
        return $scope["listTypeTaiSan" + index];
    };
    /*$scope.changeTypeProperty = function (index, type) {
        $scope.listProperty.properties[index].type = type;
        var object = $filter('filter')($scope.templateProperties, {type: type}, true);
        $scope["listTypeTaiSan" + index] = object;
        $scope.changTemplateProperty(index,'');

        if(type!='01'){
            $scope.listProperty.properties[index].type_real_estate = "";
            $scope.listProperty.properties[index].type_real_estate_sub = "";
        }
    };*/

    $scope.changTemplateProperty = function (index, template) {
        if(isNullOrEmpty(template)){
            template = $scope.getList(index)[0].id;
        }
        $scope.listProperty.properties[index].apartment = {};
        $scope.listProperty.properties[index].land = {};
        $scope.listProperty.properties[index].vehicle = {};
        $scope.listProperty.properties[index].vehicle_airplane = {};
        $scope.listProperty.properties[index].vehicle_ship = {};

        $scope.listProperty.properties[index].template = template;
        $scope.listProperty.properties[index].myProperty = true;
        template = parseInt(template);
        var object = $filter('filter')($scope.templateProperties, {id: template}, true);
        if (object != null && object != 'undefined' && object != '') {
            object = object[0];
            var id = "#button-taisan" + index;
            $(id).attr("data-content", object.html);
        }
        var landIssueDate = "#landIssueDate" + index;
        $(landIssueDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        var landIssueDate2 = "#landIssueDate2" + index;
        $(landIssueDate2).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        var landIssueDate3 = "#landIssueDate3" + index;
        $(landIssueDate3).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        var carIssueDate = "#carIssueDate" + index;
        $(carIssueDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
    };

    /*$scope.changeTypeProperty = function (index, type) {
        /!*05/09/2020 đồng bộ cấu trúc tài sản offline online*!/
        if(typeof $scope.templateProperties == 'undefined'||$scope.templateProperties==null){
            $http.get(url + "/ContractTemplate/property-template")
                .then(function (response) {
                    $scope.templateProperties = response.data;
                    /!*$scope.formatTaiSan();*!/
                    $scope.listProperty.properties[index].type = type;
                    var object = $filter('filter')($scope.templateProperties, {type: type}, true);
                    $scope["listTypeTaiSan" + index] = object;
                    $scope.changTemplateProperty(index,'');
                    // return response;
                });
        }
        else{
            $scope.listProperty.properties[index].type = type;
            var object = $filter('filter')($scope.templateProperties, {type: type}, true);
            $scope["listTypeTaiSan" + index] = object;
            $scope.changTemplateProperty(index,'');
        }

    };*/
    $scope.changeTypeProperty = function (index, type) {
        $scope.listProperty.properties[index].type = type;
        var object = $filter('filter')($scope.templateProperties, {type: type}, true);
        $scope["listTypeTaiSan" + index] = object;
        $scope.changTemplateProperty(index,'');

        /*if(type!='01'){
            $scope.listProperty.properties[index].type_real_estate = "";
            $scope.listProperty.properties[index].type_real_estate_sub = "";
        }*/
    };

    //END DaiCQ added 19/05/2020 đồng bộ trường tài sản offline và online


    /*phan cho v2*/
    $http.get(url + "/transaction/get-by-contract-id", {params: {id: contract_id}})
        .then(function (response) {
            $scope.transactionProperty = response.data;
        });
    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });


    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
            $http.get(url + "/contract/get-contract-kind-by-contract-template-code", {params: {code: template_id}})
                .then(function (response) {
                    $scope.contractKind = response.data;
                });

        });
    $scope.myFunc = function (code) {
        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: code}})
            .then(function (response) {
                $scope.contractTemplates = response.data;
                $scope.contractTemplatesApiece = "";
            });
    };

    ////////


    $http.post(url + "/users/selectByFilter", "where role=03", {headers: {'Content-Type': 'application/json'}})
        .then(function (response) {
                $scope.drafters = response.data;
                return response;
            }
        );
    $http.post(url + "/users/selectByFilter", "where role=02", {headers: {'Content-Type': 'application/json'}})
        .then(function (response) {
                $scope.notarys = response.data;
                return response;
            }
        );

    $http.get(url + "/contract/list-property-type")
        .then(function (response) {
            $scope.proTypes = response.data;
        });

    /*danh sach ngan hang*/
    $http.get(url + "/bank/getAllBank")
        .then(function (response) {
            $scope.banks = response.data;
        });


    /*for view list duong su va tai san*/
    $scope.duongsu = '<div ng-repeat="item in privys.privy track by $index"> <div class=""><b class="">Bên <span ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true">{{item.action}}</span></b> (sau đây gọi là {{item.name}}): </div> <div ng-repeat="user in item.persons track by $index" class="personList"> <div ng-switch on="user.type"> <div ng-switch-when="1"> <div class="">*Công ty:&nbsp;<span class="inputcontract" editspan="user.org_name" ng-model="user.org_name" placeholder="" contenteditable="true">{{user.org_name}}</span></div> <div class="">Địa chỉ: &nbsp;<span class="inputcontract" editspan="user.org_address" ng-model="user.org_address" placeholder="" contenteditable="true">{{user.org_address}}</span></div> <div class="">Mã số doanh nghiệp: <span class="inputcontract" editspan="user.org_code" ng-model="user.org_code" placeholder="" contenteditable="true">{{user.org_code}}</span> &nbsp; ,đăng ký lần đầu ngày: <span class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date" placeholder=" &nbsp;" contenteditable="true">{{user.first_registed_date}}</span>&nbsp; , đăng ký thay đổi lần thứ&nbsp;<span class="inputcontract" editspan="user.number_change_registed" ng-model="user.number_change_registed" placeholder="" contenteditable="true">{{user.number_change_registed}}</span>&nbsp;ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date" placeholder="&nbsp;" contenteditable="true">{{user.change_registed_date}}</span>&nbsp;theo&nbsp; <span class="inputcontract" editspan="user.department_issue" ng-model="user.department_issue" placeholder="" contenteditable="true">{{user.department_issue}}</span>&nbsp;; </div> <div class="">Họ và tên người đại diện:&nbsp;<span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="" contenteditable="true">{{user.name}}</span></div> <div class="">Chức danh:&nbsp;<span class="inputcontract" editspan="user.position" ng-model="user.position" placeholder="" contenteditable="true">{{user.position}}</span></div> </div> <div ng-switch-default> <div class="">*Họ và tên:&nbsp;<span href="#" editspan="user.name" ng-model="user.name" class="inputcontract" contenteditable="true">{{user.name}}</span>&nbsp; , sinh năm: <span placeholder="" editspan="user.birthday" ng-model="user.birthday" class="inputcontract" contenteditable="true">{{user.birthday}}</span> ; </div> </div> </div> <div class="">Giấy CMND/Hộ chiếu/CCCD số:&nbsp;<span placeholder="" editspan="user.passport" ng-model="user.passport" class="inputcontract" contenteditable="true">{{user.passport}}</span> cấp ngày:&nbsp; <span placeholder="" editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract" contenteditable="true">{{user.certification_date}}</span> tại: <span placeholder="" editspan="user.certification_place" ng-model="user.certification_place" class="inputcontract" contenteditable="true">{{user.certification_place}}</span> ; </div> <div class="">Địa chỉ:&nbsp;<span placeholder="" editspan="user.address" ng-model="user.address" class="inputcontract" contenteditable="true">{{user.address}}</span>; </div> </div> </div>';
    $scope.taisan = '<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_address" ng-model="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editspan="item.apartment.apartment_number" ng-model="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editspan="item.apartment.apartment_floor" ng-model="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_use" ng-model="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_build" ng-model="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_structure" ng-model="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor" ng-model="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editspan="item.restrict" ng-model="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editspan="item.property_info" ng-model="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';


    $http.get(url + "/contract/get-contract-by-id", {params: {id: id}})
        .then(function (response) {

            $scope.contract = response.data;
            $scope.contract.summary = "Phụ lục hợp đồng của hợp đồng số " + $scope.contract.contract_number;
            $scope.contract.id = "";
            /*$scope.contract.file_name="";
            $scope.contract.file_path="";*/
            if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                try {
                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                    $scope.listProperty = JSON.parse(pri);

                    //DaiCQ updated 25/05/2020 đồng bộ trường tài sản
                    for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                        var thisProperty = $scope.listProperty.properties[i];
                        if(typeof thisProperty.template == 'undefined'){
                            $scope.listProperty.properties[i].myProperty = true;
                            switch (thisProperty.type) {
                                case "01":
                                    $scope.listProperty.properties[i].template = 1;//set default if null
                                    break;
                                case "02":
                                    $scope.listProperty.properties[i].template = 6;//set default if null
                                    break;
                                case "99":
                                    $scope.listProperty.properties[i].template = 3;//set default if null
                                    break;
                            }
                        }
                        var object = $filter('filter')($scope.templateProperties, {type: $scope.listProperty.properties[i].type}, true);
                        $scope["listTypeTaiSan" + i] = object;
                        //load default date

                        var landIssueDate = "#landIssueDate" + i;
                        $(landIssueDate).datepicker({
                            format: "dd/mm/yyyy",
                            startDate: "01/01/1900",
                            endDate: endDate,
                            forceParse: false,
                            language: 'vi'
                        }).on('changeDate', function (ev) {
                            $(this).datepicker('hide');
                        });
                        var landIssueDate2 = "#landIssueDate2" + i;
                        $(landIssueDate2).datepicker({
                            format: "dd/mm/yyyy",
                            startDate: "01/01/1900",
                            endDate: endDate,
                            forceParse: false,
                            language: 'vi'
                        }).on('changeDate', function (ev) {

                            $(this).datepicker('hide');
                        });
                        var landIssueDate3 = "#landIssueDate3" + i;
                        $(landIssueDate3).datepicker({
                            format: "dd/mm/yyyy",
                            startDate: "01/01/1900",
                            endDate: endDate,
                            forceParse: false,
                            language: 'vi'
                        }).on('changeDate', function (ev) {

                            $(this).datepicker('hide');
                        });
                        var carIssueDate = "#carIssueDate" + i;
                        $(carIssueDate).datepicker({
                            format: "dd/mm/yyyy",
                            startDate: "01/01/1900",
                            endDate: endDate,
                            forceParse: false,
                            language: 'vi'
                        }).on('changeDate', function (ev) {
                            $(this).datepicker('hide');
                        });
                    }
                    //END DaiCQ updated 25/05/2020 đồng bộ trường tài sản

                    /*default date for contract-property. Neu de ngoai thi se ko load dc cung`. khi click vao date lan` dau` ko chon thi se bien' mat*/
                    $(function () {
                        $scope.datePropertyFormat();

                    });
                } catch (e) {
                    $scope.listProperty = "";
                }

            }
            if ($scope.contract.json_person != null && $scope.contract.json_person != "" && $scope.contract.json_person != 'undefined') {
                try {
                    var person = $scope.contract.json_person.substr(1, $scope.contract.json_person.length - 2);
                    $scope.privys = JSON.parse(person);
                    $(function () {
                        $scope.datePersonFormat();
                    });
                } catch (e) {
                    $scope.privys = "";
                }

            }/*else {
                $scope.privys={"name":"Đương sự","privy":[{"id":1,"name":"Bên A","action":"","persons":[{"template":1,"id":"","name":"","birthday":"","passport":"","certification_date":"","certification_place":"","address":"","position":"","description":"","org_name":"","org_address":"","org_code":"","first_registed_date":"","number_change_registed":"","change_registed_date":"","department_issue":""}]},{"id":2,"name":"Bên B","action":"","persons":[{"template":2,"id":"","name":"","birthday":"","passport":"","certification_date":"","certification_place":"","address":"","position":"","description":"","org_name":"","org_address":"","org_code":"","first_registed_date":"","number_change_registed":"","change_registed_date":"","department_issue":""}]}]};
            }*/
            /*default date for contract-property. Neu de ngoai thi se ko load dc cung`. khi click vao date lan` dau` ko chon thi se bien' mat*/
            $(function () {
                $('#drafterDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    forceParse: false,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
                $('#notaryDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    forceParse: false,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
            });

            $scope.checkBank = ($scope.contract.addition_status == 0) ? false : true;
            $scope.showDescrip = $scope.checkBank;

            $scope.checkError = ($scope.contract.error_status == 0) ? false : true;
            $scope.showError = $scope.checkError;
            // $scope.checkmortage = ($scope.contract.mortage_cancel_flag==0)? false:true;
            $scope.showMor = ($scope.contract.mortage_cancel_flag == 1) ? true : false;

            //set contract_NUMBER
            $http.get(url + "/contract/contractNumber", {params: {year: now.getFullYear(), userId: org_type == 1?userEntryId:0}})
                .then(function (response) {
                    if(response.data != null){
                        $scope.contract.contract_number = response.data + "/" + now.getFullYear();
                    }else {
                        $scope.contract.contract_number = "1/" + now.getFullYear();
                    }

                    return response;
                });

            /*load default date notary*/
            var date = new Date();
            $scope.contract.received_date = ("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
            $scope.contract.notary_date = ("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
        });

    $scope.changeDateNotary = function (value) {
        if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
            var dateArray = value.split("/");
            var year = dateArray[2];
            if (year != now.getFullYear()) {
                if (Number(year) && 1900 < year && year < 2100) {
                    //kiem tra xem co phai phuong xa tap trung ko.(Neu la phuong xa tap trung 1 project thi contract_number= year/userId/contract_number)
                    $http.get(url + "/contract/contractNumber", {params: {year: year, userId: org_type == 1 ? userEntryId:0}})
                        .then(function (response) {
                            $scope.contract.contract_number = response.data + "/" + year;
                            return response;
                        });

                }
            }
        }
    };

    /*Duong su ben A-B-C*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    // $scope.privys = { name: "Đương sự", privy: [ { name: "Bên A", id: 1,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] }, { name: "Bên B", id: 2,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] } ] };

    $scope.addPrivy = function () {
        if (typeof $scope.privys.privy == "undefined") $scope.privys.privy = [];
        if ($scope.privys.privy.length < alphabet.length) {
            // var object={ name: "Bên "+alphabet[$scope.privys.privy.length], id: $scope.privys.privy.length,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] };
            var object = {
                name: "Bên " + alphabet[$scope.privys.privy.length],
                id: $scope.privys.privy.length,
                action: "",
                persons: []
            };
            $scope.privys.privy.push(object);
        }
        //sonnv đánh lại bên
        $scope.getActionContractTemplate();
        //end
    };
    $scope.removePrivy = function (index) {
        $scope.privys.privy.splice(index, 1);
        //danh lai ten cho cac ben lien quan khi xoa
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            $scope.privys.privy[i].name = "Bên " + alphabet[i];
            $scope.privys.privy[i].id = i + 1;
        }
        //sonnv đánh lại bên
        $scope.getActionContractTemplate();
        //end
    };

    //sonnv
    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    $scope.getActionContractTemplate();
                });
        }
    };

    $scope.getActionContractTemplate = function () {
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            if (i == 0) {
                $scope.privys.privy[0].action = $scope.contract_template.relate_object_a_display;
            } else if (i == 1) {
                $scope.privys.privy[1].action = $scope.contract_template.relate_object_b_display;
            } else if (i == 2) {
                $scope.privys.privy[2].action = $scope.contract_template.relate_object_c_display;
            } else {
                $scope.privys.privy[i].action = alphabet[i];
            }
        }
    };

    $scope.downloadFile = function () {
        var options = {};
        options.url = '/contract/download/'+ $scope.contract.id;
        options.headers = {'token':'tokenhungnn'};
        options.mode = '_blank';
        window.open(options);
     //   window.open(url + "/contract/download/" + $scope.contract.id, '_blank');
    };
    //tab này chỉ xóa đường dẫn
    $scope.removeFile_ = function () {
        $scope.contract.file_name = "";
        $scope.contract.file_path = "";
    };
    //end

    $scope.addPerson = function (index) {
        var object = {
            template: 1,
            id: "",
            sex: {id: 1, "name": "Ông"},
            name: "",
            birthday: "",
            passport: "",
            certification_date: "",
            certification_place: "",
            address: "",
            position: "",
            description: "",
            org_name: "",
            org_address: "",
            org_code: "",
            first_registed_date: "",
            number_change_registed: "",
            change_registed_date: "",
            department_issue: ""
        };
        $scope.privys.privy[index].persons.push(object);
        $(function () {
            $scope.datePersonFormat();
        })

    };

    $scope.addCompany = function (index) {
        var object = {
            template: 2,
            id: "",
            name: "",
            birthday: "",
            passport: "",
            certification_date: "",
            certification_place: "",
            address: "",
            position: "",
            description: "",
            org_name: "",
            org_address: "",
            org_code: "",
            first_registed_date: "",
            number_change_registed: "",
            change_registed_date: "",
            department_issue: ""
        };
        $scope.privys.privy[index].persons.push(object);
        $(function () {
            $scope.datePersonFormat();
        })

    };

    $scope.addCreditInstitution = function (index) {
        var object = {
            template: 3,
            id: "",
            org_name: "",
            org_code: "",
            org_address: "",
            customer_management_unit: "",
            address: "",
            phone: "",
            fax: "",
            registration_certificate: "",
            name: "",
            position: "",
            authorization_document: ""
        };
        $scope.privys.privy[index].persons.push(object);
        $(function () {
            $scope.datePersonFormat();
        })

    };

    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };


    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editable-text="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editable-text="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editable-text="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editable-text="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editable-text="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';
    $scope.listTypeTaiSan = [
        {
            id: "0",
            name: "Mẫu thông tin thửa đất",
            htmlContent: '<div class="">Quyền sử dụng đất của bên A đối với thửa đất theo cụ thể như sau:</div> <div class="">-Thửa đất số: , tờ bản đồ số: </div> <div class="">-Địa chỉ thửa đất: </div> <div class="">-Diện tích: m2 (bằng chữ: mét vuông )</div> <div class="">-Hình thức sử dụng:</div> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;</div> <div class="">+Sử dụng chung: </div> </div></div> <div >-Mục đích sử dụng:&nbsp; </div> <div class="">-Thời hạn sử dụng: </div> <div class="">-Nguồn gốc sử dụng: </div>'
        },
        {
            id: "1",
            name: "Mẫu nhà chung cư",
            htmlContent: '<div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số &nbsp;do cấp ngày , cụ thể như sau:</div> <div class="">-Địa chỉ:&nbsp; </div> <div class="">-Căn hộ số: tầng: </div> <div class="">-Tổng diện tích sử dụng:&nbsp; </div> <div class="">-Diện tích xây dựng:&nbsp; </div> <div class="">-Kết cấu nhà:&nbsp; </div> <div class="">-Số tầng nhà chung cư: &nbsp;tầng</div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: , tờ bản đồ số:&nbsp; </div> <div class="">-Địa chỉ thửa đất: &nbsp; </div> <div class="">-Diện tích: &nbsp;m2 (bằng chữ: &nbsp;mét vuông )</div> <div class="">-Hình thức sử dụng:</div> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp; </div> <div class="">+Sử dụng chung: </div> </div> </div> <div >-Mục đích sử dụng:&nbsp;</div> <div class="">-Thời hạn sử dụng: </div> <div class="">-Nguồn gốc sử dụng: </div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp; </div>'
        },
        {id: "99", name: "Tài sản khác", htmlContent: '<div class="">Thông tin tài sản: </div>'}
    ];
    /*Thong tin tai san*/
    $scope.listProperty = {
        name: "property",
        properties: [{
            type: "",
            id: 1,
            property_info: "",
            owner_info: "",
            other_info: "",
            land: {
                land_certificate: "",
                land_issue_place: "",
                land_issue_date: "",
                land_map_number: "",
                land_number: "",
                land_address: "",
                land_area: "",
                land_area_text: "",
                land_public_area: "",
                land_private_area: "",
                land_use_purpose: "",
                land_use_period: "",
                land_use_origin: "",
                land_associate_property: "",
                land_street: "",
                land_district: "",
                land_province: "",
                land_full_of_area: ""
            },
            vehicle: {
                car_license_number: "",
                car_regist_number: "",
                car_issue_place: "",
                car_issue_date: "",
                car_frame_number: "",
                car_machine_number: ""
            },
            /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
            owner_info_address:"",
            vehicle_airplane: {
                airplane_name: "",
                airplane_regist_number: "",
                airplane_type: "",
                airplane_engine_number: "",
                airplane_max_weight: "",
                airplane_producer: "",
                airplane_year_manufacture: "",
                airplane_factory_number: "",
                airplane_regist_number_vietnam: ""
            },
            vehicle_ship: {
                ship_name: "",
                ship_regist_number: "",
                ship_level: "",
                ship_function: "",
                ship_year_place_construction: "",
                ship_design_length: "",
                ship_max_length: "",
                ship_design_height: "",
                ship_max_height: "",
                ship_width: "",
                ship_dimension_sinking: "",
                ship_freeboard: "",
                ship_hull_material: ""
            },
            type_real_estate: "",
            type_real_estate_sub:""
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/

        }]
    };


    $(function () {
        $scope.datePropertyFormat();
        $scope.datePersonFormat();
        //load tooltip
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            $(document).on('click', '.popover-title .close', function (e) {
                var $target = $(e.target), $popover = $target.closest('.popover').prev();
                $popover && $popover.popover('hide');
            });
            defer.resolve();
        }, 1000);

        /*      if($scope.listProperty.properties.length>0){
                  for(var i=0; i<$scope.listProperty.properties.length;i++){
                      var object = $filter('filter')($scope.listTypeTaiSan, {id: $scope.listProperty.properties[i].type_view},true)[0];
                      var id="#button-taisan"+i;
                      $(id).attr("data-content", object.htmlContent);
                  }
              }*/
    });


    $scope.addProperty = function () {
        // var object={ type: "", id: 1, property_info:"", owner_info:"", other_info:"", land: { land_certificate:"", land_issue_place:"", land_issue_date:"", land_map_number:"", land_number:"", land_address:"", land_area:"", land_area_text:"", land_public_area:"", land_private_area:"", land_use_purpose:"", land_use_period:"", land_use_origin:"", land_associate_property:"", land_street:"", land_district:"", land_province:"", land_full_of_area:"" }, vehicle:{ car_license_number:"", car_regist_number:"", car_issue_place:"", car_issue_date:"", car_frame_number:"", car_machine_number:"" } };
        var object = {
            type: "01",
            id: $scope.listProperty.properties.length + 1,
            type_view: "",
            property_info: "",
            owner_info: "",
            other_info: "",
            restrict: "",
            apartment: {
                apartment_address: "",
                apartment_number: "",
                apartment_floor: "",
                apartment_area_use: "",
                apartment_area_build: "",
                apartment_structure: "",
                apartment_total_floor: ""
            },
            land: {
                land_certificate: "",
                land_issue_place: "",
                land_issue_date: "",
                land_map_number: "",
                land_number: "",
                land_address: "",
                land_area: "",
                land_area_text: "",
                land_public_area: "",
                land_private_area: "",
                land_use_purpose: "",
                land_use_period: "",
                land_use_origin: "",
                land_associate_property: "",
                land_street: "",
                land_district: "",
                land_province: "",
                land_full_of_area: ""
            },
            vehicle: {
                car_license_number: "",
                car_regist_number: "",
                car_issue_place: "",
                car_issue_date: "",
                car_frame_number: "",
                car_machine_number: ""
            },
            /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
            owner_info_address:"",
            vehicle_airplane: {
                airplane_name: "",
                airplane_regist_number: "",
                airplane_type: "",
                airplane_engine_number: "",
                airplane_max_weight: "",
                airplane_producer: "",
                airplane_year_manufacture: "",
                airplane_factory_number: "",
                airplane_regist_number_vietnam: ""
            },
            vehicle_ship: {
                ship_name: "",
                ship_regist_number: "",
                ship_level: "",
                ship_function: "",
                ship_year_place_construction: "",
                ship_design_length: "",
                ship_max_length: "",
                ship_design_height: "",
                ship_max_height: "",
                ship_width: "",
                ship_dimension_sinking: "",
                ship_freeboard: "",
                ship_hull_material: ""
            },
            type_real_estate: "",
            type_real_estate_sub:""
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/

        };
        $scope.listProperty.properties.push(object);

        //load tooltip for button
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            $(document).on('click', '.popover-title .close', function (e) {
                var $target = $(e.target), $popover = $target.closest('.popover').prev();
                $popover && $popover.popover('hide');
            });
            defer.resolve();
        }, 1000);
        $(function () {
            $scope.datePropertyFormat();
        })

    };

    $scope.removeProperty = function (index) {
        $scope.listProperty.properties.splice(index, 1);
    };

    $scope.changTypeViewProperty = function (index, type_view) {
        $scope.listProperty.properties[index].template = type_view;
        type_view = parseInt(type_view);
        var object = $filter('filter')($scope.listTypeTaiSan, {id: type_view}, true);
        if (object != null && object != 'undefined' && object != '') {
            object = object[0];
            var id = "#button-taisan" + index;
            $(id).attr("data-content", object.htmlContent);
        }
    };

    /*set format date for person and property*/
    $scope.datePersonFormat = function () {
        if ($scope.privys.privy != null && $scope.privys.privy != 'undefined' && $scope.privys.privy.length != null && $scope.privys.privy.length > 0) {
            for (var i = 0; i < $scope.privys.privy.length; i++) {
                for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                    var string = "#birthday" + i + "-" + j;
                    $(string).datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                    var pla = "#certification" + i + "-" + j;
                    $(pla).datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });

                    var first_registed_date = "#first_registed_date" + i + "-" + j;
                    $(first_registed_date).datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });

                    var change_registed_date = "#change_registed_date" + i + "-" + j;
                    $(change_registed_date).datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });

                }
            }
        }

    };

    $scope.datePropertyFormat = function () {
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            var string = "#landDate" + i;
            $(string).datepicker({
                format: "dd/mm/yyyy",
                startDate: "01/01/1900",
                endDate: endDate,
                forceParse: false,
                language: 'vi'
            }).on('changeDate', function (ev) {
                $(this).datepicker('hide');
            });
            var carDate = "#carDate" + i;
            $(carDate).datepicker({
                format: "dd/mm/yyyy",
                startDate: "01/01/1900",
                endDate: endDate,
                forceParse: false,
                language: 'vi'
            }).on('changeDate', function (ev) {
                $(this).datepicker('hide');
            });
        }
    };
    /*end property*/


    //sonnv
    $scope.dataSelectedSex = {
        availableOptions: [
            {id: 1, name: 'Ông'},
            {id: 2, name: 'Bà'}
        ],
        selectedOption: {id: 1, name: 'Ông'}
    };
    $scope.user_sex_name = function (user_sex_name, privyIndex, index) {
        console.log(user_sex_name);
        console.log(privyIndex);
        console.log(index);
        if (user_sex_name == "Ông" || user_sex_name == "ông") {
            $scope.privys.privy[privyIndex].persons[index].sex = {id: 1, name: 'Ông'};
        } else if (user_sex_name == "Bà" || user_sex_name == "bà") {
            $scope.privys.privy[privyIndex].persons[index].sex = {id: 2, name: 'Bà'};
        } else {
            $scope.privys.privy[privyIndex].persons[index].sex = {id: 1, name: 'Ông'};
        }
    };
    //end
//hungnn goi y khi nhap
    $scope.getsuggest = function (nprivy, npersons) {
        var namesuggest = "#name" + nprivy + "-" + npersons;

        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggest',

            params: {
                template: 1
            },
            onSelect: function (suggestion) {
                for (var i = 0; i < $scope.privys.privy.length; i++) {
                    for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                        var item = $scope.privys.privy[i].persons[j];
                        if (nprivy == i & npersons == j) {

                            item.name = suggestion.name;
                            item.birthday = suggestion.birthday;
                            item.passport = suggestion.passport;
                            item.certification_date = suggestion.certification_date;
                            item.certification_place = suggestion.certification_place;
                            item.address = suggestion.address;
                            item.position = suggestion.position;
                            item.description = suggestion.description;

                            //sonnv
                            if (angular.isUndefined($scope.privys.privy[i].persons[j].sex)
                                || $scope.privys.privy[i].persons[j].sex == null
                                || $scope.privys.privy[i].persons[j].sex == "") {
                                $scope.privys.privy[i].persons[index].sex = {id: 1, name: 'Ông'};
                            }
                            if (suggestion.sex == '1' || suggestion.sex == 1) {
                                $scope.privys.privy[i].persons[j].sex.id = 1;
                                $scope.privys.privy[i].persons[j].sex.name = 'Ông';
                            } else if (suggestion.sex == '2' || suggestion.sex == 2) {
                                $scope.privys.privy[i].persons[j].sex.id = 2;
                                $scope.privys.privy[i].persons[j].sex.name = 'Bà';
                            }
                            //end
                        }

                    }
                }
                $scope.$apply();
            }
        });
    };

    $scope.getsuggest_org = function (nprivy, npersons) {
        var namesuggest = "#org_name" + nprivy + "-" + npersons;


        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggest',

            params: {
                template: 2
            },
            onSelect: function (suggestion) {
                for (var i = 0; i < $scope.privys.privy.length; i++) {
                    for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                        var item = $scope.privys.privy[i].persons[j];
                        if (nprivy == i & npersons == j) {


                            item.org_name = suggestion.org_name;
                            item.org_code = suggestion.org_code;
                            item.org_address = suggestion.org_address;
                            item.name = suggestion.name;
                            item.birthday = suggestion.birthday;
                            item.passport = suggestion.passport;
                            item.position = suggestion.position;
                            item.first_registed_date = suggestion.first_registed_date;
                            item.number_change_registed = suggestion.number_change_registed;
                            item.change_registed_date = suggestion.change_registed_date;
                            item.department_issue = suggestion.department_issue;
                            item.certification_date = suggestion.certification_date;
                            item.certification_place = suggestion.certification_place;
                            item.address = suggestion.address;
                            item.description = suggestion.description;
                        }

                    }
                }
                $scope.$apply();
            }
        });
    };

    $scope.getsuggestproperty = function (index, type) {
        var namesuggest = ".autocomplete_land_certificate" + index;
        console.log("type" + type);
        if (type == '02') {
            namesuggest = "#car_frame_number" + index;
        }
        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggestProperty',

            params: {
                type: type
            },
            onSelect: function (suggestion) {

                for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                    if (index == i) {
                        if (type == '01') {
                            var item = $scope.listProperty.properties[i].land;
                            item.land_street = suggestion.land_street;
                            item.land_certificate = suggestion.land_certificate;
                            item.land_address = suggestion.land_address;
                            item.land_issue_place = suggestion.land_issue_place;
                            item.land_issue_date = suggestion.land_issue_date;
                            item.land_number = suggestion.land_number;
                            item.land_map_number = suggestion.land_map_number;
                            item.land_associate_property = suggestion.land_associate_property;
                            item.land_area = suggestion.land_area;
                            item.land_area_text = suggestion.land_area_text;
                            item.land_private_area = suggestion.land_private_area;
                            item.land_public_area = suggestion.land_public_area;
                            item.land_use_purpose = suggestion.land_use_purpose;
                            item.land_use_period = suggestion.land_use_period;
                            item.land_use_origin = suggestion.land_use_origin;
                            item.land_associate_property = suggestion.land_associate_property;
                            item.land_street = suggestion.land_street;
                            item.land_district = suggestion.land_district;
                            item.land_province = suggestion.land_province;
                            item.land_full_of_area = suggestion.land_full_of_area;
                            // các trường bổ sung
                            item.land_type = suggestion.land_type;
                            item.construction_area = suggestion.construction_area;
                            item.building_area = suggestion.building_area;
                            item.land_use_type = suggestion.land_use_type;
                            item.land_sort = suggestion.land_sort;
                            $scope.listProperty.properties[i].owner_info = suggestion.owner_info;
                            $scope.listProperty.properties[i].other_info = suggestion.other_info;
                            $scope.listProperty.properties[i].restrict = suggestion.restrict;

                        } else if (type == '02') {
                            var item = $scope.listProperty.properties[i].vehicle;
                            $scope.listProperty.properties[i].land.land_street = suggestion.land_street;
                            item.car_license_number = suggestion.car_license_number;
                            item.car_regist_number = suggestion.car_regist_number;
                            item.car_issue_place = suggestion.car_issue_place;
                            item.car_issue_date = suggestion.car_issue_date;
                            item.car_frame_number = suggestion.car_frame_number;
                            item.car_machine_number = suggestion.car_machine_number;
                            $scope.listProperty.properties[i].owner_info = suggestion.owner_info;
                            $scope.listProperty.properties[i].other_info = suggestion.other_info;
                            $scope.listProperty.properties[i].restrict = suggestion.restrict;
                        }
                    }

                }
                $scope.$apply();
            }
        });
    };

    //Lấy gợi ý đương sự là tổ chức tín dụng
    $scope.getsuggest_Credit = function (nprivy, npersons) {
        var namesuggest = "#credit_code" + nprivy + "-" + npersons;


        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggest',

            params: {
                template: 3
            },
            onSelect: function (suggestion) {
                for (var i = 0; i < $scope.privys.privy.length; i++) {
                    for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                        var item = $scope.privys.privy[i].persons[j];
                        if (nprivy == i & npersons == j) {
                            item.org_name = suggestion.org_name;
                            item.org_code = suggestion.org_code;
                            item.org_address = suggestion.org_address;
                            item.customer_management_unit = suggestion.customer_management_unit;
                            item.address = suggestion.address;
                            item.phone = suggestion.phone;
                            item.fax = suggestion.fax;
                            item.registration_certificate = suggestion.registration_certificate;
                            item.name = suggestion.name;
                            item.position = suggestion.position;
                            item.authorization_document = suggestion.authorization_document;
                        }

                    }
                }
                $scope.$apply();
            }
        });
    };

    // $http.get(url+"/contract/get-contract-kind-by-contract-template-id", {params: { id: template_id}})
    //     .then(function(response) {
    //         $scope.contractKind=response.data;
    //
    //     });
    //
    // $http.get(url+"/contract/get-contract-template-by-id", {params: { id: template_id }})
    //     .then(function(response) {
    //         $scope.contractTemplate=response.data;
    //     });

    if (notary_id != null && notary_id != 'underfined' && notary_id != "" && notary_id != "0") {
        $http.get(url + "/users/get-user", {params: {id: notary_id}})
            .then(function (response) {
                $scope.notary = response.data;
            });
    }

    if (drafter_id != null && drafter_id != 'underfined' && drafter_id != "" && drafter_id != "0") {
        $http.get(url + "/users/get-user", {params: {id: drafter_id}})
            .then(function (response) {
                $scope.drafter = response.data;
            });
    }

    /*Calculate total fee*/
    $scope.calculateTotal = function () {
        /*set default =0 de khi parseInt ko bi loi neu' ng dung` xoa tren giao dien dua vao` chuoi~ rong~*/
        var cost_tt91 = '0';
        var cost_draft = '0';
        var cost_notary_outsite = '0';
        var cost_other_determine = '0';
        if ($scope.contract.cost_tt91 != null && $scope.contract.cost_tt91 != 'underfined') cost_tt91 = $scope.contract.cost_tt91.toString().replace(/,/g, "");
        if ($scope.contract.cost_draft != null && $scope.contract.cost_draft != 'underfined') cost_draft = $scope.contract.cost_draft.toString().replace(/,/g, "");
        if ($scope.contract.cost_notary_outsite != null && $scope.contract.cost_notary_outsite != 'underfined') cost_notary_outsite = $scope.contract.cost_notary_outsite.toString().replace(/,/g, "");
        if ($scope.contract.cost_other_determine != null && $scope.contract.cost_other_determine != 'underfined') cost_other_determine = $scope.contract.cost_other_determine.toString().replace(/,/g, "");

        $scope.contract.cost_total = parseInt(cost_tt91) + parseInt(cost_draft) + parseInt(cost_notary_outsite) + parseInt(cost_other_determine);
    };


    /*When click Luu thong tin*/
    $scope.addContractWrapper = function () {
        if ($scope.checkValidate()) {
            $http.get(url + "/contract/checkContractNumber", {params: {contract_number: $scope.contract.contract_number}})
                .then(function (response) {
                    if (response.status == 200 && response.data == true) {
                        if ($scope.checkDate()) {
                            $("#checkDate").modal('show');
                        } else {
                            /*genaral duong su va tai san*/
                            $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
                            $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";

                            if ($scope.contract.kindhtml != null && $scope.contract.kindhtml != 'undefined' && $scope.contract.kindhtml.length > 0) {
                                $scope.addTemporary();
                            } else {
                                $scope.addContract();
                            }
                        }

                    } else {
                        //alert(response.statusText);
                        $("#checkContractNumber").modal('show');
                    }
                });

        } else {
            $("#checkValidate").modal('show');
        }
    };
    $scope.addContract = function () {
        var object_bank_by_id = $filter('filter')($scope.banks, {code: $scope.contract.bank_code}, true)[0];
        if (object_bank_by_id != null && object_bank_by_id != "undefined") {
            $scope.contract.bank_name = object_bank_by_id.name;
        }
        /*genaral duong su va tai san*/
        $scope.genInforProAndPrivys();

        $scope.contract.entry_date_time = new Date();
        $scope.contract.update_date_time = new Date();
        if ($scope.checkBank == true) {
            $scope.contract.addition_status = 1;
        } else {
            $scope.contract.addition_status = 0;
        }
        if ($scope.checkError == true) {
            $scope.contract.error_status = 1;
        } else {
            $scope.contract.error_status = 0;
        }


        var contractAdd = JSON.parse(JSON.stringify($scope.contract));
        if ($scope.myFile != null && $scope.myFile != 'undefined' && $scope.myFile.size > 0) {
            var file = $scope.myFile;
            var uploadUrl = url + "/contract/uploadFile";
            fileUpload.uploadFileToUrl(file, uploadUrl)
                .then(function (response) {
                        if (response.data != null && response.data != 'undefined' && response.status == 200) {
                            $scope.contract.file_name = response.data.name;
                            $scope.contract.file_path = response.data.path;
                            var contractAdd = JSON.parse(JSON.stringify($scope.contract));
                            $http.post(url + "/contract/", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                .then(function (response) {
                                    if (response.status == 200 && response.data > 0) {

                                        var listPerson = [];
                                        for (var i = 0; i < $scope.privys.privy.length; i++) {
                                            var item2 = $scope.privys.privy[i];
                                            for (var j = 0; j < item2.persons.length; j++) {
                                                if (typeof item2.persons[j].sex == "undefined") {
                                                    item2.persons[j].sex = {id: 1, name: "Ông"};
                                                }
                                                item2.persons[j].sex = item2.persons[j].sex.id;
                                                if (item2.persons[j].template == 1 && item2.persons[j].passport != "") {
                                                    listPerson.push(item2.persons[j]);
                                                }
                                                if (item2.persons[j].template == 2 && item2.persons[j].org_code != "") {
                                                    listPerson.push(item2.persons[j]);
                                                }

                                            }
                                        }

                                        var listPersonAllJson = JSON.stringify(listPerson);

                                        $http.get(contextPath + "/contract/addPrivyFuncOnline", {
                                            params: {
                                                addData: listPersonAllJson,
                                                statusOnline: 0
                                            }
                                        })
                                            .then(function (response) {
                                                console.log(response.status);
                                                return response;
                                            });
                                        //  $scope.checkNayPrivy(listPersonAllJson);

                                        /*for(var k = 0 ;k<listPerson.length;k++){
                                            var addSuggestPrivy = JSON.parse(JSON.stringify(listPerson[k]));
                                            $http.post(urlstp+"/contract/addSuggestPrivy",listPerson[k],{headers:{'Content-Type':'application/json'}})

                                        }*/
                                        /*$http.post(urlstp+"/contract/addSuggestPrivyAll",listPersonAll,{headers:{'Content-Type':'application/json'}})*/
                                        var listProperty = [];
                                        var checkTest = $scope.listProperty.properties.length;
                                        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                                            var item3 = $scope.listProperty.properties[i];
                                            if ((item3.type == "01" && item3.land.land_certificate != "") || (item3.type == "02" && item3.vehicle.car_frame_number != "")) {
                                                var listPropertyForm = {
                                                    id: "",
                                                    type: item3.type,
                                                    type_view: 0,
                                                    owner_info: item3.owner_info,
                                                    other_info: item3.other_info,
                                                    restrict: item3.restrict,
                                                    land_certificate: item3.land.land_certificate,
                                                    land_issue_place: item3.land.land_issue_place,
                                                    land_issue_date: item3.land.land_issue_date,
                                                    land_map_number: item3.land.land_map_number,
                                                    land_number: item3.land.land_number,
                                                    land_address: item3.land.land_address,
                                                    land_area: item3.land.land_area,
                                                    land_area_text: item3.land.land_area_text,
                                                    land_public_area: item3.land.land_public_area,
                                                    land_private_area: item3.land.land_private_area,
                                                    land_use_purpose: item3.land.land_use_purpose,
                                                    land_use_period: item3.land.land_use_period,
                                                    land_use_origin: item3.land.land_use_origin,
                                                    land_associate_property: item3.land.land_associate_property,
                                                    land_street: item3.land.land_street,
                                                    land_district: item3.land.land_district,
                                                    land_province: item3.land.land_province,
                                                    land_full_of_area: item3.land.land_full_of_area,
                                                    land_type: item3.land.land_type,
                                                    construction_area: item3.land.construction_area,
                                                    building_area: item3.land.building_area,
                                                    land_use_type: item3.land.land_use_type,
                                                    land_sort: item3.land.land_sort,
                                                    car_license_number: item3.vehicle.car_license_number,
                                                    car_regist_number: item3.vehicle.car_regist_number,
                                                    car_issue_place: item3.vehicle.car_issue_place,
                                                    car_issue_date: item3.vehicle.car_issue_date,
                                                    car_frame_number: item3.vehicle.car_frame_number,
                                                    car_machine_number: item3.vehicle.car_machine_number,
                                                    apartment_address: item3.apartment.apartment_address,
                                                    apartment_number: item3.apartment.apartment_number,
                                                    apartment_floor: item3.apartment.apartment_floor,
                                                    apartment_area_use: item3.apartment.apartment_area_use,
                                                    apartment_area_build: item3.apartment.apartment_area_build,
                                                    apartment_structure: item3.apartment.apartment_structure,
                                                    apartment_total_floor: item3.apartment.apartment_total_floor,

                                                    /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                                                    owner_info_address: item3.owner_info_address,
                                                    airplane_name: item3.vehicle_airplane.airplane_name,
                                                    airplane_regist_number: item3.vehicle_airplane.airplane_regist_number,
                                                    airplane_type: item3.vehicle_airplane.airplane_type,
                                                    airplane_engine_number: item3.vehicle_airplane.airplane_engine_number,
                                                    airplane_max_weight: item3.vehicle_airplane.airplane_max_weight,
                                                    airplane_producer: item3.vehicle_airplane.airplane_producer,
                                                    airplane_year_manufacture: item3.vehicle_airplane.airplane_year_manufacture,
                                                    airplane_factory_number: item3.vehicle_airplane.airplane_factory_number,
                                                    airplane_regist_number_vietnam: item3.vehicle_airplane.airplane_regist_number_vietnam,
                                                    ship_name: item3.vehicle_ship.ship_name,
                                                    ship_regist_number: item3.vehicle_ship.ship_regist_number,
                                                    ship_level: item3.vehicle_ship.ship_level,
                                                    ship_function: item3.vehicle_ship.ship_function,
                                                    ship_year_place_construction: item3.vehicle_ship.ship_year_place_construction,
                                                    ship_design_length: item3.vehicle_ship.ship_design_length,
                                                    ship_max_length: item3.vehicle_ship.ship_max_length,
                                                    ship_design_height: item3.vehicle_ship.ship_design_height,
                                                    ship_max_height: item3.vehicle_ship.ship_max_height,
                                                    ship_width: item3.vehicle_ship.ship_width,
                                                    ship_dimension_sinking: item3.vehicle_ship.ship_dimension_sinking,
                                                    ship_freeboard: item3.vehicle_ship.ship_freeboard,
                                                    ship_hull_material: item3.vehicle_ship.ship_hull_material,
                                                    /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                                                    type_real_estate: item3.type_real_estate,
                                                    type_real_estate_sub: item3.type_real_estate_sub
                                                };

                                                listProperty.push(listPropertyForm);
                                            }


                                        }
                                        var listPropertyAllJson = JSON.stringify(listProperty);

                                        //   $scope.checkNayProperty(listPropertyAllJson);
                                        $http.get(contextPath + "/contract/addPropertyFuncOnline", {
                                            params: {
                                                addData: listPropertyAllJson,
                                                statusOnline: 0
                                            }
                                        })
                                            .then(function (response) {
                                                console.log(response.status);
                                                return response;
                                            });

                                        $window.location.href = contextPath + '/contract/list?status=1';

                                    } else {
                                        $("#errorEdit").modal('show');
                                    }

                                    return response;
                                });
                        } else {
                            $("#errorEdit").modal('show');
                        }
                    },
                    function (response) {
                        // failure callback
                        $("#errorEdit").modal('show');
                    }
                );
        } else {
            $http.post(url + "/contract/", contractAdd, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                    if (response.status == 200 && response.data > 0) {
                        var listPerson = [];
                        for (var i = 0; i < $scope.privys.privy.length; i++) {
                            var item2 = $scope.privys.privy[i];
                            for (var j = 0; j < item2.persons.length; j++) {
                                if (typeof item2.persons[j].sex == "undefined") {
                                    item2.persons[j].sex = {id: 1, name: "Ông"};
                                }
                                item2.persons[j].sex = item2.persons[j].sex.id;
                                if (item2.persons[j].template == 1 && item2.persons[j].passport != "") {
                                    listPerson.push(item2.persons[j]);
                                }
                                if (item2.persons[j].template == 2 && item2.persons[j].org_code != "") {
                                    listPerson.push(item2.persons[j]);
                                }
                                if (item2.persons[j].template == 3 && item2.persons[j].org_code != "") {
                                    listPerson.push(item2.persons[j]);
                                }

                            }
                        }

                        var listPersonAllJson = JSON.stringify(listPerson);

                        $http.get(contextPath + "/contract/addPrivyFuncOnline", {
                            params: {
                                addData: listPersonAllJson,
                                statusOnline: 0
                            }
                        })
                            .then(function (response) {
                                console.log(response.status);
                                return response;
                            });
                        //  $scope.checkNayPrivy(listPersonAllJson);

                        /*for(var k = 0 ;k<listPerson.length;k++){
                            var addSuggestPrivy = JSON.parse(JSON.stringify(listPerson[k]));
                            $http.post(urlstp+"/contract/addSuggestPrivy",listPerson[k],{headers:{'Content-Type':'application/json'}})

                        }*/
                        /*$http.post(urlstp+"/contract/addSuggestPrivyAll",listPersonAll,{headers:{'Content-Type':'application/json'}})*/
                        var listProperty = [];
                        var checkTest = $scope.listProperty.properties.length;
                        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                            var item3 = $scope.listProperty.properties[i];
                            if ((item3.type == "01" && item3.land.land_certificate != "") || (item3.type == "02" && item3.vehicle.car_frame_number != "")) {
                                var listPropertyForm = {
                                    id: "",
                                    type: item3.type,
                                    type_view: 0,
                                    owner_info: item3.owner_info,
                                    other_info: item3.other_info,
                                    restrict: item3.restrict,
                                    land_certificate: item3.land.land_certificate,
                                    land_issue_place: item3.land.land_issue_place,
                                    land_issue_date: item3.land.land_issue_date,
                                    land_map_number: item3.land.land_map_number,
                                    land_number: item3.land.land_number,
                                    land_address: item3.land.land_address,
                                    land_area: item3.land.land_area,
                                    land_area_text: item3.land.land_area_text,
                                    land_public_area: item3.land.land_public_area,
                                    land_private_area: item3.land.land_private_area,
                                    land_use_purpose: item3.land.land_use_purpose,
                                    land_use_period: item3.land.land_use_period,
                                    land_use_origin: item3.land.land_use_origin,
                                    land_associate_property: item3.land.land_associate_property,
                                    land_street: item3.land.land_street,
                                    land_district: item3.land.land_district,
                                    land_province: item3.land.land_province,
                                    land_full_of_area: item3.land.land_full_of_area,
                                    land_type: item3.land.land_type,
                                    construction_area: item3.land.construction_area,
                                    building_area: item3.land.building_area,
                                    land_use_type: item3.land.land_use_type,
                                    land_sort: item3.land.land_sort,
                                    car_license_number: item3.vehicle.car_license_number,
                                    car_regist_number: item3.vehicle.car_regist_number,
                                    car_issue_place: item3.vehicle.car_issue_place,
                                    car_issue_date: item3.vehicle.car_issue_date,
                                    car_frame_number: item3.vehicle.car_frame_number,
                                    car_machine_number: item3.vehicle.car_machine_number,
                                    apartment_address: item3.apartment.apartment_address,
                                    apartment_number: item3.apartment.apartment_number,
                                    apartment_floor: item3.apartment.apartment_floor,
                                    apartment_area_use: item3.apartment.apartment_area_use,
                                    apartment_area_build: item3.apartment.apartment_area_build,
                                    apartment_structure: item3.apartment.apartment_structure,
                                    apartment_total_floor: item3.apartment.apartment_total_floor,

                                    /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                                    owner_info_address: item3.owner_info_address,
                                    airplane_name: item3.vehicle_airplane.airplane_name,
                                    airplane_regist_number: item3.vehicle_airplane.airplane_regist_number,
                                    airplane_type: item3.vehicle_airplane.airplane_type,
                                    airplane_engine_number: item3.vehicle_airplane.airplane_engine_number,
                                    airplane_max_weight: item3.vehicle_airplane.airplane_max_weight,
                                    airplane_producer: item3.vehicle_airplane.airplane_producer,
                                    airplane_year_manufacture: item3.vehicle_airplane.airplane_year_manufacture,
                                    airplane_factory_number: item3.vehicle_airplane.airplane_factory_number,
                                    airplane_regist_number_vietnam: item3.vehicle_airplane.airplane_regist_number_vietnam,
                                    ship_name: item3.vehicle_ship.ship_name,
                                    ship_regist_number: item3.vehicle_ship.ship_regist_number,
                                    ship_level: item3.vehicle_ship.ship_level,
                                    ship_function: item3.vehicle_ship.ship_function,
                                    ship_year_place_construction: item3.vehicle_ship.ship_year_place_construction,
                                    ship_design_length: item3.vehicle_ship.ship_design_length,
                                    ship_max_length: item3.vehicle_ship.ship_max_length,
                                    ship_design_height: item3.vehicle_ship.ship_design_height,
                                    ship_max_height: item3.vehicle_ship.ship_max_height,
                                    ship_width: item3.vehicle_ship.ship_width,
                                    ship_dimension_sinking: item3.vehicle_ship.ship_dimension_sinking,
                                    ship_freeboard: item3.vehicle_ship.ship_freeboard,
                                    ship_hull_material: item3.vehicle_ship.ship_hull_material,
                                    /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                                    type_real_estate: item3.type_real_estate,
                                    type_real_estate_sub: item3.type_real_estate_sub
                                };

                                listProperty.push(listPropertyForm);
                            }


                        }
                        var listPropertyAllJson = JSON.stringify(listProperty);

                        //   $scope.checkNayProperty(listPropertyAllJson);
                        $http.get(contextPath + "/contract/addPropertyFuncOnline", {
                            params: {
                                addData: listPropertyAllJson,
                                statusOnline: 0
                            }
                        })
                            .then(function (response) {
                                console.log(response.status);
                                return response;
                            });

                        $window.location.href = contextPath + '/contract/list?status=1';

                    } else {
                        $("#errorEdit").modal('show');
                    }

                    return response;
                });
        }

    };

    $scope.addTemporary = function () {
        /*genaral duong su va tai san*/
        $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
        $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";

        //gan gia tri cho #copyContract tranh' thay doi gia tri cua divcontract
        $("#copyContract").html($("div #contentKindHtml").html());
        $("#copyContract #danhsachduongsu").html("");
        $("#copyContract #taisandat").html("");

        var listInput = $("#copyContract .inputcontract");
        for (var i = 0; i < listInput.length; i++) {
            var val = listInput[i].getAttribute("editable-text");
            listInput[i].innerHTML = '{{' + val + '}}';
        }

        var kindhtml = $("#copyContract").html();
        $scope.contract.kindhtml = kindhtml;
        // set lai gia tri mac dinh cho #copyContract
        $("#copyContract").html("  ");

        /*FORMAT GEN INFO PROPERTY AND RELATION_OBJECT*/
        $scope.genInforProAndPrivys();

        /*end gen info*/
        $scope.genOfflineToOnline();
        $scope.temporary.entry_date_time = new Date();
        $scope.temporary.update_date_time = new Date();

        var contractTem = JSON.parse(JSON.stringify($scope.temporary));
        if ($scope.myFile != null && $scope.myFile != 'undefined' && $scope.myFile.size > 0) {
            if ($scope.myFile.size > 5242000) {
                $("#errorMaxFile").modal('show');
            } else {
                var file = $scope.myFile;
                var uploadUrl = url + "/contract/uploadFile";
                fileUpload.uploadFileToUrl(file, uploadUrl)
                    .then(function (response) {
                            if (response.data != null && response.data != 'undefined' && response.status == 200) {
                                $scope.contract.file_name = response.data.name;
                                $scope.contract.file_path = response.data.path;
                                var contractAdd = JSON.parse(JSON.stringify($scope.contract));
                                $http.post(url + "/contract/temporary", contractTem, {headers: {'Content-Type': 'application/json'}})
                                    .then(function (response) {
                                            if (response.status == 200) {
                                                if ($scope.checkOnline) {
                                                    $window.location.href = contextPath + '/contract/temporary/list?status=1';
                                                } else {
                                                    $window.location.href = contextPath + '/contract/list?status=1';
                                                }
                                            } else {
                                                $("#errorEdit").modal('show');
                                            }
                                        },
                                        function (response) {
                                            // failure callback
                                            $("#errorEdit").modal('show');
                                        }
                                    );
                            } else {
                                $("#errorEdit").modal('show');
                            }
                        },
                        function (response) {
                            // failure callback
                            $("#errorEdit").modal('show');
                        }
                    );
            }

        } else {
            $http.post(url + "/contract/temporary", contractTem, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                        if (response.status == 200) {
                            if ($scope.checkOnline) {
                                $window.location.href = contextPath + '/contract/temporary/list?status=1';
                            } else {
                                $window.location.href = contextPath + '/contract/list?status=1';
                            }
                        } else {
                            $("#errorEdit").modal('show');
                        }
                    },
                    function (response) {
                        // failure callback
                        $("#errorEdit").modal('show');
                    }
                );
        }

    };

    $scope.genOfflineToOnline = function () {
        $scope.temporary.contract_template_id = $scope.contract.contract_template_id;
        $scope.temporary.contract_number = $scope.contract.contract_number;
        $scope.temporary.contract_value = $scope.contract.contract_value;
        $scope.temporary.relation_object_a = $scope.contract.relation_object_a;
        $scope.temporary.relation_object_b = $scope.contract.relation_object_b;
        $scope.temporary.relation_object_c = $scope.contract.relation_object_c;
        $scope.temporary.notary_id = $scope.contract.notary_id;
        $scope.temporary.drafter_id = $scope.contract.drafter_id;
        $scope.temporary.received_date = $scope.contract.received_date;
        $scope.temporary.notary_date = $scope.contract.notary_date;
        $scope.temporary.user_require_contract = $scope.contract.user_require_contract;
        $scope.temporary.number_copy_of_contract = $scope.contract.number_copy_of_contract;
        $scope.temporary.number_of_sheet = $scope.contract.number_of_sheet;
        $scope.temporary.number_of_page = $scope.contract.number_of_page;
        $scope.temporary.cost_tt91 = $scope.contract.cost_tt91;
        $scope.temporary.cost_draft = $scope.contract.cost_draft;
        $scope.temporary.cost_notary_outsite = $scope.contract.cost_notary_outsite;
        $scope.temporary.cost_other_determine = $scope.contract.cost_other_determine;
        $scope.temporary.cost_total = $scope.contract.cost_total;
        $scope.temporary.notary_place_flag = $scope.contract.notary_place_flag;
        $scope.temporary.notary_place = $scope.contract.notary_place;
        $scope.temporary.bank_service_fee = $scope.contract.bank_service_fee;
        $scope.temporary.crediter_name = $scope.contract.crediter_name;
        $scope.temporary.file_name = $scope.contract.file_name;
        $scope.temporary.file_path = $scope.contract.file_path;
        $scope.temporary.original_store_place = $scope.contract.original_store_place;
        $scope.temporary.note = $scope.contract.note;
        $scope.temporary.summary = $scope.contract.summary;
        $scope.temporary.jsonstring = $scope.contract.jsonstring;
        $scope.temporary.json_property = $scope.contract.json_property;
        $scope.temporary.json_person = $scope.contract.json_person;
        $scope.temporary.bank_code = $scope.contract.bank_code;
        $scope.temporary.entry_user_id = $scope.contract.entry_user_id;
        $scope.temporary.entry_user_name = $scope.contract.entry_user_name;
        $scope.temporary.update_user_id = $scope.contract.update_user_id;
        $scope.temporary.update_user_name = $scope.contract.update_user_name;
        $scope.temporary.kindhtml = $scope.contract.kindhtml;
    };

    $scope.genInforProAndPrivys = function () {
        $scope.contract.relation_object_a = "";
        $scope.contract.relation_object_b = "";
        /*gen contract.propertyInfo va relation_object*/
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            var item1 = $scope.privys.privy[i];
            var string1 = '';
            for (var j = 0; j < item1.persons.length; j++) {
                var string = "";
                var item = item1.persons[j];
                if (item != null && item !== 'undefined') {
                    if (item.template == 3) {//nếu đương sự là tổ chức tín dụng
                        if (item.org_name != null && item.org_name != '') string += "Tên ngân hàng: " + item.org_name + "; ";
                        if (item.org_code != null && item.org_code != '') string += "Mã số doanh nghiệp: " + item.org_code + "; ";
                        if (item.org_address != null && item.org_address != '') string += "Địa chỉ trụ sở chính: " + item.org_address + "; ";
                        if (item.customer_management_unit != null && item.customer_management_unit != '') string += "Đơn vị trực tiếp quản lý khách hàng: " + item.customer_management_unit + "; ";
                        if (item.address != null && item.address != '') string += "Địa chỉ: " + item.address + "; ";
                        if (item.phone != null && item.phone != '') string += "Điện thoại: " + item.phone + "; ";
                        if (item.fax != null && item.fax != '') string += "Fax: " + item.fax + "; ";
                        if (item.registration_certificate != null && item.registration_certificate != '') string += "Giấy chứng nhận đăng ký hoạt động Chi nhánh/Phòng giao dịch: " + item.registration_certificate + "; ";
                        if (item.name != null && item.name != '') string += "Họ tên người đại diện: " + item.name + "; ";
                        if (item.position != null && item.position != '') string += "Chức vụ: " + item.position + "; ";
                        if (item.authorization_document != null && item.authorization_document != '') string += "Văn bản ủy quyền: " + item.authorization_document + "; ";
                    }
                    else {
                        if (item.org_name != null && item.org_name != '') {
                            string += "Công ty: " + item.org_name + "; ";
                        }
                        if (item.org_address != null && item.org_address != '') {
                            string += "Địa chỉ công ty: " + item.org_address + "; ";
                        }
                        if (item.org_code != null && item.org_code != '') string += "Mã doanh nghiệp: " + item.org_code + "; ";
                        if (item.first_registed_date != null && item.first_registed_date != '') string += "Đăng kí lần đầu ngày:" + item.first_registed_date + ";";
                        if (item.number_change_registed != null && item.number_change_registed != '') string += "Đăng kí thay đổi lần thứ:" + item.number_change_registed + ";";
                        if (item.change_registed_date != null && item.change_registed_date != '') string += "Ngày đăng kí thay đổi:" + item.change_registed_date + ";";
                        if (item.department_issue != null && item.department_issue != '') string += "Theo:" + item.department_issue + ";";
                        //if(item.name!=null && item.name!='')string+="Họ tên: "+item.name+"; ";
                        if (item.name != null && item.name != '') {
                            if (item.template == 1) {
                                string += item.sex.name + ": " + item.name + "; ";
                            } else {
                                string += "Họ tên: " + item.name + "; ";
                            }
                        }
                        if (item.birthday != null && item.birthday != '') string += "Sinh năm: " + item.birthday + "; ";
                        if (item.position != null && item.position != '') string += "Chức danh: " + item.position + "; ";
                        if (item.passport !== "" && item.passport != '') string += "CMND/Hộ chiếu/CCCD: " + item.passport + "; ";
                        if (item.certification_date != null && item.certification_date != '') string += "Ngày cấp: " + item.certification_date + "; ";
                        if (item.certification_place != null && item.certification_place != '') string += "Nơi cấp: " + item.certification_place + "; ";
                        if (item.address != null && item.address != '') string += "Địa chỉ: " + item.address + "; ";
                        if (item.description != null && item.description != '') string += "Mô tả: " + item.description + "; ";
                    }

                }
                if (string.length > 0) {
                    string = (j + 1) + ". " + string + "\\n ";
                    string1 += string;
                    // string1+=string.replace("\\n","\n");
                }

            }
            if (string1.length > 0) {
                $scope.contract.relation_object_a += "Bên " + item1.action + " (sau đây gọi là " + item1.name + ")" + ":\\n" + string1;//item1.name+":\\n"+string1;
                // $scope.contract.relation_object_a=$scope.contract.relation_object_a.replace("\\n","\n");
            }

        }
        /*lay relation_object_b thay the cho property_Info*/
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            var item = $scope.listProperty.properties[i];
            var stringpro = "";
            // $scope.contract.relation_object_b+=i+1 + ".";
            if (item.property_info !== "" && typeof item.property_info != '') {
                stringpro += item.property_info;
            }
            switch (item.type) {
                case "01":
                    if (item.apartment != null && item.apartment !== 'undefined') {
                        if (item.apartment.apartment_number != null && item.apartment.apartment_number != '') {
                            stringpro += "Căn hộ số: " + item.apartment.apartment_number + "; ";
                        }
                        if (item.apartment.apartment_address != null && item.apartment.apartment_address != '') {
                            stringpro += "Địa chỉ căn hộ: " + item.apartment.apartment_address + "; ";
                        }
                        if (item.apartment.apartment_floor != null && item.apartment.apartment_floor != '') {
                            stringpro += "Tầng số: " + item.apartment.apartment_floor + "; ";
                        }
                        if (item.apartment.apartment_area_use != null && item.apartment.apartment_area_use != '') {
                            stringpro += "Diện tích căn hộ: " + item.apartment.apartment_area_use + "; ";
                        }
                        if (item.apartment.apartment_area_build != null && item.apartment.apartment_area_build != '') {
                            stringpro += "Diện tích xây dựng: " + item.apartment.apartment_area_build + "; ";
                        }
                        if (item.apartment.apartment_structure != null && item.apartment.apartment_structure != '') {
                            stringpro += "Kết cấu nhà: " + item.apartment.apartment_structure + "; ";
                        }
                        if (item.apartment.apartment_total_floor != null && item.apartment.apartment_total_floor != '') {
                            stringpro += "Tổng số tầng: " + item.apartment.apartment_total_floor + "; ";
                        }
                    }
                    if (item.land != null && item.land !== "" && item.land !== 'undefined') {
                        if (item.land.land_number != null && item.land.land_number != '') {
                            stringpro += "Thửa đất số: " + item.land.land_number + "; ";
                        }
                        if (item.land.land_map_number != null && item.land.land_map_number != '') {
                            stringpro += "Tờ bản đồ số: " + item.land.land_map_number + "; ";
                        }
                        if (item.land.land_address != null && item.land.land_address != '') {
                            stringpro += "Địa chỉ: " + item.land.land_address + "; ";
                        }
                        if (item.land.land_certificate != null && item.land.land_certificate != '') {
                            stringpro += "Số giấy chứng nhận: " + item.land.land_certificate + "; ";
                        }
                        if (item.land.land_issue_place != null && item.land.land_issue_place != '') {
                            stringpro += "Nơi cấp: " + item.land.land_issue_place + "; ";
                        }
                        if (item.land.land_issue_date != null && item.land.land_issue_date != '') {
                            stringpro += "Ngày cấp: " + item.land.land_issue_date + "; ";
                        }
                        if (item.land.land_associate_property != null && item.land.land_associate_property != '') {
                            stringpro += "Tài sản gắn liền với đất: " + item.land.land_associate_property + "; ";
                        }
                        if (item.land.land_area != null && item.land.land_area != '') {
                            stringpro += "Diện tích: " + item.land.land_area + "; ";
                        }
                        if (item.land.land_private_area != null && item.land.land_private_area != '') {
                            stringpro += "Diện tích sử dụng riêng: " + item.land.land_private_area + "; ";
                        }
                        if (item.land.land_public_area != null && item.land.land_public_area != '') {
                            stringpro += "Diện tích sử dụng chung: " + item.land.land_public_area + "; ";
                        }
                        if (item.land.land_use_purpose != null && item.land.land_use_purpose != '') {
                            stringpro += "Mục đích sử dụng: " + item.land.land_use_purpose + "; ";
                        }
                        if (item.land.land_use_period != null && item.land.land_use_period != '') {
                            stringpro += "Thời hạn: " + item.land.land_use_period + "; ";
                        }
                        if (item.land.land_use_origin != null && item.land.land_use_origin != '') {
                            stringpro += "Nguồn gốc sử dụng: " + item.land.land_use_origin + "; ";
                        }
                        if (item.restrict != null && item.restrict != '') {
                            stringpro += "Hạn chế quyền nếu có: " + item.restrict + "; ";
                        }
                        if (item.land.land_type != null && item.land.land_type != '') {
                            stringpro += "Loại đất :" + item.land.land_type + "; ";
                        }
                        if (item.land.construction_area != null && item.land.construction_area != '') {
                            stringpro += "Diện tích xây dựng :" + item.land.construction_area + "; ";
                        }
                        if (item.land.building_area != null && item.land.building_area != '') {
                            stringpro += "Diện tích sàn :" + item.land.building_area + "; ";
                        }
                        if (item.land.land_use_type != null && item.land.land_use_type != '') {
                            stringpro += "Hình thức sở hữu :" + item.land.land_use_type + "; ";
                        }
                        if (item.land.land_sort != null && item.land.land_sort != '') {
                            stringpro += "Cấp nhà ở :" + item.land.land_sort + "; ";
                        }
                    }
                    break;
                case "02":
                    /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                    if (item.vehicle_airplane != null && item.vehicle_airplane !== 'undefined') {
                        if (item.vehicle_airplane.airplane_name != null && item.vehicle_airplane.airplane_name != '') {
                            stringpro += "Tên phương tiện tàu bay: " + item.vehicle_airplane.airplane_name + "; ";
                        }
                        if (item.vehicle_airplane.airplane_regist_number != null && item.vehicle_airplane.airplane_regist_number != '') {
                            stringpro += "Số giấy đăng ký: " + item.vehicle_airplane.airplane_regist_number + "; ";
                        }
                        if (item.vehicle_airplane.airplane_type != null && item.vehicle_airplane.airplane_type != '') {
                            stringpro += "Kiểu loại: " + item.vehicle_airplane.airplane_type + "; ";
                        }
                        if (item.vehicle_airplane.apartment_area_use != null && item.vehicle_airplane.apartment_area_use != '') {
                            stringpro += "Số động cơ: " + item.vehicle_airplane.airplane_engine_number + "; ";
                        }
                        if (item.vehicle_airplane.airplane_max_weight != null && item.vehicle_airplane.airplane_max_weight != '') {
                            stringpro += "Trọng lượng tối đa cho phép: " + item.vehicle_airplane.airplane_max_weight + "; ";
                        }
                        if (item.vehicle_airplane.airplane_producer != null && item.vehicle_airplane.airplane_producer != '') {
                            stringpro += "Tên nhà sản xuất và quốc gia sản xuất: " + item.vehicle_airplane.airplane_producer + "; ";
                        }
                        if (item.vehicle_airplane.airplane_year_manufacture != null && item.vehicle_airplane.airplane_year_manufacture != '') {
                            stringpro += "Năm sản xuất: " + item.vehicle_airplane.airplane_year_manufacture + "; ";
                        }
                        if (item.vehicle_airplane.airplane_factory_number != null && item.vehicle_airplane.airplane_factory_number != '') {
                            stringpro += "Số xuất xưởng của nhà sản xuất: " + item.vehicle_airplane.airplane_factory_number + "; ";
                        }
                        if (item.vehicle_airplane.airplane_regist_number_vietnam != null && item.vehicle_airplane.airplane_regist_number_vietnam != '') {
                            stringpro += "Số hiệu đăng ký tại Việt Nam: " + item.vehicle_airplane.airplane_regist_number_vietnam + "; ";
                        }
                    }
                    else if (item.vehicle_ship != null && item.vehicle_ship !== 'undefined') {
                        if (item.vehicle_ship.ship_name != null && item.vehicle_ship.ship_name != '') {
                            stringpro += "Tên phương tiện thủy nội địa: " + item.vehicle_ship.ship_name + "; ";
                        }
                        if (item.vehicle_ship.ship_regist_number != null && item.vehicle_ship.ship_regist_number != '') {
                            stringpro += "Số giấy đăng ký: " + item.vehicle_ship.ship_regist_number + "; ";
                        }
                        if (item.owner_info_address != null && item.owner_info_address != '') {
                            stringpro += "Địa chỉ chủ phương tiện: " + item.owner_info_address + "; ";
                        }
                        if (item.vehicle_ship.ship_level != null && item.vehicle_ship.ship_level != '') {
                            stringpro += "Cấp phương tiện: " + item.vehicle_ship.ship_level + "; ";
                        }
                        if (item.vehicle_ship.ship_function != null && item.vehicle_ship.ship_function != '') {
                            stringpro += "Công dụng: " + item.vehicle_ship.ship_function + "; ";
                        }
                        if (item.vehicle_ship.ship_year_place_construction != null && item.vehicle_ship.ship_year_place_construction != '') {
                            stringpro += "Năm và nơi đóng: " + item.vehicle_ship.ship_year_place_construction + "; ";
                        }
                        if (item.vehicle_ship.ship_design_length != null && item.vehicle_ship.ship_design_length != '') {
                            stringpro += "Chiều dài thiết kế: " + item.vehicle_ship.ship_design_length + "; ";
                        }
                        if (item.vehicle_ship.ship_max_length != null && item.vehicle_ship.ship_max_length != '') {
                            stringpro += "Chiều dài lớn nhất: " + item.vehicle_ship.ship_max_length + "; ";
                        }
                        if (item.vehicle_ship.ship_design_height != null && item.vehicle_ship.ship_design_height != '') {
                            stringpro += "Chiều rộng thiết kế: " + item.vehicle_ship.ship_design_height + "; ";
                        }
                        if (item.vehicle_ship.ship_width != null && item.vehicle_ship.ship_width != '') {
                            stringpro += "Chiều rộng lớn nhất: " + item.vehicle_ship.ship_width + "; ";
                        }
                        if (item.vehicle_ship.ship_dimension_sinking != null && item.vehicle_ship.ship_dimension_sinking != '') {
                            stringpro += "Chiều chìm: " + item.vehicle_ship.ship_dimension_sinking + "; ";
                        }
                        if (item.vehicle_ship.ship_freeboard != null && item.vehicle_ship.ship_freeboard != '') {
                            stringpro += "Mạn khô: " + item.vehicle_ship.ship_freeboard + "; ";
                        }
                        if (item.vehicle_ship.ship_hull_material != null && item.vehicle_ship.ship_hull_material != '') {
                            stringpro += "Vật liệu vỏ: " + item.vehicle_ship.ship_hull_material + "; ";
                        }
                    }
                    /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/

                    else{
                        if (item.vehicle.car_license_number != null && item.vehicle.car_license_number != '') {
                            stringpro += "Biển kiểm soát: " + item.vehicle.car_license_number + "; ";
                        }
                        if (item.vehicle.car_regist_number != null && item.vehicle.car_regist_number != '') {
                            stringpro += "Số đăng ký: " + item.vehicle.car_regist_number + "; ";
                        }
                        if (item.vehicle.car_issue_place != null && item.vehicle.car_issue_place != '') {
                            stringpro += "Nơi cấp: " + item.vehicle.car_issue_place + "; ";
                        }
                        if (item.vehicle.car_issue_date != null && item.vehicle.car_issue_date != '') {
                            stringpro += "Ngày cấp: " + item.vehicle.car_issue_date + "; ";
                        }
                        if (item.vehicle.car_frame_number != null && item.vehicle.car_frame_number != '') {
                            stringpro += "Số khung: " + item.vehicle.car_frame_number + "; ";
                        }
                        if (item.vehicle.car_machine_number != null && item.vehicle.car_machine_number != '') {
                            stringpro += "Số máy:" + item.vehicle.car_machine_number + "; ";
                        }
                    }

                    break;
                default:
                    break;
            }

            if (item.owner_info != null && item.owner_info != '') {
                if (stringpro.length > 0) {
                    stringpro += "; Chủ sở hữu: " + item.owner_info + "; ";
                } else {
                    stringpro += "Chủ sở hữu: " + item.owner_info + "; ";
                }
            }
            if (item.other_info != null && item.other_info != '') {
                stringpro += "Thông tin khác: " + item.other_info + "; ";
            }
            if (stringpro.length > 0) {
                if ($scope.listProperty.properties.length > 1) {
                    $scope.contract.relation_object_b += i + 1 + "." + stringpro + "\\n";
                } else {
                    $scope.contract.relation_object_b += stringpro;
                }
                stringpro = "";
            }
        }
    };
    $scope.suggestNotaryFee = function () {
        if ($scope.contract.contract_template_id == null || $scope.contract.contract_template_id == 'undefined' || $scope.contract.contract_template_id == '' || $scope.contract.contract_value == null || $scope.contract.contract_value == 'undefined') {
            $scope.announcement.notaryFee = "Vui lòng chọn Tên hợp đồng và Giá trị Hợp đồng";
            $scope.contract.cost_tt91 = 0;
            $scope.calculateTotal();
            $("#fee-status").show();
            setTimeout(function () {
                $("#fee-status").hide();
            }, 5000);
        } else {
            var contractValue = 0;
            if ($scope.contract.contract_value == 0) {
                contractValue = 1;
            } else {
                contractValue = $scope.contract.contract_value;
            }
            $http.get(contextPath + "/contract/suggestNotaryFee", {
                params: {
                    codeTemplateId: $scope.contract.contract_template_id,
                    notaryFee: contractValue
                }
            })
                .then(function (response) {
                    $scope.contractFee = response.data;
                    console.log("cong thuc" + $scope.contractFee.formula_fee);
                    $scope.contract.cost_tt91 = $scope.contractFee.notaryFeeNumber;
                    //tinh lai phi tong
                    $scope.calculateTotal();
                    if ($scope.contractFee.circulars_fee == null || $scope.contractFee.circulars_fee == '') {

                    } else {
                        $scope.announcement.notaryFee = "Căn cứ: " + $scope.contractFee.circulars_fee;
                        $("#fee-status").show();
                        setTimeout(function () {
                            $("#fee-status").hide();
                        }, 5000);

                    }
                });

        }
    };

    $scope.suggestCertFee = function (type) {
        $http.get(contextPath + "/certificate/suggestCertFee", {
            params: {
                type: type,
                soBan: 1
            }
        })
            .then(function (response) {
                $scope.certFee = response.data;
                console.log("cong thuc" + $scope.certFee.formula_fee);
                $scope.contract.cost_tt91 = $scope.certFee.formula_fee;
                //tinh lai phi tong
                $scope.calculateTotal();

            });
    };

    /*check validate*/
    $scope.checkValidate = function () {
        var check = true;
        $scope.contract_signer_ = "";
        $scope.contract_value_ = "";
        /*if(!$scope.contractKind.name.length>0){
            return false;
        }*/
        if (isNullOrEmpty($scope.contract.contract_template_id) || !$scope.contract.contract_template_id > 0) {
            check = false;
        }
        if (isNullOrEmpty($scope.contract.contract_number) || !$scope.contract.contract_number.toString().length > 0) {
            check = false;
        }
        if (isNullOrEmpty($scope.contract.received_date) || !$scope.contract.received_date.toString().length == 10) {
            check = false;
        }
        if (isNullOrEmpty($scope.contract.notary_date) || !$scope.contract.notary_date.toString().length == 10) {
            check = false;
        }
        /*  if(!$scope.contract.drafter_id>0){
              return false;
          }*/
        if (isNullOrEmpty($scope.contract.notary_id) || !$scope.contract.notary_id > 0) {
            check = false;
        }
        if (isNullOrEmpty($scope.contract.contract_value)) {
            $scope.contract_value_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if (org_type == 1) {
            if (isNullOrEmpty($scope.contract.contract_signer)) {
                $scope.contract_signer_ = "Trường không được bỏ trống. ";
                check = false;
            }
        }
        return check;
    };

    $scope.viewAsDoc = function () {
        $("#viewHtmlAsWord").html($("#contentKindHtml").html());
        $("#viewContentAsWord").modal('show');
    };

    $scope.downloadWord = function () {
        $("#contentKindHtml").wordExport();
    };

    //convert date dd/mm/yyyy sang date cua he thong.
    $scope.formatDate = function (strDate) {
        if (strDate == null || strDate.length != 10) return null;
        var dateArray = strDate.split("/");
        var date = dateArray[2] + "-" + dateArray[1] + "-" + dateArray[0];
        if (moment(date, "YYYY/MM/DD", true).isValid()) {
            return new Date(date);
        } else {
            return null;
        }

    };
    $scope.checkDate = function () {
        var date1 = $scope.formatDate($scope.contract.received_date);
        var date2 = $scope.formatDate($scope.contract.notary_date);
        var now = new Date();
        if (date1 == null || date2 == null || date1 > date2 || date1 > now || date2 > now) {
            return true;
        }
        return false;
    };

}]);

//giup format cac' so' sang dang tien` te 1,000,000
myApp.$inject = ['$scope'];
myApp.directive('format', ['$filter', function ($filter) {
    return {
        require: '?ngModel',
        link: function (scope, elem, attrs, ctrl) {
            if (!ctrl) return;


            ctrl.$formatters.unshift(function (a) {
                return $filter(attrs.format)(ctrl.$modelValue)
            });


            ctrl.$parsers.unshift(function (viewValue) {
                var plainNumber = viewValue.replace(/[^\d|\-+|\.+]/g, '');
                elem.val($filter(attrs.format)(plainNumber));
                return plainNumber;
            });
        }
    };
}]);

myApp.directive('dynamic', function ($compile) {
    return {
        restrict: 'A',
        replace: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic, function (html) {
                ele.html(html);
                $compile(ele.contents())(scope);
            });
        }
    };
});