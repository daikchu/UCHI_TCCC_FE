
myApp.controller('attestationTempAddController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.itemAdd = {
        id:"",
        name:"",
        description:"",
        kind_html:"",
        type:"",
        active_flg:"",
        type_org:""
    };
    $scope.itemUpdate = {
        id:"",
        name:"",
        description:"",
        kind_html:"",
        type:"",
        active_flg:"",
        type_org:""
    };

    if(type_custum == 'custum_add' || type_custum == 'custum_update'){        //add,custum_add,custum_update     các type xảy ra
        $scope.itemAdd.id = id;
        $scope.itemAdd.name = name;
        $scope.itemAdd.description = description;
        $scope.itemAdd.kind_html = kind_html;
        $scope.itemAdd.type = type;
        $scope.itemAdd.active_flg = active_flg;
        $scope.itemAdd.type_org = type_org;

        var doc = new DOMParser().parseFromString(kind_html_custum, "text/html");

        console.log(("str1,str2,str3,str4".match(/,/g) || []).length); //logs 3
        console.log(("str1,str2,str3,str4".match(new RegExp("str", "g")) || []).length); //logs 4

        kind_html_custum = doc.body.innerHTML;
        /*end*/
        $scope.itemAdd.kind_html = kind_html_custum;
        //$("#editor").html(kind_html_custum);
        CKEDITOR.instances.editor.setData( kind_html_custum );
    }

    //api lấy mẫu lời chứng
    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });

    //hàm xử lý thay đổi loại lời chứng
    $scope.changeTypeCert = function (type) {
        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {type: type}})
            .then(function (response) {
                $scope.contractTemplates = response.data;
            });
    };



    //
    $scope.myFunc = function (code) {
        $http.get(url + "/contract/list-contract-template-by-contract-kind-code", {params: {code: code}})
            .then(function (response) {
                $scope.contractTemplates = response.data;
            });
    };
    $scope.changeTemplate = function (code) {
        if (code > 0) {
            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    if(type_custum != 'custum_update'){
                        CKEDITOR.instances.editor.setData( $scope.contract_template.kind_html );
                        //$("#editor").html($scope.contract_template.kind_html)
                    }
                });
        }
    };
    $scope.BeforeSubmit = function() {
        $scope.contractTempAdd.entry_date_time = new Date();
        $scope.contractTempAdd.update_date_time = new Date();

        $timeout(function() {
            if($scope.validateContractTempAdd() == false){
                /*$("#checkValidate").modal('show');*/
            }else {
                if(type_custum == 'custum_add' || type_custum == 'custum_update'){
                    $scope.copy_code_template_ = angular.copy($scope.contractTempAdd.code_template);
                    $scope.contractTempAdd.code_template = code_template_custum;
                    if(type_custum == 'custum_add'){
                        if($scope.contractTempAdd.kind_id == '0'){
                            $scope.contractTempAdd.kind_id = $scope.contractTempAdd.code_template;
                        }
                    }
                }
                if(type_custum == 'custum_update') {
                    $scope.genAddToUpdate();
                    var contractTempUpdate = JSON.parse(JSON.stringify($scope.contractTempUpdate));
                    $http.put(url + "/ContractTemplate/UpdateContractTempHibernate", contractTempUpdate, {headers: {'Content-Type': 'application/json'}})
                        .then(function (response) {
                                console.log("response update",response);
                                if (response.data == true) {
                                    $window.location.href = contextPath + '/system/osp/contracttemplate-list?status=2';
                                } else {
                                    $("#errorEdit").modal('show');
                                    $scope.contractTempAdd.code_template = $scope.copy_code_template_;
                                }
                            }
                        );

                } else {

                    var contractTempAdd = JSON.parse(JSON.stringify($scope.contractTempAdd));
                    $http.post(url + "/ContractTemplate/addContractTempHibernate", contractTempAdd, {headers: {'Content-Type': 'application/json'}})
                        .then(function (response) {
                                console.log("response add",response);
                                if (response.data == true) {
                                    $window.location.href = contextPath + '/system/osp/contracttemplate-list?status=1';
                                } else {
                                    $("#errorEdit").modal('show');
                                    if(type_custum == 'custum_add'){
                                        $scope.contractTempAdd.code_template = $scope.copy_code_template_;
                                    }
                                }
                            }
                        );
                }
            }
        }, 0);
    };

    $scope.genAddToUpdate = function() {
        $scope.contractTempUpdate.id = $scope.contractTempAdd.id;
        $scope.contractTempUpdate.name = $scope.contractTempAdd.name;
        $scope.contractTempUpdate.kind_id = $scope.contractTempAdd.kind_id;
        $scope.contractTempUpdate.kind_id_tt08 = $scope.contractTempAdd.kind_id_tt08;
        $scope.contractTempUpdate.code = $scope.contractTempAdd.code;
        $scope.contractTempUpdate.description = $scope.contractTempAdd.description;
        $scope.contractTempUpdate.file_name = $scope.contractTempAdd.file_name;
        $scope.contractTempUpdate.file_path = $scope.contractTempAdd.file_path;
        $scope.contractTempUpdate.active_flg = $scope.contractTempAdd.active_flg;
        $scope.contractTempUpdate.relate_object_number = $scope.contractTempAdd.relate_object_number;
        $scope.contractTempUpdate.relate_object_a_display = $scope.contractTempAdd.relate_object_A_display;
        $scope.contractTempUpdate.relate_object_b_display = $scope.contractTempAdd.relate_object_B_display;
        $scope.contractTempUpdate.relate_object_c_display = $scope.contractTempAdd.relate_object_C_display;
        $scope.contractTempUpdate.period_flag = $scope.contractTempAdd.period_flag;
        $scope.contractTempUpdate.period_req_flag = $scope.contractTempAdd.period_req_flag;
        $scope.contractTempUpdate.mortage_cancel_func = $scope.contractTempAdd.mortage_cancel_func;
        $scope.contractTempUpdate.sync_option = $scope.contractTempAdd.sync_option;
        $scope.contractTempUpdate.entry_user_id = $scope.contractTempAdd.entry_user_id;
        $scope.contractTempUpdate.entry_user_name = $scope.contractTempAdd.entry_user_name;
        $scope.contractTempUpdate.entry_date_time = $scope.contractTempAdd.entry_date_time;
        $scope.contractTempUpdate.update_user_id = $scope.contractTempAdd.update_user_id;
        $scope.contractTempUpdate.update_user_name = $scope.contractTempAdd.update_user_name;
        $scope.contractTempUpdate.update_date_time = $scope.contractTempAdd.update_date_time;
        $scope.contractTempUpdate.kind_html = $scope.contractTempAdd.kind_html;
        $scope.contractTempUpdate.office_code = $scope.contractTempAdd.office_code;
        $scope.contractTempUpdate.code_template = $scope.contractTempAdd.code_template;
    };

    $scope.validateContractTempAdd = function () {
        $scope.code_valid = "";
        $scope.kind_id_valid = "";
        $scope.name_valid = "";
        $scope.active_flg_valid = "";
        $scope.HTML_valid = "";
        var fosus = 0;

        $scope.validate = true;
        $scope.contractTempAdd.code_template = $scope.contractTempAdd.kind_id;

        //gan kind_html
        var htmlEditor = CKEDITOR.instances['editor'].getData();

        $("#giatriKindHtml").html(htmlEditor);
        //   $("#giatriKindHtml").html($("#editor").html());
        var kind_html = document.getElementById("giatriKindHtml").value;
        $scope.kind_html_copy = kind_html;

        if(typeof $scope.contractTempAdd.code == "undefined" || $scope.contractTempAdd.code == "") {
            $scope.validate = false;
            $scope.code_valid = "Trường không được bỏ trống. ";
            if(fosus == 0){
                fosus = 1;
                $("#code_valid").focus();
            }
        }
        if(typeof $scope.contractTempAdd.code_template == "undefined" || $scope.contractTempAdd.code_template == "") {
            $scope.validate = false;
            $scope.kind_id_valid = "Trường không được bỏ trống. ";
            if(fosus == 0){
                fosus = 1;
                $("#kind_id_valid").focus();
            }
        }
        if(typeof $scope.contractTempAdd.name == "undefined" || $scope.contractTempAdd.name == "") {
            $scope.validate = false;
            $scope.name_valid = "Trường không được bỏ trống. ";
            if(fosus == 0){
                fosus = 1;
                $("#name_valid").focus();
            }
        }
        if(typeof $scope.contractTempAdd.active_flg == "undefined" || $scope.contractTempAdd.active_flg == "") {
            $scope.validate = false;
            $scope.active_flg_valid = "Trường không được bỏ trống. ";
            if(fosus == 0){
                fosus = 1;
                $("#active_flg_valid").focus();
            }
        }
        if(typeof kind_html == "undefined" || kind_html == null || kind_html == "" || kind_html.trim() == "") {
            $scope.validate = false;
            $scope.HTML_valid = "Trường không được bỏ trống. ";
            if(fosus == 0){
                fosus = 1;
                $("#editor").focus();
            }
        }

        $('.text-duongsu').html('');
        $('.text-taisan').html('');
        $('.text-duongsu-ben-a').html('');
        $('.text-duongsu-ben-b').html('');
        // $("#giatriKindHtml").html($("#editor").html());
        $("#giatriKindHtml").html(htmlEditor);
        var kind_html = document.getElementById("giatriKindHtml").value;

        $scope.contractTempAdd.kind_html = kind_html;

        return $scope.validate;
    };

    //$scope.myFile = {file:""};
    $scope.fileTemplateImport = {};

    $scope.importFileWord = function () {
        console.log("changed file");
        var s = $scope.myFile;
        if ($scope.fileTemplateImport.size > 5242000) {
            $("#errorMaxFile").modal('show');
        } else {
            var file = $scope.fileTemplateImport;
            var uploadUrl = url + "/ContractTemplate/get-html-of-doc-file";

            var formData = new FormData();
            formData.append('file', $scope.fileTemplateImport);

            $.ajax({
                url : url + '/ContractTemplate/get-html-of-doc-file',
                type : 'POST',
                data : formData,
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                success : function(data) {
                    //$("#editor").html(data);
                    CKEDITOR.instances.editor.setData( data );
                    $('#giatriKindHtml').val(data);
                    /* console.log(data);
                     alert(data);*/
                }
            });


        }
    }
}]);

myApp.$inject = ['$scope'];
myApp.service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function (file, uploadUrl) {
        var fd = new FormData();
        fd.append('file', file);

        $http.post(uploadUrl,fd,
            {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }).success(function (response) {
            deffered.resolve(response);

        }).error(function (response) {
            deffered.reject(response);
        });


        /*        return $http.post(uploadUrl, fd, {
                    transformRequest: angular.identity,
                    headers: {'Content-Type': undefined}
                })*/

    }
}]);
