myApp.controller('temporaryAddFromFileController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    var now = new Date();
    var endDate = ("0" + now.getDate()).slice(-2) + '/' + ("0" + (now.getMonth() + 1)).slice(-2) + '/' + now.getFullYear();
    $scope.checkLoad = false;
    // var url="http://localhost:8082/api";
    $scope.contract = {
        tcid: "",
        type: "",
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
        request_recipient: "",
        notary_book:""
    };
    $scope.org_type = org_type;
    $scope.userEntryId = userEntryId;

    $scope.list_load_privy = [{id: 1, name: "Cá nhân - Cá nhân"}, {id: 2, name: "Tổ chức - Cá nhân"}, {
        id: 3,
        name: "Tổ chức - Tổ chức"
    }, {id: 4, name: "Cá nhân - Tổ chức"}];

    $scope.announcement = {notaryFee: ""};

    $scope.contract.contract_value = 0;

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

    $scope.getListRealEstateTypeSubByIndex = function (index) {
        return $scope["property_real_estate_type_sub" + index];
    };
    //END Bổ sung các loại tài sản thuộc bất động sản

    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    // $scope.contract.kindhtml = $scope.contract_template.kind_html;

                    //sonnv fix teamplate con
                    $scope.changeTemplate_Apiece(code);
                    $scope.getActionContractTemplate();
                    //fix copy
                    $scope.contract_template_copy = response.data;
                    // $scope.kindhtml_copy = $scope.contract_template.kind_html;
                });
        } else {
            $scope.contract_template = "";
            $scope.contractTemplatesApiece = "";
            $scope.contract_template_copy = "";
            $scope.contract.kindhtml = "";
            $scope.kindhtml_copy = "";
        }
    };

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

    $scope.flg_nhan_dien_key_start_duong_su;
    $scope.flg_nhan_dien_key_end_duong_su;
    $scope.flg_nhan_dien_key_start_tai_san;
    $scope.flg_nhan_dien_key_end_tai_san;
    $scope.alertNhanDien = "";
    $scope.importFileWord = function () {
        console.log("changed file");
        /*var element = document.getElementById("alertNhanDienKey");
        element.parentNode.removeChild(element);*/
        document.getElementById("alertNhanDienKey").innerHTML = '';
        console.log("changed file");
        var file = $scope.myFileImport;
        if ($scope.myFileImport.size > 5242000) {
            $("#errorMaxFile").modal('show');
        } else {
            var file = $scope.myFileImport;
            var uploadUrl = url + "/contract/temporary/read-and-dissect-file";
            fileUpload.uploadFileToUrl(file, uploadUrl)
                .then(function (response) {
                        if (response.data != null && response.data != 'undefined' && response.status == 200) {
                            //refresh data
                            $scope.flg_nhan_dien_key_start_duong_su = 0;
                            $scope.flg_nhan_dien_key_end_duong_su = 0;
                            $scope.flg_nhan_dien_key_start_tai_san = 0;
                            $scope.flg_nhan_dien_key_end_tai_san = 0;

                            console.log("data dissect file is ", response.data);
                            //bind data


                            $scope.contract = response.data.temporaryContract;

                            //load ten tccc
                            // console.log($("#office-department").text());
                            $scope.contract.office_department = $("#office-department").text();
                            $scope.contract.office_province = $("#office_province").text();
                            $scope.contract.notary_place = $("#notary_office_address").text();
                            console.log("office-department = " + $scope.contract.office_department);

                            if ($scope.contract.notary_date != null) {
                                $scope.changeDateNotary($scope.contract.notary_date);
                            }
                            if ($scope.contract.notary_id != null) {
                                $scope.changeNotary($scope.contract.notary_id);
                            }
                            $scope.flg_nhan_dien_key_start_duong_su = response.data.flg_nhanDienKeyStartDuongSu;
                            $scope.flg_nhan_dien_key_end_duong_su = response.data.flg_nhanDienKeyEndDuongSu;
                            $scope.flg_nhan_dien_key_start_tai_san = response.data.flg_nhanDienKeyStartTaiSan;
                            $scope.flg_nhan_dien_key_end_tai_san = response.data.flg_nhanDienKeyEndTaiSan;
                            /* $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: $scope.contract.contract_template_id }})
                                 .then(function(response) {

                                     $scope.contract_template = response.data;
                                     $scope.contractKindValue = $scope.contract_template.code.toString();
                                     $scope.myFunc($scope.contractKindValue);
                                 });*/

                            //convert contract_value from number to string
                            if ($scope.contract.contract_value != null) {
                                $scope.changeContractValue($scope.contract.contract_value);
                            }

                            $scope.contract_template = {};
                            $scope.contractKindValue = "";
                            if ($scope.contract.contract_template_id != null && $scope.contract.contract_template_id > 0) {
                                $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: $scope.contract.contract_template_id}})
                                    .then(function (response) {
                                        $scope.contract_template = response.data;
                                        $scope.contractKindValue = $scope.contract_template.code.toString();
                                        $scope.contract.kindhtml = $scope.contract_template.kind_html;

                                        //sonnv fix teamplate con
                                        $scope.changeTemplate_Apiece($scope.contract.contract_template_id);
                                        $scope.getActionContractTemplate();
                                        //fix copy
                                        $scope.contract_template_copy = response.data;
                                        $scope.kindhtml_copy = $scope.contract_template.kind_html;
                                    });

                                $http.get(url + "/contract/get-contract-kind-by-contract-template-code", {params: {code: $scope.contract.contract_template_id}})
                                    .then(function (response) {
                                        $scope.contractKind = response.data;
                                        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: $scope.contractKind.contract_kind_code}})
                                            .then(function (response) {
                                                $scope.contractTemplates = response.data;
                                            });

                                    });
                            } else {
                                $scope.contract_template = "";
                                $scope.contractTemplatesApiece = "";
                                $scope.contract_template_copy = "";
                                $scope.contract.kindhtml = "";
                                $scope.kindhtml_copy = "";
                            }


                            if ($scope.contract.json_property != null && $scope.contract.json_property != "" && $scope.contract.json_property != 'undefined') {
                                try {
                                    var pri = $scope.contract.json_property.substr(1, $scope.contract.json_property.length - 2);
                                    $scope.listProperty = JSON.parse(pri);
                                    //convert land_area from number to string
                                    for (var i = 0; i < $scope.listProperty.properties.length; i++) {
                                        if ($scope.listProperty.properties[i].land.land_area != null) {
                                            $scope.changelandAreaValue(0, $scope.listProperty.properties[i].land.land_area);
                                        }
                                    }


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
                                    // $scope.privys=JSON.parse(person);
                                    $scope.privys = JSON.parse(person);
                                } catch (e) {
                                    $scope.privys = "";
                                }

                            }

                            if ($scope.flg_nhan_dien_key_start_duong_su == 0 || $scope.flg_nhan_dien_key_end_duong_su == 0 || $scope.flg_nhan_dien_key_start_tai_san == 0 || $scope.flg_nhan_dien_key_end_tai_san == 0) {
                                $scope.alertNhanDien = "Không nhận diện được từ khóa: ";
                                var flg_before = 0;
                                if ($scope.flg_nhan_dien_key_start_duong_su == 0) {
                                    if (flg_before == 0) {
                                        $scope.alertNhanDien += "bắt đầu khối đương sự";
                                    } else {
                                        $scope.alertNhanDien += ", bắt đầu khối đương sự";
                                    }
                                    flg_before = 1;
                                }
                                if ($scope.flg_nhan_dien_key_end_duong_su == 0) {
                                    if (flg_before == 0) {
                                        $scope.alertNhanDien += "kết thúc khối đương sự";
                                    } else {
                                        $scope.alertNhanDien += ", kết thúc khối đương sự";
                                    }
                                    flg_before = 1;
                                }
                                if ($scope.flg_nhan_dien_key_start_tai_san == 0) {
                                    if (flg_before == 0) {
                                        $scope.alertNhanDien += "bắt đầu khối tài sản";
                                    } else {
                                        $scope.alertNhanDien += ", bắt đầu khối tài sản";
                                    }
                                    flg_before = 1;

                                }
                                if ($scope.flg_nhan_dien_key_end_tai_san == 0) {
                                    if (flg_before == 0) {
                                        $scope.alertNhanDien += "kết thúc khối tài sản";
                                    } else {
                                        $scope.alertNhanDien += ", kết thúc khối tài sản";
                                    }
                                    flg_before = 1;

                                }
                                // $("#alertNhanDienKey").appendChild();
                                var div = document.getElementById('alertNhanDienKey');
                                div.innerHTML += $scope.alertNhanDien;
                            }


                        } else {
                            $("#errorAdd").modal('show');
                        }
                    },
                    function (response) {
                        // failure callback
                        $("#errorAdd").modal('show');
                    }
                );
        }
    };


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

    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });

    $scope.myFunc = function (code) {
        if (typeof code != "undefined") {
            $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: code}})
                .then(function (response) {
                    $scope.contractTemplates = response.data;
                    $scope.contractTemplatesApiece = "";
                });
        } else {
            $scope.contractTemplates = "";
            $scope.contractTemplatesApiece = "";
            $scope.contract_template = "";
            $scope.contract_template_copy = "";
            $scope.contract.kindhtml = "";
            $scope.kindhtml_copy = "";
        }
    };


    /*if(org_type==1){
        $http.get(url+"/contract/contractNumber",{params:{year:now.getFullYear(),userId:userEntryId}})
            .then(function (response) {
                $scope.contract.contract_number=now.getFullYear()+"/"+userEntryId+"/"+response.data;
                return response;
            });
    }else{
        $http.get(url+"/contract/contractNumber",{params:{year:now.getFullYear(),userId:0}})
            .then(function (response) {
                $scope.contract.contract_number=now.getFullYear()+"/"+response.data;
                return response;
            });
    }*/


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
                // item.land_area = value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
                valueRemovePhay = value.replace(",", "");
                var chuso = docso(valueRemovePhay).trim();
                item.land_area_text = chuso.charAt(0).toUpperCase() + chuso.slice(1);
                item.land_area = value;
                /*var chuso = docso(value).trim();
                item.land_area_text = chuso.charAt(0).toUpperCase() + chuso.slice(1);
                item.land_area = value;*/
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

                }
            }
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

    /*load default date notary*/
//load ten tccc
    // console.log($("#office-department").text());
    $scope.contract.office_department = $("#office-department").text();
    $scope.contract.office_province = $("#office_province").text();
    $scope.contract.notary_place = $("#notary_office_address").text();
    var date = new Date();
    /*$scope.contract.received_date=("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' +  date.getFullYear();
    $scope.contract.notary_date=("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' +  date.getFullYear();*/
    var dateArray = $scope.contract.notary_date.split("/");
    var date = dateArray[0];
    var month = dateArray[1];
    var year = dateArray[2];
    $scope.contract.notary_date_date = date;
    $scope.contract.notary_date_month = month;
    $scope.contract.notary_date_year = year;
    var ngay = $scope.contract.notary_date_date + "/" + $scope.contract.notary_date_month + "/" + $scope.contract.notary_date_year;
    $scope.contract.convert_notary_date_date = docngaythang(ngay);


    /*load template duong su+tai san*/
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


    /*Duong su ben A-B-C*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    // $scope.privys = { name: "Đương sự", privy: [ { name: "Bên A", id: 1,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] }, { name: "Bên B", id: 2,action:"", persons: [ { id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:"" } ] } ] };
    $scope.privys = {name: "Đương sự", privy: []};


    $scope.addPrivy = function () {
        if ($scope.privys.privy.length < alphabet.length) {
            // var object={ name: "Bên "+alphabet[$scope.privys.privy.length], id: $scope.privys.privy.length,action:"", persons: [ {type:"", id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"",position:"", description:"",org_name:"",org_address:"",org_code:"",first_registed_date:"",number_change_registed:"",change_registed_date:"",department_issue:"" } ] };
            var object = {
                name: "Bên " + alphabet[$scope.privys.privy.length],
                type: "",
                id: $scope.privys.privy.length,
                action: "",
                persons: []
            };
            $scope.privys.privy.push(object);
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
        $scope.getActionContractTemplate();
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

    $scope.showPerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons[index].myPerson = !$scope.privys.privy[parentIndex].persons[index].myPerson;
    };
    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };
    // khoi tao duong su
    $scope.initPrivyInput = function () {

        $scope.privys = privy_init;

        for (var i = 0; i < $scope.privys.privy.length; i++) {
            for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                if ($scope.privys.privy[i].persons[j].myPerson == null) {
                    $scope.privys.privy[i].persons[j].myPerson = true;
                    //sonnv
                    if (i == 0) {
                        $scope.privys.privy[0].action = $scope.contract_template.relate_object_a_display;
                    }
                    if (i == 1) {
                        $scope.privys.privy[1].action = $scope.contract_template.relate_object_b_display;
                    }
                    if (i == 2) {
                        $scope.privys.privy[2].action = $scope.contract_template.relate_object_c_display;
                    }
                    //end
                    // datepicker init privy
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
                }
            }
        }


    };
    // khoi tao tai san
    $scope.initPropertyInput = function () {


        $scope.listProperty = property_init;
        if ($scope.listProperty.properties[0].template == null) {
            $scope.listProperty.properties[0].template = 1;
        }
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            if ($scope.listProperty.properties[i].myProperty == null) {
                $scope.listProperty.properties[i].myProperty = true;
                // datepicker init
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
        }
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {

            /*$scope.listProperty.properties[i].myProperty = true;*/
            // datepicker init
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

        var object = $filter('filter')($scope.templateProperties, {type: "01"}, true);
        if ($scope["listTypeTaiSan" + 0] == null) {
            $scope["listTypeTaiSan" + 0] = object;
        }


    };
    // set date pick for privy-init
    $scope.setDatePrivy = function () {


        for (var i = 0; i < $scope.privys.privy.length; i++) {
            for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {


                // datepicker init privy
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

            }
        }


    };
    // set date pick for p-init
    $scope.setDateProperty = function () {

        for (var i = 0; i < $scope.listProperty.properties.length; i++) {

            /*$scope.listProperty.properties[i].myProperty = true;*/
            // datepicker init
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


    };

    /*dia diem cong chung*/
    $scope.contract.notary_place_flag = true;

    /*Thong tin tai san*/
    //$scope.listProperty=	{ name: "property", properties: [ { type: "", id: 1,type_view:"", property_info:"", owner_info:"", other_info:"",restrict:"",apartment:{apartment_address:"",apartment_number:"",apartment_floor:"",apartment_area_use:"",apartment_area_build:"",apartment_structure:"",apartment_total_floor:""}, land: { land_certificate:"", land_issue_place:"", land_issue_date:"", land_map_number:"", land_number:"", land_address:"", land_area:"", land_area_text:"", land_public_area:"", land_private_area:"", land_use_purpose:"", land_use_period:"", land_use_origin:"", land_associate_property:"", land_street:"", land_district:"", land_province:"", land_full_of_area:"" }, vehicle:{ car_license_number:"", car_regist_number:"", car_issue_place:"", car_issue_date:"", car_frame_number:"", car_machine_number:"" } } ] };
    $scope.listProperty = {name: "property", properties: []};
    //$scope.listProperty= property_init;

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
                land_full_of_area: "",
                land_type: "",
                construction_area: "",
                building_area: "",
                land_use_type: "",
                land_sort: ""
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
        $scope.listProperty.properties.push(object);
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
        //console.log($scope.listProperty.properties[index].myProperty);
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
            //console.log(object[0]);

            $scope.privys.privy[itemIndex].persons[index].teamplate_1 = object.html;
            //console.log($scope.privys.privy[itemIndex].persons[index].teamplate_1);
        }
        var birth = "#userBirthday" + itemIndex + "-" + index;
        $(birth).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        var userCerDate = "#userCertificationDate" + itemIndex + "-" + index;
        $(userCerDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        var userFirstDate = "#userFirstRegistedDate" + itemIndex + "-" + index;
        $(userFirstDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {

            $(this).datepicker('hide');
        });
        var userChangeDate = "#userChangeRegistedDate" + itemIndex + "-" + index;
        $(userChangeDate).datepicker({
            format: "dd/mm/yyyy",
            startDate: "01/01/1900",
            endDate: endDate,
            forceParse: false,
            language: 'vi'
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });
        var CerDateComp = "#userCertificationDateComp" + itemIndex + "-" + index;
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

    $scope.changeNotary = function (notary_id) {
        var object = $filter('filter')($scope.notarys, {userId: parseInt(notary_id)}, true)[0];
        //console.log(object);
//notary_person
        $scope.contract.notary_person = object.family_name + " " + object.first_name;

    };

    $scope.changeNotaryPlace = function (notaryPlace) {
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
        if (template == 3) {
            namesuggest = "#credit_code" + itemIndex + "-" + index;
        }
        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggest',

            params: {
                template: template
            },
            onSelect: function (suggestion) {
                if (template == 2) {
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

    /*end property*/
    $scope.viewAsDoc = function () {
        $("#viewHtmlAsWord").html($("#contentKindHtml").html());
        $("#viewContentAsWord").modal('show');
    };

    $scope.downloadWord = function () {
        $("#contentKindHtml").wordExport();
    };

    /*danh sach ngan hang*/
    $http.get(url + "/bank/getAllBank")
        .then(function (response) {
            $scope.banks = response.data;
        });
    $scope.contract.bank_service_fee = 0;
    /*danh sách sổ công chứng*/
    $http.get(url + "/notaryBook/listSattusNotarybook",{
        params: {
            type: typeHD
        }
    })
        .then(function (response) {
            $scope.notaryBook = response.data;
        });

    /*Calculate total fee*/
    $scope.contract.cost_draft = 0;
    $scope.contract.cost_notary_outsite = 0;
    $scope.contract.cost_other_determine = 0;
    $scope.contract.cost_total = 0;
    $scope.contract.cost_tt91 = 0;
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


    $scope.checkAdd = function () {
        if ($scope.contract.notary_id == null || $scope.contract.notary_id == "" || $scope.contract.notary_id == 'underfined') {
            $("#errorLog").modal('show');
        } else {
            $("#addContract").modal('show');
        }
    };
    /*if(!$scope.contract.notary_id>0){
        if($scope.checkValidateBasic()){
            $("#errorLog").modal('show');
        }else{
            $("#checkValidate").modal('show');
        }

    }else{*/
    /*When click Luu thong tin*/
    $scope.addContractWrapper = function () {
        $scope.checkLoad = false;
        if (!$scope.checkValidateBasic()) {
            //$("#checkValidate").modal('show');
        }

        if ($scope.checkValidateAdvance()) {
            if ($scope.checkDate()) {
                $scope.checkLoad = true;
                $("#checkDate").modal('show');
            } else {
                // neu ten hop dong khong co thi luu la ki tu dac biet o0o
                if ($scope.contract.contract_number == null || $scope.contract.contract_number == 'undefined' || $scope.contract.contract_number == '') {
                    $scope.contract.contract_number = "o0o";
                }
                /*$http.get(url+"/contract/checkContractNumber",{params: {contract_number:$scope.contract.contract_number}})
                    .then(function (response) {
                        if(response.status == 200   && response.data==true){*/
                $scope.contract.type = "0";

                /*genaral duong su va tai san*/
                $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
                $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";

                $scope.contract.entry_date_time = new Date();
                $scope.contract.update_date_time = new Date();

                /*gen property info and relation object*/
                $scope.genInforProAndPrivys();

                /*format list Duogn su in html*/
                $scope.contract.kindhtml = $("div #contentKindHtml").html();

                var contractAdd = JSON.parse(JSON.stringify($scope.contract));
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
                                        $http.post(url + "/contract/temporaryNotCheck", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                            .then(function (response) {
                                                    if (response.status == 200) {
                                                        $window.location.href = contextPath + '/contract/temporary/list?status=1';
                                                    } else {
                                                        $scope.checkLoad = true;
                                                        $("#errorEdit").modal('show');
                                                    }
                                                },
                                                function (response) {
                                                    // failure callback
                                                    $scope.checkLoad = true;
                                                    $("#errorEdit").modal('show');
                                                }
                                            );
                                    } else {
                                        $scope.checkLoad = true;
                                        $("#errorEdit").modal('show');
                                    }
                                },
                                function (response) {
                                    // failure callback
                                    $scope.checkLoad = true;
                                    $("#errorEdit").modal('show');
                                }
                            );
                    }

                } else {
                    $http.post(url + "/contract/temporaryNotCheck", contractAdd, {headers: {'Content-Type': 'application/json'}})
                        .then(function (response) {
                                if (response.status == 200) {
                                    $window.location.href = contextPath + '/contract/temporary/list?status=1';
                                } else {
                                    $scope.checkLoad = true;
                                    $("#errorEdit").modal('show');
                                }
                            },
                            function (response) {
                                // failure callback
                                $scope.checkLoad = true;
                                $("#errorEdit").modal('show');
                            }
                        );
                }

                /*}else{
                    $scope.checkLoad=true;
                    //alert(response.statusText);
                    $("#checkContractNumber").modal('show');
                }
            });*/
            }


        } else {
            //$("#checkValidate").modal('show');
        }


    };

    $scope.addContract = function () {
        $scope.checkLoad = false;
        if (!$scope.checkValidateBasic()) {
            //$("#checkValidate").modal('show');
        } else {
            if ($scope.checkDate()) {
                $scope.checkLoad = true;
                $("#checkDate").modal('show');
            } else {
                /*$http.get(url + "/contract/checkContractNumber", {params: {contract_number: $scope.contract.contract_number}})
                    .then(function (response) {
                        if (response.status == 200  && response.data == true) {*/
                $scope.contract.type = "3";

                /*genaral duong su va tai san*/
                if ($scope.contract.contract_number == null || $scope.contract.contract_number == 'undefined' || $scope.contract.contract_number == '') {
                    $scope.contract.contract_number = "o0o";
                }
                $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
                $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";

                $scope.contract.entry_date_time = new Date();
                $scope.contract.update_date_time = new Date();

                /*gen property info and relation object*/
                $scope.genInforProAndPrivys();
                // $scope.contract.kindhtml=$scope.getKindHtml();
                $scope.contract.kindhtml = $("div #contentKindHtml").html();

                /*end format*/
                var contractAdd = JSON.parse(JSON.stringify($scope.contract));
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
                                        $http.post(url + "/contract/temporaryNotCheck", contractAdd, {headers: {'Content-Type': 'application/json'}})
                                            .then(function (response) {
                                                    if (response.status == 200) {
                                                        if (org_type == 1) {
                                                            getTemporaryContractSaved(response.data);
                                                        } else $window.location.href = contextPath + '/contract/temporary/list?status=1';
                                                    } else {
                                                        $scope.checkLoad = true;
                                                        $("#errorEdit").modal('show');
                                                    }
                                                },
                                                function (response) {
                                                    // failure callback
                                                    $scope.checkLoad = true;
                                                    $("#errorEdit").modal('show');
                                                }
                                            );
                                    } else {
                                        $scope.checkLoad = true;
                                        $("#errorEdit").modal('show');
                                    }
                                },
                                function (response) {
                                    // failure callback
                                    $scope.checkLoad = true;
                                    $("#errorEdit").modal('show');
                                }
                            );
                    }

                } else {
                    $http.post(url + "/contract/temporaryNotCheck", contractAdd, {headers: {'Content-Type': 'application/json'}})
                        .then(function (response) {
                                if (response.status == 200) {
                                    if (org_type == 1) {
                                        getTemporaryContractSaved(response.data);
                                    } else $window.location.href = contextPath + '/contract/temporary/list?status=1';
                                } else {
                                    $("#errorEdit").modal('show');
                                }
                            },
                            function (response) {
                                // failure callback
                                $scope.checkLoad = true;
                                $("#errorEdit").modal('show');
                            }
                        );
                }

                /*} else {
                    $scope.checkLoad = true;
                    //alert(response.statusText);
                    $("#checkContractNumber").modal('show');
                }
            });*/
            }
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


    $scope.getKindHtml = function () {
        $("#copyContract").html($("div #contentKindHtml").html());
        $("#copyContract .duongsu").html(" ");
        $("#copyContract .taisan").html(" ");
        var kindhtml = $("#copyContract").html();
        $("#copyContract").html("  ");
        return kindhtml;
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

    /*gen info property and privys*/
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
        /*end gen info*/
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

    /*check validate form*/
    $scope.checkValidateBasic = function () {
        $scope.result = true;
        var fosus = 0;

        $scope.contractKindValue_valid = "";
        $scope.contract_template_id_valid = "";

        if (!$scope.contractKind.contract_kind_code > 0) {
            $scope.contractKindValue_valid = "Trường không được bỏ trống.";
            $scope.result = false;
            if (fosus == 0) {
                fosus = 1;
                $("#contractKindValue_valid").focus();
            }
        }
        if (!$scope.contract.contract_template_id > 0) {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $scope.result = false;
            if (fosus == 0) {
                fosus = 1;
                $("#contract_template_id_valid").focus();
            }
        }
        /*if(!$scope.contract.contract_number.toString().length>0){
            return false;
        }*/
        return $scope.result;
    };

    $scope.checkValidateAdvance = function () {
        $scope.result = true;
        var fosus = 0;

        $scope.contractKindValue_valid = "";
        $scope.contract_template_id_valid = "";
        $scope.contract_value_ = "";

        $scope.contract_signer_ = "";

        if (!$scope.contractKind.contract_kind_code > 0) {
            $scope.contractKindValue_valid = "Trường không được bỏ trống.";
            $scope.result = false;
            if (fosus == 0) {
                fosus = 1;
                $("#contractKindValue_valid").focus();
            }
        }
        if (!$scope.contract.contract_template_id > 0) {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $scope.result = false;
            if (fosus == 0) {
                fosus = 1;
                $("#contract_template_id_valid").focus();
            }
        }
        /*if(!$scope.contract.contract_number.toString().length>0){
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
        /*if(!$scope.contract.notary_id>0){
            return false;
        }*/
        if ($scope.contract.contract_value == null || $scope.contract.contract_value == undefined || $scope.contract.contract_value === "") {
            $scope.contract_value_ = "Trường không được bỏ trống.";
            $scope.result = false;
            if (fosus == 0) {
                fosus = 1;
                $("#contract_value_").focus();
            }
        }

        if ($scope.org_type == 1) {
            if ($scope.contract.contract_signer == null || $scope.contract.contract_signer == 'undefined' || $scope.contract.contract_signer === '') {
                $scope.contract_signer_ = "Trường không được bỏ trống. ";
                $scope.result = false;
            }
        }

        //DaiCQ add check validate format for passport 10082020
        if (!$scope.isValidPassportFormat()) {
            check = false;
        }
        //END DaiCQ add check validate format for passport 10082020

        return $scope.result;
    };

    $scope.checkphi = function (phi) {
        console.log(phi);
        var b = "0.5*a";
        var c = Number(b);
        var a = phi / 100;
        console.log("gia tri" + a);
    };

    //--------------------------------------------
    $scope.stringToDate = function (_date, _format, _delimiter) {
        var timenow = new Date();
        var formatLowerCase = _format.toLowerCase();
        var formatItems = formatLowerCase.split(_delimiter);
        var dateItems = _date.split(_delimiter);
        var monthIndex = formatItems.indexOf("mm");
        var dayIndex = formatItems.indexOf("dd");
        var yearIndex = formatItems.indexOf("yyyy");
        var month = parseInt(dateItems[monthIndex]);
        month -= 1;
        var formatedDate = new Date(dateItems[yearIndex], month, dateItems[dayIndex], timenow.getHours(), timenow.getMinutes(), timenow.getSeconds(), '00');
        return formatedDate;
    };

    $scope.updateContractTemplate = function () {
        $scope.contract_template_id_valid = "";
        $scope.contractKindValue_valid = "";
        $scope.HTML_valid = "";

        if (!$scope.contractKindValue > 0) {
            $scope.contractKindValue_valid = "Trường không được bỏ trống.";
            $("#contractKindValue_valid").focus();
            return false;
        }
        if (typeof $scope.contract.contract_template_id == "undefined" || $scope.contract.contract_template_id == "" || typeof $scope.contract_template == "undefined" || $scope.contract_template == "") {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $("#contract_template_id_valid").focus();
            return false;
        }
        if ($scope.contract.contract_template_id <= 0) {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $("#contract_template_id_valid").focus();
            return false;
        }
        var kind_html = $("div #contentKindHtml").html();
        if (typeof kind_html == "undefined" || kind_html.length <= 0) {
            $scope.HTML_valid = "Trường không được bỏ trống.";
            $("#editor").focus();
            return false;
        }

        $scope.copycontract_template_ = angular.copy($scope.contract_template);

        $timeout(function () {
            var kind_html = $("div #contentKindHtml").html();

            var update_contract_template = {
                id: "",
                name: "",
                kind_id: "",
                kind_id_tt08: "",
                code: "",
                description: "",
                file_name: "",
                file_path: "",
                active_flg: "",
                relate_object_number: "",
                relate_object_A_display: "",
                relate_object_B_display: "",
                relate_object_C_display: "",
                period_flag: "",
                period_req_flag: "",
                mortage_cancel_func: "",
                sync_option: "",
                entry_user_id: "",
                entry_user_name: "",
                entry_date_time: "",
                update_user_id: "",
                update_user_name: "",
                update_date_time: "",
                kind_html: "",
                office_code: "",
                code_template: ""
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
            if (typeof $scope.contract_template.relate_object_a_display != "undefined") {
                update_contract_template.relate_object_A_display = $scope.contract_template.relate_object_a_display;
            } else {
                update_contract_template.relate_object_A_display = "";
            }
            if (typeof $scope.contract_template.relate_object_b_display != "undefined") {
                update_contract_template.relate_object_B_display = $scope.contract_template.relate_object_b_display;
            } else {
                update_contract_template.relate_object_B_display = "";
            }
            if (typeof $scope.contract_template.relate_object_c_display != "undefined") {
                update_contract_template.relate_object_C_display = $scope.contract_template.relate_object_c_display;
            } else {
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
            if ($scope.contract_template.office_code == null || $scope.contract_template.office_code == "" || typeof $scope.contract_template.office_code == "undefined") {
                update_contract_template.office_code = "";
            } else {
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

            if (doc.body.innerHTML.length > 0) {
                if (doc.getElementById("id_duongsu")) {
                    if (!docupdate.getElementById("id_duongsu")) {
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }

                if (doc.getElementById("id_taisan")) {
                    if (!docupdate.getElementById("id_taisan")) {
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }
            }
            //end check

            var form = '';

            form += '<input type="hidden" name="id" value="' + update_contract_template.id + '">';
            form += '<input type="hidden" name="name" value="' + update_contract_template.name + '">';
            form += '<input type="hidden" name="kind_id" value="' + update_contract_template.kind_id + '">';
            form += '<input type="hidden" name="kind_id_tt08" value="' + update_contract_template.kind_id_tt08 + '">';
            form += '<input type="hidden" name="code" value="' + update_contract_template.code + '">';
            form += '<input type="hidden" name="description" value="' + update_contract_template.description + '">';
            form += '<input type="hidden" name="file_name" value="' + update_contract_template.file_name + '">';
            form += '<input type="hidden" name="file_path" value="' + update_contract_template.file_path + '">';
            form += '<input type="hidden" name="active_flg" value="' + update_contract_template.active_flg + '">';
            form += '<input type="hidden" name="relate_object_number" value="' + update_contract_template.relate_object_number + '">';
            form += '<input type="hidden" name="relate_object_A_display" value="' + update_contract_template.relate_object_A_display + '">';
            form += '<input type="hidden" name="relate_object_B_display" value="' + update_contract_template.relate_object_B_display + '">';
            form += '<input type="hidden" name="relate_object_C_display" value="' + update_contract_template.relate_object_C_display + '">';
            form += '<input type="hidden" name="period_flag" value="' + update_contract_template.period_flag + '">';
            form += '<input type="hidden" name="period_req_flag" value="' + update_contract_template.period_req_flag + '">';
            form += '<input type="hidden" name="mortage_cancel_func" value="' + update_contract_template.mortage_cancel_func + '">';
            form += '<input type="hidden" name="sync_option" value="' + update_contract_template.sync_option + '">';
            form += '<input type="hidden" name="entry_user_id" value="' + update_contract_template.entry_user_id + '">';
            form += '<input type="hidden" name="entry_user_name" value="' + update_contract_template.entry_user_name + '">';
            form += '<input type="hidden" name="entry_date_time" value="">';
            form += '<input type="hidden" name="update_user_id" value="' + update_contract_template.update_user_id + '">';
            form += '<input type="hidden" name="update_user_name" value="' + update_contract_template.update_user_name + '">';
            form += '<input type="hidden" name="update_date_time" value="">';
            form += '<textarea id="conTractTemPlatePostCustumUpdateJS_kind_html" class="hidden" name="kind_html" rows="10"></textarea>';
            form += '<input type="hidden" name="office_code" value="' + update_contract_template.office_code + '">';
            form += '<input type="hidden" name="code_template" value="' + update_contract_template.code_template + '">';

            var _form_ = $('<form target="_blank" id = "conTractTemPlatePostCustumUpdateJS" class="hidden" action="' + conTractTemPlatePostCustumUpdateJS + '" method="post">' + form + '</form>');
            $('body').append(_form_);
            document.getElementById("conTractTemPlatePostCustumUpdateJS_kind_html").value = update_contract_template.kind_html;
            $("#conTractTemPlatePostCustumUpdateJS").submit();
            $("#conTractTemPlatePostCustumUpdateJS").remove();

        }, 0);
    };

    $scope.addContractTemplate = function () {
        $scope.contract_template_id_valid = "";
        $scope.contractKindValue_valid = "";
        $scope.HTML_valid = "";

        if (!$scope.contractKind.contract_kind_code > 0) {
            $scope.contractKindValue_valid = "Trường không được bỏ trống.";
            $("#contractKindValue_valid").focus();
            return false;
        }
        if (typeof $scope.contract.contract_template_id == "undefined" || $scope.contract.contract_template_id == "" || typeof $scope.contract_template == "undefined" || $scope.contract_template == "") {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $("#contract_template_id_valid").focus();
            return false;
        }
        if ($scope.contract.contract_template_id <= 0) {
            $scope.contract_template_id_valid = "Trường không được bỏ trống.";
            $("#contract_template_id_valid").focus();
            return false;
        }
        var kind_html = $("div #contentKindHtml").html();
        if (typeof kind_html == "undefined" || kind_html.length <= 0) {
            $scope.HTML_valid = "Trường không được bỏ trống.";
            $("#editor").focus();
            return false;
        }

        $scope.copycontract_template_ = angular.copy($scope.contract_template);

        $timeout(function () {
            var kind_html = $("div #contentKindHtml").html();

            var add_contract_template = {
                id: "",
                name: "",
                kind_id: "",
                kind_id_tt08: "",
                code: "",
                description: "",
                file_name: "",
                file_path: "",
                active_flg: "",
                relate_object_number: "",
                relate_object_A_display: "",
                relate_object_B_display: "",
                relate_object_C_display: "",
                period_flag: "",
                period_req_flag: "",
                mortage_cancel_func: "",
                sync_option: "",
                entry_user_id: "",
                entry_user_name: "",
                entry_date_time: new Date(),
                update_user_id: "",
                update_user_name: "",
                update_date_time: new Date(),
                kind_html: "",
                office_code: "",
                code_template: ""
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
            if (typeof $scope.contract_template.relate_object_a_display != "undefined") {
                add_contract_template.relate_object_A_display = $scope.contract_template.relate_object_a_display;
            } else {
                add_contract_template.relate_object_A_display = "";
            }
            if (typeof $scope.contract_template.relate_object_b_display != "undefined") {
                add_contract_template.relate_object_B_display = $scope.contract_template.relate_object_b_display;
            } else {
                add_contract_template.relate_object_B_display = "";
            }
            if (typeof $scope.contract_template.relate_object_c_display != "undefined") {
                add_contract_template.relate_object_C_display = $scope.contract_template.relate_object_c_display;
            } else {
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
            if ($scope.contract_template.office_code == null || $scope.contract_template.office_code == "" || typeof $scope.contract_template.office_code == "undefined") {
                add_contract_template.office_code = "";
            } else {
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

            if (doc.body.innerHTML.length > 0) {
                if (doc.getElementById("id_duongsu")) {
                    if (!docupdate.getElementById("id_duongsu")) {
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }

                if (doc.getElementById("id_taisan")) {
                    if (!docupdate.getElementById("id_taisan")) {
                        $("#ErorUpdateContractTemplate").modal('show');
                        return false;
                    }
                }
            }
            //end check

            var form = '';

            form += '<input type="hidden" name="id" value="' + add_contract_template.id + '">';
            form += '<input type="hidden" name="name" value="' + add_contract_template.name + '">';
            form += '<input type="hidden" name="kind_id" value="' + add_contract_template.kind_id + '">';
            form += '<input type="hidden" name="kind_id_tt08" value="' + add_contract_template.kind_id_tt08 + '">';
            form += '<input type="hidden" name="code" value="' + add_contract_template.code + '">';
            form += '<input type="hidden" name="description" value="' + add_contract_template.description + '">';
            form += '<input type="hidden" name="file_name" value="' + add_contract_template.file_name + '">';
            form += '<input type="hidden" name="file_path" value="' + add_contract_template.file_path + '">';
            form += '<input type="hidden" name="active_flg" value="' + add_contract_template.active_flg + '">';
            form += '<input type="hidden" name="relate_object_number" value="' + add_contract_template.relate_object_number + '">';
            form += '<input type="hidden" name="relate_object_A_display" value="' + add_contract_template.relate_object_A_display + '">';
            form += '<input type="hidden" name="relate_object_B_display" value="' + add_contract_template.relate_object_B_display + '">';
            form += '<input type="hidden" name="relate_object_C_display" value="' + add_contract_template.relate_object_C_display + '">';
            form += '<input type="hidden" name="period_flag" value="' + add_contract_template.period_flag + '">';
            form += '<input type="hidden" name="period_req_flag" value="' + add_contract_template.period_req_flag + '">';
            form += '<input type="hidden" name="mortage_cancel_func" value="' + add_contract_template.mortage_cancel_func + '">';
            form += '<input type="hidden" name="sync_option" value="' + add_contract_template.sync_option + '">';
            form += '<input type="hidden" name="entry_user_id" value="' + add_contract_template.entry_user_id + '">';
            form += '<input type="hidden" name="entry_user_name" value="' + add_contract_template.entry_user_name + '">';
            form += '<input type="hidden" name="entry_date_time" value="">';
            form += '<input type="hidden" name="update_user_id" value="' + add_contract_template.update_user_id + '">';
            form += '<input type="hidden" name="update_user_name" value="' + add_contract_template.update_user_name + '">';
            form += '<input type="hidden" name="update_date_time" value="">';
            form += '<textarea id="conTractTemPlatePostCustumAddJS_kind_html" class="hidden" name="kind_html" rows="10"></textarea>';
            form += '<input type="hidden" name="office_code" value="' + add_contract_template.office_code + '">';
            form += '<input type="hidden" name="code_template" value="' + add_contract_template.code_template + '">';

            var _form_ = $('<form target="_blank" id = "conTractTemPlatePostCustumAddJS" class="hidden" action="' + conTractTemPlatePostCustumAddJS + '" method="post">' + form + '</form>');
            $('body').append(_form_);
            document.getElementById("conTractTemPlatePostCustumAddJS_kind_html").value = add_contract_template.kind_html;
            $("#conTractTemPlatePostCustumAddJS").submit();
            $("#conTractTemPlatePostCustumAddJS").remove();
        }, 0);
    };

}]);
