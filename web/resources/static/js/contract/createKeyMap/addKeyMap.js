
myApp.controller('contractAddController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.begin_or_close = false;
    $scope.check_type_special_word = false;

    $scope.contractKinds = [
        {name:"Đương sự",type:"1"},
        {name:"Tài sản",type:"2"},
        {name:"Các loại khác",type:"3"},
        {name:"Từ khóa đặc biệt",type:"4"}
    ];

    $scope.myFunc = function (type) {
        $scope.check_type_special_word=false;
        if(type == "1"){
            $http.get(url+"/ContractTemplate/privy-template")
                .then(function (response) {
                    $scope.template=response.data;
                });
            $scope.changekeyName("-1");
        } else if(type == "2") {
            $http.get(url+"/ContractTemplate/property-template")
                .then(function (response) {
                    $scope.template=response.data;
                });
            $scope.changekeyName("-1");
        } else if(type == "3") {
            $scope.changekeyName("3");
        }
        else if(type=='4'){
            $scope.check_type_special_word=true;
            $scope.contract.first_word = "";
            $scope.contract.end_word = "";
            $scope.contract.begin_or_close = "0";
        }
        else{
            $scope.changekeyName("-1");
        }

    };

    $scope.check_ = true;
    $scope.myFunc_ = function () {
        if(typeof $scope.contract.type != 'undefined' && $scope.contract.type == '1' && $scope.begin_or_close != false) {
            $scope.check_ = false;
        } else {
            $scope.check_ = true;
        }
    };

    $scope.addKeyMap = function () {
        if($scope.validate()){
            $scope.contract.flg_inline = "0";
            if($scope.contract.type==2 && $scope.contract.begin_or_close != 0){
                var str="Bắt đầu/kết thúc tài sản "

                if($scope.contract.type_property==1){
                    str+= "đất";
                }
                else if ($scope.contract.type_property==3){
                    str+= "khác";
                } else if($scope.contract.type_property==6){
                    str+= "oto xe máy";
                }
                else if($scope.contract.type_property==8){
                    str+= "mẫu chung cư";
                }
                else if($scope.contract.type_property==10){
                    str+= "đất và tài sản gắn liền";
                }
                $scope.contract.note = str;
            }
            $scope.map_var_search_();
            var contractKeyMap = JSON.stringify($scope.contract);
            //check exist key
            $http.post(url+"/ContractKeyMap/check-exists-key", contractKeyMap, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                    if(response.data){

                        $http.post(url+"/ContractKeyMap/addContractKeyMap", contractKeyMap, {headers: {'Content-Type': 'application/json'}})
                            .then(function (response) {
                                if(response.data){
                                    $window.location.href = contextPath+'/contract/list-key-map-contract?status=1';
                                } else {
                                    $("#error").modal("show");
                                }
                            });

                    } else {
                        $("#error2").modal("show");
                    }
                });
        }
    };

    $scope.begin_or_close_ = function (begin_or_close) {
        $scope.contract_copy = angular.copy($scope.contract);
        if(begin_or_close == "0"){
            $scope.begin_or_close = false;
            $scope.contract = $scope.contract_copy;
        } else {
            $scope.begin_or_close = true;
            if($scope.contract.type == "1"){
                $scope.contract.type_property = "";
                $scope.contract.map_var = "";
                $scope.contract.first_word = "";
                $scope.contract.end_word = "";
            } else if($scope.contract.type == "2"){
                $scope.contract.map_var = "";
                $scope.contract.first_word = "";
                $scope.contract.end_word = "";
            } else if($scope.contract.type == "3"){
                $scope.contract.type_property = "";
                $scope.contract.first_word = "";
                $scope.contract.end_word = "";

            }
            else if($scope.contract.type == "4"){
                $scope.contract.type_property = "";
                $scope.contract.map_var = "";
                $scope.contract.first_word = "";
                $scope.contract.end_word = "";
                $scope.contract.begin_or_close = "0";

            }
        }
    };

    $scope.map_var_search_ = function(){
        if($scope.check_ == true && $scope.check_type_special_word==false) {
            for (var i = 0; i < $scope.keyName.length; i++) {
                if ($scope.contract.map_var == $scope.keyName[i].map_var) {
                    $scope.contract.map_var_search = $scope.keyName[i].name;

                    if($scope.keyName[i].name=="Cùng nơi cư trú"){
                        $scope.contract.flg_inline = 1;
                        $scope.contract.map_var="address";
                    }

                    break;
                }
            }
        }
    };

    $scope.validate = function () {
        var check = true;
        var focus = 0;

        $scope.type_valid = "";
        $scope.type_property_valid = "";
        $scope.map_var_valid = "";
        $scope.key_name_valid = "";
      /*  $scope.first_word_valid = "";
        $scope.end_word_valid = "";*/
        $scope.special_word_valid = "";

        if(typeof $scope.contract.type == "undefined" || $scope.contract.type == "" || $scope.contract.type == null){
            if($scope.check_type_special_word==false){
                $scope.type_valid = "Trường không được bỏ trống.";
                check = false;
                if(focus == 0){
                    $("#type_valid").focus();
                    focus = 1
                }
            }

        }

        if($scope.contract.type != "3" && $scope.check_ == true){
            if(typeof $scope.contract.type_property == "undefined" || $scope.contract.type_property == "" || $scope.contract.type_property == null){
                if($scope.check_type_special_word==false) {
                    $scope.type_property_valid = "Trường không được bỏ trống.";
                    check = false;
                    if (focus == 0) {
                        $("#type_property_valid").focus();
                        focus = 1
                    }
                }
            }
        }

        if(typeof $scope.contract.map_var == "undefined" || $scope.contract.map_var == "" || $scope.contract.map_var == null){
            if($scope.check_type_special_word==false) {
                if (!$scope.begin_or_close) {
                    $scope.map_var_valid = "Trường không được bỏ trống.";
                    check = false;
                    if (focus == 0) {
                        $("#map_var_valid").focus();
                        focus = 1
                    }
                }
            }
        }

        if(typeof $scope.contract.key_name == "undefined" || $scope.contract.key_name == "" || $scope.contract.key_name == null){
            $scope.key_name_valid = "Trường không được bỏ trống.";
            check = false;
            if(focus == 0){
                $("#key_name_valid").focus();
                focus = 1
            }
        }

        if($scope.check_type_special_word==true) {
            if(typeof $scope.contract.key_name == "undefined" || $scope.contract.key_name == "" || $scope.contract.key_name == null){
                $scope.special_word_valid = "Trường không được bỏ trống.";
                check = false;
                if(focus == 0){
                    $("#special_word_valid").focus();
                    focus = 1
                }
            }
        }


      /*  if(typeof $scope.contract.first_word == "undefined" || $scope.contract.first_word == "" || $scope.contract.first_word == null){
            if($scope.check_type_special_word==false) {
                if (!$scope.begin_or_close) {
                    $scope.first_word_valid = "Trường không được bỏ trống.";
                    check = false;
                    if (focus == 0) {
                        $("#first_word_valid").focus();
                        focus = 1
                    }
                }
            }
        }*/

      /*  if(typeof $scope.contract.end_word == "undefined" || $scope.contract.end_word == "" || $scope.contract.end_word == null){
            if(!$scope.begin_or_close) {
                $scope.end_word_valid = "Trường không được bỏ trống.";
                check = false;
                if (focus == 0) {
                    $("#end_word_valid").focus();
                    focus = 1
                }
            }
        }*/

        return check;
    };

    $scope.changekeyName = function (type_property) {
        if (type_property != '-1') {
            if ($scope.contract.type == "1") {//duong su
                if ($scope.contract.type_property == "1") {  //cá nhân
                    $scope.keyName = [
                        {name: "Họ tên", map_var: "name"},
                        {name: "Ngày sinh", map_var: "birthday"},
                        {name: "Số chứng minh nhân dân", map_var: "passport"},
                        {name: "ngày cấp", map_var: "certification_date"},
                        {name: "Nơi cấp", map_var: "certification_place"},
                        {name: "Nơi cư trú", map_var: "address"}
                    ];

                } else if ($scope.contract.type_property == "2") {   // công ty
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

            } else if ($scope.contract.type == "2") {//tai san
                if ($scope.contract.type_property == "1") {  //Tài sản đất
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

                } else if ($scope.contract.type_property == "3") {   // Tài sản
                    $scope.keyName = [
                        {name: "Thông tin tài sản", map_var: "property_info"},
                        {name: "Thông tin chủ sở hữu", map_var: "owner_info"},
                        {name: "Thông tin khác", map_var: "other_info"}
                    ];

                } else if ($scope.contract.type_property == "6") {   // Ô tô - xe máy
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

                } else if ($scope.contract.type_property == "8") {   // Mẫu chung cư
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

                } else if ($scope.contract.type_property == "10") {   // Đất, tài sản gắn liền với đất
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
            } else if ($scope.contract.type == "3") {
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

}]);