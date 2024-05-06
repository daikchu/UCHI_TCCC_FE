/**
 * Created by TienManh on 6/4/2017.
 */
myApp.controller('temporaryDetailController', ['$scope', '$http', '$filter', '$window', '$sce', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $sce, $timeout, $q, fileUpload) {
    $scope.url = url;
    $scope.myFile = {file: ""};
    $scope.privys = {};
    $scope.listProperty = {};
    $scope.bank = {};
    $scope.checkdelete = false;
    $scope.announcement = {notaryFee: ""};
    $scope.userEntryId = userEntryId;


//Bổ sung các loại tài sản thuộc bất động sản
    $scope.property_real_estate_type = [];
    $scope.property_real_estate_type_sub = [];
    $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: 0}})
        .then(function (response) {

            $scope.property_real_estate_type = response.data;
        });

    $scope.changePropertyRealEstate = function (index, parent_code) {
        $http.get(url + "/contract/get-list-property-real-estate-type", {params: {parent_code: parent_code}})
            .then(function (response) {
                $scope["property_real_estate_type_sub" + index] = response.data;
                /*if($scope["property_real_estate_type_sub" + index] == null || $scope["property_real_estate_type_sub" + index].length==0) {
                    $scope.listProperty.properties[index].type_real_estate = parent_code;
                }
                else $scope.listProperty.properties[index].type_real_estate = $scope["property_real_estate_type_sub" + index][0].code;*/
            });
    };

    $scope.getListRealEstateTypeSubByIndex = function (index) {
        return $scope["property_real_estate_type_sub" + index];
    };
    //END Bổ sung các loại tài sản thuộc bất động sản


    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    $scope.contract.kindhtml = $scope.contract_template.kind_html;

                    //sonnv fix teamplate con
                    $scope.changeTemplate_Apiece(code);
                    $scope.getActionContractTemplate();
                    //fix copy
                    $scope.contract_template_copy = response.data;
                    $scope.kindhtml_copy = $scope.contract_template.kind_html;
                });
        }
    };

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
        }
    };

    $scope.changeTemplate_Apiece_Select = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    $scope.contract.kindhtml = $scope.contract_template.kind_html;
                });
        } else {
            $scope.contract_template = $scope.contract_template_copy;
            $scope.contract.kindhtml = $scope.kindhtml_copy;
        }
    };

    $scope.getContractNumber = function () {
        //kiem tra xem co phai phuong xa tap trung ko.(Neu la phuong xa tap trung 1 project thi contract_number= year/userId/contract_number)
        var year = now.getFullYear();
        if (org_type == 1) {
            $http.get(url + "/contract/contractNumber", {params: {year: year, userId: userEntryId}})
                .then(function (response) {
                    /*$scope.contract.contract_number = year + "/" + userEntryId + "/" + response.data;*/
                    $scope.contract.contract_number = response.data + "/" + year;
                    return response;
                });
        } else {

            $http.get(url + "/contract/contractNumber", {params: {year: year, userId: 0}})
                .then(function (response) {
                    $scope.contract.contract_number = response.data + "/" + year;
                    /*$scope.contract.contract_number = year + "/" + response.data;*/
                    return response;
                });
        }
    };
    $scope.removeFile = function () {
        $http.get(url + "/contract/temporary/remove", {params: {id: id}})
            .then(function (response) {
                if (response.data = true) {
                    $scope.contract.file_name = "";
                    $scope.contract.file_path = "";
                }
            });
    };

    if (code != null && code != 'undefined' && code != "") {
        $http.get(url + "/bank/get-by-code", {params: {code: code}})
            .then(function (response) {
                $scope.bank = response.data;
            });
    }
    $scope.genContent = function (string) {
        return $sce.trustAsHtml(string);
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


    $http.get(url + "/contract/temporary", {params: {id: id}})
        .then(function (response) {

            $scope.contract = response.data;

            if ($scope.contract.contract_number == 'o0o') {
                $scope.contract.contract_number = '';
            }
            if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                try {
                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                    $scope.listProperty = JSON.parse(pri);
                    $http.get(url + "/ContractTemplate/property-template")
                        .then(function (response) {
                            $scope.templateProperties = response.data;
                            $scope.formatTaiSan();
                            for (var i = 0; i < $scope.listProperty.properties.length; i++) {
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
                } catch (e) {
                    $scope.listProperty = "";
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

            $scope.checkBank = ($scope.contract.addition_status == 0) ? false : true;
            $scope.showDescrip = $scope.checkBank;

            /*default date for contract-property. Neu de ngoai thi se ko load dc cung`. khi click vao date lan` dau` ko chon thi se bien' mat*/
            $(function () {
                $('#drafterDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
                $('#notaryDate').datepicker({
                    format: "dd/mm/yyyy",
                    startDate: "01/01/1900",
                    endDate: endDate,
                    language: 'vi'
                }).on('changeDate', function (ev) {
                    $(this).datepicker('hide');
                });
            });

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
            $scope.contract.contract_value_vnd = $scope.contract.contract_value != null ? $scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") : 0;

            $scope.contract.contract_value_convert = docso($scope.contract.contract_value);

            var object = $filter('filter')($scope.notarys, {userId: parseInt($scope.contract.notary_id)}, true)[0];
            if (typeof object.family_name != "undefined" || typeof object.first_name != "undefined") {
                $scope.contract.notary_person = object.family_name + " " + object.first_name;
            }


        });
//hungnn
    $scope.onloadDateFormat = function () {
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            var item1 = $scope.privys.privy[i];
            for (var j = 0; j < item1.persons.length; j++) {
                $scope.onloadDate(i, j);
            }
        }
    };
    $scope.onloadDate = function (i, j) {

        var birth = "#userBirthday" + i + "-" + j;
        $(birth).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        console.log($(birth).text());
        var userCerDate = "#userCertificationDate" + i + "-" + j;
        $(userCerDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        var userFirstDate = "#userFirstRegistedDate" + i + "-" + j;
        $(userFirstDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        var userChangeDate = "#userChangeRegistedDate" + i + "-" + j;
        $(userChangeDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        var CerDateComp = "#userCertificationDateComp" + i + "-" + j;
        $(CerDateComp).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

    };

    $scope.changeContractValue = function (value) {
        $scope.contract.contract_value_vnd = value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
        var chuso = docso(value).trim();
        $scope.contract.contract_value_convert = chuso.charAt(0).toUpperCase() + chuso.slice(1);
    };

    $scope.changelandAreaValue = function (index, value) {
        //  $scope.contract.contract_value_vnd=value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            if (index == i) {
                var item = $scope.listProperty.properties[i].land;
                var chuso = docso(value).trim();
                item.land_area_text = chuso.charAt(0).toUpperCase() + chuso.slice(1);
            }
        }
    };

    $scope.changeDateNotary = function (value) {
        if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
            var dateArray = value.split("/");
            var date = dateArray[0];
            var month = dateArray[1];
            var year = dateArray[2];
            $scope.contract.notary_date_date = date;
            $scope.contract.notary_date_month = month;
            $scope.contract.notary_date_year = year;
            var ngay = $scope.contract.notary_date_date + "/" + $scope.contract.notary_date_month + "/" + $scope.contract.notary_date_year;
            $scope.contract.convert_notary_date_date = docngaythang(ngay);

            if (year != now.getFullYear()) {
                if (Number(year) && 1900 < year && year < 2100) {
                    //kiem tra xem co phai phuong xa tap trung ko.(Neu la phuong xa tap trung 1 project thi contract_number= year/userId/contract_number)
                    if (org_type == 1) {
                        $http.get(url + "/contract/contractNumber", {params: {year: year, userId: userEntryId}})
                            .then(function (response) {
                                $scope.contract.contract_number = year + "/" + userEntryId + "/" + response.data;
                                return response;
                            });
                    } else {
                        $http.get(url + "/contract/contractNumber", {params: {year: year, userId: 0}})
                            .then(function (response) {
                                $scope.contract.contract_number = year + "/" + response.data;
                                return response;
                            });
                    }

                }
            }
        }
    };
    /*for view list duong su va tai san*/

    $http.get(url + "/ContractTemplate/privy-template")
        .then(function (response) {
            $scope.templatePrivys = response.data;
            $scope.formatDuongSu();
            $scope.formatDuongSuBenA();
            $scope.formatDuongSuBenB();
            console.log("$scope.templatePrivys", $scope.templatePrivys);
            return response;
        });
    $http.get(url + "/ContractTemplate/property-template")
        .then(function (response) {
            $scope.templateProperties = response.data;
            //$scope.formatTaiSan();
            console.log("$scope.templateProperties", $scope.templateProperties);
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
        /* hungnn tam off   var htmlkind=$scope.contract.kindhtml.replace("dynamic=\"taisan\"","id=\"id_taisan\" dynamic=\"taisan\"");
            var doc = new DOMParser().parseFromString(htmlkind, "text/html");
            console.log( doc.getElementById("id_taisan") );
        if(doc.body.innerHTML.length>0){
            $scope.taisan=doc.getElementById("id_taisan").innerHTML;
        }else{*/

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
        //}
    };

    $scope.checkRemoveActionPrivy = function ($event, index) {
        var checkbox = $event.target;
        if (checkbox.checked) { //If it is checked
            $scope.privys.privy[index].type = 0;
        } else {
            $scope.privys.privy[index].type = "";
        }
    };
    $scope.changTemplatePrivy = function (itemIndex, index, template) {
        $scope.privys.privy[itemIndex].persons[index].myPerson = true;
        $scope.privys.privy[itemIndex].persons[index].template = template;
        template = parseInt(template);
        var object = $filter('filter')($scope.templatePrivys, {id: template}, true);
        if (object != null && object != 'undefined' && object != '') {
            object = object[0];
            var id = "#button-duongsu" + index;
            $(id).attr("data-content", object.html);

            $scope.privys.privy[itemIndex].persons[index].teamplate_1 = object.html;
            console.log($scope.privys.privy[itemIndex].persons[index].teamplate_1);
        }
        $scope.onloadDate(itemIndex, index);

    };

    $scope.getList = function (index) {
        return $scope["listTypeTaiSan" + index];
    };

    $scope.changeTypeProperty = function (index, type) {
        $scope.listProperty.properties[index].type = type;
        var object = $filter('filter')($scope.templateProperties, {type: type}, true);
        $scope["listTypeTaiSan" + index] = object;
        $scope.changTemplateProperty(index, '');

        if(type!='01'){
            $scope.listProperty.properties[index].type_real_estate = "";
            $scope.listProperty.properties[index].type_real_estate_sub = "";
        }
    };
    $scope.changTemplateProperty = function (index, template) {
        if (isNullOrEmpty(template)) {
            template = $scope.getList(index)[0].id;
        }
        $scope.listProperty.properties[index].apartment = {};
        $scope.listProperty.properties[index].land = {};
        $scope.listProperty.properties[index].vehicle = {};
        $scope.listProperty.properties[index].vehicle_airplane = {};
        $scope.listProperty.properties[index].vehicle_ship = {};

        $scope.listProperty.properties[index].myProperty = true;
        $scope.listProperty.properties[index].template = template;
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
    // $scope.duongsu='<div ng-repeat="item in privys.privy track by $index"> <div class=""><b style="font-family: Times New Roman; font-size: 14pt;" class="">Bên <span ng-model="item.action" editspan="item.action" class="inputcontract" contenteditable="true">{{item.action}}</span></b> (sau đây gọi là {{item.name}}): </div> <div ng-repeat="user in item.persons track by $index" class="personList"> <div ng-switch on="user.type"> <div ng-switch-when="1"> <div class="">*Công ty:&nbsp;<span class="inputcontract" editspan="user.org_name" ng-model="user.org_name" placeholder="" contenteditable="true">{{user.org_name}}</span></div> <div class="">Địa chỉ: &nbsp;<span class="inputcontract" editspan="user.org_address" ng-model="user.org_address" placeholder="" contenteditable="true">{{user.org_address}}</span></div> <div class="">Mã số doanh nghiệp: <span class="inputcontract" editspan="user.org_code" ng-model="user.org_code" placeholder="" contenteditable="true">{{user.org_code}}</span> &nbsp; ,đăng ký lần đầu ngày: <span class="inputcontract" editspan="user.first_registed_date" ng-model="user.first_registed_date" placeholder=" &nbsp;" contenteditable="true">{{user.first_registed_date}}</span>&nbsp; , đăng ký thay đổi lần thứ&nbsp;<span class="inputcontract" editspan="user.number_change_registed" ng-model="user.number_change_registed" placeholder="" contenteditable="true">{{user.number_change_registed}}</span>&nbsp;ngày: <span class="inputcontract" editspan="user.change_registed_date" ng-model="user.change_registed_date" placeholder="&nbsp;" contenteditable="true">{{user.change_registed_date}}</span>&nbsp;theo&nbsp; <span class="inputcontract" editspan="user.department_issue" ng-model="user.department_issue" placeholder="" contenteditable="true">{{user.department_issue}}</span>&nbsp;; </div> <div class="">Họ và tên người đại diện:&nbsp;<span class="inputcontract" editspan="user.name" ng-model="user.name" placeholder="" contenteditable="true">{{user.name}}</span></div> <div class="">Chức danh:&nbsp;<span class="inputcontract" editspan="user.position" ng-model="user.position" placeholder="" contenteditable="true">{{user.position}}</span></div> </div> <div ng-switch-default> <div class="">*Họ và tên:&nbsp;<span href="#" editspan="user.name" ng-model="user.name" class="inputcontract" contenteditable="true">{{user.name}}</span>&nbsp; , sinh năm: <span placeholder="" editspan="user.birthday" ng-model="user.birthday" class="inputcontract" contenteditable="true">{{user.birthday}}</span> ; </div> </div> </div> <div class="">Giấy CMND số:&nbsp;<span placeholder="" editspan="user.passport" ng-model="user.passport" class="inputcontract" contenteditable="true">{{user.passport}}</span> cấp ngày:&nbsp; <span placeholder="" editspan="user.certification_date" ng-model="user.certification_date" class="inputcontract" contenteditable="true">{{user.certification_date}}</span> tại: <span placeholder="" editspan="user.certification_place" ng-model="user.certification_place" class="inputcontract" contenteditable="true">{{user.certification_place}}</span> ; </div> <div class="">Địa chỉ:&nbsp;<span placeholder="" editspan="user.address" ng-model="user.address" class="inputcontract" contenteditable="true">{{user.address}}</span>; </div> </div> </div>';
    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editspan="item.land.land_certificate" ng-model="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editspan="item.land.land_issue_place" ng-model="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editspan="item.land.land_issue_date" ng-model="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_address" ng-model="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editspan="item.apartment.apartment_number" ng-model="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editspan="item.apartment.apartment_floor" ng-model="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_use" ng-model="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_area_build" ng-model="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editspan="item.apartment.apartment_structure" ng-model="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editspan="item.apartment.apartment_total_floor" ng-model="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editspan="item.land.land_number" ng-model="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editspan="item.land.land_map_number" ng-model="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editspan="item.land.land_address" ng-model="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editspan="item.land.land_area" ng-model="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editspan="item.land.land_area_text" ng-model="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editspan="item.land.land_private_area" ng-model="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editspan="item.land.land_public_area" ng-model="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editspan="item.land.land_use_purpose" ng-model="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editspan="item.land.land_use_period" ng-model="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editspan="item.land.land_use_origin" ng-model="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editspan="item.restrict" ng-model="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editspan="item.property_info" ng-model="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';

    // $http.get(url+"/contract/get-contract-kind-by-contract-template-id", {params: { id: template_id}})
    //     .then(function(response) {
    //         $scope.contractKind=response.data;
    //     });
    //
    // $http.get(url+"/contract/get-contract-template-by-id", {params: { id: template_id }})
    //     .then(function(response) {
    //         $scope.contractTemplate=response.data;
    //     });

    /*Duong su ben A-B-C*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    // $scope.privys = { name: "Đương sự", privy: [ { name: "Bên A", id: 1,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] }, { name: "Bên B", id: 2,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] } ] };

    $scope.addPrivy = function () {
        if ($scope.privys.privy.length < alphabet.length) {
            // var object={ name: "Bên "+alphabet[$scope.privys.privy.length], id: $scope.privys.privy.length,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] };
            var object = {
                name: "Bên " + alphabet[$scope.privys.privy.length],
                id: $scope.privys.privy.length,
                action: "",
                persons: []
            };
            $scope.privys.privy.push(object);
            //sonnv
            $scope.getActionContractTemplate();
            //end
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
        //end
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
    //end
    $scope.addPerson = function (index) {
        var object = {
            template: "",
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
            department_issue: "",

            customer_management_unit: "",
            phone: "",
            fax: "",
            registration_certificate: "",
            authorization_document: ""
        };
        $scope.privys.privy[index].persons.push(object);
        /*load popover*/
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            $(document).on('click', '.popover-title .close', function (e) {
                var $target = $(e.target), $popover = $target.closest('.popover').prev();
                $popover && $popover.popover('hide');
            });
            defer.resolve();
        }, 1000);
    };

    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };

    //hungnn
    $scope.showPerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons[index].myPerson = !$scope.privys.privy[parentIndex].persons[index].myPerson;
    };
    $scope.changeNotary = function (notary_id) {
        var object = $filter('filter')($scope.notarys, {userId: parseInt(notary_id)}, true)[0];
        console.log(object);
//notary_person
        $scope.contract.notary_person = object.family_name + " " + object.first_name;

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
    //hungnn goi y khi nhap
    $scope.getsuggest = function (itemIndex, index, template) {
        var namesuggest = "#name" + itemIndex + "-" + index;
        if (template == 2) {
            namesuggest = "#org_name" + itemIndex + "-" + index;
        }
        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggest',

            params: {
                template: template
            },
            onSelect: function (suggestion) {
                if (template == 3) {
                    $scope.privys.privy[itemIndex].persons[index].org_name = suggestion.org_name;
                    $scope.privys.privy[itemIndex].persons[index].org_code = suggestion.org_code;
                    $scope.privys.privy[itemIndex].persons[index].org_address = suggestion.org_address;
                    $scope.privys.privy[itemIndex].persons[index].customer_management_unit = suggestion.customer_management_unit;
                    $scope.privys.privy[itemIndex].persons[index].address = suggestion.address;
                    $scope.privys.privy[itemIndex].persons[index].phone = suggestion.phone;
                    $scope.privys.privy[itemIndex].persons[index].fax = suggestion.fax;
                    $scope.privys.privy[itemIndex].persons[index].registration_certificate = suggestion.registration_certificate;
                    $scope.privys.privy[itemIndex].persons[index].name = suggestion.name;
                    $scope.privys.privy[itemIndex].persons[index].position = suggestion.position;
                    $scope.privys.privy[itemIndex].persons[index].authorization_document = suggestion.authorization_document;
                } else {
                    $scope.privys.privy[itemIndex].persons[index].name = suggestion.name;
                    $scope.privys.privy[itemIndex].persons[index].passport = suggestion.passport;
                    $scope.privys.privy[itemIndex].persons[index].certification_date = suggestion.certification_date;
                    $scope.privys.privy[itemIndex].persons[index].certification_place = suggestion.certification_place;
                    $scope.privys.privy[itemIndex].persons[index].address = suggestion.address;
                    $scope.privys.privy[itemIndex].persons[index].description = suggestion.description;
                    $scope.privys.privy[itemIndex].persons[index].birthday = suggestion.birthday;
                    $scope.privys.privy[itemIndex].persons[index].position = suggestion.position;
                    $scope.privys.privy[itemIndex].persons[index].description = suggestion.description;

                    //sonnv
                    if (angular.isUndefined($scope.privys.privy[itemIndex].persons[index].sex)
                        || $scope.privys.privy[itemIndex].persons[index].sex == null
                        || $scope.privys.privy[itemIndex].persons[index].sex == "") {
                        $scope.privys.privy[itemIndex].persons[index].sex = {id: 1, name: 'Ông'};
                    }

                    if (suggestion.sex == '1' || suggestion.sex == 1) {
                        $scope.privys.privy[itemIndex].persons[index].sex.id = 1;
                        $scope.privys.privy[itemIndex].persons[index].sex.name = 'Ông';
                    } else if (suggestion.sex == '2' || suggestion.sex == 2) {
                        $scope.privys.privy[itemIndex].persons[index].sex.id = 2;
                        $scope.privys.privy[itemIndex].persons[index].sex.name = 'Bà';
                    }
                    //end

                    if (template == 2) {
                        $scope.privys.privy[itemIndex].persons[index].org_name = suggestion.org_name;
                        $scope.privys.privy[itemIndex].persons[index].org_address = suggestion.org_address;
                        $scope.privys.privy[itemIndex].persons[index].org_code = suggestion.org_code;
                        $scope.privys.privy[itemIndex].persons[index].first_registed_date = suggestion.first_registed_date;
                        $scope.privys.privy[itemIndex].persons[index].number_change_registed = suggestion.number_change_registed;
                        $scope.privys.privy[itemIndex].persons[index].change_registed_date = suggestion.change_registed_date;
                        $scope.privys.privy[itemIndex].persons[index].department_issue = suggestion.department_issue;

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
            namesuggest = ".autocomplete_car_frame_number" + index;
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
                            // apartment
                            $scope.listProperty.properties[i].apartment.apartment_address = suggestion.apartment_address;
                            $scope.listProperty.properties[i].apartment.apartment_number = suggestion.apartment_number;
                            $scope.listProperty.properties[i].apartment.apartment_floor = suggestion.apartment_floor;
                            $scope.listProperty.properties[i].apartment.apartment_area_use = suggestion.apartment_area_use;
                            $scope.listProperty.properties[i].apartment.apartment_area_build = suggestion.apartment_area_build;
                            $scope.listProperty.properties[i].apartment.apartment_structure = suggestion.apartment_structure;
                            $scope.listProperty.properties[i].apartment.apartment_total_floor = suggestion.apartment_total_floor;
                            // info general


                        } else if (type == '02') {
                            var item = $scope.listProperty.properties[i].vehicle;
                            item.car_license_number = suggestion.car_license_number;
                            item.car_regist_number = suggestion.car_regist_number;
                            item.car_issue_place = suggestion.car_issue_place;
                            item.car_issue_date = suggestion.car_issue_date;
                            item.car_frame_number = suggestion.car_frame_number;
                            item.car_machine_number = suggestion.car_machine_number;
                        }
                        $scope.listProperty.properties[i].land.land_street = suggestion.land_street;
                        $scope.listProperty.properties[i].owner_info = suggestion.owner_info;
                        $scope.listProperty.properties[i].other_info = suggestion.other_info;
                        $scope.listProperty.properties[i].restrict = suggestion.restrict;
                    }
                }
                $scope.$apply();
            }
        });
    };

    //hungnn end

    // $scope.taisan='<div ng-repeat="item in listProperty.properties track by $index"> <div ng-switch on="item.type_view"> <div ng-switch-when="0"><span class="">Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> &nbsp; cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span>&nbsp;cụ thể như sau:</span> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span>&nbsp; , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span>&nbsp; </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> &nbsp;&nbsp; </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span>&nbsp; &nbsp;&nbsp; </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span> </div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> </div> <div ng-switch-when="1"> <div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số <span class="inputcontract" editable-text="item.land.land_certificate" placeholder="" contenteditable="true">{{item.land.land_certificate}}</span> &nbsp;do <span class="inputcontract" editable-text="item.land.land_issue_place" placeholder="" contenteditable="true">{{item.land.land_issue_place}}</span> cấp ngày <span class="inputcontract" editable-text="item.land.land_issue_date" placeholder="" contenteditable="true">{{item.land.land_issue_date}}</span> , cụ thể như sau: </div> <div class="">-Địa chỉ:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_address" placeholder="" contenteditable="true">{{item.apartment.apartment_address}}</span> </div> <div class="">-Căn hộ số: <span class="inputcontract" editable-text="item.apartment.apartment_number" placeholder="" contenteditable="true">{{item.apartment.apartment_number}}</span> tầng: <span class="inputcontract" editable-text="item.apartment.apartment_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_floor}}</span></div> <div class="">-Tổng diện tích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_use" placeholder="" contenteditable="true">{{item.apartment.apartment_area_use}}</span> </div> <div class="">-Diện tích xây dựng:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_area_build" placeholder="" contenteditable="true">{{item.apartment.apartment_area_build}}</span> </div> <div class="">-Kết cấu nhà:&nbsp;<span class="inputcontract" editable-text="item.apartment.apartment_structure" placeholder="" contenteditable="true">{{item.apartment.apartment_structure}}</span> </div> <div class="">-Số tầng nhà chung cư: <span class="inputcontract" editable-text="item.apartment.apartment_total_floor" placeholder="" contenteditable="true">{{item.apartment.apartment_total_floor}}</span> &nbsp;tầng </div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: <span class="inputcontract" editable-text="item.land.land_number" placeholder="&nbsp;" contenteditable="true">{{item.land.land_number}}</span> , tờ bản đồ số:&nbsp; <span class="inputcontract" editable-text="item.land.land_map_number" placeholder="" contenteditable="true">{{item.land.land_map_number}}</span></div> <div class="">-Địa chỉ thửa đất: &nbsp; <span class="inputcontract" editable-text="item.land.land_address" placeholder="" contenteditable="true">{{item.land.land_address}}</span> </div> <div class="">-Diện tích: <span class="inputcontract" editable-text="item.land.land_area" placeholder="" contenteditable="true">{{item.land.land_area}}</span> &nbsp;m2 (bằng chữ: <span class="inputcontract" editable-text="item.land.land_area_text" placeholder="" contenteditable="true">{{item.land.land_area_text}}</span> &nbsp;mét vuông ) </div> <div class="">-Hình thức sử dụng:</div> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;<span class="inputcontract" editable-text="item.land.land_private_area" placeholder="" contenteditable="true">{{item.land.land_private_area}}</span> </div> <div class="">+Sử dụng chung: <span class="inputcontract" editable-text="item.land.land_public_area" placeholder=" " contenteditable="true">{{item.land.land_public_area}}</span> </div> </blockquote> </blockquote> <span style="font-size: 17.5px;">-Mục đích sử dụng:&nbsp;<span class="inputcontract" editable-text="item.land.land_use_purpose" placeholder="" contenteditable="true">{{item.land.land_use_purpose}}</span></span> <div class="">-Thời hạn sử dụng: <span class="inputcontract" editable-text="item.land.land_use_period" placeholder="" contenteditable="true">{{item.land.land_use_period}}</span></div> <div class="">-Nguồn gốc sử dụng: <span class="inputcontract" editable-text="item.land.land_use_origin" placeholder="" contenteditable="true">{{item.land.land_use_origin}}</span></div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp;<span class="inputcontract" editable-text="item.restrict" placeholder="" contenteditable="true">{{item.restrict}}</span> </div> </div> <div ng-switch-default> <div class="">Thông tin tài sản:&nbsp;<span class="inputcontract" editable-text="item.property_info" placeholder="" contenteditable="true">{{item.property_info}}</span></div> </div> </div> </div>';
    // $scope.listTypeTaiSan=[
    //     {id:"0",name:"Mẫu thông tin thửa đất",htmlContent:'<div class="">Quyền sử dụng đất của bên A đối với thửa đất theo cụ thể như sau:</div> <div class="">-Thửa đất số: , tờ bản đồ số: </div> <div class="">-Địa chỉ thửa đất: </div> <div class="">-Diện tích: m2 (bằng chữ: mét vuông )</div> <div class="">-Hình thức sử dụng:</div> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp;</div> <div class="">+Sử dụng chung: </div> </div></div> <div >-Mục đích sử dụng:&nbsp; </div> <div class="">-Thời hạn sử dụng: </div> <div class="">-Nguồn gốc sử dụng: </div>'},
    //     {id:"1",name:"Mẫu nhà chung cư",htmlContent:'<div class="">Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số &nbsp;do cấp ngày , cụ thể như sau:</div> <div class="">-Địa chỉ:&nbsp; </div> <div class="">-Căn hộ số: tầng: </div> <div class="">-Tổng diện tích sử dụng:&nbsp; </div> <div class="">-Diện tích xây dựng:&nbsp; </div> <div class="">-Kết cấu nhà:&nbsp; </div> <div class="">-Số tầng nhà chung cư: &nbsp;tầng</div> <div class="">Căn hộ nêu trên là tài sản gắn liền với thửa đất sau:</div> <div class="">-Thửa đất số: , tờ bản đồ số:&nbsp; </div> <div class="">-Địa chỉ thửa đất: &nbsp; </div> <div class="">-Diện tích: &nbsp;m2 (bằng chữ: &nbsp;mét vuông )</div> <div class="">-Hình thức sử dụng:</div> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div style="margin: 0 0 0 40px; border: none; padding: 0px;"> <div class="">+Sử dụng riêng: &nbsp; </div> <div class="">+Sử dụng chung: </div> </div> </div> <div >-Mục đích sử dụng:&nbsp;</div> <div class="">-Thời hạn sử dụng: </div> <div class="">-Nguồn gốc sử dụng: </div> <div class="">Những hạn chế về quyền sử dụng đất(nếu có):&nbsp; </div>'},
    //     {id:"99",name:"Tài sản khác",htmlContent:'<div class="">Thông tin tài sản: </div>'}
    // ]
    /*Thong tin tai san*/
    $scope.listProperty = {name: "property", properties: []};

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

        // if($scope.listProperty.properties.length>0){
        //     for(var i=0; i<$scope.listProperty.properties.length;i++){
        //         var object = $filter('filter')($scope.listTypeTaiSan, {id: $scope.listProperty.properties[i].type_view})[0];
        //         var id="#button-taisan"+i;
        //         $(id).attr("data-content", object.htmlContent);
        //     }
        // }

    });


    $scope.addProperty = function () {
        var object = {
            type: "",
            id: $scope.listProperty.properties.length + 1,
            template: "",
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
            type_real_estate:"",
            type_real_estate_sub:""

        };
        // var object={ type: "01", id: $scope.listProperty.properties.length+1,type_view:"", property_info:"", owner_info:"", other_info:"",restrict:"",apartment:{apartment_address:"",apartment_number:"",apartment_floor:"",apartment_area_use:"",apartment_area_build:"",apartment_structure:"",apartment_total_floor:""}, land: { land_certificate:"", land_issue_place:"", land_issue_date:"", land_map_number:"", land_number:"", land_address:"", land_area:"", land_area_text:"", land_public_area:"", land_private_area:"", land_use_purpose:"", land_use_period:"", land_use_origin:"", land_associate_property:"", land_street:"", land_district:"", land_province:"", land_full_of_area:"" }, vehicle:{ car_license_number:"", car_regist_number:"", car_issue_place:"", car_issue_date:"", car_frame_number:"", car_machine_number:"" } };
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
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            var object = $filter('filter')($scope.templateProperties, {type: $scope.listProperty.properties[index].type}, true);
            $scope["listTypeTaiSan" + index] = object;
        }
    };
    $scope.showProperty = function (index) {
        $scope.listProperty.properties[index].myProperty = !$scope.listProperty.properties[index].myProperty;
    };
    /*end property*/

    /*Calculate total fee*/
    $scope.calculateTotal = function () {
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

//chuyen ccv ky
    $scope.ccvKyTemporary = function () {
        if ($scope.checkValidate()) {
            if ($scope.contract.type == 2) {
                $scope.contract.type = 0;
            }

            if ($scope.contract.type == 3) {

                $scope.contract.type = 0;

            }
            if ($scope.contract.type == 4) {

            }
            if ($scope.checkDate()) {
                $("#checkDate").modal('show');
            } else {
                $scope.runEdit();
            }

        } else {
            $("#checkValidate").modal('show');
        }

    };
//luu hop dong
    $scope.editTemporary = function () {
        if ($scope.checkValidate()) {

            if ($scope.checkDate()) {
                $("#checkDate").modal('show');
            } else {
                $scope.runEdit();
            }

        } else {
            $("#checkValidate").modal('show');
        }

    };

    $scope.runEdit = function () {
        /*genaral duong su va tai san*/
        if ($scope.contract.contract_number == null || $scope.contract.contract_number == 'undefined' || $scope.contract.contract_number == '') {
            $scope.contract.contract_number = 'o0o';
        }
        $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
        $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";
        $scope.contract.entry_date_time = new Date();
        $scope.contract.update_date_time = new Date();
        /*format list items html duong su*/
        //gan gia tri cho #copyContract tranh' thay doi gia tri cua divcontract
        $scope.contract.kindhtml = $("div #contentKindHtml").html();

        /*FORMAT GEN INFO PROPERTY AND RELATION_OBJECT*/
        $scope.genInforProAndPrivys();
        var subUrl = 3;
        if ($scope.contract.type == 0) {
            subUrl = 0;
        }
        var contractAdd = JSON.parse(JSON.stringify($scope.contract));
        if ($scope.myFile.file != null && $scope.myFile.file != 'undefined' && $scope.myFile.file.size > 0) {
            if ($scope.myFile.file.size > 5242000) {
                $("#errorMaxFile").modal('show');
            } else {
                var file = $scope.myFile.file;
                var uploadUrl = url + "/contract/uploadFile";
                fileUpload.uploadFileToUrl(file, uploadUrl)
                    .then(function (response) {
                            if (response.data != null && response.data != 'undefined' && response.status == 200) {
                                $scope.contract.file_name = response.data.name;
                                $scope.contract.file_path = response.data.path;
                                var contractAdd = JSON.parse(JSON.stringify($scope.contract));

                                $http.put(url + "/contract/temporary", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                    .then(function (response) {
                                            if (response.status == 200 && response.data > 0) {
                                                if (org_type == 1 && $scope.contract.type != "3") {
                                                    //goi ham dong dau hop dong
                                                    getTemporaryContractSaved(response.data);
                                                } else $window.location.href = contextPath + '/contract/temporary/list?status=' + subUrl;

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
            $http.put(url + "/contract/temporary", contractAdd, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                        if (response.status == 200 && response.data > 0) {
                            if (org_type == 1 && $scope.contract.type != "3") {
                                //goi ham dong dau hop dong
                                getTemporaryContractSaved(response.data);
                            } else $window.location.href = contextPath + '/contract/temporary/list?status=' + subUrl;
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

    //chứng thực
    function getTemporaryContractSaved(id) {
        $http.get(url + "/contract/temporary", {params: {id: id}})
            .then(function (response) {

                $scope.contract = response.data;

                if ($scope.contract.contract_number == "o0o") {
                    $scope.contract.contract_number = "";
                }

                if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                    $scope.listProperty = JSON.parse(pri);
                }
                if ($scope.contract.json_person != null && $scope.contract.json_person != "" && $scope.contract.json_person != 'undefined') {
                    var person = $scope.contract.json_person.substr(1, $scope.contract.json_person.length - 2);
                    $scope.privys = JSON.parse(person);

                }
                $scope.checkBank = ($scope.contract.addition_status == 0) ? false : true;
                $scope.showDescrip = $scope.checkBank;
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
                var date1 = new Date();
                if ($scope.contract.notary_date == null || $scope.contract.notary_date == 'undefined' || $scope.contract.notary_date == '') {
                    $scope.contract.notary_date = ("0" + date1.getDate()).slice(-2) + '/' + ("0" + (date1.getMonth() + 1)).slice(-2) + '/' + date1.getFullYear();
                }

                $scope.contract.contract_value_vnd = $scope.contract.contract_value != null ? $scope.contract.contract_value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") : '';
                $scope.contract.contract_value_convert = docso($scope.contract.contract_value);
                /*var object = $filter('filter')($scope.notarys, {userId:parseInt($scope.contract.notary_id)},true)[0];
                console.log(object);*/
                $scope.contract.notary_person = $scope.contract.contract_signer;

                markContractCall();


            });

    }

    //ham goi dong dau luon nen neu la to chuc chung thuc
    function markContractCall() {
        if ($scope.contract.contract_number != undefined && $scope.contract.contract_number != '') {

            $http.get(url + "/contract/checkContractNumber", {params: {contract_number: $scope.contract.contract_number}})
                .then(function (response) {
                    if (response.status == 200 && response.data == true) {
                        $scope.checkLoad = true;
                        $scope.contract.type = "4";
                        $scope.contract.update_date_time = new Date();

                        if ($scope.myFile != null && $scope.myFile.file != 'undefined' && $scope.myFile.file.size > 0) {
                            if ($scope.myFile.file.size > 5242000) {
                                $("#errorMaxFile").modal('show');
                            } else {

                                var file = $scope.myFile.file;
                                var uploadUrl = url + "/contract/uploadFile";
                                fileUpload.uploadFileToUrl(file, uploadUrl)
                                    .then(function (response) {
                                            if (response.data != null && response.data != 'undefined' && response.status == 200) {
                                                $scope.contract.file_name = response.data.name;
                                                $scope.contract.file_path = response.data.path;
                                                var contractAdd = JSON.parse(JSON.stringify($scope.contract));
                                                $http.put(url + "/contract/temporary/mark", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                                    .then(function (response) {

                                                            if (response.status == 200 && response.data > 0) {

                                                                var listPerson = [];
                                                                for (var i = 0; i < $scope.privys.privy.length; i++) {
                                                                    var item2 = $scope.privys.privy[i];
                                                                    for (var j = 0; j < item2.persons.length; j++) {
                                                                        var item4 = item2.persons[j];
                                                                        var listPersonForm = {
                                                                            template: item4.template,
                                                                            id: item4.id,
                                                                            sex: null,
                                                                            name: item4.name,
                                                                            birthday: item4.birthday,
                                                                            passport: item4.passport,
                                                                            certification_date: item4.certification_date,
                                                                            certification_place: item4.certification_place,
                                                                            address: item4.address,
                                                                            position: item4.position,
                                                                            description: item4.description,
                                                                            org_name: item4.org_name,
                                                                            org_address: item4.org_address,
                                                                            org_code: item4.org_code,
                                                                            first_registed_date: item4.first_registed_date,
                                                                            number_change_registed: item4.number_change_registed,
                                                                            change_registed_date: item4.change_registed_date,
                                                                            department_issue: item4.department_issue,
                                                                            customer_management_unit: item4.customer_management_unit,
                                                                            phone: item4.phone,
                                                                            fax: item4.fax,
                                                                            registration_certificate: item4.registration_certificate,
                                                                            authorization_document: item4.authorization_document
                                                                        };
                                                                        if (listPersonForm.template == 1 && listPersonForm.passport != "") {
                                                                            listPersonForm.sex = item4.sex.id;
                                                                            listPerson.push(listPersonForm);
                                                                        }
                                                                        if (listPersonForm.template == 2 && listPersonForm.org_code != "") {
                                                                            listPerson.push(listPersonForm);
                                                                        }
                                                                        if (listPersonForm.template == 3 && listPersonForm.org_code != "") {
                                                                            listPerson.push(listPersonForm);
                                                                        }

                                                                    }
                                                                }
                                                                var listPersonAllJson = JSON.stringify(listPerson);
                                                                $http.get(contextPath + "/contract/addPrivyFuncOnline", {
                                                                    params: {
                                                                        addData: listPersonAllJson,
                                                                        statusOnline: 1
                                                                    }
                                                                })
                                                                    .then(function (response) {
                                                                        console.log(response.status);
                                                                        return response;
                                                                    });
                                                                /*$scope.checkNayPrivy(listPersonAllJson);*/
                                                                /*for(var k = 0 ;k<listPerson.length;k++){
                                                                 var addSuggestPrivy = JSON.parse(JSON.stringify(listPerson[k]));
                                                                 $http.post(urlstp+"/contract/addSuggestPrivy",listPerson[k],{headers:{'Content-Type':'application/json'}})

                                                                 }*/
                                                                var listProperty = [];
                                                                var checkTest = $scope.listProperty.properties.length;
                                                                for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                                                                    var item3 = $scope.listProperty.properties[i];
                                                                    if ((item3.type == "01" && item3.land.land_certificate != "") || (item3.type == "02" && item3.vehicle.car_frame_number != "")) {
                                                                        var listPropertyForm = {
                                                                            id: "",
                                                                            type: item3.type,
                                                                            type_view: item3.template,
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
                                                                            ship_hull_material: isNullOrEmpty(item3.type_real_estate) ? "" : item3.type_real_estate,
                                                                            type_real_estate_sub: isNullOrEmpty(item3.type_real_estate_sub) ? "" : item3.type_real_estate_sub

                                                                        };

                                                                        listProperty.push(listPropertyForm);
                                                                    }


                                                                }
                                                                var listPropertyAllJson = JSON.stringify(listProperty);
                                                                $http.get(contextPath + "/contract/addPropertyFuncOnline", {
                                                                    params: {
                                                                        addData: listPropertyAllJson,
                                                                        statusOnline: 1
                                                                    }
                                                                })
                                                                    .then(function (response) {
                                                                        console.log(response.status);
                                                                        return response;
                                                                    });
                                                                /*$scope.checkNayProperty(listPropertyAllJson);*/
                                                                /*for(var k = 0 ;k<listProperty.length;k++){
                                                                 $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                                                 }*/

                                                                $window.location.href = contextPath + "/contract/temporary/list?status=5";
                                                                $scope.checkLoad = false;
                                                                $scope.thongbao = "Hợp đồng được đóng dấu thành công!";
                                                                $("#showThongBao").modal('show');
                                                            } else {
                                                                $scope.checkLoad = false;
                                                                $scope.contract.type = "1";
                                                                $scope.thongbao = "Thao tác thất bại. Hãy thử lại sau!";
                                                                $("#showThongBao").modal('show');
                                                            }
                                                        },
                                                        function (response) {
                                                            // failure callback
                                                            $scope.checkLoad = false;
                                                            $scope.contract.type = "1";
                                                            $("#errorEdit").modal('show');
                                                        }
                                                    );
                                            } else {
                                                $("#errorEdit").modal('show');
                                            }
                                        }
                                        /*function (response) {
                                            // failure callback
                                            $("#errorEdit").modal('show');
                                        }*/
                                    );
                            }

                        } else {

                            var contractAdd = JSON.parse(JSON.stringify($scope.contract));
                            $http.put(url + "/contract/temporary/mark", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                .then(function (response) {

                                        if (response.status == 200 && response.data > 0) {

                                            var listPerson = [];
                                            for (var i = 0; i < $scope.privys.privy.length; i++) {
                                                var item2 = $scope.privys.privy[i];
                                                for (var j = 0; j < item2.persons.length; j++) {
                                                    var item4 = item2.persons[j];
                                                    var listPersonForm = {
                                                        template: item4.template,
                                                        id: item4.id,
                                                        sex: null,
                                                        name: item4.name,
                                                        birthday: item4.birthday,
                                                        passport: item4.passport,
                                                        certification_date: item4.certification_date,
                                                        certification_place: item4.certification_place,
                                                        address: item4.address,
                                                        position: item4.position,
                                                        description: item4.description,
                                                        org_name: item4.org_name,
                                                        org_address: item4.org_address,
                                                        org_code: item4.org_code,
                                                        first_registed_date: item4.first_registed_date,
                                                        number_change_registed: item4.number_change_registed,
                                                        change_registed_date: item4.change_registed_date,
                                                        department_issue: item4.department_issue,
                                                        customer_management_unit: item4.customer_management_unit,
                                                        phone: item4.phone,
                                                        fax: item4.fax,
                                                        registration_certificate: item4.registration_certificate,
                                                        authorization_document: item4.authorization_document
                                                    };
                                                    if (listPersonForm.template == 1 && listPersonForm.passport != "") {
                                                        listPersonForm.sex = item4.sex.id;
                                                        listPerson.push(listPersonForm);
                                                    }
                                                    if (listPersonForm.template == 2 && listPersonForm.org_code != "") {
                                                        listPerson.push(listPersonForm);
                                                    }
                                                    if (listPersonForm.template == 3 && listPersonForm.org_code != "") {
                                                        listPerson.push(listPersonForm);
                                                    }

                                                }
                                            }
                                            var listPersonAllJson = JSON.stringify(listPerson);
                                            $http.get(contextPath + "/contract/addPrivyFuncOnline", {
                                                params: {
                                                    addData: listPersonAllJson,
                                                    statusOnline: 1
                                                }
                                            })
                                                .then(function (response) {
                                                    console.log(response.status);
                                                    return response;
                                                });
                                            /*$scope.checkNayPrivy(listPersonAllJson);*/
                                            /*for(var k = 0 ;k<listPerson.length;k++){
                                             var addSuggestPrivy = JSON.parse(JSON.stringify(listPerson[k]));
                                             $http.post(urlstp+"/contract/addSuggestPrivy",listPerson[k],{headers:{'Content-Type':'application/json'}})

                                             }*/
                                            var listProperty = [];
                                            var checkTest = $scope.listProperty.properties.length;
                                            for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                                                var item3 = $scope.listProperty.properties[i];
                                                if ((item3.type == "01" && item3.land.land_certificate != "") || (item3.type == "02" && item3.vehicle.car_frame_number != "")) {
                                                    var listPropertyForm = {
                                                        id: "",
                                                        type: item3.type,
                                                        type_view: item3.template,
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
                                            var listPropertyAllJson = JSON.stringify(listProperty);
                                            $http.get(contextPath + "/contract/addPropertyFuncOnline", {
                                                params: {
                                                    addData: listPropertyAllJson,
                                                    statusOnline: 1
                                                }
                                            })
                                                .then(function (response) {
                                                    console.log(response.status);
                                                    return response;
                                                });
                                            /*$scope.checkNayProperty(listPropertyAllJson);*/
                                            /*for(var k = 0 ;k<listProperty.length;k++){
                                             $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                             }*/

                                            $window.location.href = contextPath + "/contract/temporary/list?status=5";
                                            $scope.checkLoad = false;
                                            $scope.thongbao = "Hợp đồng được đóng dấu thành công!";
                                            $("#showThongBao").modal('show');
                                        } else {
                                            $scope.checkLoad = false;
                                            $scope.contract.type = "1";
                                            $scope.thongbao = "Thao tác thất bại. Hãy thử lại sau!";
                                            $("#showThongBao").modal('show');
                                        }
                                    },
                                    function (response) {
                                        // failure callback
                                        $scope.checkLoad = false;
                                        $scope.contract.type = "1";
                                        $("#errorEdit").modal('show');
                                    }
                                );
                        }
                    } else {
                        $("#checkContractNumber").modal('show');
                    }
                });
        } else {
            $("#notContractNumber").modal('show');
        }
    }

    //END chứng thực


    //when delete contract
    $scope.deleteContract = function () {
        $scope.checkdelete = true;

        $http.delete(url + "/contract/temporary", {params: {id: id}})
            .then(function (response) {
                    if (response.status == 200) {

                        $window.location.href = contextPath + '/contract/temporary/list?status=2';
                    } else {
                        $scope.checkdelete = false;
                        $("#errorEdit").modal('show');
                    }
                },
                function (response) {
                    // failure callback
                    $scope.checkdelete = false;
                    $("#errorEdit").modal('show');

                }
            );

    };

    $scope.viewAsDoc = function () {
        $("#viewHtmlAsWord").html($("#contentKindHtml").html());
        $("#viewContentAsWord").modal('show');
    };

    $scope.downloadWord = function () {
        $("#contentKindHtml").wordExport();
    };

    $scope.downloadFile = function () {
        window.open(url + "/contract/temporary/download/" + $scope.contract.tcid, '_blank');
    };

    $scope.genInforProAndPrivys = function () {
        /*gen contract.propertyInfo va relation_object*/
        $scope.contract.relation_object_a = "";
        $scope.contract.relation_object_b = "";
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
                $scope.contract.relation_object_a += "Bên " + item1.action + " (sau đây gọi là " + item1.name + ")" + ":\\n" + string1;
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
                    if (!isNullOrEmpty(item.template) && item.template == 11) {
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
                    } else if (!isNullOrEmpty(item.template) && item.template == 12) {
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

    $scope.checkDate = function () {
        if ($scope.contract.received_date != null && $scope.contract.notary_date != null) {
            var date1 = $scope.formatDate($scope.contract.received_date);
            var date2 = $scope.formatDate($scope.contract.notary_date);
            var now = new Date();
            if (date2 == null || date2 == 'undefined') {
                date2 = now;
            }
            if (date1 > date2 || date1 > now || date2 > now) {
                return true;
            }
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

    /*check validate*/
    $scope.checkValidate = function () {
        var check = true;
        $scope.contract_number_ = "";
        $scope.received_date_ = "";
        $scope.notary_date_ = "";
        $scope.contract_value_ = "";
        $scope.contract_kind_ = "";
        $scope.contract_template_ = "";

        if (!$scope.contractKind.contract_kind_code.length > 0) {
            $scope.contract_kind_ = "Trường không được bỏ trống";
            check = false;
        }
        if (!$scope.contract.contract_template_id > 0) {
            $scope.contract_template_ = "Trường không được bỏ trống";
            check = false;
        }
        if ($scope.contract.contract_value == null || $scope.contract.contract_value == undefined || $scope.contract.contract_value === "") {
            $scope.contract_value_ = "Trường không được bỏ trống";
            check = false;
        }

        //DaiCQ add check validate format for passport 10082020
        /*if (!$scope.isValidPassportFormat()) {
            check = false;
        }*/
        //END DaiCQ add check validate format for passport 10082020

        if (org_type == 1) {
            if (isNullOrEmpty($scope.contract.contract_number)) {
                $scope.contract_number_ = "Trường không được bỏ trống";
                check = false;
            }
            if (isNullOrEmpty($scope.contract.contract_signer)) {
                $scope.contract_signer_ = "Trường không được bỏ trống";
                check = false;
            }
            if (isNullOrEmpty($scope.contract.received_date)) {
                $scope.received_date_ = "Trường không được bỏ trống";
                check = false;
            }
            if (isNullOrEmpty($scope.contract.notary_date)) {
                $scope.notary_date_ = "Trường không được bỏ trống";
                check = false;
            }

        }

        /*        if(!$scope.contract.contract_number.toString().length>0){
                    return false;
                }*/
        /*if(!$scope.contract.received_date.toString().length==10){
            return false;
        }
        if(!$scope.contract.notary_date.toString().length==10){
            return false;
        }*/
        /*if(!$scope.contract.drafter_id>0){
            return false;
        }*/
        /*      if(!$scope.contract.notary_id>0){
                  return false;
              }*/

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
