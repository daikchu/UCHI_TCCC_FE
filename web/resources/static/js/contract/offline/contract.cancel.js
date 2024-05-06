/**
 * Created by TienManh on 5/28/2017.
 */

// var myApp = angular.module('osp', ["xeditable","ngSanitize"]);
myApp.run(function (editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});

myApp.controller('contractEditController', ['$scope', '$http', '$filter', '$window', 'fileUpload', function ($scope, $http, $filter, $window, fileUpload) {
    $scope.privys = {};
    $scope.listProperty = {};
    $scope.number_contract_old = number_contract;
    $scope.announcement = {notaryFee: ""};
    $scope.myFile = {file: ""};
    // var url="http://localhost:8082/api";
    $scope.checkOnline = false;
    if (from != null && from == "1") {
        $scope.checkOnline = true;
    }

    $scope.org_type = org_type;

    //Bổ sung các loại tài sản thuộc bất động sản
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

    // cho phep chon lại tên hợp đồng khi hủy
    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    //check online or offline
                    if ($scope.contract.kindhtml != null && $scope.contract.kindhtml.length > 0) {
                        $scope.contract_template = response.data;
                        $scope.contract.kindhtml = $scope.contract_template.kind_html;
                    } else {
                        $scope.contract_template = response.data;
                    }
                    //sonnv
                    $scope.getActionContractTemplate();
                    if (sub_template_id != null && sub_template_id != "" && sub_template_id > 0) {
                        $scope.changeTemplate_Apiece(code);
                        //fix copy
                        $scope.contract_template_copy = response.data;
                        $scope.kindhtml_copy = $scope.contract_template.kind_html;
                    }
                    //end
                });
        }
    };

    //DaiCQ added 19/05/2020 đồng bộ tài sản offline online

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
        /*05/09/2020 đồng bộ cấu trúc tài sản offline online*/
        if(typeof $scope.templateProperties == 'undefined'){
            $http.get(url + "/ContractTemplate/property-template")
                .then(function (response) {
                    $scope.templateProperties = response.data;
                    /*$scope.formatTaiSan();*/
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
        }
        /*END 05/09/2020 đồng bộ cấu trúc tài sản offline online*/

        if(type!='01'){
            $scope.listProperty.properties[index].type_real_estate = "";
            $scope.listProperty.properties[index].type_real_estate_sub = "";
        }

    };

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

    //END DaiCQ added 19/05/2020



    /*phan cho v2*/
    $http.get(url + "/transaction/get-by-contract-id", {params: {id: contract_id}})
        .then(function (response) {
            $scope.transactionProperty = response.data;
        });
    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });
    /*$scope.myFuncLoadMortage=function(codeTemplate){

        $http.get(url+"/contract/get-contract-template-by-code-template", {params: { code_temp: codeTemplate }})
            .then(function(response) {
                $scope.template=response.data;
                $(function () {
                    $('#periodDate').datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse : false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                    $('#mortageCancelDate').datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "01/01/1900",
                        endDate: endDate,
                        forceParse : false,
                        language: 'vi'
                    }).on('changeDate', function (ev) {
                        $(this).datepicker('hide');
                    });
                });
            });

    };*/


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

    //sonnv
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
        window.open(url + "/contract/download/" + $scope.contract.id, '_blank');
    };
    //tab này chỉ xóa đường dẫn
    $scope.removeFile_ = function () {
        $scope.contract.file_name = "";
        $scope.contract.file_path = "";
    };
    //end

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

    $scope.changeTemplate_Apiece = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-parent-code-template", {params: {kind_id: code}})
                .then(function (response) {
                    $scope.contractTemplatesApiece = response.data;
                });
        } else {
            $scope.contractTemplatesApiece = "";
        }
    };

    $scope.changeTemplate_Apiece_Select = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    $scope.contract.kindhtml = $scope.contract_template.kind_html;
                    console.log($scope.contract);
                });
        } else {
            $scope.contract_template = $scope.contract_template_copy;
            $scope.contract.kindhtml = $scope.kindhtml_copy;
        }
    };

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


    /*test for load html $compile*/
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

    // $scope.duongsu='<div ng-repeat="item in privys.privy track by $index"> <div class=""><b style="font-family: Times New Roman; font-size: 14pt;" class="">Bên <span ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true">{{item.action}}</span></b> (sau đây gọi là {{item.name}}): </div> <div ng-repeat="user in item.persons track by $index" class="personList"> <div ng-switch on="user.type"> <div ng-switch-when="1"> <div class="">*Công ty:&nbsp;<span class="inputcontract" editspan="user.org_name" ng-model="user.org_name" placeholder="" contenteditable="true">{{user.org_name}}</span></div> <div class="">Địa chỉ: &nbsp;<span class="inputcontract" editspan="user.org_address" ng-model="user.org_address" placeholder="" contenteditable="true">{{user.org_address}}</span></div> <div class="">Mã số doanh nghiệp: <span class="inputcontract" editspan="user.org_code" ng-model="user.org_code" placeholder="" contenteditable="true">{{user.org_code}}</span> &nbsp; ,đăng ký lần đầu ngày: <span class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date" placeholder=" &nbsp;" contenteditable="true">{{user.first_registed_date}}</span>&nbsp; , đăng ký thay đổi lần thứ&nbsp;<span class="inputcontract" editspan="user.number_change_registed" ng-model="user.number_change_registed" placeholder="" contenteditable="true">{{user.number_change_registed}}</span>&nbsp;ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date" placeholder="&nbsp;" contenteditable="true">{{user.change_registed_date}}</span>&nbsp;theo&nbsp; <span class="inputcontract" editspan="user.department_issue" ng-model="user.department_issue" placeholder="" contenteditable="true">{{user.department_issue}}</span>&nbsp;; </div> <div class="">Họ và tên người đại diện:&nbsp;<span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="" contenteditable="true">{{user.name}}</span></div> <div class="">Chức danh:&nbsp;<span class="inputcontract" editspan="user.position" ng-model="user.position" placeholder="" contenteditable="true">{{user.position}}</span></div> </div> <div ng-switch-default> <div class="">*Họ và tên:&nbsp;<span href="#" editspan="user.name" ng-model="user.name" class="inputcontract" contenteditable="true">{{user.name}}</span>&nbsp; , sinh năm: <span placeholder="" editspan="user.birthday" ng-model="user.birthday" class="inputcontract" contenteditable="true">{{user.birthday}}</span> ; </div> </div> </div> <div class="">Giấy CMND số:&nbsp;<span placeholder="" editspan="user.passport" ng-model="user.passport" class="inputcontract" contenteditable="true">{{user.passport}}</span> cấp ngày:&nbsp; <span placeholder="" editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract" contenteditable="true">{{user.certification_date}}</span> tại: <span placeholder="" editspan="user.certification_place" ng-model="user.certification_place" class="inputcontract" contenteditable="true">{{user.certification_place}}</span> ; </div> <div class="">Địa chỉ:&nbsp;<span placeholder="" editspan="user.address" ng-model="user.address" class="inputcontract" contenteditable="true">{{user.address}}</span>; </div> </div> </div>';
    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_address" ng-model="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editspan="item.apartment.apartment_number" ng-model="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editspan="item.apartment.apartment_floor" ng-model="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_use" ng-model="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_build" ng-model="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_structure" ng-model="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor" ng-model="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editspan="item.restrict" ng-model="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editspan="item.property_info" ng-model="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';

    $http.get(url + "/contract/get-contract-by-id", {params: {id: id}})
        .then(function (response) {

            $scope.contract = response.data;

            $scope.contract.summary = "Văn bản hủy hợp đồng số " + $scope.contract.contract_number;
            /*$scope.contract.file_name = "";
            $scope.contract.file_path = "";*/

            if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                try {
                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                    $scope.listProperty = JSON.parse(pri);
                    for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                        var thisProperty = $scope.listProperty.properties[i];
                        if (typeof thisProperty.template == 'undefined') {
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
                    }

                    /*default date for contract-property. Neu de ngoai thi se ko load dc cung`. khi click vao date lan` dau` ko chon thi se bien' mat*/
                    $(function () {
                        $scope.datePropertyFormat();

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
                    $(function () {
                        $scope.datePersonFormat();
                    })
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

            //set contract_NUMBER
            $http.get(url + "/contract/contractNumber", {params: {year: now.getFullYear(), userId: org_type == 1?userEntryId:0}})
                .then(function (response) {
                    $scope.contract.contract_number = response.data + "/" + now.getFullYear();
                    return response;
                });

            //load default
            $scope.contract.office_department = $("#office-department").text();
            $scope.contract.office_province = $("#office_province").text();
            var dateArray = $scope.contract.notary_date.split("/");
            var date = dateArray[0];
            var month = dateArray[1];
            var year = dateArray[2];
            $scope.contract.notary_date_date = date;
            $scope.contract.notary_date_month = month;
            $scope.contract.notary_date_year = year;
            var ngay = $scope.contract.notary_date_date + "/" + $scope.contract.notary_date_month + "/" + $scope.contract.notary_date_year;
            $scope.contract.convert_notary_date_date = docngaythang(ngay);
            $scope.contract.contract_value_vnd = $scope.contract.contract_value != null ? $scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") : '';
            //   $scope.contract.contract_value_vnd=$scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
            $scope.contract.contract_value_convert = docso($scope.contract.contract_value);
            var object = $filter('filter')($scope.notarys, {userId: parseInt($scope.contract.notary_id)}, true)[0];
            console.log(object);
            $scope.contract.notary_person = object.family_name + " " + object.first_name;
        });

    $scope.changeDateNotary = function (value) {
        if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
            var dateArray = value.split("/");
            var year = dateArray[2];
            if (year != now.getFullYear()) {
                if (Number(year) && 1900 < year && year < 2100) {
                    //kiem tra xem co phai phuong xa tap trung ko.(Neu la phuong xa tap trung 1 project thi contract_number= year/userId/contract_number)
                    $http.get(url + "/contract/contractNumber", {params: {year: year, userId: org_type == 1?userEntryId:0}})
                        .then(function (response) {
                            $scope.contract.contract_number = response.data + "/" + year;
                            return response;
                        });

                }
            }
        }
    };

    /*duong su va tai san*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    $scope.addPrivy = function () {
        if ($scope.privys.privy.length < alphabet.length) {
            var object = {
                id: $scope.privys.privy.length,
                name: "Bên " + alphabet[$scope.privys.privy.length],
                action: "",
                persons: [{id: "", name: "", description: ""}]
            };
            $scope.privys.privy.push(object);
            //sonnv
            $scope.getActionContractTemplate();
        }
    };
    $scope.removePrivy = function (index) {
        $scope.privys.privy.splice(index, 1);
        //danh lai ten cho cac ben lien quan khi xoa
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            $scope.privys.privy[i].name = "Bên " + alphabet[i];
            $scope.privys.privy[i].id = i + 1;
        }
        //sonnv
        $scope.getActionContractTemplate();
    };
    $scope.addPerson = function (index) {
        var object = {
            type: 0,
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
    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };

    $scope.addProperty = function () {
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
            owner_info_address: "",
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
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
            type_real_estate: "",
            type_real_estate_sub:""

        };
        $scope.listProperty.properties.push(object);
        $(function () {
            $scope.datePropertyFormat();
        });
    };

    $scope.removeProperty = function (index) {
        $scope.listProperty.properties.splice(index, 1);
    };
    /*set format date for person and property*/
    $scope.datePersonFormat = function () {
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
    $scope.cancelContract = function () {

        if ($scope.checkAllRequiredField()) {
            if ($scope.checkValidate()) {
                if ($scope.checkDate()) {
                    $("#checkDate").modal('show');
                } else {
                    //check contract_number
                    $http.get(url + "/contract/checkContractNumber", {params: {contract_number: $scope.contract.contract_number}})
                        .then(function (response) {
                            if (response.status == 200 && response.data == true) {
                                var object_bank_by_id = $filter('filter')($scope.banks, {code: $scope.contract.bank_code}, true)[0];
                                if (object_bank_by_id != null && object_bank_by_id != "undefined") {
                                    $scope.contract.bank_name = object_bank_by_id.name;
                                }
                                /*genaral duong su va tai san*/
                                $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
                                if (typeof $scope.privys != "undefined" && $scope.privys.length > 0 && $scope.privys != {}) {
                                    $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";
                                } else {
                                    $scope.contract.json_person = "";
                                }
                                var json_person = $scope.contract.json_person;
                                $scope.contract.entry_date_time = new Date();
                                $scope.contract.update_date_time = new Date();
                                // lưu thông tin cho phần hủy hợp đồng
                                $scope.contract.kindhtml = $("div #contentKindHtml").html();
                                var test = $("div #contentKindHtml").html();
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

                                if (json_person !== null && json_person !== '' && json_person !== 'undefined' && json_person !== '{}' && json_person !== "'{}'") {
                                    $scope.genInforProAndPrivys();
                                }

                                var contractCancel = JSON.parse(JSON.stringify($scope.contract));
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


                                                        var contractCancel = JSON.parse(JSON.stringify($scope.contract));
                                                        $http.post(url + "/contract/cancel", contractCancel, {headers: {'Content-Type': 'application/json'}})
                                                            .then(function (response) {
                                                                    if (response.status == 200) {
                                                                        if ($scope.checkOnline) {
                                                                            $window.location.href = contextPath + '/contract/temporary/list?status=4';
                                                                        } else {
                                                                            $window.location.href = contextPath + '/contract/list?status=3';
                                                                        }
                                                                    } else {
                                                                        $scope.checkCancel = false;
                                                                        $("#errorAdd").modal('show');
                                                                    }
                                                                },
                                                                function (response) {
                                                                    // failure callback
                                                                    $scope.checkCancel = false;
                                                                    $("#errorAdd").modal('show');

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
                                    $http.post(url + "/contract/cancel", contractCancel, {headers: {'Content-Type': 'application/json'}})
                                        .then(function (response) {
                                                if (response.status == 200) {
                                                    if ($scope.checkOnline) {
                                                        $window.location.href = contextPath + '/contract/temporary/list?status=4';
                                                    } else {
                                                        $window.location.href = contextPath + '/contract/list?status=3';
                                                    }
                                                } else {
                                                    $scope.checkCancel = false;
                                                    $("#errorAdd").modal('show');
                                                }
                                            },
                                            function (response) {
                                                // failure callback
                                                $scope.checkCancel = false;
                                                $("#errorAdd").modal('show');
                                            }
                                        );
                                }

                            } else {
                                //alert(response.statusText);
                                $("#checkContractNumber").modal('show');
                            }
                        });
                }

            } else {
                $("#checkValidate").modal('show');
            }

        } else {
            $("#checkValidate").modal('show');
        }
    };

    $scope.genInforProAndPrivys = function () {
        /*gen contract.propertyInfo va relation_object*/
        if ($scope.privys != null && $scope.privys != "") {
            $scope.contract.relation_object_a = "";
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
                        } else {
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
        }
        /*lay relation_object_b thay the cho property_Info*/
        $scope.contract.relation_object_b = "";
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
                    if (item.land != null && item.land !== 'undefined') {
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
                    if (!isNullOrEmpty(item.template) && item.template==11) {
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
                    else if (!isNullOrEmpty(item.template) && item.template == 12) {
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
                    else {
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
                            stringpro += "Số máy: " + item.vehicle.car_machine_number + "; ";
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
    $scope.checkValidate = function () {
        var check = true;
        $scope.received_date_ = "";
        if (isNullOrEmpty($scope.contract.contract_template_id) || !$scope.contract.contract_template_id > 0) {
            check = false;
        }
        if (isNullOrEmpty($scope.contract.contract_number) || !$scope.contract.contract_number.toString().length > 0) {
            check = false;
        }
        if(org_type==1) {
            if(isNullOrEmpty($scope.contract.received_date) || !$scope.contract.received_date.toString().length==10){
                $scope.received_date_ = "Trường không được bỏ trống và theo định dạng dd/MM/yyyy.";
                check = false;
            }
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
        return check;
    };

    $scope.checkAllRequiredField = function () {
        var check = true;
        $scope.contractKindValue_ = "";
        $scope.contract_template_id_ = "";
        $scope.contract_number_ = "";
        $scope.received_date_ = "";
        $scope.notary_date_ = "";
        $scope.notary_id_ = "";
        $scope.contract_signer_ = "";
        $scope.contract_value_ = "";


        /*        if($scope.contractKindValue == null || $scope.contractKindValue == 'undefined' || $scope.contractKindValue == ''){
                    $scope.contractKindValue_ = "Trường không được bỏ trống. ";
                    check = false;
                }*/
        if (isNullOrEmpty($scope.contract.contract_template_id)) {
            $scope.contract_template_id_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if (isNullOrEmpty($scope.contract.contract_number)) {
            $scope.contract_number_ = "Trường không được bỏ trống. ";
            check = false;
        }
        /*        if($scope.contract.received_date == null || $scope.contract.received_date =='undefined' || $scope.contract.received_date ==''){
                    $scope.received_date_ = "Trường không được bỏ trống và theo định dạng dd/MM/yyyy. ";
                    check = false;
                }*/
        if (isNullOrEmpty($scope.contract.notary_date)) {
            $scope.notary_date_ = "Trường không được bỏ trống và theo định dạng dd/MM/yyyy. ";
            check = false;
        }
        if (isNullOrEmpty($scope.contract.notary_id)) {
            $scope.notary_id_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if (isNullOrEmpty($scope.contract.contract_value)) {
            $scope.contract_value_ = "Trường không được bỏ trống!";
            check = false;
        }
        if ($scope.org_type == 1) {
            if (isNullOrEmpty($scope.contract.contract_signer)) {
                $scope.contract_signer_ = "Trường không được bỏ trống. ";
                check = false;
            }
        }
        return check;
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

