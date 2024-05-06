
myApp.controller('contractTempAddController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.contractTempAdd = {
        master_dbName:master_dbName_,
        master_serverip:master_serverip_,
        master_serverport:master_serverport_,
        master_driver:master_driver_,
        master_databaseUserName:master_databaseUserName_,
        master_databasePassword:master_databasePassword_
    };
    //mặc định năm đồng bộ
    $scope.year = "1";
    $scope.yearCheck1 = true;

    $scope.BeforeSubmit = function() {
        $("#giatriKindHtml").html($("#editor").html());
        $("#giatriKindHtml").val($("#editor").html());

        if($scope.validateContractTempAdd() == false){
            $("#checkValidate").modal('show');
        }else {
            var contractTempAdd = JSON.parse(JSON.stringify($scope.contractTempAdd));
            $http.post(url + "/masterConvert/updateConfigDBMaster", contractTempAdd, {headers: {'Content-Type': 'application/json'}})
                .then(function (response) {
                        if (response.status == 200 ) {
                            $window.location.href = contextPath + '/system/osp/config-db-master-view?status=1';
                        } else {
                            $("#errorEdit").modal('show');
                        }
                    }
                );
        }
    };

    $scope.connectDBmaster = function() {
        var contractTempAdd = JSON.parse(JSON.stringify($scope.contractTempAdd));
        $http.post(url + "/masterConvert/connectTestConfigDBMaster", contractTempAdd, {headers: {'Content-Type': 'application/json'}})
            .then(function (response) {
                    if (response.status == 200  && response.data == true) {
                        $window.location.href = contextPath + '/system/osp/config-db-master-view?status=2';
                    } else {
                        $window.location.href = contextPath + '/system/osp/config-db-master-view?status=3';
                    }
                }
            );
    };

    $scope.changeYear = function(year) {
        if(year =="1"){
            $scope.yearCheck1 = true;
            $scope.yearCheck2 = false;
        }else if(year =="2"){
            $scope.yearCheck1 = false;
            $scope.yearCheck2 = true;
        }
    };

    $scope.convertDBmaster = function() {
        if($scope.validateConvertDBmaster() == false){
            if($scope.validate_modal == true) {
                $("#checkValidate").modal('show');
            }
        }else {
            $scope.checkResponse = 0;

            $("#convertDBmaster").modal('hide');
            if($scope.year == "1") {
                $http.get(url + "/masterConvert/convertDBMaster", {
                    params: {
                        entry_user_id: $scope.entry_user_id,
                        entry_user_name: $scope.entry_user_name,
                        fromYear: $scope.fromYear,
                        toYear: $scope.fromYear
                    }
                });
                timer = setInterval(indexHandle, 1000);

            }else if($scope.year == "2") {
                $http.get(url + "/masterConvert/convertDBMaster", {
                    params: {
                        entry_user_id: $scope.entry_user_id,
                        entry_user_name: $scope.entry_user_name,
                        fromYear: $scope.fromYear,
                        toYear: $scope.toYear
                    }
                });
            }
            $('#status-success-5').css("display","block");
            $("#uchi-status-2").show();
            setTimeout(function() {
                $("#uchi-status-2").hide();
                $('#status-success-5').css("display","none");
            }, 5000);
            timer = setInterval(indexHandle, 1000);
        }
    };

    function indexHandle(){
        if($scope.checkResponse != 100) {
            if ($scope.year == "1") {
                $.ajax({
                    type: "GET",
                    url: url + "/masterConvert/init-index-convertDBMaster-handle",
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: {
                        fromYear: $scope.fromYear,
                        toYear: $scope.fromYear
                    },

                    success: function (response) {
                        console.log("2=" + response);
                        $scope.checkResponse = response;
                        $(".progress-bar").attr("aria-valuenow", response);
                        $(".progress-bar").text(response + "%");
                        $(".progress-bar").css("width", response + "%");
                        $('.progress').show(500);
                        // if (response == "100") {
                        //     window.clearInterval(timer);
                        //     $('.progress').hide(500);
                        // }
                    },
                    error: function (e) {
                        console.log("ERROR: ", e);
                    },
                    done: function (e) {
                        console.log("DONE");
                    }
                })
            } else if ($scope.year == "2") {
                $.ajax({
                    type: "GET",
                    url: url + "/masterConvert/init-index-convertDBMaster-handle",
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: {
                        fromYear: $scope.fromYear,
                        toYear: $scope.toYear
                    },

                    success: function (response) {
                        console.log("2=" + response);
                        $scope.checkResponse = response;
                        $(".progress-bar").attr("aria-valuenow", response);
                        $(".progress-bar").text(response + "%");
                        $(".progress-bar").css("width", response + "%");
                        $('.progress').show(500);
                        // if (response == "100") {
                        //     window.clearInterval(timer);
                        //     $('.progress').hide(500);
                        // }
                    },
                    error: function (e) {
                        console.log("ERROR: ", e);
                    },
                    done: function (e) {
                        console.log("DONE");
                    }
                })
            }
        }else{
            $('#status-success-5').css("display","block");
            $("#uchi-status-2").show();
            window.clearInterval(timer);
            $('.progress').hide(500);
        }
    };

    $scope.validateConvertDBmaster = function () {
        $scope.validate_ = true;
        $scope.validate_modal = true;
        if($scope.year == "1") {
            if (typeof $scope.fromYear == "undefined" || $scope.fromYear == "") {
                $scope.validate_ = false;
                return $scope.validate_;
            }
        }else if($scope.year == "2") {
            if (typeof $scope.fromYear == "undefined" || $scope.fromYear == "") {
                $scope.validate_ = false;
                return $scope.validate_;
            }
            if (typeof $scope.toYear == "undefined" || $scope.toYear == "") {
                $scope.validate_ = false;
                return $scope.validate_;
            }
            if (parseInt($scope.toYear) < parseInt($scope.fromYear)) {
                $scope.validate_ = false;
                $scope.validate_modal = false;
                $("#errorYearConvert").modal("show");
                return $scope.validate_;
            }
        }

        return $scope.validate_;
    };

    $scope.validateContractTempAdd = function () {
        $scope.validate = true;

        if(typeof $scope.contractTempAdd.master_dbName == "undefined" || $scope.contractTempAdd.master_dbName == "") {
            $scope.validate = false;
            return $scope.validate;
        }
        if(typeof $scope.contractTempAdd.master_serverip == "undefined" || $scope.contractTempAdd.master_serverip == "") {
            $scope.validate = false;
            return $scope.validate;
        }
        if(typeof $scope.contractTempAdd.master_serverport == "undefined" && $scope.contractTempAdd.master_serverport == "") {
            $scope.validate = false;
            return $scope.validate;
        }
        if(typeof $scope.contractTempAdd.master_driver == "undefined" || $scope.contractTempAdd.master_driver == "") {
            $scope.validate = false;
            return $scope.validate;
        }
        if(typeof $scope.contractTempAdd.master_databaseUserName == "undefined" || $scope.contractTempAdd.master_databaseUserName == "") {
            $scope.validate = false;
            return $scope.validate;
        }
        if(typeof $scope.contractTempAdd.master_databasePassword == "undefined" || $scope.contractTempAdd.master_databasePassword == "") {
            $scope.validate = false;
            return $scope.validate;
        }

        return $scope.validate;
    };

    /*   //$scope.myFile = {file:""};
       $scope.fileTemplateImport = {};

       $scope.importFileWord = function () {
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
                       $('#editor').html(data);
                       $('#giatriKindHtml').val(data);
                       /!* console.log(data);
                        alert(data);*!/
                   }
               });


           }
       }
   */

}]);
