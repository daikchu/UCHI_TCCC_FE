/**
 * Created by TienManh on 5/23/2017.
 */

// var myApp = angular.module('osp', ["xeditable","ngSanitize"]);
// myApp.run(function(editableOptions) {
//     editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
// });

myApp.controller('contractDetailController',['$scope','$http','$filter','$window','$sce','$timeout',function ($scope,$http,$filter,$window,$sce,$timeout) {
    $scope.url=url;
    $scope.checkOnline=false;
    if(from!=null && from=="1"){
        $scope.checkOnline=true;
    }
    $scope.property={};
    $scope.privys={};
    $scope.listProperty={};
    $scope.bank={};
    $scope.checkdelete=false;
    // var url="http://localhost:8082/api";
    $('html, body').animate({scrollTop: '0px'}, 0);

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

    if(code!=null && code !='undefined' && code!=""){
        $http.get(url+"/bank/get-by-code", {params:{code:code}})
            .then(function(response) {
                $scope.bank=response.data;
            });
    }

    $http.get(url+"/contract/get-contract-by-id",{params:{id:id}})
        .then(function (response) {

            $scope.contract=response.data;

            if($scope.contract.json_property!=null && $scope.contract.json_property!="" && $scope.contract.json_property!= 'undefined') {
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
            }else {
                try {
                    $http.get(url+"/contract/get-Property-by-contract-id",{params:{contractId:id}})
                        .then(function (response){
                            $scope.property_info_contract = response.data == null ? response.data : response.data.property_info;
                            $scope.type_property_info_contract = response.data == null ? response.data : response.data.type;
                            $scope.id_property_info_contract = response.data == null ? response.data : response.data.id;
                            $scope.listProperty = {"name":"property","properties":[{"id":$scope.id_property_info_contract+"","type":$scope.type_property_info_contract,"property_info":$scope.property_info_contract}]};
                        });
                } catch (e) {
                }
            }
            if($scope.contract.json_person!=null && $scope.contract.json_person!="" && $scope.contract.json_person!= 'undefined' && $scope.contract.json_person != "'{}'" && $scope.contract.json_person != "{}"){
                var person=$scope.contract.json_person.substr(1,$scope.contract.json_person.length-2);
                $scope.privys=JSON.parse(person);
            }
            if($scope.contract.json_person == "'{}'" || $scope.contract.json_person == "{}"){
                $scope.contract.json_person = "";
            }

            $scope.checkBank = ($scope.contract.addition_status==0)? false:true;
            $scope.showDescrip=$scope.checkBank;

            $scope.checkError=($scope.contract.error_status==0)?false:true;
            $scope.showError=$scope.checkError;

            //load default
            $scope.contract.office_department=$("#office-department").text();
            $scope.contract.office_province=$("#office_province").text();
            var dateArray =  $scope.contract.notary_date.split("/");
            var date=dateArray[0];
            var month=dateArray[1];
            var year=dateArray[2];
            $scope.contract.notary_date_date=date;
            $scope.contract.notary_date_month=month;
            $scope.contract.notary_date_year=year;
            var ngay=$scope.contract.notary_date_date+"/"+$scope.contract.notary_date_month+"/"+$scope.contract.notary_date_year;
            $scope.contract.convert_notary_date_date=docngaythang(ngay);
            $scope.contract.contract_value_vnd=$scope.contract.contract_value!=null?$scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,"):'';
            //$scope.contract.contract_value_vnd=$scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
            $scope.contract.contract_value_convert=docso($scope.contract.contract_value);
            if(org_type==0){
                var object = $filter('filter')($scope.notarys, {userId:parseInt($scope.contract.notary_id)},true)[0];
                console.log(object);
                $scope.contract.notary_person=object.family_name +" "+object.first_name;
            }
            else{//neu la to chuc chung thuc
                $scope.contract.notary_person=$scope.contract.contract_signer;
            }

        });

    //DaiCQ added 19/05/2020 đồng bộ các trường tài sản offline và online

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

    //END DaiCQ added 19/05/2020 đồng bộ các trường tài sản offline và online

    // phan cho v2
    $http.get(url+"/transaction/get-by-contract-id", {params: { id: contract_id}})
        .then(function(response) {
            $scope.transactionProperty=response.data;
        });
    $http.get(url+"/contract/list-contract-kind")
        .then(function(response) {
            $scope.contractKinds=response.data;
        });



    $http.get(url+"/contract/get-contract-kind-by-contract-template-code", {params: { code: template_id}})
        .then(function(response) {
            $scope.contractKind=response.data;
        });

//load for giai chap va thoi han hop dong
    $http.get(url+"/contract/get-contract-template-by-code-template", {params: { code_temp: template_id }})
        .then(function(response) {
            $scope.contractTemplate=response.data;
        });

    if(sub_template_id != null && sub_template_id != "" && sub_template_id > 0) {
        $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: sub_template_id}})
            .then(function (response) {
                $scope.contractTemplatesApiece = response.data;
            });
    }

    $http.post(url+"/users/selectByFilter","where role=03", {headers: {'Content-Type': 'application/json'} })
        .then(function (response) {
                $scope.drafters=response.data;
                return response;
            }
        );
    $http.post(url+"/users/selectByFilter","where role=02", {headers: {'Content-Type': 'application/json'} })
        .then(function (response) {
                $scope.notarys=response.data;
                return response;
            }
        );


    /*for view list duong su va tai san*/
    $http.get(url+"/ContractTemplate/privy-template")
        .then(function (response) {
            $scope.templatePrivys=response.data;
            $scope.formatDuongSu();
            $scope.formatDuongSuBenA();
            $scope.formatDuongSuBenB();
            return response;
        });
    $http.get(url+"/ContractTemplate/property-template")
        .then(function (response) {
            $scope.templateProperties=response.data;
            $scope.formatTaiSan();
            return response;
        });

    $scope.formatDuongSu=function () {
        $scope.duongsu='';
        $scope.duongsu+=duongsu_pre;
        if($scope.templatePrivys!=null && $scope.templatePrivys!='undefined' && $scope.templatePrivys!=''){
            for(var i=0;i<$scope.templatePrivys.length;i++){
                var item=$scope.templatePrivys[i];
                $scope.duongsu+='<div ng-switch-when="'+item.id+'">';
                $scope.duongsu+=item.html;
                $scope.duongsu+='</div>';
            }
        }

        $scope.duongsu+=duongsu_suff;
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

    $scope.formatTaiSan=function () {
        $scope.taisan='';
        $scope.taisan+=taisan_pre;
        if($scope.templateProperties!=null && $scope.templateProperties!='undefined' && $scope.templateProperties!=''){
            for(var i=0;i<$scope.templateProperties.length;i++){
                var item=$scope.templateProperties[i];
                $scope.taisan+='<div ng-switch-when="'+item.id+'">';
                $scope.taisan+=item.html;
                $scope.taisan+='</div>';
            }
        }

        $scope.taisan+=taisan_suff;
    };
    // $scope.duongsu='<div ng-repeat="item in privys.privy track by $index"> <div class=""><b style="font-family: Times New Roman; font-size: 14pt;" class="">Bên <span ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true">{{item.action}}</span></b> (sau đây gọi là {{item.name}}): </div> <div ng-repeat="user in item.persons track by $index" class="personList"> <div ng-switch on="user.type"> <div ng-switch-when="1"> <div class="">*Công ty:&nbsp;<span class="inputcontract" editspan="user.org_name" ng-model="user.org_name" placeholder="" contenteditable="true">{{user.org_name}}</span></div> <div class="">Địa chỉ: &nbsp;<span class="inputcontract" editspan="user.org_address" ng-model="user.org_address" placeholder="" contenteditable="true">{{user.org_address}}</span></div> <div class="">Mã số doanh nghiệp: <span class="inputcontract" editspan="user.org_code" ng-model="user.org_code" placeholder="" contenteditable="true">{{user.org_code}}</span> &nbsp; ,đăng ký lần đầu ngày: <span class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date" placeholder=" &nbsp;" contenteditable="true">{{user.first_registed_date}}</span>&nbsp; , đăng ký thay đổi lần thứ&nbsp;<span class="inputcontract" editspan="user.number_change_registed" ng-model="user.number_change_registed" placeholder="" contenteditable="true">{{user.number_change_registed}}</span>&nbsp;ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date" placeholder="&nbsp;" contenteditable="true">{{user.change_registed_date}}</span>&nbsp;theo&nbsp; <span class="inputcontract" editspan="user.department_issue" ng-model="user.department_issue" placeholder="" contenteditable="true">{{user.department_issue}}</span>&nbsp;; </div> <div class="">Họ và tên người đại diện:&nbsp;<span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="" contenteditable="true">{{user.name}}</span></div> <div class="">Chức danh:&nbsp;<span class="inputcontract" editspan="user.position" ng-model="user.position" placeholder="" contenteditable="true">{{user.position}}</span></div> </div> <div ng-switch-default> <div class="">*Họ và tên:&nbsp;<span href="#" editspan="user.name" ng-model="user.name" class="inputcontract" contenteditable="true">{{user.name}}</span>&nbsp; , sinh năm: <span placeholder="" editspan="user.birthday" ng-model="user.birthday" class="inputcontract" contenteditable="true">{{user.birthday}}</span> ; </div> </div> </div> <div class="">Giấy CMND số:&nbsp;<span placeholder="" editspan="user.passport" ng-model="user.passport" class="inputcontract" contenteditable="true">{{user.passport}}</span> cấp ngày:&nbsp; <span placeholder="" editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract" contenteditable="true">{{user.certification_date}}</span> tại: <span placeholder="" editspan="user.certification_place" ng-model="user.certification_place" class="inputcontract" contenteditable="true">{{user.certification_place}}</span> ; </div> <div class="">Địa chỉ:&nbsp;<span placeholder="" editspan="user.address" ng-model="user.address" class="inputcontract" contenteditable="true">{{user.address}}</span>; </div> </div> </div>';
    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_address" ng-model="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editspan="item.apartment.apartment_number" ng-model="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editspan="item.apartment.apartment_floor" ng-model="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_use" ng-model="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_build" ng-model="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_structure" ng-model="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor" ng-model="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editspan="item.restrict" ng-model="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editspan="item.property_info" ng-model="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';

    $scope.viewAsDoc=function () {
        $("#viewHtmlAsWord").html($("#contentKindHtml").html());
        $("#viewContentAsWord").modal('show');
    };

    $scope.downloadWord=function () {
        $("#contentKindHtml").wordExport();
    };

    $scope.downloadFile=function () {
        window.open(url+"/contract/download/"+$scope.contract.id, '_blank');
    };

    $scope.viewFile = function () {
        $http.get(url+"/contract/viewfile",{
            params: {
                id:$scope.contract.id
            }
        })
            .then(function (response) {
                // var file = window.URL.createObjectURL(this.response);
                // document.querySelector("iframe").src = file;
                $scope.vFile = response.data;
            })
    }
    //convert date dd-mm-yyyy sang dd/MM/yyyy.
    $scope.formatDate= function (stringDate) {
        if(stringDate==null || stringDate.length!=10) return null;
        var dateArray = stringDate.split("-");
        var date = dateArray[0] + "/" + dateArray[1] + "/" + dateArray[2];
        return date; //converted
    };

    //--------------------------------------------
    $scope._deleteContract = function (id) {
        var object = $filter('filter')($scope.notarys, {userId:parseInt($scope.contract.notary_id)},true)[0];
        console.log(object);
        $http.delete(url + "/contract/", {params: {id: id, userId: $scope.entry_user_id_login}} )
            .then(function (response) {
                    if (response.status == 200) {
                        $window.location.href = contextPath + '/contract/list?status=2';
                    } else {
                        $scope.checkdelete_ = false;
                        $("#errorEdit").modal('show');
                    }
                },
                function (response) {
                    // failure callback
                    $scope.checkdelete_ = false;
                    $("#errorEdit").modal('show');

                }
            )
    };

    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                });
        }
    };

    $scope.updateContractTemplate = function () {
        if($scope.contract.sub_template_id != null && $scope.contract.sub_template_id != "" && $scope.contract.sub_template_id > 0) {
            $scope.contract_template = $scope.contractTemplatesApiece;
        } else {
            $scope.contract_template = $scope.contractTemplate;
        }

        if($scope.contract.contract_template_id <= 0){
            $("#checkValidate").modal('show');
            return false;
        }
        var kind_html = $("div #contentKindHtml").html();
        if(typeof kind_html == "undefined" || kind_html.length <= 0){
            $("#checkValidate").modal('show');
            return false;
        }

        $scope.copycontract_template_ = angular.copy($scope.contract_template);

        $timeout(function() {
            var kind_html = $("div #contentKindHtml").html();

            var update_contract_template = {
                id:"",
                name:"",
                kind_id:"",
                kind_id_tt08:"",
                code:"",
                description:"",
                file_name:"",
                file_path:"",
                active_flg:"",
                relate_object_number:"",
                relate_object_A_display:"",
                relate_object_B_display:"",
                relate_object_C_display:"",
                period_flag:"",
                period_req_flag:"",
                mortage_cancel_func:"",
                sync_option:"",
                entry_user_id:"",
                entry_user_name:"",
                entry_date_time:"",
                update_user_id:"",
                update_user_name:"",
                update_date_time:"",
                kind_html:"",
                office_code:"",
                code_template:""
            };

            update_contract_template.id = $scope.contract_template.contractTemplateId;
            update_contract_template.name = $scope.contract_template.name;
            update_contract_template.kind_id = $scope.contract_template.kind_id;
            update_contract_template.kind_id_tt08 = $scope.contract_template.kind_id_tt08;
            update_contract_template.code = $scope.contract_template.code;
            update_contract_template.description = $scope.contract_template.description;
            update_contract_template.file_name = $scope.contract_template.file_name;
            update_contract_template.file_path = $scope.contract_template.file_path;
            update_contract_template.active_flg = $scope.contract_template.active_flg;
            update_contract_template.relate_object_number = $scope.contract_template.relate_object_number;
            if(typeof $scope.contract_template.relate_object_a_display != "undefined") {
                update_contract_template.relate_object_A_display = $scope.contract_template.relate_object_a_display;
            }else {
                update_contract_template.relate_object_A_display = "";
            }
            if(typeof $scope.contract_template.relate_object_b_display != "undefined") {
                update_contract_template.relate_object_B_display = $scope.contract_template.relate_object_b_display;
            }else {
                update_contract_template.relate_object_B_display = "";
            }
            if(typeof $scope.contract_template.relate_object_c_display != "undefined") {
                update_contract_template.relate_object_C_display = $scope.contract_template.relate_object_c_display;
            }else {
                update_contract_template.relate_object_C_display = "";
            }
            update_contract_template.period_flag = $scope.contract_template.period_flag;
            update_contract_template.period_req_flag = $scope.contract_template.period_req_flag;
            update_contract_template.mortage_cancel_func = $scope.contract_template.mortage_cancel_func;
            update_contract_template.sync_option = $scope.contract_template.sync_option;
            update_contract_template.entry_user_id = $scope.contract_template.entry_user_id;
            update_contract_template.entry_user_name = $scope.contract_template.entry_user_name;
            update_contract_template.entry_date_time = $scope.contract_template.entry_date_time;
            update_contract_template.update_user_id = $scope.contract_template.update_user_id;
            update_contract_template.update_user_name = $scope.contract_template.update_user_name;
            update_contract_template.update_date_time = new Date();
            update_contract_template.kind_html = kind_html;
            if($scope.contract_template.office_code == null || $scope.contract_template.office_code == "" || typeof $scope.contract_template.office_code == "undefined"){
                update_contract_template.office_code = "";
            }else{
                update_contract_template.office_code = $scope.contract_template.office_code;
            }
            update_contract_template.code_template = $scope.contract_template.code_template;

            //check div tồn tại
            kind_html = kind_html.replace("dynamic=\"duongsu\"", "id=\"id_duongsu\" dynamic=\"duongsu\"");
            kind_html = kind_html.replace("dynamic=\"taisan\"", "id=\"id_taisan\" dynamic=\"taisan\"");
            $scope.copycontract_template_.kind_html = $scope.copycontract_template_.kind_html.replace("dynamic=\"duongsu\"", "id=\"id_duongsu\" dynamic=\"duongsu\"");
            $scope.copycontract_template_.kind_html = $scope.copycontract_template_.kind_html.replace("dynamic=\"taisan\"", "id=\"id_taisan\" dynamic=\"taisan\"");

            var doc = new DOMParser().parseFromString($scope.copycontract_template_.kind_html, "text/html");
            var docupdate = new DOMParser().parseFromString(kind_html, "text/html");

            if(doc.body.innerHTML.length>0){
                if(doc.getElementById("id_duongsu")){
                    if(!docupdate.getElementById("id_duongsu")){
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }

                if(doc.getElementById("id_taisan")){
                    if(!docupdate.getElementById("id_taisan")){
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }
            }
            //end check

            var form = '';

            form += '<input type="hidden" name="id" value="'+update_contract_template.id+'">';
            form += '<input type="hidden" name="name" value="'+update_contract_template.name+'">';
            form += '<input type="hidden" name="kind_id" value="'+update_contract_template.kind_id+'">';
            form += '<input type="hidden" name="kind_id_tt08" value="'+update_contract_template.kind_id_tt08+'">';
            form += '<input type="hidden" name="code" value="'+update_contract_template.code+'">';
            form += '<input type="hidden" name="description" value="'+update_contract_template.description+'">';
            form += '<input type="hidden" name="file_name" value="'+update_contract_template.file_name+'">';
            form += '<input type="hidden" name="file_path" value="'+update_contract_template.file_path+'">';
            form += '<input type="hidden" name="active_flg" value="'+update_contract_template.active_flg+'">';
            form += '<input type="hidden" name="relate_object_number" value="'+update_contract_template.relate_object_number+'">';
            form += '<input type="hidden" name="relate_object_A_display" value="'+update_contract_template.relate_object_A_display+'">';
            form += '<input type="hidden" name="relate_object_B_display" value="'+update_contract_template.relate_object_B_display+'">';
            form += '<input type="hidden" name="relate_object_C_display" value="'+update_contract_template.relate_object_C_display+'">';
            form += '<input type="hidden" name="period_flag" value="'+update_contract_template.period_flag+'">';
            form += '<input type="hidden" name="period_req_flag" value="'+update_contract_template.period_req_flag+'">';
            form += '<input type="hidden" name="mortage_cancel_func" value="'+update_contract_template.mortage_cancel_func+'">';
            form += '<input type="hidden" name="sync_option" value="'+update_contract_template.sync_option+'">';
            form += '<input type="hidden" name="entry_user_id" value="'+update_contract_template.entry_user_id+'">';
            form += '<input type="hidden" name="entry_user_name" value="'+update_contract_template.entry_user_name+'">';
            form += '<input type="hidden" name="entry_date_time" value="">';
            form += '<input type="hidden" name="update_user_id" value="'+update_contract_template.update_user_id+'">';
            form += '<input type="hidden" name="update_user_name" value="'+update_contract_template.update_user_name+'">';
            form += '<input type="hidden" name="update_date_time" value="">';
            form += '<textarea id="conTractTemPlatePostCustumUpdateJS_kind_html" class="hidden" name="kind_html" rows="10"></textarea>';
            form += '<input type="hidden" name="office_code" value="'+update_contract_template.office_code+'">';
            form += '<input type="hidden" name="code_template" value="'+update_contract_template.code_template+'">';

            var _form_ = $('<form target="_blank" id = "conTractTemPlatePostCustumUpdateJS" class="hidden" action="'+conTractTemPlatePostCustumUpdateJS+'" method="post">'+form+'</form>');
            $('body').append(_form_);
            document.getElementById("conTractTemPlatePostCustumUpdateJS_kind_html").value = update_contract_template.kind_html;
            $("#conTractTemPlatePostCustumUpdateJS").submit();
            $("#conTractTemPlatePostCustumUpdateJS").remove();
        }, 0);
    };

    $scope.addContractTemplate = function () {
        if($scope.contract.sub_template_id != null && $scope.contract.sub_template_id != "" && $scope.contract.sub_template_id > 0) {
            $scope.contract_template = $scope.contractTemplatesApiece;
        } else {
            $scope.contract_template = $scope.contractTemplate;
        }

        if($scope.contract.contract_template_id <= 0){
            $("#checkValidate").modal('show');
            return false;
        }
        var kind_html = $("div #contentKindHtml").html();
        if(typeof kind_html == "undefined" || kind_html.length <= 0){
            $("#checkValidate").modal('show');
            return false;
        }

        $scope.copycontract_template_ = angular.copy($scope.contract_template);

        $timeout(function() {
            var kind_html = $("div #contentKindHtml").html();

            var add_contract_template = {
                id:"",
                name:"",
                kind_id:"",
                kind_id_tt08:"",
                code:"",
                description:"",
                file_name:"",
                file_path:"",
                active_flg:"",
                relate_object_number:"",
                relate_object_A_display:"",
                relate_object_B_display:"",
                relate_object_C_display:"",
                period_flag:"",
                period_req_flag:"",
                mortage_cancel_func:"",
                sync_option:"",
                entry_user_id:"",
                entry_user_name:"",
                entry_date_time: new Date(),
                update_user_id:"",
                update_user_name:"",
                update_date_time: new Date(),
                kind_html:"",
                office_code:"",
                code_template:""
            };

            add_contract_template.id = $scope.contract_template.contractTemplateId;
            add_contract_template.name = $scope.contract_template.name;
            add_contract_template.kind_id = $scope.contract_template.kind_id;         //mẫu con
            add_contract_template.kind_id_tt08 = $scope.contract_template.kind_id_tt08;
            add_contract_template.code = $scope.contract_template.code;
            add_contract_template.description = $scope.contract_template.description;
            add_contract_template.file_name = $scope.contract_template.file_name;
            add_contract_template.file_path = $scope.contract_template.file_path;
            add_contract_template.active_flg = $scope.contract_template.active_flg;
            add_contract_template.relate_object_number = $scope.contract_template.relate_object_number;
            if(typeof $scope.contract_template.relate_object_a_display != "undefined") {
                add_contract_template.relate_object_A_display = $scope.contract_template.relate_object_a_display;
            }else {
                add_contract_template.relate_object_A_display = "";
            }
            if(typeof $scope.contract_template.relate_object_b_display != "undefined") {
                add_contract_template.relate_object_B_display = $scope.contract_template.relate_object_b_display;
            }else {
                add_contract_template.relate_object_B_display = "";
            }
            if(typeof $scope.contract_template.relate_object_c_display != "undefined") {
                add_contract_template.relate_object_C_display = $scope.contract_template.relate_object_c_display;
            }else {
                add_contract_template.relate_object_C_display = "";
            }
            add_contract_template.period_flag = $scope.contract_template.period_flag;
            add_contract_template.period_req_flag = $scope.contract_template.period_req_flag;
            add_contract_template.mortage_cancel_func = $scope.contract_template.mortage_cancel_func;
            add_contract_template.sync_option = $scope.contract_template.sync_option;
            add_contract_template.entry_user_id = $scope.contract_template.entry_user_id;
            add_contract_template.entry_user_name = $scope.contract_template.entry_user_name;
            add_contract_template.entry_date_time = $scope.contract_template.entry_date_time;
            add_contract_template.update_user_id = $scope.contract_template.update_user_id;
            add_contract_template.update_user_name = $scope.contract_template.update_user_name;
            add_contract_template.update_date_time = new Date();
            add_contract_template.kind_html = kind_html;
            if($scope.contract_template.office_code == null || $scope.contract_template.office_code == "" || typeof $scope.contract_template.office_code == "undefined"){
                add_contract_template.office_code = "";
            }else{
                add_contract_template.office_code = $scope.contract_template.office_code;
            }
            add_contract_template.code_template = $scope.contract_template.code_template;

            //check div tồn tại
            kind_html = kind_html.replace("dynamic=\"duongsu\"", "id=\"id_duongsu\" dynamic=\"duongsu\"");
            kind_html = kind_html.replace("dynamic=\"taisan\"", "id=\"id_taisan\" dynamic=\"taisan\"");
            $scope.copycontract_template_.kind_html = $scope.copycontract_template_.kind_html.replace("dynamic=\"duongsu\"", "id=\"id_duongsu\" dynamic=\"duongsu\"");
            $scope.copycontract_template_.kind_html = $scope.copycontract_template_.kind_html.replace("dynamic=\"taisan\"", "id=\"id_taisan\" dynamic=\"taisan\"");

            var doc = new DOMParser().parseFromString($scope.copycontract_template_.kind_html, "text/html");
            var docupdate = new DOMParser().parseFromString(kind_html, "text/html");

            if(doc.body.innerHTML.length>0){
                if(doc.getElementById("id_duongsu")){
                    if(!docupdate.getElementById("id_duongsu")){
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }

                if(doc.getElementById("id_taisan")){
                    if(!docupdate.getElementById("id_taisan")){
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }
            }
            //end check

            var form = '';

            form += '<input type="hidden" name="id" value="'+add_contract_template.id+'">';
            form += '<input type="hidden" name="name" value="'+add_contract_template.name+'">';
            form += '<input type="hidden" name="kind_id" value="'+add_contract_template.kind_id+'">';
            form += '<input type="hidden" name="kind_id_tt08" value="'+add_contract_template.kind_id_tt08+'">';
            form += '<input type="hidden" name="code" value="'+add_contract_template.code+'">';
            form += '<input type="hidden" name="description" value="'+add_contract_template.description+'">';
            form += '<input type="hidden" name="file_name" value="'+add_contract_template.file_name+'">';
            form += '<input type="hidden" name="file_path" value="'+add_contract_template.file_path+'">';
            form += '<input type="hidden" name="active_flg" value="'+add_contract_template.active_flg+'">';
            form += '<input type="hidden" name="relate_object_number" value="'+add_contract_template.relate_object_number+'">';
            form += '<input type="hidden" name="relate_object_A_display" value="'+add_contract_template.relate_object_A_display+'">';
            form += '<input type="hidden" name="relate_object_B_display" value="'+add_contract_template.relate_object_B_display+'">';
            form += '<input type="hidden" name="relate_object_C_display" value="'+add_contract_template.relate_object_C_display+'">';
            form += '<input type="hidden" name="period_flag" value="'+add_contract_template.period_flag+'">';
            form += '<input type="hidden" name="period_req_flag" value="'+add_contract_template.period_req_flag+'">';
            form += '<input type="hidden" name="mortage_cancel_func" value="'+add_contract_template.mortage_cancel_func+'">';
            form += '<input type="hidden" name="sync_option" value="'+add_contract_template.sync_option+'">';
            form += '<input type="hidden" name="entry_user_id" value="'+add_contract_template.entry_user_id+'">';
            form += '<input type="hidden" name="entry_user_name" value="'+add_contract_template.entry_user_name+'">';
            form += '<input type="hidden" name="entry_date_time" value="">';
            form += '<input type="hidden" name="update_user_id" value="'+add_contract_template.update_user_id+'">';
            form += '<input type="hidden" name="update_user_name" value="'+add_contract_template.update_user_name+'">';
            form += '<input type="hidden" name="update_date_time" value="">';
            form += '<textarea id="conTractTemPlatePostCustumAddJS_kind_html" class="hidden" name="kind_html" rows="10"></textarea>';
            form += '<input type="hidden" name="office_code" value="'+add_contract_template.office_code+'">';
            form += '<input type="hidden" name="code_template" value="'+add_contract_template.code_template+'">';

            var _form_ = $('<form target="_blank" id = "conTractTemPlatePostCustumAddJS" class="hidden" action="'+conTractTemPlatePostCustumAddJS+'" method="post">'+form+'</form>');
            $('body').append(_form_);
            document.getElementById("conTractTemPlatePostCustumAddJS_kind_html").value = add_contract_template.kind_html;
            $("#conTractTemPlatePostCustumAddJS").submit();
            $("#conTractTemPlatePostCustumAddJS").remove();
        }, 0);
    };

    // $scope.viewFile = function () {
    //     var oFileIn;
    //     oFileIn = document.getElementById('my_file_input');
    //     if(oFileIn.addEventListener) {
    //         oFileIn.addEventListener('change', filePicked, false);
    //     }
    // }
    // function filePicked(oEvent) {
    //     // Get The File From The Input
    //     var oFile = oEvent.target.files[0];
    //     var sFilename = oFile.name;
    //     // Create A File Reader HTML5
    //     var reader = new FileReader();
    //
    //     // Ready The Event For When A File Gets Selected
    //     reader.onload = function(e) {
    //         var data = e.target.result;
    //         var cfb = XLS.CFB.read(data, {type: 'binary'});
    //         var wb = XLS.parse_xlscfb(cfb);
    //         // Loop Over Each Sheet
    //         wb.SheetNames.forEach(function(sheetName) {
    //             // Obtain The Current Row As CSV
    //             var sCSV = XLS.utils.make_csv(wb.Sheets[sheetName]);
    //             var oJS = XLS.utils.sheet_to_row_object_array(wb.Sheets[sheetName]);
    //
    //             $("#my_file_output").html(sCSV);
    //             console.log(oJS)
    //         });
    //     };
    //
    //     // Tell JS To Start Reading The File.. You could delay this if desired
    //     reader.readAsBinaryString(oFile);
    // }
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
            scope.$watch(attrs.dynamic, function(html) {
                ele.html(html);
                $compile(ele.contents())(scope);
            });
        }
    };
});

myApp.directive('compile', function ($compile) {
    // directive factory creates a link function
    return function (scope, element, attrs) {
        scope.$watch(
            // first param is name of property in scope to watch
            function (scope) {
                // watch the 'compile' expression for changes
                return scope.$eval(attrs.compile);
            },
            // second param is function to run if that property value changes.
            function (value) {
                // when the 'compile' expression changes
                // assign it into the current DOM
                element.html(value);

                // compile the new DOM and link it to the current
                // scope.
                // NOTE: we only compile .childNodes so that
                // we don't get into infinite loop compiling ourselves
                $compile(element.contents())(scope);
            });
    };
})