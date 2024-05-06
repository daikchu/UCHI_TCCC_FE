// var myApp = angular.module('osp', []);
myApp.controller('contractAddController', ['$scope', '$http', '$filter', '$window', 'fileUpload', '$timeout', '$q', function ($scope, $http, $filter, $window, fileUpload, $timeout, $q) {

    $scope.contractAddWrapper = {contract: {}, property: {}};
    $scope.contract = {
        id: "",
        contract_template_id: "",
        contract_number: "",
        notary_book: "",
        contract_value: "",
        relation_object_a: "",
        relation_object_b: "",
        relation_object_c: "",
        notary_id: "",
        drafter_id: "",
        received_date: "",
        notary_date: "",
        user_require_contract: "",
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
        bank_id: null,
        bank_service_fee: "",
        crediter_name: "",
        file_name: "",
        file_path: "",
        error_status: 0,
        error_user_id: "",
        error_description: "",
        addition_status: 0,
        addition_description: "",
        cancel_status: 0,
        cancel_description: "",
        cancel_relation_contract_id: null,
        contract_period: "",
        mortage_cancel_flag: 0,
        mortage_cancel_date: "",
        mortage_cancel_note: "",
        original_store_place: "",
        note: "",
        summary: "",
        entry_user_id: "",
        entry_user_name: "",
        entry_date_time: "",
        update_user_id: "",
        update_user_name: "",
        update_date_time: "",
        bank_name: "",
        jsonstring: "",
        kindhtml: "",
        content: "",
        title: "",
        bank_code: "",
        json_property: "",
        json_person: "",
        sub_template_id: "",
        contract_signer: "",
        request_recipient: "",

        type_real_estate: "",
        type_real_estate_sub:""
    };
    $scope.contractOfflineTemporary = {
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

        /*type_real_estate: "",
        type_real_estate_sub:""*/
    };

    $scope.announcement = {notaryFee: ""};
    $scope.userEntryId = userEntryId;


    $scope.convertTemporary = function () {
        $scope.contractOfflineTemporary.type = "5";
        $scope.contractOfflineTemporary.contract_template_id = $scope.contract.contract_template_id;
        $scope.contractOfflineTemporary.contract_number = $scope.contract.contract_number;
        $scope.contractOfflineTemporary.contract_value = $scope.contract.contract_value;
        $scope.contractOfflineTemporary.notary_id = $scope.contract.notary_id;
        $scope.contractOfflineTemporary.drafter_id = $scope.contract.drafter_id;
        $scope.contractOfflineTemporary.received_date = $scope.contract.received_date;
        $scope.contractOfflineTemporary.notary_date = $scope.contract.notary_date;
        $scope.contractOfflineTemporary.cost_tt91 = $scope.contract.cost_tt91;
        $scope.contractOfflineTemporary.cost_draft = $scope.contract.cost_draft;
        $scope.contractOfflineTemporary.cost_notary_outsite = $scope.contract.cost_notary_outsite;
        $scope.contractOfflineTemporary.cost_other_determine = $scope.contract.cost_other_determine;
        $scope.contractOfflineTemporary.cost_total = $scope.contract.cost_total;
        $scope.contractOfflineTemporary.notary_place_flag = $scope.contract.notary_place_flag;
        $scope.contractOfflineTemporary.notary_place = $scope.contract.notary_place;
        $scope.contractOfflineTemporary.bank_service_fee = $scope.contract.bank_service_fee;
        $scope.contractOfflineTemporary.crediter_name = $scope.contract.crediter_name;
        $scope.contractOfflineTemporary.file_name = $scope.contract.file_name;
        $scope.contractOfflineTemporary.file_path = $scope.contract.file_path;
        $scope.contractOfflineTemporary.note = $scope.contract.note;
        $scope.contractOfflineTemporary.summary = $scope.contract.summary;
        $scope.contractOfflineTemporary.bank_code = $scope.contract.bank_code;
        $scope.contractOfflineTemporary.sub_template_id = $scope.contract.sub_template_id;
        //
        $scope.contractOfflineTemporary.entry_user_id = $scope.contract.entry_user_id;
        $scope.contractOfflineTemporary.entry_user_name = $scope.contract.entry_user_name;
        $scope.contractOfflineTemporary.update_user_id = $scope.contract.update_user_id;
        $scope.contractOfflineTemporary.update_user_name = $scope.contract.update_user_name;

        $scope.contractOfflineTemporary.number_of_sheet = $scope.contract.number_of_sheet;
        $scope.contractOfflineTemporary.number_of_page = $scope.contract.number_of_page;
        $scope.contractOfflineTemporary.number_copy_of_contract = $scope.contract.number_copy_of_contract;
        $scope.contractOfflineTemporary.original_store_place = $scope.contract.original_store_place;
        $scope.contractOfflineTemporary.contract_signer = $scope.contract.contract_signer;
        $scope.contractOfflineTemporary.request_recipient = $scope.contract.request_recipient;

        $scope.contractOfflineTemporary.notary_book = $scope.contract.notary_book;

        /*$scope.contractOfflineTemporary.type_real_estate = $scope.contract.type_real_estate;
        $scope.contractOfflineTemporary.type_real_estate_sub = $scope.contract.type_real_estate_sub;*/

    };

    $scope.myFile = {};
    $scope.org_type = org_type;
    $scope.showDetails = true;//flg show thông tin chi tiết tài sản

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

    /*$scope.changePropertyRealEstate = function (index, parent_code) {
        /!*05/09/2020 đồng bộ cấu trúc tài sản offline online*!/
        if(typeof $scope.templateProperties == 'undefined'){
            $http.get(url + "contract/get-list-property-real-estate-type", {params: {parent_code: parent_code}})
                .then(function (response) {
                //    $scope.templateProperties = response.data;
                    /!*$scope.formatTaiSan();*!/
                    $scope.listProperty.properties[index].real_estate_type = parent_code;
                    var object = $filter('filter')($scope.templateProperties, {parent_code: parent_code}, true);
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
        /!*END 05/09/2020 đồng bộ cấu trúc tài sản offline online*!/

    };*/

    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });

    $scope.myFunc = function (code) {
        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: code}})
            .then(function (response) {
                $scope.contractTemplates = response.data;
                $scope.contractTemplatesApiece = "";
            });
    };

    if (org_type == 1) {
        $http.get(url + "/contract/contractNumber", {params: {year: now.getFullYear(), userId: userEntryId}})
            .then(function (response) {
                if(response.data != null){
                    $scope.contract.contract_number = response.data + "/" + now.getFullYear();
                }else {
                    $scope.contract.contract_number = "1/" + now.getFullYear();
                }

                return response;
            });
    } else {
        $http.get(url + "/contract/contractNumber", {params: {year: now.getFullYear(), userId: 0}})
            .then(function (response) {
                if(response.data != null){
                    $scope.contract.contract_number = response.data + "/" + now.getFullYear();
                }else {
                    $scope.contract.contract_number = "1/" + now.getFullYear();
                }
                return response;
            });
    }


    $scope.changeDateNotary = function (value) {
        if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
            var dateArray = value.split("/");
            var year = dateArray[2];
            if (year != now.getFullYear()) {
                f;
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


    $http.post(url + "/users/selectByFilter", "where role=03", {headers: {'Content-Type': 'application/json'}})
        .then(function (response) {
                $scope.drafters = response.data;
                return response;
            }
        );

    if ($scope.org_type == "1") {
        $http.post(url + "/users/selectByFilter", "where role=02 and id=" + $scope.userEntryId, {headers: {'Content-Type': 'application/json'}})
            .then(function (response) {
                    $scope.notarys = response.data;
                    return response;
                }
            );
    } else {
        $http.post(url + "/users/selectByFilter", "where role=02", {headers: {'Content-Type': 'application/json'}})
            .then(function (response) {
                    $scope.notarys = response.data;
                    return response;
                }
            );
    }

    /*load default date notary*/
    $scope.contract.contract_value = 0;
    var date = new Date();
    $scope.contract.received_date = ("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
    $scope.contract.notary_date = ("0" + date.getDate()).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();

    /*Duong su ben A-B-C*/
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

    $scope.privys = {
        name: "Đương sự",
        privy: [{
            id: 1,
            name: "Bên A",
            action: "",
            persons: [{
                template: 1,
                id: "",
                sex: {id: 1, name: "Ông"},
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
            }]
        }, {
            id: 2,
            name: "Bên B",
            action: "",
            persons: [{
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
            }]
        }]
    };

    $scope.addPrivy = function () {
        if ($scope.privys.privy.length < alphabet.length) {
            var object = {
                id: $scope.privys.privy.length,
                name: "Bên " + alphabet[$scope.privys.privy.length],
                action: "",
                persons: [{
                    template: 1,
                    id: "",
                    sex: "",
                    name: "",
                    birthday: "",
                    passport: "",
                    certification_date: "",
                    certification_place: "",
                    address: "",
                    description: ""
                }]
            };
            $scope.privys.privy.push(object);
        }
        $(function () {
            $scope.datePersonFormat();

        });
        //sonnv
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
        //sonnv
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
                })
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
    //end

    $scope.addPerson = function (index) {
        // var object= {id: "",name: "",birthday:"",passport:"",certification_date:"",certification_place:"",address:"", description:""};
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
        //reload date for birthday
        $(function () {
            $scope.datePersonFormat();
        });

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
        //reload date for birthday
        $(function () {
            $scope.datePersonFormat();
        });

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
        //reload date for birthday
        $(function () {
            $scope.datePersonFormat();
        });

    };
    $scope.removePerson = function (parentIndex, index) {
        $scope.privys.privy[parentIndex].persons.splice(index, 1);
    };


    /*dia diem cong chung*/
    $scope.contract.notary_place_flag = true;


    /*Thong tin tai san*/
    $scope.listProperty = {
        name: "property",
        properties: [{
            type: "01",
            id: 1,
            /*template: "8",*/
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

            type_real_estate:"",
            type_real_estate_sub:""
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
        }]
    };


    $(function () {
        $scope.datePropertyFormat();
        $scope.datePersonFormat();
    });

    $scope.addProperty = function () {
        var object = {
            type: "01",
            id: $scope.listProperty.properties.length + 1,
            /*template: "8",*/
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

            type_real_estate:"",
            type_real_estate_sub:""
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
        };
        $scope.listProperty.properties.push(object);
        $(function () {
            $scope.datePropertyFormat();
        });

    };

    $scope.removeProperty = function (index) {
        $scope.listProperty.properties.splice(index, 1);
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

    $scope.checkBank = false;
    $scope.showDescrip = $scope.checkBank;

    /*When click Luu thong tin*/
    $scope.addContractWrapper = function () {
        if ($scope.checkAllRequiredField()) {
            if ($scope.checkValidate()) {
                if ($scope.checkDate()) {
                    $("#checkDate").modal('show');
                } else {
                    if(org_type==1) $scope.contract.type=4;
                    $http.get(url + "/contract/checkContractNumber", {params: {contract_number: $scope.contract.contract_number}})
                        .then(function (response) {
                            if (response.status == 200 && response.data == true) {

                                var object_bank_by_id = $filter('filter')($scope.banks, {code: $scope.contract.bank_code}, true)[0];
                                if (object_bank_by_id != null && object_bank_by_id != "undefined") {
                                    $scope.contract.bank_name = object_bank_by_id.name;
                                }
                                /*genaral duong su va tai san*/
                                $scope.contract.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
                                $scope.contract.json_person = "'" + JSON.stringify($scope.privys) + "'";

                                $scope.contract.entry_date_time = new Date();
                                $scope.contract.update_date_time = new Date();
                                if ($scope.checkBank == true) {
                                    $scope.contract.addition_status = 1;
                                } else {
                                    $scope.contract.addition_status = 0;
                                }
                                /*gen contract.propertyInfo va relation_object*/
                                $scope.genInforProAndPrivys();

                                //check validate


                                /*end gen info*/

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

                                                                        // $scope.checkNayPrivy(listPersonAllJson);
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
                                                                                    type_real_estate:"",
                                                                                    type_real_estate_sub:""
                                                                                };

                                                                                listProperty.push(listPropertyForm);
                                                                            }


                                                                        }
                                                                        var listPropertyAllJson = JSON.stringify(listProperty);
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
                                                                        // $scope.checkNayProperty(listPropertyAllJson);
                                                                        /*for(var k = 0 ;k<listProperty.length;k++){
                                                                        $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                                                    }*/

                                                                        $window.location.href = contextPath + '/contract/list?status=1';
                                                                    } else {
                                                                        $("#errorAdd").modal('show');
                                                                    }
                                                                },
                                                                function (response) {
                                                                    // failure callback
                                                                    $("#errorAdd").modal('show');
                                                                }
                                                            );
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
                                                                type_real_estate:"",
                                                                type_real_estate_sub:""

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
                                                    /*for(var k = 0 ;k<listProperty.length;k++){
                                                    $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                                }*/
                                                    $window.location.href = contextPath + '/contract/list?status=1';
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
                            } else {
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

    /*When click luu tam*/
    $scope.temporaryOfflineAdd = function () {
        if ($scope.checkAllRequiredFieldTemporary()) {
            $scope.convertTemporary();
            /*genaral duong su va tai san*/
            $scope.contractOfflineTemporary.json_property = "'" + JSON.stringify($scope.listProperty) + "'";
            $scope.contractOfflineTemporary.json_person = "'" + JSON.stringify($scope.privys) + "'";

            $scope.contractOfflineTemporary.entry_date_time = new Date();
            $scope.contractOfflineTemporary.update_date_time = new Date();

            /*gen contract.propertyInfo va relation_object*/
            $scope.genInforProAndPrivysTemp();

            /*end gen info*/
            // nếu số hợp đồng bỏ trống set mặc định là 0.
            if ($scope.contractOfflineTemporary.contract_number == null || $scope.contractOfflineTemporary.contract_number == 'undefined' || $scope.contractOfflineTemporary.contract_number == '') {
                $scope.contractOfflineTemporary.contract_number = "o0o";
            }

            var contractOfflineTemporary = JSON.parse(JSON.stringify($scope.contractOfflineTemporary));

            if ($scope.myFile != null && $scope.myFile != 'undefined' && $scope.myFile.size > 0) {
                if ($scope.myFile.size > 5242000) {
                    $("#errorMaxFile").modal('show');
                } else {
                    var file = $scope.myFile;
                    var uploadUrl = url + "/contract/uploadFile";
                    fileUpload.uploadFileToUrl(file, uploadUrl)
                        .then(function (response) {
                                if (response.data != null && response.data != 'undefined' && response.status == 200) {
                                    $scope.contractOfflineTemporary.file_name = response.data.name;
                                    $scope.contractOfflineTemporary.file_path = response.data.path;
                                    var contractOfflineTemporary_ = JSON.parse(JSON.stringify($scope.contractOfflineTemporary));
                                    $http.post(url + "/contract/temporaryNotCheck", contractOfflineTemporary_, {headers: {'Content-Type': 'application/json'}})
                                        .then(function (response) {
                                                if (response.status == 200 && response.data > 0) {


                                                    // $scope.checkNayProperty(listPropertyAllJson);
                                                    /*for(var k = 0 ;k<listProperty.length;k++){
                                                     $http.post(urlstp+"/contract/addSuggestProperty",listProperty[k],{headers:{'Content-Type':'application/json'}})
                                                     }*/

                                                    $window.location.href = contextPath + '/contract/list?status=1';
                                                } else {
                                                    $("#errorAdd").modal('show');
                                                }
                                            },
                                            function (response) {
                                                // failure callback
                                                $("#errorAdd").modal('show');
                                            }
                                        );
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

            } else {
                $http.post(url + "/contract/temporaryNotCheck", contractOfflineTemporary, {headers: {'Content-Type': 'application/json'}})
                    .then(function (response) {
                            if (response.status == 200 && response.data > 0) {

                                $window.location.href = contextPath + '/contract/list?status=1';
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


        } else {
            $("#checkValidate").modal('show');
        }


    };
    $scope.checkValidate = function () {
        if (isNullOrEmpty($scope.contract.contract_template_id) || !Number($scope.contract.contract_template_id) > 0) {
            return false;
        }
        if (isNullOrEmpty($scope.contract.contract_number) || !$scope.contract.contract_number.toString().length > 0) {
            return false;
        }
        if (isNullOrEmpty($scope.contract.received_date) || !$scope.contract.received_date.toString().length == 10) {
            return false;
        }
        if (isNullOrEmpty($scope.contract.notary_date) || !$scope.contract.notary_date.toString().length == 10) {
            return false;
        }
        /*if(!$scope.contract.drafter_id>0){
            return false;
        }*/
        if (isNullOrEmpty($scope.contract.notary_id) || !$scope.contract.notary_id > 0) {
            return false;
        }
        if ($scope.contract.contract_value !== 0 && isNullOrEmpty($scope.contract.contract_value)) {
            return false;
        }
        return true;
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
                                                                            type_real_estate:"",
                                                                            type_real_estate_sub:""
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
                                                        type_real_estate:"",
                                                        type_real_estate_sub:""
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


    //convert date dd/mm/yyyy sang date cua he thong.
    /*$scope.addSuggestPrivy = function () {
     var listPerson = [];
     for(var i=0 ; i<$scope.privys.privy.length;i++){
     var item2=$scope.privys.privy[i];
     for( var j = 0;j<item2.persons.length;j++){
     listPerson.push(item2.persons[j])
     }
     }
     for(var k = 0 ;k<listPerson.length;k++){
     var addSuggestPrivy = JSON.parse(JSON.stringify(listPerson[k]));
     $http.post(url+"/contract/addSuggestPrivy",listPerson[k],{headers:{'Content-Type':'application/json'}})

     }


     }*/
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

    $scope.checkAllRequiredField = function () {
        var check = true;
        $scope.contractKindValue_ = "";
        $scope.contract_template_id_ = "";
        $scope.contract_number_ = "";
        $scope.received_date_ = "";
        $scope.notary_date_ = "";
        $scope.notary_id_ = "";
        $scope.contract_signer_ = "";
        $scope.contract_value_="";


        if ($scope.contractKindValue == null || $scope.contractKindValue == 'undefined' || $scope.contractKindValue == '') {
            $scope.contractKindValue_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if ($scope.contract.contract_template_id == null || $scope.contract.contract_template_id == 'undefined' || $scope.contract.contract_template_id == '') {
            $scope.contract_template_id_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if ($scope.contract.contract_number == null || $scope.contract.contract_number == 'undefined' || $scope.contract.contract_number == '') {
            $scope.contract_number_ = "Trường không được bỏ trống. ";
            check = false;
        }
        if ($scope.contract.received_date == null || $scope.contract.received_date == 'undefined' || $scope.contract.received_date == '') {
            $scope.received_date_ = "Trường không được bỏ trống và theo định dạng dd/MM/yyyy. ";
            check = false;
        }
        if ($scope.contract.notary_date == null || $scope.contract.notary_date == 'undefined' || $scope.contract.notary_date == '') {
            $scope.notary_date_ = "Trường không được bỏ trống và theo định dạng dd/MM/yyyy. ";
            check = false;
        }
        if ($scope.contract.notary_id == null || $scope.contract.notary_id == 'undefined' || $scope.contract.notary_id == '') {
            $scope.notary_id_ = "Trường không được bỏ trống. ";
            check = false;
        }

        if ($scope.contract.contract_value == null || $scope.contract.contract_value == 'undefined' || $scope.contract.contract_value === '') {
            $scope.contract_value_ = "Trường không được bỏ trống. ";
            check = false;
        }

        if ($scope.org_type == 1) {
            if ($scope.contract.contract_signer == null || $scope.contract.contract_signer == 'undefined' || $scope.contract.contract_signer === '') {
                $scope.contract_signer_ = "Trường không được bỏ trống. ";
                check = false;
            }
        }

        //DaiCQ add check validate format for passport 10082020
        if (!$scope.isValidPassportFormat()) {
            check = false;
        }
        //END DaiCQ add check validate format for passport 10082020

        return check;
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
                    /*    if($scope.contractFee.from_fee=='0' && ($scope.contractFee.to_fee == null || $scope.contractFee.to_fee =='' || $scope.contractFee.to_fee =='undefined')){
                        $scope.announcement.notaryFee = "Với loại hợp đồng trên áp dụng phí công chứng "+$scope.contractFee.formula_fee+" vnđ .";
                    }
                    else if($scope.contractFee.to_fee == null || $scope.contractFee.to_fee =='' || $scope.contractFee.to_fee =='undefined'){
                        $scope.announcement.notaryFee = "Với loại hợp đồng trên và khoảng tiền LỚN HƠN "+$scope.contractFee.from_fee+" vnđ áp dụng tính phí hợp đồng NHỎ HƠN "+$scope.contractFee.notaryFeeMax+" vnđ và công thức tính phí là: "+$scope.contractFee.formula_fee+" .Nếu có giá trị a thì là Giá trị hợp đồng.";
                    }else {
                        $scope.announcement.notaryFee = "Với loại hợp đồng trên và khoảng tiền từ "+$scope.contractFee.from_fee+" đến " +$scope.contractFee.to_fee+" vnđ áp dụng công thức tính phí: "+$scope.contractFee.formula_fee+" vnđ.Nếu có giá trị a thì là Giá trị hợp đồng.";
                    }*/
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

    $scope.checkAllRequiredFieldTemporary = function () {
        var check = true;
        $scope.contractKindValue_ = "";
        $scope.contract_template_id_ = "";
        $scope.contract_number_ = "";
        $scope.received_date_ = "";
        $scope.notary_date_ = "";
        $scope.notary_id_ = "";


        if ($scope.contractKindValue == null || $scope.contractKindValue == 'undefined' || $scope.contractKindValue == '') {
            $scope.contractKindValue_ = "Trường không được bỏ trống khi lưu tạm. ";
            check = false;
        }
        if ($scope.contract.contract_template_id == null || $scope.contract.contract_template_id == 'undefined' || $scope.contract.contract_template_id == '') {
            $scope.contract_template_id_ = "Trường không được bỏ trống khi lưu tạm. ";
            check = false;
        }

        return check;
    };


    /*set format date for person and property*/
    $scope.datePersonFormat = function () {
        for (var i = 0; i < $scope.privys.privy.length; i++) {
            for (var j = 0; j < $scope.privys.privy[i].persons.length; j++) {
                var item = $scope.privys.privy[i].persons[j];

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
                            item.sex = suggestion.sex;

                            if (suggestion.sex == null || suggestion.sex == "") {
                                item.sex = {id: 1, name: 'Ông'};
                            }
                            if (suggestion.sex == '1' || suggestion.sex == 1) {
                                item.sex = {id: 1, name: 'Ông'};
                            } else if (suggestion.sex == '2' || suggestion.sex == 2) {
                                item.sex = {id: 2, name: 'Bà'};
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

    $scope.getsuggestproperty = function (index, type, template) {
        var namesuggest = ".autocomplete_land_certificate" + index;
        console.log("type" + type);
        if (type == '02') {
            namesuggest = ".autocomplete_car_frame_number" + index;
           /* if(template == 11) namesuggest = "#airplane_engine_number" + index;
            if(template == 12) namesuggest = "#ship_regist_number" + index;*/
        }

        $(namesuggest).autocomplete({
            minChars: 3,
            serviceUrl: contextPath + '/contract/getsuggestProperty',

            params: {
                type: type
            },
            onSelect: function (suggestion) {
                console.log("response suggest property: "+suggestion);

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
                            /*if($scope.listProperty.properties[i].vehicle_airplane != null
                                && $scope.listProperty.properties[i].vehicle_airplane.airplane_engine_number != ''){
                                var item = $scope.listProperty.properties[i].vehicle_airplane;
                                item.airplane_name = suggestion.airplane_engine_number;
                                item.airplane_regist_number = suggestion.airplane_regist_number;
                                item.airplane_type = suggestion.airplane_type;
                                item.airplane_engine_number = suggestion.airplane_engine_number;
                                item.airplane_max_weight = suggestion.airplane_max_weight;
                                item.airplane_producer = suggestion.airplane_producer;
                                item.airplane_year_manufacture = suggestion.airplane_year_manufacture;
                                item.airplane_factory_number = suggestion.airplane_factory_number;
                                item.airplane_regist_number_vietnam = suggestion.airplane_regist_number_vietnam;
                            }
                            else if($scope.listProperty.properties[i].vehicle_ship != null
                                && $scope.listProperty.properties[i].vehicle_ship.ship_regist_number != ''){
                                var item = $scope.listProperty.properties[i].vehicle_ship;
                                item.ship_name = suggestion.ship_name;
                                item.ship_regist_number = suggestion.ship_regist_number;
                                item.ship_level = suggestion.ship_level;
                                item.ship_function = suggestion.ship_function;
                                item.ship_year_place_construction = suggestion.ship_year_place_construction;
                                item.ship_design_length = suggestion.ship_design_length;
                                item.ship_max_length = suggestion.ship_max_length;
                                item.ship_design_height = suggestion.ship_design_height;
                                item.ship_max_height = suggestion.ship_max_height;
                                item.ship_width = suggestion.ship_width;
                                item.ship_dimension_sinking = suggestion.ship_dimension_sinking;
                                item.ship_freeboard = suggestion.ship_freeboard;
                                item.ship_hull_material = suggestion.ship_hull_material;
                            }
                            else{*/
                                var item = $scope.listProperty.properties[i].vehicle;
                                item.car_license_number = suggestion.car_license_number;
                                item.car_regist_number = suggestion.car_regist_number;
                                item.car_issue_place = suggestion.car_issue_place;
                                item.car_issue_date = suggestion.car_issue_date;
                                item.car_frame_number = suggestion.car_frame_number;
                                item.car_machine_number = suggestion.car_machine_number;
                            /*}*/

                            $scope.listProperty.properties[i].land.land_street = suggestion.land_street;
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
        } else $scope.changePropertyRealEstate(index,"");

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
    /*gen info property and privys*/
    $scope.genInforProAndPrivys = function () {
        $scope.contract.relation_object_a = "";
        $scope.contract.relation_object_b = "";
        /*gen contract.propertyInfo va relation_object*/
        var check = $scope.privys.privy[0];
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
                        if (item.passport != null && item.passport != '') string += "CMND/Hộ chiếu/CCCD: " + item.passport + "; ";
                        if (item.certification_date != null && item.certification_date != '') string += "Ngày cấp: " + item.certification_date + "; ";
                        if (item.certification_place != null && item.certification_place != '') string += "Nơi cấp: " + item.certification_place + "; ";
                        if (item.address != null && item.address != '') string += "Địa chỉ: " + item.address + "; ";
                        if (item.description != null && item.description != '') string += "Mô tả: " + item.description + "; ";

                    }

                    // if (item.description != null && item.description != '') string += "Mô tả: " + item.description + "; ";
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
            if (item.property_info != null && item.property_info != '') {
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

        /*end gen info*/
    };

    // gen info privy property for temporacyContractOffline

    $scope.genInforProAndPrivysTemp = function () {
        $scope.contractOfflineTemporary.relation_object_a = "";
        $scope.contractOfflineTemporary.relation_object_b = "";
        /*gen contract.propertyInfo va relation_object*/
        var check = $scope.privys.privy[0];
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
                        if (item.name != null && item.name != '') string += "Họ tên: " + item.name + "; ";
                        if (item.birthday != null && item.birthday != '') string += "Sinh năm: " + item.birthday + "; ";
                        if (item.position != null && item.position != '') string += "Chức danh: " + item.position + "; ";
                        if (item.passport != null && item.passport != '') string += "CMND/Hộ chiếu/CCCD: " + item.passport + "; ";
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
                $scope.contractOfflineTemporary.relation_object_a += item1.name + ":\\n" + string1;
                // $scope.contract.relation_object_a=$scope.contract.relation_object_a.replace("\\n","\n");
            }

        }
        /*lay relation_object_b thay the cho property_Info*/
        for (var i = 0; i < $scope.listProperty.properties.length; i++) {
            var item = $scope.listProperty.properties[i];
            var stringpro = "";
            // $scope.contract.relation_object_b+=i+1 + ".";
            if (item.property_info != null && item.property_info != '') {
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
                        item.vehicle = '';
                        item.vehicle_ship = '';
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
                        item.vehicle = '';
                        item.vehicle_airplane = '';
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
                        if (item.vehicle_ship.ship_max_height != null && item.vehicle_ship.ship_max_height != '') {
                            stringpro += "Chiều rộng lớn nhất: " + item.vehicle_ship.ship_max_height + "; ";
                        }
                        if (item.vehicle_ship.ship_width != null && item.vehicle_ship.ship_width != '') {
                            stringpro += "Chiều cao mạn: " + item.vehicle_ship.ship_width + "; ";
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
                    /*END Bổ sung trường tài sản phương tiện vận tài  là "Tàu bay" và "Phương tiện thủy nội địa"*/
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
                    $scope.contractOfflineTemporary.relation_object_b += i + 1 + "." + stringpro + "\\n";
                } else {
                    $scope.contractOfflineTemporary.relation_object_b += stringpro;
                }
                stringpro = "";
            }
        }

        /*end gen info*/
    };

    /*for validation form*/

    $scope.pattern = new RegExp("/^(((0[1-9]|[12]\d|3[01])-(0[13578]|1[02])-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)-(0[13456789]|1[012])-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])-02-((19|[2-9]\d)\d{2}))|(29-02-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/");

    /*end validation form*/

}]);


//giup format cac' so' sang dang tien` te 1,000,000
myApp.$inject = ['$scope'];
myApp.directive('format', ['$filter', function ($filter) {
    return {
        require: '?ngModel',
        link: function (scope, elem, attrs, ctrl) {
            if (!ctrl) return;


            ctrl.$formatters.unshift(function (a) {
                if(isNullOrEmpty(a)) return;
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