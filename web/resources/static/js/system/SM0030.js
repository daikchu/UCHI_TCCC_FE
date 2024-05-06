
myApp.controller('contractTempAddController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.contractTempAdd = {
        id:"",
        name:"",
        kind_id:"",
        kind_id_tt08:"0",
        code:"",
        description:"",
        file_name:"",
        file_path:"",
        active_flg:"",
        relate_object_number:"0",
        relate_object_A_display:"",
        relate_object_B_display:"",
        relate_object_C_display:"",
        period_flag:"0",
        period_req_flag:"0",
        mortage_cancel_func:"0",
        sync_option:"0",
        entry_user_id:"",
        entry_user_name:"",
        entry_date_time:"",
        update_user_id:"",
        update_user_name:"",
        update_date_time:"",
        kind_html:"",
        office_code:"0",
        code_template:""
    };
    $scope.contractTempUpdate = {
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
        relate_object_a_display:"",
        relate_object_b_display:"",
        relate_object_c_display:"",
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

    if(type_custum == 'custum_add' || type_custum == 'custum_update'){        //add,custum_add,custum_update     các type xảy ra
        $scope.contractTempAdd.id = id_custum;
        $scope.contractTempAdd.name = name_custum;
        $scope.contractTempAdd.kind_id = kind_id_custum;
        $scope.contractTempAdd.kind_id_tt08 = kind_id_tt08_custum;
        $scope.contractTempAdd.code = code_custum;
        $scope.contractTempAdd.description = description_custum;
        $scope.contractTempAdd.file_name = file_name_custum;
        $scope.contractTempAdd.file_path = file_path_custum;
        $scope.contractTempAdd.active_flg = active_flg_custum;
        $scope.contractTempAdd.relate_object_number = relate_object_number_custum;
        $scope.contractTempAdd.relate_object_A_display = relate_object_A_display_custum;
        $scope.contractTempAdd.relate_object_B_display = relate_object_B_display_custum;
        $scope.contractTempAdd.relate_object_C_display = relate_object_C_display_custum;
        $scope.contractTempAdd.period_flag = period_flag_custum;
        $scope.contractTempAdd.period_req_flag = period_req_flag_custum;
        $scope.contractTempAdd.mortage_cancel_func = mortage_cancel_func_custum;
        $scope.contractTempAdd.sync_option = sync_option_custum;
        /*xử lý đương sự, tài sản*/
        kind_html_custum = kind_html_custum.replace(/dynamic="duongsu"/g, "id=\"id_duongsu\" dynamic=\"duongsu\"");
        kind_html_custum = kind_html_custum.replace(/dynamic="duongsubena"/g, "id=\"id_duongsubena\" dynamic=\"duongsubena\"");
        kind_html_custum = kind_html_custum.replace(/dynamic="duongsubenb"/g, "id=\"id_duongsubenb\" dynamic=\"duongsubenb\"");
        kind_html_custum = kind_html_custum.replace(/dynamic="taisan"/g, "id=\"id_taisan\" dynamic=\"taisan\"");

        var doc = new DOMParser().parseFromString(kind_html_custum, "text/html");

        while (doc.getElementById("id_duongsu")) {
            doc = new DOMParser().parseFromString(kind_html_custum, "text/html");
            if(typeof doc.getElementById("id_duongsu") == "undefined" || !doc.getElementById("id_duongsu") || doc.getElementById("id_duongsu") == null){
                break;
            }

            doc.getElementById("id_duongsu").innerHTML = "<a class=\"btn btn-success\">>>Khu vực hiển thị đương sự<<</a>";
            kind_html_custum = doc.body.innerHTML;
            kind_html_custum = kind_html_custum.replace("id=\"id_duongsu\" dynamic=\"duongsu\"", "dynamic=\"duongsu\"");
        }

        while (doc.getElementById("id_duongsubena")) {
            doc = new DOMParser().parseFromString(kind_html_custum, "text/html");
            if(typeof doc.getElementById("id_duongsubena") == "undefined" || !doc.getElementById("id_duongsubena") || doc.getElementById("id_duongsubena") == null){
                break;
            }

            doc.getElementById("id_duongsubena").innerHTML = "<a class=\"btn btn-success\">>>Khu vực hiển thị đương sự bên a<<</a>";
            kind_html_custum = doc.body.innerHTML;
            kind_html_custum = kind_html_custum.replace("id=\"id_duongsubena\" dynamic=\"duongsubena\"", "dynamic=\"duongsubena\"");
        }

        while (doc.getElementById("id_duongsubenb")) {
            doc = new DOMParser().parseFromString(kind_html_custum, "text/html");
            if(typeof doc.getElementById("id_duongsubenb") == "undefined" || !doc.getElementById("id_duongsubenb") || doc.getElementById("id_duongsubenb") == null){
                break;
            }

            doc.getElementById("id_duongsubenb").innerHTML = "<a class=\"btn btn-success\">>>Khu vực hiển thị đương sự bên b<<</a>";
            kind_html_custum = doc.body.innerHTML;
            kind_html_custum = kind_html_custum.replace("id=\"id_duongsubenb\" dynamic=\"duongsubenb\"", "dynamic=\"duongsubenb\"");
        }

        while (doc.getElementById("id_taisan")) {
            doc = new DOMParser().parseFromString(kind_html_custum, "text/html");
            if(typeof doc.getElementById("id_taisan") == "undefined" || !doc.getElementById("id_taisan") || doc.getElementById("id_taisan") == null){
                break;
            }

            doc.getElementById("id_taisan").innerHTML = "<a class=\"btn btn-primary\">>>Khu vực hiển thị tài sản<<</a>";
            kind_html_custum = doc.body.innerHTML;
            kind_html_custum = kind_html_custum.replace("id=\"id_taisan\" dynamic=\"taisan\"", "dynamic=\"taisan\"");
        }

        console.log(("str1,str2,str3,str4".match(/,/g) || []).length); //logs 3
        console.log(("str1,str2,str3,str4".match(new RegExp("str", "g")) || []).length); //logs 4

        kind_html_custum = doc.body.innerHTML;
        /*end*/
        $scope.contractTempAdd.kind_html = kind_html_custum;
        $scope.contractTempAdd.office_code = office_code_custum;
        $scope.contractTempAdd.code_template = code_template_custum;
        //$("#editor").html(kind_html_custum);
        CKEDITOR.instances.editor.setData( kind_html_custum );

        if(parent_custum_check == "false") {
            $scope.contractTemplates = [{
                code_template: parent_code_template_custum,
                name: parent_name_custum
            }];
        } else {
            $scope.contractTemplates = [{
                code_template: kind_id_custum,
                name: name_custum
            }];
        }
    }

    $http.get(url + "/contract/list-contract-kind")
        .then(function (response) {
            $scope.contractKinds = response.data;
        });

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
