myApp.controller('contractListController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.search = {
        basic: 0,
        type: "",
        type_property: "",
        map_var: "",
        begin_or_close: "",
        first_word: "",
        end_word: ""
    };
    $scope.listDataMapKey = {items: "", rowCount: 0, numberPerPage: 20, pageNumber: 1, pageList: [], pageCount: 0};
    var search = JSON.stringify($scope.search);

    //loại từ khóa
    $scope.contractKinds = [
        {name: "Đương sự", type: "1"},
        {name: "Tài sản", type: "2"},
        {name: "Các loại khác", type: "3"},
        {name:"Từ khóa đặc biệt",type:"4"}
    ];
    //mẫu từ khóa
    $scope.myFunc = function (type) {
        if (type == "1") {
            $http.get(url + "/ContractTemplate/privy-template")
                .then(function (response) {
                    $scope.template = response.data;
                });
            $scope.changekeyName("-1");
        } else if (type == "2") {
            $http.get(url + "/ContractTemplate/property-template")
                .then(function (response) {
                    $scope.template = response.data;
                });
            $scope.changekeyName("-1");
        } else if (type == "3") {
            $scope.template = [];
            $scope.changekeyName("3");
        }else if (type == "4") {
            $scope.template = [];
            $scope.keyName=[];
        }
        else{
            $scope.changekeyName("-1");
        }
    };
    //từ khóa dành cho
    $scope.changekeyName = function (type_property) {
        if (type_property != '-1') {
            if ($scope.search.type == "1") {//duong su
                if ($scope.search.type_property == "1") {  //cá nhân
                    $scope.keyName = [
                        {name: "Họ tên", map_var: "name"},
                        {name: "Ngày sinh", map_var: "birthday"},
                        {name: "Số chứng minh nhân dân", map_var: "passport"},
                        {name: "ngày cấp", map_var: "certification_date"},
                        {name: "Nơi cấp", map_var: "certification_place"},
                        {name: "Nơi cư trú", map_var: "address"}
                    ];

                } else if ($scope.search.type_property == "2") {   // công ty
                    $scope.keyName = [
                        {name: "Tên công ty", map_var: "org_name"},
                        {name: "Địa chỉ công ty", map_var: "org_address"},
                        {name: "Mã số doanh nghiệp", map_var: "org_code"},
                        {name: "Đăng ký lần đầu ngày", map_var: "first_registed_date"},
                        {name: "Đăng ký thay đổi lần thứ", map_var: "number_change_registed"},
                        {name: "Ngày thay đổi", map_var: "change_registed_date"},
                        {name: "Họ và tên người đại diện", map_var: "name"},
                        {name: "Chức danh", map_var: "position"},
                        {name: "Số chứng minh nhân dân", map_var: "passport"},
                        {name: "ngày cấp", map_var: "certification_date"},
                        {name: "Nơi cấp", map_var: "certification_place"},
                        {name: "Nơi cư trú", map_var: "address"}
                    ];
                }
                else{
                    $scope.keyName = [];
                }

            } else if ($scope.search.type == "2") {//tai san
                if ($scope.search.type_property == "1") {  //Tài sản đất
                    $scope.keyName = [
                        {
                            name: "Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số",
                            map_var: "land.land_certificate"
                        },
                        {name: "Nơi cấp", map_var: "land.land_issue_place"},
                        {name: "Ngày cấp", map_var: "land.land_issue_date"},
                        {name: "Thửa đất số", map_var: "land.land_number"},
                        {name: "Tờ bản đồ số", map_var: "land.land_map_number"},
                        {name: "Địa chỉ thửa đất", map_var: "land.land_address"},
                        {name: "Diện tích", map_var: "land.land_area"},
                        {name: "Bằng chữ", map_var: "land.land_area_text"},
                        {name: "Hình thức sử dụng", map_var: "land.land_use_type"},
                        {name: "Sử dụng riêng", map_var: "land.land_private_area"},
                        {name: "Sử dụng chung", map_var: "land.land_public_area"},
                        {name: "Mục đích sử dụng", map_var: "land.land_use_purpose"},
                        {name: "Thời hạn sử dụng", map_var: "land.land_use_period"},
                        {name: "Nguồn gốc sử dụng", map_var: "land.land_use_origin"},
                        {name: "Hạn chế và quyền sử dụng đất", map_var: "restrict"},
                        {name: "Tài sản gắn liền với đất", map_var: "land.land_associate_property"},
                        {name: "Thông tin chủ sở hữu", map_var: "owner_info"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                } else if ($scope.search.type_property == "3") {   // Tài sản
                    $scope.keyName = [
                        {name: "Thông tin tài sản", map_var: "property_info"},
                        {name: "Thông tin chủ sở hữu", map_var: "owner_info"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                } else if ($scope.search.type_property == "6") {   // Ô tô - xe máy
                    $scope.keyName = [
                        {name: "Biển kiểm soát", map_var: "vehicle.car_license_number"},
                        {name: "Số giấy đăng ký", map_var: "vehicle.car_regist_number"},
                        {name: "Nơi cấp", map_var: "vehicle.car_issue_place"},
                        {name: "Ngày cấp", map_var: "vehicle.car_issue_date"},
                        {name: "Số khung", map_var: "vehicle.car_frame_number"},
                        {name: "Số máy", map_var: "vehicle.car_machine_number"},
                        {name: "Thông tin chủ sở hữu", map_var: "owner_info"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                } else if ($scope.search.type_property == "8") {   // Mẫu chung cư
                    $scope.keyName = [
                        {
                            name: "Căn hộ thuộc quyền sở hữu của bên A theo giấy chứng nhận số",
                            map_var: "land.land_certificate"
                        },
                        {name: "Nơi cấp", map_var: "land.land_issue_place"},
                        {name: "Ngày cấp", map_var: "land.land_issue_date"},
                        {name: "Địa chỉ", map_var: "apartment.apartment_address"},
                        {name: "Căn hộ số", map_var: "apartment.apartment_number"},
                        {name: "Tầng", map_var: "apartment.apartment_floor"},
                        {name: "Tổng diện tích sử dụng", map_var: "apartment.apartment_area_use"},
                        {name: "Diện tích xây dựng", map_var: "apartment.apartment_area_build"},
                        {name: "Kết cấu nhà", map_var: "apartment.apartment_structure"},
                        {name: "Số tầng nhà chung cư", map_var: "apartment.apartment_total_floor"},
                        {name: "Thửa đất số", map_var: "land.land_number"},
                        {name: "Tờ bản đồ số", map_var: "land.land_map_number"},
                        {name: "Địa chỉ thửa đất", map_var: "land.land_address"},
                        {name: "Diện tích", map_var: "land.land_area"},
                        {name: "Bằng chữ", map_var: "land.land_area_text"},
                        {name: "Hình thức sử dụng", map_var: "land.land_use_type"},
                        {name: "Sử dụng riêng", map_var: "land.land_private_area"},
                        {name: "Sử dụng chung", map_var: "land.land_public_area"},
                        {name: "Mục đích sử dụng", map_var: "land.land_use_purpose"},
                        {name: "Thời hạn sử dụng", map_var: "land.land_use_period"},
                        {name: "Nguồn gốc sử dụng", map_var: "land.land_use_origin"},
                        {name: "Hạn chế và quyền sử dụng đất", map_var: "restrict"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                } else if ($scope.search.type_property == "10") {   // Đất, tài sản gắn liền với đất
                    $scope.keyName = [
                        {
                            name: "Quyền sử dụng đất của bên A đối với thửa đất theo giấy chứng nhận số",
                            map_var: "land.land_certificate"
                        },
                        {name: "Nơi cấp", map_var: "land.land_issue_place"},
                        {name: "Ngày cấp", map_var: "land.land_issue_date"},
                        {name: "Thửa đất số", map_var: "land.land_number"},
                        {name: "Tờ bản đồ số", map_var: "land.land_map_number"},
                        {name: "Địa chỉ thửa đất", map_var: "land.land_address"},
                        {name: "Diện tích", map_var: "land.land_area"},
                        {name: "Bằng chữ", map_var: "land.land_area_text"},
                        {name: "Hình thức sử dụng", map_var: "land.land_use_type"},
                        {name: "Sử dụng riêng", map_var: "land.land_private_area"},
                        {name: "Sử dụng chung", map_var: "land.land_public_area"},
                        {name: "Mục đích sử dụng", map_var: "land.land_use_purpose"},
                        {name: "Thời hạn sử dụng", map_var: "land.land_use_period"},
                        {name: "Nguồn gốc sử dụng", map_var: "land.land_use_origin"},
                        {name: "Hạn chế và quyền sử dụng đất", map_var: "restrict"},
                        {name: "Tài sản gắn liền với đất", map_var: "land.land_associate_property"},
                        {name: "Thông tin chủ sở hữu", map_var: "owner_info"},
                        {name: "Loại nhà ở", map_var: "land.land_type"},
                        {name: "Diện tích xây dựng", map_var: "land.construction_area"},
                        {name: "Diện tích sàn", map_var: "land.building_area"},
                        {name: "Cấp (hạng) nhà ở", map_var: "land.land_sort"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                }
                else{
                    $scope.keyName = [];
                }
            } else if ($scope.search.type == "3") {
                $scope.keyName = [
                    {name: "Tên hợp đồng", map_var: "contract_template_id"},
                    /*{name: "Số hợp đồng", map_var: "contract_number"},
                    {name: "Ngày thụ lý", map_var: "received_date"},*/
                    {name: "Ngày công chứng", map_var: "notary_date"},
                    {name: "Giá trị hợp đồng", map_var: "contract_value"},
                    {name: "Địa điểm công chứng", map_var: "notary_place"}
                ];
            }
        } else {
            $scope.keyName = [];
            $scope.template = [];
        }
    };

    $http.get(url + "/ContractKeyMap/listContractKeyMap", {
        params: {
            search: search,
            offset: 0,
            number: $scope.listDataMapKey.numberPerPage
        }
    })
        .then(function (response) {
            $scope.listDataMapKey.items = response.data;
            $scope.tooltip();
            console.log(response.data);
        });
    $http.get(url + "/ContractKeyMap/countContractKeyMap", {params: {search: search}})
        .then(function (response) {
            $scope.listDataMapKey.rowCount = response.data;
            $scope.listDataMapKey.pageCount = getPageCountContract($scope.listDataMapKey);
            $scope.listDataMapKey.pageList = getPageList($scope.listDataMapKey);

        });


    $scope.currentPage;
    var listPageHaveSelectedAll = [];
    $scope.selectAllCurrentPage = false;
    var listIdSelect = [];
    $scope.loadPageData = function (index) {
       // if (index >= 1) {
            $scope.listDataMapKey.pageNumber = index;
            var search = JSON.stringify($scope.search);
            $http.get(url + "/ContractKeyMap/listContractKeyMap", {
                params: {
                    search: search,
                    offset: $scope.listDataMapKey.numberPerPage * ($scope.listDataMapKey.pageNumber - 1),
                    number: $scope.listDataMapKey.numberPerPage
                }
            })
                .then(function (response) {
                    $scope.listDataMapKey.items = response.data;
                    $scope.listDataMapKey.pageList = getPageList($scope.listDataMapKey);
                    $scope.tooltip();
                    /**/
                  //  $scope.checkbox = false;
                    $timeout(function () {
                        if(listPageHaveSelectedAll.includes($scope.listDataMapKey.pageNumber)){
                            $scope.selectAllCurrentPage = true;
                            $("#select_all_"+$scope.listDataMapKey.pageNumber).prop('checked', true);
                            $(".onChangeSelectBox_").prop('checked', true);
                            for(var i=0;i<$scope.listDataMapKey.items.length;i++){
                                if(!listIdSelect.includes( $scope.listDataMapKey.items[i].id)){
                                    listIdSelect.push($scope.listDataMapKey.items[i].id);
                                }
                            }
                        }
                        else{
                            $("#select_all_"+$scope.listDataMapKey.pageNumber).prop('checked', false);
                            $scope.selectAllCurrentPage = false;
                            for(var i=0;i<$scope.listDataMapKey.items.length;i++){
                                if(listIdSelect.includes( $scope.listDataMapKey.items[i].id)){
                                    $("#IDonChangeSelectBox_" + $scope.listDataMapKey.items[i].id).prop('checked', true);
                                }
                                else{
                                    $("#IDonChangeSelectBox_" + $scope.listDataMapKey.items[i].id).prop('checked', false);
                                }

                            }
                        }
                    }, 0);
                    /**/
                });
       // }
    };

    //search advance
    $scope.searchAdvance = function () {

        $scope.search.basic = 1;
        $scope.listDataMapKey.pageNumber = 1;
        $scope.loadCountDatalistMapKey();
        $scope.loadListContractKeyMap();

    };

    /*load all */
    $scope.loadCountDatalistMapKey = function () {
        var search = JSON.stringify($scope.search);
        $http.get(url + "/ContractKeyMap/countContractKeyMap", {params: {search: search}})
            .then(function (response) {
                $scope.listDataMapKey.rowCount = response.data;
                $scope.listDataMapKey.pageCount = getPageCountContract($scope.listDataMapKey);
                $scope.listDataMapKey.pageList = getPageList($scope.listDataMapKey);

            });
    };

    /*reload list*/
    $scope.loadListContractKeyMap = function () {
        var search = JSON.stringify($scope.search);
        $http.get(url + "/ContractKeyMap/listContractKeyMap", {
            params: {
                search: search,
                offset: 0,
                number: $scope.listDataMapKey.numberPerPage
            }
        })
            .then(function (response) {
                $scope.listDataMapKey.items = response.data;
                $scope.tooltip();
            });
    };

    /*add id input*/
    $scope.addIdSelect = function (element, index) {
        console.log(element.item);
        var id_ = element.item.id;

        //if checked = true
            if (!listIdSelect.includes(Number(id_))) {
                    listIdSelect.push(Number(id_));
                $("#IDonChangeSelectBox_"+Number(id_)).prop('checked', true);

                if ($('.onChangeSelectBox_:checked').length == $('.onChangeSelectBox_').length) {
                    $scope.selectAllCurrentPage = true;
                    $("#select_all_"+$scope.listDataMapKey.pageNumber).prop('checked', true);
                    if(!listPageHaveSelectedAll.includes($scope.listDataMapKey.pageNumber)){
                        listPageHaveSelectedAll.push($scope.listDataMapKey.pageNumber);
                    }

                }

            } else {//if checked = false

                $("#IDonChangeSelectBox_"+Number(id_)).prop('checked', false);

                listIdSelect = deleteElementFromArrays(listIdSelect, Number(id_));
                $scope.selectAllCurrentPage = false;
                $("#select_all_"+$scope.listDataMapKey.pageNumber).prop('checked', false);
                listPageHaveSelectedAll = deleteElementFromArrays(listPageHaveSelectedAll, $scope.listDataMapKey.pageNumber);
            }


    };

    /*add all input*/
    $scope.select_all = function (element) {
        console.log(element, $scope.listDataMapKey.items.length);

        var check = element;
        if (check==true) {
            for (var i = 0; i < $scope.listDataMapKey.items.length; i++) {
                if(!listIdSelect.includes(Number($scope.listDataMapKey.items[i].id))){
                    listIdSelect.push(Number($scope.listDataMapKey.items[i].id));
                }
                $("#IDonChangeSelectBox_"+$scope.listDataMapKey.items[i].id).prop('checked', true);
            }
            if(!listPageHaveSelectedAll.includes($scope.listDataMapKey.pageNumber)){
                listPageHaveSelectedAll.push($scope.listDataMapKey.pageNumber);
            }

        }
        else{
            listPageHaveSelectedAll = deleteElementFromArrays(listPageHaveSelectedAll, $scope.listDataMapKey.pageNumber);
            for (var i = 0; i < $scope.listDataMapKey.items.length; i++) {
                listIdSelect = deleteElementFromArrays(listIdSelect, Number($scope.listDataMapKey.items[i].id));
                $("#IDonChangeSelectBox_"+$scope.listDataMapKey.items[i].id).prop('checked', false);
            }

        }


    };

    function deleteElementFromArrays(arr,num) {
     //   var arr = [5, 15, 110, 210, 550];
        var index = arr.indexOf(num);

        if (index > -1) {
            arr.splice(index, 1);
        }
        return arr;
    }


    $scope.deleteContractKeyMap = function () {
        var listId = "";
        for(var i = 0; i<listIdSelect.length; i++){
            if(listId==""){
                listId = listIdSelect[i];
            } else{
                listId +="," + listIdSelect[i];
            }
        }
     //   var listId = document.getElementById("listIdSelect").value;
        if (typeof listId == "undefined" || listId == "" || listId == null) {
            $("#checkDelete").modal("hide");
            $("#errorDelete").modal("show");
        } else {
            $http.get(url + "/ContractKeyMap/deleteContractKeyMaps", {params: {listId: listId}})
                .then(function (response) {
                    if (response.data == true) {
                        $window.location.href = contextPath + '/contract/list-key-map-contract?status=3';
                    } else {
                        $("#error").modal("show");
                    }
                });
        }
    };

    $scope.clearCondition = function () {
        $scope.search.basic = 0;
        $scope.search.type = "";
        $scope.search.type_property = "";
        $scope.search.map_var = "";
        $scope.search.begin_or_close = "";
        $(".select2-selection__rendered").html('--Chọn--');
        $scope.search.first_word = "";
        $scope.search.end_word = "";
    };

    /*load tooltip*/
    $scope.tooltip = function () {
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            defer.resolve();
        }, 1000);
    };

    /*load tong trang va danh sach trang*/
    function getPageCountContract(pageResult) {
        var pageCount = Math.ceil(pageResult.rowCount / pageResult.numberPerPage);
        return pageCount;
    };

    function getPageList(pagingResult) {
        var pages = [];
        var from = pagingResult.pageNumber - 3;
        var to = pagingResult.pageNumber + 5;
        if (from < 0) {
            to -= from;
            from = 1;
        }

        if (from < 1) {
            from = 1;
        }

        if (to > pagingResult.pageCount) {
            to = pagingResult.pageCount;
        }

        for (var i = from; i <= to; i++) {
            pages.push(i);
        }
        return pages;
    };

    $scope.importFileWord = function () {
        var file = $scope.myFileImport;

        if ($scope.myFileImport.size > 5242000) {
            $("#errorMaxFile").modal('show');

        } else {

            var file = $scope.myFileImport;
            var uploadUrl = url + "/ContractKeyMap/read-file-doc";
            fileUpload.uploadFileToUrl(file, uploadUrl)
                .then(function (response) {
                        if (response.data != null && response.data != 'undefined' && response.status == 200) {
                            var fields = response.data.fields.join();
                            var contract = response.data.contract;
                            var form = '';
                            form += '<input type="hidden" name="fields" value="' + fields + '">';
                            form += '<input type="hidden" name="fields_" value="">';
                            if (contract.id == null) contract.id = "";
                            form += '<input type="hidden" name="id" value="' + contract.id + '">';
                            if (contract.contract_template_id == null) contract.contract_template_id = "";
                            form += '<input type="hidden" name="contract_template_id" value="' + contract.contract_template_id + '">';
                            if (contract.contract_number == null) contract.contract_number = "";
                            form += '<input type="hidden" name="contract_number" value="' + contract.contract_number + '">';
                            if (contract.contract_value == null) contract.contract_value = "";
                            form += '<input type="hidden" name="contract_value" value="' + contract.contract_value + '">';
                            if (contract.relation_object_a == null) contract.relation_object_a = "";
                            form += '<input type="hidden" name="relation_object_a" value="' + contract.relation_object_a + '">';
                            if (contract.relation_object_b == null) contract.relation_object_b = "";
                            form += '<input type="hidden" name="relation_object_b" value="' + contract.relation_object_b + '">';
                            if (contract.relation_object_c == null) contract.relation_object_c = "";
                            form += '<input type="hidden" name="relation_object_c" value="' + contract.relation_object_c + '">';
                            if (contract.notary_id == null) contract.notary_id = "";
                            form += '<input type="hidden" name="notary_id" value="' + contract.notary_id + '">';
                            if (contract.drafter_id == null) contract.drafter_id = "";
                            form += '<input type="hidden" name="drafter_id" value="' + contract.drafter_id + '">';
                            if (contract.received_date == null) contract.received_date = "";
                            form += '<input type="hidden" name="received_date" value="' + contract.received_date + '">';
                            if (contract.notary_date == null) contract.notary_date = "";
                            form += '<input type="hidden" name="notary_date" value="' + contract.notary_date + '">';
                            if (contract.user_require_contract == null) contract.user_require_contract = "";
                            form += '<input type="hidden" name="user_require_contract" value="' + contract.user_require_contract + '">';
                            if (contract.number_copy_of_contract == null) contract.number_copy_of_contract = "";
                            form += '<input type="hidden" name="number_copy_of_contract" value="' + contract.number_copy_of_contract + '">';
                            if (contract.number_of_sheet == null) contract.number_of_sheet = "";
                            form += '<input type="hidden" name="number_of_sheet" value="' + contract.number_of_sheet + '">';
                            if (contract.number_of_page == null) contract.number_of_page = "";
                            form += '<input type="hidden" name="number_of_page" value="' + contract.number_of_page + '">';
                            if (contract.cost_tt91 == null) contract.cost_tt91 = "";
                            form += '<input type="hidden" name="cost_tt91" value="' + contract.cost_tt91 + '">';
                            if (contract.cost_draft == null) contract.cost_draft = "";
                            form += '<input type="hidden" name="cost_draft" value="' + contract.cost_draft + '">';
                            if (contract.cost_notary_outsite == null) contract.cost_notary_outsite = "";
                            form += '<input type="hidden" name="cost_notary_outsite" value="' + contract.cost_notary_outsite + '">';
                            if (contract.cost_other_determine == null) contract.cost_other_determine = "";
                            form += '<input type="hidden" name="cost_other_determine" value="' + contract.cost_other_determine + '">';
                            if (contract.cost_total == null) contract.cost_total = "";
                            form += '<input type="hidden" name="cost_total" value="' + contract.cost_total + '">';
                            if (contract.notary_place_flag == null) contract.notary_place_flag = "";
                            form += '<input type="hidden" name="notary_place_flag" value="' + contract.notary_place_flag + '">';
                            if (contract.notary_place == null) contract.notary_place = "";
                            form += '<input type="hidden" name="notary_place" value="' + contract.notary_place + '">';
                            if (contract.bank_id == null) contract.bank_id = "";
                            form += '<input type="hidden" name="bank_id" value="' + contract.bank_id + '">';
                            if (contract.bank_service_fee == null) contract.bank_service_fee = "";
                            form += '<input type="hidden" name="bank_service_fee" value="' + contract.bank_service_fee + '">';
                            if (contract.crediter_name == null) contract.crediter_name = "";
                            form += '<input type="hidden" name="crediter_name" value="' + contract.crediter_name + '">';
                            if (contract.file_name == null) contract.file_name = "";
                            form += '<input type="hidden" name="file_name" value="' + contract.file_name + '">';
                            if (contract.file_path == null) contract.file_path = "";
                            form += '<input type="hidden" name="file_path" value="' + contract.file_path + '">';
                            if (contract.error_status == null) contract.error_status = "";
                            form += '<input type="hidden" name="error_status" value="' + contract.error_status + '">';
                            if (contract.error_user_id == null) contract.error_user_id = "";
                            form += '<input type="hidden" name="error_user_id" value="' + contract.error_user_id + '">';
                            if (contract.error_description == null) contract.error_description = "";
                            form += '<input type="hidden" name="error_description" value="' + contract.error_description + '">';
                            if (contract.addition_status == null) contract.addition_status = "";
                            form += '<input type="hidden" name="addition_status" value="' + contract.addition_status + '">';
                            if (contract.addition_description == null) contract.addition_description = "";
                            form += '<input type="hidden" name="addition_description" value="' + contract.addition_description + '">';
                            if (contract.cancel_status == null) contract.cancel_status = "";
                            form += '<input type="hidden" name="cancel_status" value="' + contract.cancel_status + '">';
                            if (contract.cancel_description == null) contract.cancel_description = "";
                            form += '<input type="hidden" name="cancel_description" value="' + contract.cancel_description + '">';
                            if (contract.cancel_relation_contract_id == null) contract.cancel_relation_contract_id = "";
                            form += '<input type="hidden" name="cancel_relation_contract_id" value="' + contract.cancel_relation_contract_id + '">';
                            if (contract.contract_period == null) contract.contract_period = "";
                            form += '<input type="hidden" name="contract_period" value="' + contract.contract_period + '">';
                            if (contract.mortage_cancel_flag == null) contract.mortage_cancel_flag = "";
                            form += '<input type="hidden" name="mortage_cancel_flag" value="' + contract.mortage_cancel_flag + '">';
                            if (contract.mortage_cancel_date == null) contract.mortage_cancel_date = "";
                            form += '<input type="hidden" name="mortage_cancel_date" value="' + contract.mortage_cancel_date + '">';
                            if (contract.mortage_cancel_note == null) contract.mortage_cancel_note = "";
                            form += '<input type="hidden" name="mortage_cancel_note" value="' + contract.mortage_cancel_note + '">';
                            if (contract.original_store_place == null) contract.original_store_place = "";
                            form += '<input type="hidden" name="original_store_place" value="' + contract.original_store_place + '">';
                            if (contract.note == null) contract.note = "";
                            form += '<input type="hidden" name="note" value="' + contract.note + '">';
                            if (contract.summary == null) contract.summary = "";
                            form += '<input type="hidden" name="summary" value="' + contract.summary + '">';
                            if (contract.entry_user_id == null) contract.entry_user_id = "";
                            form += '<input type="hidden" name="entry_user_id" value="' + contract.entry_user_id + '">';
                            if (contract.entry_user_name == null) contract.entry_user_name = "";
                            form += '<input type="hidden" name="entry_user_name" value="' + contract.entry_user_name + '">';
                            if (contract.entry_date_time == null) contract.entry_date_time = "";
                            form += '<input type="hidden" name="entry_date_time" value="' + contract.entry_date_time + '">';
                            if (contract.update_user_id == null) contract.update_user_id = "";
                            form += '<input type="hidden" name="update_user_id" value="' + contract.update_user_id + '">';
                            if (contract.update_user_name == null) contract.update_user_name = "";
                            form += '<input type="hidden" name="update_user_name" value="' + contract.update_user_name + '">';
                            if (contract.update_date_time == null) contract.update_date_time = "";
                            form += '<input type="hidden" name="update_date_time" value="' + contract.update_date_time + '">';
                            if (contract.bank_name == null) contract.bank_name = "";
                            form += '<input type="hidden" name="bank_name" value="' + contract.bank_name + '">';
                            if (contract.jsonstring == null) contract.jsonstring = "";
                            form += '<input type="hidden" name="jsonstring" value="' + contract.jsonstring + '">';
                            if (contract.kindhtml == null) contract.kindhtml = "";
                            form += '<input type="hidden" name="kindhtml" value="' + contract.kindhtml + '">';
                            if (contract.content == null) contract.content = "";
                            form += '<input type="hidden" name="content" value="' + contract.content + '">';
                            if (contract.title == null) contract.title = "";
                            form += '<input type="hidden" name="title" value="' + contract.title + '">';
                            if (contract.bank_code == null) contract.bank_code = "";
                            form += '<input type="hidden" name="bank_code" value="' + contract.bank_code + '">';
                            if (contract.json_property == null) contract.json_property = "";
                            form += '<textarea type="hidden" name="json_property" id="json_property_custum_post"></textarea>';
                            if (contract.json_person == null) contract.json_person = "";
                            form += '<textarea type="hidden" name="json_person" id="json_property_custum_post"></textarea>';
                            if (contract.sub_template_id == null) contract.sub_template_id = "";
                            form += '<input type="hidden" name="sub_template_id" value="' + contract.sub_template_id + '">';

                            var _form_ = $('<form target="_blank" id = "read-file-doc" class="hidden" action="' + readfiledocUrl + '" method="post">' + form + '</form>');
                            $('body').append(_form_);
                            document.getElementById("json_property_custum_post").value = contract.json_property;
                            document.getElementById("json_property_custum_post").value = contract.json_person;
                            $("#read-file-doc").submit();
                            $("#read-file-doc").remove();

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
    }
}]);