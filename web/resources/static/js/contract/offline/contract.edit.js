/**
 * Created by TienManh on 5/23/2017.
 */
myApp.controller('contractEditController', ['$scope', '$http', '$filter', '$sce', '$window', function ($scope, $http, $filter, $sce, $window) {
    $scope.url = url;
    $scope.privys = {};
    $scope.listProperty = {};
    $scope.announcement = {notaryFee: ""};

    $scope.checkOnline = false;
    $scope.org_type = org_type;

    if (from != null && from == "1") {
        $scope.checkOnline = true;
    }

    //Bổ sung loại tài sản bất động sản
    $scope.property_real_estate_type = [];
    $scope.property_real_estate_type_sub = [];
    $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: 0}})
        .then(function (response) {

            $scope.property_real_estate_type = response.data;
        });

    $scope.changePropertyRealEstate = function(index, parent_code){
        $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: parent_code}})
            .then(function (response) {
                $scope["property_real_estate_type_sub" + index] = response.data;
                /*if($scope["property_real_estate_type_sub" + index] == null || $scope["property_real_estate_type_sub" + index].length==0) {
                    $scope.listProperty.properties[index].type_real_estate = parent_code;
                }
                else $scope.listProperty.properties[index].type_real_estate = $scope["property_real_estate_type_sub" + index][0].code;*/
            });
    };

    $scope.getListRealEstateTypeSubByIndex = function(index){
        return $scope["property_real_estate_type_sub" + index];
    };
    //END Bổ sung loại tài sản bất động sản



    $scope.removeFile = function () {
        $http.get(url + "/contract/remove", {params: {id: id}})
            .then(function (response) {
                if (response.data = true) {
                    $scope.contract.file_name = "";
                    $scope.contract.file_path = "";
                }
            });
    };
    // phan lay notary_id hop dong back up de check
    $http.post(url + "/users/selectByFilter", "where account='backupstp'", {headers: {'Content-Type': 'application/json'}})
        .then(function (response) {
            $scope.userBackUp = response.data;
            if($scope.userBackUp!=undefined && $scope.userBackUp!=null && $scope.userBackUp.length>0){
                $scope.notaryIdBackUp = $scope.userBackUp[0].userId;
            }


        });
    /*phan cho v2*/
    $http.get(url + "/transaction/get-by-contract-id", {params: {id: contract_id}})
        .then(function (response) {
            $scope.transactionProperty = response.data;
        });
    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });
    $scope.myFuncLoadMortage = function (codeTemplate) {

        $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: codeTemplate}})
            .then(function (response) {
                $scope.template = response.data;
                $(function () {
                    $('#periodDate').datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                    $('#mortageCancelDate').datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse: false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                });
            });

    };


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

    $http.get(url + "/contract/list-contract-template-same-kind", {params: {code_temp: template_id}})
        .then(function (response) {
            $scope.contractTemplates = response.data;
        });

    if (sub_template_id != null && sub_template_id != "" && sub_template_id > 0) {
        $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: sub_template_id}})
            .then(function (response) {
                $scope.contractTemplatesApiece = [response.data];
            });
    }

    //load for giai chap va thoi han hop dong
    $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: template_id}})
        .then(function (response) {
            $scope.template = response.data;
            $(function () {
                $('#periodDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    forceParse: false,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
                $('#mortageCancelDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    forceParse: false,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
            });

        });


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
    /*danh sách sổ công chứng*/
    $http.get(url + "/notaryBook/listSattusNotarybook",{
        params: {
            type: typeHD
        }
    })
        .then(function (response) {
            $scope.notaryBook = response.data;
        });


    /*for view list duong su va tai san*/
    $http.get(url + "/ContractTemplate/privy-template")
        .then(function (response) {
            $scope.templatePrivys = response.data;
            $scope.formatDuongSu();
            $scope.formatDuongSuBenA();
            $scope.formatDuongSuBenB();
            return response;
        });
    $http.get(url + "/ContractTemplate/property-template")
        .then(function (response) {
            $scope.templateProperties = response.data;
            $scope.formatTaiSan();
            return response;
        });

    $scope.formatDuongSu = function () {
        $scope.duongsu = '';
        $scope.duongsu += duongsu_pre;
        if ($scope.templatePrivys != null && $scope.templatePrivys != 'undefined' && $scope.templatePrivys != '') {
            for (var i = 0; i < $scope.templatePrivys.length; i++) {
                var item = $scope.templatePrivys[i];
                $scope.duongsu += '<div ng-switch-when="' + item.id + '">';
                $scope.duongsu += item.html;
                $scope.duongsu += '</div>';
            }
        }

        $scope.duongsu += duongsu_suff;
    };

    $scope.formatDuongSuBenA = function () {
        $scope.duongsubena = '';
        $scope.duongsubena += duongsu_ben_a_pre;
        if ($scope.templatePrivys != null && $scope.templatePrivys != 'undefined' && $scope.templatePrivys != '') {
            for (var i = 0; i < $scope.templatePrivys.length; i++) {
                var item = $scope.templatePrivys[i];
                $scope.duongsubena += '<div ng-switch-when="' + item.id + '">';
                $scope.duongsubena += item.html;
                $scope.duongsubena += '</div>';
            }
        }
        $scope.duongsubena += duongsu_suff;
        $scope.duongsubena += '</div';
    };

    $scope.formatDuongSuBenB = function () {
        $scope.duongsubenb = '';
        $scope.duongsubenb += duongsu_ben_b_pre;
        if ($scope.templatePrivys != null && $scope.templatePrivys != 'undefined' && $scope.templatePrivys != '') {
            for (var i = 0; i < $scope.templatePrivys.length; i++) {
                var item = $scope.templatePrivys[i];
                $scope.duongsubenb += '<div ng-switch-when="' + item.id + '">';
                $scope.duongsubenb += item.html;
                $scope.duongsubenb += '</div>';
            }
        }
        $scope.duongsubenb += duongsu_suff;
        $scope.duongsubenb += '</div';
    };

    $scope.formatTaiSan = function () {
        $scope.taisan = '';
        $scope.taisan += taisan_pre;
        if ($scope.templateProperties != null && $scope.templateProperties != 'undefined' && $scope.templateProperties != '') {
            for (var i = 0; i < $scope.templateProperties.length; i++) {
                var item = $scope.templateProperties[i];
                $scope.taisan += '<div ng-switch-when="' + item.id + '">';
                $scope.taisan += item.html;
                $scope.taisan += '</div>';
            }
        }

        $scope.taisan += taisan_suff;
    };
    // $scope.duongsu='<div ng-repeat="item in privys.privy track by $index"> <div class=""><b style="font-family: Times New Roman; font-size: 14pt;" class="">Bên <span ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true">{{item.action}}</span></b> (sau đây gọi là {{item.name}}): </div> <div ng-repeat="user in item.persons track by $index" class="personList"> <div ng-switch on="user.type"> <div ng-switch-when="1"> <div class="">*Công ty:&nbsp;<span class="inputcontract" editspan="user.org_name" ng-model="user.org_name" placeholder="" contenteditable="true">{{user.org_name}}</span></div> <div class="">Địa chỉ: &nbsp;<span class="inputcontract" editspan="user.org_address" ng-model="user.org_address" placeholder="" contenteditable="true">{{user.org_address}}</span></div> <div class="">Mã số doanh nghiệp: <span class="inputcontract" editspan="user.org_code" ng-model="user.org_code" placeholder="" contenteditable="true">{{user.org_code}}</span> &nbsp; ,đăng ký lần đầu ngày: <span class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date" placeholder=" &nbsp;" contenteditable="true">{{user.first_registed_date}}</span>&nbsp; , đăng ký thay đổi lần thứ&nbsp;<span class="inputcontract" editspan="user.number_change_registed" ng-model="user.number_change_registed" placeholder="" contenteditable="true">{{user.number_change_registed}}</span>&nbsp;ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date" placeholder="&nbsp;" contenteditable="true">{{user.change_registed_date}}</span>&nbsp;theo&nbsp; <span class="inputcontract" editspan="user.department_issue" ng-model="user.department_issue" placeholder="" contenteditable="true">{{user.department_issue}}</span>&nbsp;; </div> <div class="">Họ và tên người đại diện:&nbsp;<span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="" contenteditable="true">{{user.name}}</span></div> <div class="">Chức danh:&nbsp;<span class="inputcontract" editspan="user.position" ng-model="user.position" placeholder="" contenteditable="true">{{user.position}}</span></div> </div> <div ng-switch-default> <div class="">*Họ và tên:&nbsp;<span href="#" editspan="user.name" ng-model="user.name" class="inputcontract" contenteditable="true">{{user.name}}</span>&nbsp; , sinh năm: <span placeholder="" editspan="user.birthday" ng-model="user.birthday" class="inputcontract" contenteditable="true">{{user.birthday}}</span> ; </div> </div> </div> <div class="">Giấy CMND số:&nbsp;<span placeholder="" editspan="user.passport" ng-model="user.passport" class="inputcontract" contenteditable="true">{{user.passport}}</span> cấp ngày:&nbsp; <span placeholder="" editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract" contenteditable="true">{{user.certification_date}}</span> tại: <span placeholder="" editspan="user.certification_place" ng-model="user.certification_place" class="inputcontract" contenteditable="true">{{user.certification_place}}</span> ; </div> <div class="">Địa chỉ:&nbsp;<span placeholder="" editspan="user.address" ng-model="user.address" class="inputcontract" contenteditable="true">{{user.address}}</span>; </div> </div> </div>';
    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_address" ng-model="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editspan="item.apartment.apartment_number" ng-model="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editspan="item.apartment.apartment_floor" ng-model="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_use" ng-model="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_build" ng-model="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_structure" ng-model="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor" ng-model="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editspan="item.restrict" ng-model="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editspan="item.property_info" ng-model="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';

    $http.get(url + "/contract/get-contract-by-id", {params: {id: id}})
        .then(function (response) {

            $scope.contract = response.data;

            $scope.notaryIdSaveBackUp = $scope.contract.notary_id;
            var ggwp = $scope.contract.kindhtml;
            if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                try {
                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                    $scope.listProperty = JSON.parse(pri);

                    //DaiCQ updated 25/05/2020 đồng bộ trường tài sản
                    $http.get(url + "/ContractTemplate/property-template")
                        .then(function (response) {
                            $scope.templateProperties = response.data;
                            $scope.formatTaiSan();
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
                        });
                    //END DaiCQ updated 25/05/2020 đồng bộ trường tài sản

                    /*default date for contract-property. Neu de ngoai thi se ko load dc cung`. khi click vao date lan` dau` ko chon thi se bien' mat*/
                    $(function () {
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
                } catch (e) {
                    $scope.listProperty = "";
                }
            } else {
                try {
                    $http.get(url + "/contract/get-Property-by-contract-id", {params: {contractId: id}})
                        .then(function (response) {
                            $scope.property_info_contract = response.data == null ? response.data : response.data.property_info;
                            $scope.type_property_info_contract = response.data == null ? response.data : response.data.type;
                            $scope.id_property_info_contract = response.data == null ? response.data : response.data.id;
                            $scope.listProperty = {
                                "name": "property",
                                "properties": [{
                                    "id": $scope.id_property_info_contract + "",
                                    "type": $scope.type_property_info_contract,
                                    "property_info": $scope.property_info_contract
                                }]
                            };
                        });
                } catch (e) {
                }
            }
            if ($scope.contract.json_person != null && $scope.contract.json_person != "" && $scope.contract.json_person != 'undefined') {
                try {
                    var person = $scope.contract.json_person.substr(1, $scope.contract.json_person.length - 2);
                    $scope.privys = JSON.parse(person);
                } catch (e) {
                    $scope.privys = "";
                }

            }
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

        });

    //DaiCQ added 19/05/2020

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
    $scope.changeTypeProperty = function (index, type) {
        $scope.listProperty.properties[index].type = type;
        var object = $filter('filter')($scope.templateProperties, {type: type}, true);
        $scope["listTypeTaiSan" + index] = object;

        if(type!='01'){
            $scope.listProperty.properties[index].type_real_estate = "";
            $scope.listProperty.properties[index].type_real_estate_sub = "";
        }
    };

    $scope.changTemplateProperty = function (index, template) {
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
    //END DaiCQ added 19/05/2020

    /*duong su va tai san*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    $scope.addPrivy = function () {
        if ($scope.privys.privy.length < alphabet.length) {
            var object = {
                name: "Bên " + alphabet[$scope.privys.privy.length],
                id: $scope.privys.privy.length,
                persons: [{id: "", name: "", description: ""}]
            };
            $scope.privys.privy.push(object);
        }
    };
    $scope.removePrivy = function (index) {
        $scope.privys.privy.splice(index, 1);
        //danh lai ten cho cac ben lien quan khi xoa
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            $scope.privys.privy[i].name = "Bên " + alphabet[i];
            $scope.privys.privy[i].id = i + 1;
        }

    };
    $scope.addPerson = function (index) {
        var object = {
            id: "",
            name: "",
            description: ""
        };
        $scope.privys.privy[index].persons.push(object);
    };
    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };


    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editable-text="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editable-text="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editable-text="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editable-text="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editable-text="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';
    $scope.addProperty = function () {
        // var object={ type: "01", id: 1, property_info:"", owner_info:"", other_info:"", land: { land_certificate:"", land_issue_place:"", land_issue_date:"", land_map_number:"", land_number:"", land_address:"", land_area:"", land_area_text:"", land_public_area:"", land_private_area:"", land_use_purpose:"", land_use_period:"", land_use_origin:"", land_associate_property:"", land_street:"", land_district:"", land_province:"", land_full_of_area:"" }, vehicle:{ car_license_number:"", car_regist_number:"", car_issue_place:"", car_issue_date:"", car_frame_number:"", car_machine_number:"" } };
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
            type_real_estate:"",
            type_real_estate_sub:""
        };
        $scope.listProperty.properties.push(object);

        $(function () {
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
        });
    };

    $scope.removeProperty = function (index) {
        $scope.listProperty.properties.splice(index, 1);
    };


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
    $scope.editContract = function () {
        if ($scope.contract.contract_template_id != null) {
            if ($scope.checkValidate()) {
                if ($scope.checkDate()) {
                    $("#checkDate").modal('show');
                } else {
                    var object_bank_by_id = $filter('filter')($scope.banks, {code: $scope.contract.bank_code}, true)[0];
                    if (object_bank_by_id != null && object_bank_by_id != "undefined") {
                        $scope.contract.bank_name = object_bank_by_id.name;
                    }

                    $scope.contract.entry_date_time = new Date();
                    $scope.contract.update_date_time = new Date();
                    $scope.contract.update_user_name = updateUserName;
                    $scope.contract.update_user_id = updateUserId;

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
                    $http.put(url + "/contract/", contractAdd, {headers: {'Content-Type': 'application/json'}})
                        .then(function (response) {
                                if (response.status == 200 && response.data > 0) {
                                    var listPerson = [];
                                    if (typeof $scope.privys.privy != "undefined") {
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
                                    var listProperty = [];
                                    if (typeof $scope.listProperty.properties != "undefined") {
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
                                                    airplane_name: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_name,
                                                    airplane_regist_number: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_regist_number,
                                                    airplane_type: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_type,
                                                    airplane_engine_number: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_engine_number,
                                                    airplane_max_weight: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_max_weight,
                                                    airplane_producer: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_producer,
                                                    airplane_year_manufacture: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_year_manufacture,
                                                    airplane_factory_number: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_factory_number,
                                                    airplane_regist_number_vietnam: isNullOrEmpty(item3.vehicle_airplane) ? "" : item3.vehicle_airplane.airplane_regist_number_vietnam,
                                                    ship_name: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_name,
                                                    ship_regist_number: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_regist_number,
                                                    ship_level: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_level,
                                                    ship_function: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_function,
                                                    ship_year_place_construction: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_year_place_construction,
                                                    ship_design_length: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_design_length,
                                                    ship_max_length: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_max_length,
                                                    ship_design_height: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_design_height,
                                                    ship_max_height: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_max_height,
                                                    ship_width: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_width,
                                                    ship_dimension_sinking: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_dimension_sinking,
                                                    ship_freeboard: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_freeboard,
                                                    ship_hull_material: isNullOrEmpty(item3.vehicle_ship) ? "" : item3.vehicle_ship.ship_hull_material,
                                                    /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
                                                    type_real_estate: isNullOrEmpty(item3.type_real_estate) ? "" : item3.type_real_estate,
                                                    type_real_estate_sub: isNullOrEmpty(item3.type_real_estate_sub) ? "" : item3.type_real_estate_sub

                                                };

                                                listProperty.push(listPropertyForm);
                                            }
                                        }
                                    }
                                    var listPropertyAllJson = JSON.stringify(listProperty);

                                    // $scope.checkNayProperty(listPropertyAllJson);
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
                                    /*for(var k = 0 ;k<listProperty.length;k++){
                                        $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                    }*/
                                    if ($scope.checkOnline) {
                                        $window.location.href = contextPath + '/contract/temporary/list?status=3';
                                    } else {
                                        $window.location.href = contextPath + '/contract/list?status=4';
                                    }

                                } else {
                                    $("#errorEdit").modal('show');
                                }
                            },
                            function (response) {
                                // failure callback
                                $scope.checkCancel = false;
                                $("#errorEdit").modal('show');

                            });
                }
            } else {
                $("#checkValidate").modal('show');
            }
        } else {
            $("#checkCodeTemplate").modal('show');
        }
    };


    $scope.viewAsDoc = function () {
        $("#viewHtmlAsWord").html($("#contentKindHtml").html());
        $("#viewContentAsWord").modal('show');
    };

    $scope.downloadWord = function () {
        $("#contentKindHtml").wordExport();
    };
    // addSuggest From Controller
    $scope.checkNayPrivy = function (check) {

        $.ajax({
            type: "GET",
            url: location.protocol + '//' + location.host + '/contract/addPrivyFunc',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                addData: check,
            }

        });
    };
    // addSuggest From Controller
    $scope.checkNayProperty = function (check) {

        $.ajax({
            type: "GET",
            url: location.protocol + '//' + location.host + '/contract/addPropertyFunc',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                addData: check,
            }

        });
    };
    $scope.downloadFile = function () {
        window.open(url + "/contract/download/" + $scope.contract.id, '_blank');
    };
    $scope.suggestNotaryFee = function () {
        if ($scope.contract.contract_template_id == null || $scope.contract.contract_template_id == 'undefined' || $scope.contract.contract_template_id == '') {
            $scope.announcement.notaryFee = "Vui lòng chọn Tên hợp đồng và Giá trị Hợp đồng";
            $scope.contract.cost_tt91 = 0;
            $scope.calculateTotal();
            $("#fee-status").show();
            setTimeout(function () {
                $("#fee-status").hide();
            }, 5000);
        } else {
            var contractValue = 0;
            if ($scope.contract.contract_value == 0 || $scope.contract.contract_value == null || $scope.contract.contract_value == 'undefined') {
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
        if ($scope.contract.json_person == null || $scope.contract.json_person == "") {
            return false;
        }
        /* if(date1==null || date2==null || date1>date2 || date1>now || date2>now){
             return true;
         }*/
        if (date2 == null || date2 > now) {
            return true;
        }
        return false;
    };

    //DaiCQ check format passport contains special char
    $scope.isValidPassportFormat = function () {
        var result = true;
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                $('#CMT-' + i + '-' + j).hide();
                var item = $scope.privys.privy[i].persons[j];
                if (item.passport != null && item.passport != '' && isContainSpecialChar(item.passport)) {
                    $('#CMT-' + i + '-' + j).show();
                    result = false;
                }
            }
        }
        return result;
    };
    //END DaiCQ check format passport contains special char

    $scope.checkValidate = function () {
        var check = true;
        /*if ($scope.contract.json_person == null || $scope.contract.json_person == "") {
            check = false;
        }*/
        if (!$scope.contract.contract_template_id > 0) {
            check = false;
        }
        if (!$scope.contract.contract_number.toString().length > 0) {
            check = false;
        }
        if (!$scope.contract.received_date.toString().length == 10) {
            check = false;
        }
        if (!$scope.contract.notary_date.toString().length == 10) {
            check = false;
        }
        /*if(!$scope.contract.drafter_id>0){
            return false;
        }*/
        if (!$scope.contract.notary_id > 0) {
            check = false;
        }

        //DaiCQ add check validate format for passport 10082020
        /*if (!$scope.isValidPassportFormat()) {
            check = false;
        }*/
        //END DaiCQ add check validate format for passport 10082020

        return check;
    }

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