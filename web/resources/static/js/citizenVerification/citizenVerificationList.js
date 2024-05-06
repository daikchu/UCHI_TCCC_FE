var myApp = angular.module('osp', ['ngSanitize']);
myApp.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common['X-Requested-With'];

    $httpProvider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';
    $httpProvider.defaults.headers.common['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS';
    $httpProvider.defaults.headers.common['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With';
}]);

myApp.controller('citizenVerificationController',['$scope','$http','$window','$sce',function ($scope,$http,$window,$sce) {
    //declare

    $scope.searchConditionOrigin = {
        verify_id:$("#verify_id").val(),
        citizen_verify_fullname: $("#citizen_verify_fullname").val(),
        citizen_verify_cccd: $("#citizen_verify_cccd").val(),
        verify_by: $("#verify_by").val(),
        verify_status:$("#search_verify_status").val(),
        verify_date_from: $("#verify_date_from").val(),
        verify_date_to: $("#verify_date_to").val(),
        order_id: $("#order_id").val()
    };
    $scope.searchCondition = {
        verify_id:"",
        citizen_verify_fullname: "",
        citizen_verify_cccd: "",
        verify_by: "",
        verify_status:$("#search_verify_status").val(),
        verify_date_from: "",
        verify_date_to: ""
    };
    $scope.searchConditionMessage = {
      verify_date_from: "",
      verify_date_to: ""
    };
    $scope.citizenVerification = {
        verify_id: "",
        order_id: "",
        notary_office_id: "",
        province_code: "",
        verify_date: null,
        verify_by: "",
        verify_status: "",
        citizen_verify_cccd: "",
        citizen_verify_fullname: "",
        citizen_info: "",
        notary_office_name: "",
        province_name: "",
        verify_status_name: "",
        verify_by_name: "",
        verify_date_formatted: ""
    };


    $scope.paymentTransactionMessage = {
        status: "",
        transaction_status: "",
        note: "",
        attach_files: ""
    };
    $scope.transactionStatuses = [];
    $scope.additionalStatuses = [];


    //todo get can bo thuc hien

    onDisplayNotify();
    //END init

    $scope.onSearch = function() {
        $("#search_verify_status").val($scope.searchCondition.verify_status);
        if(!validateSearchCondition()) return;
        $("#page").val("1");
        $("#search-frm").submit();
    };

    function validateSearchCondition() {
        $scope.searchConditionMessage.verify_date_from = "";
        $scope.searchConditionMessage.verify_date_to = "";
        var isValid = true;
        var dateFromObj = getDateObjectFromDateStr($("#verify_date_from").val());
        var dateToObj = getDateObjectFromDateStr($("#verify_date_to").val());
        if(dateFromObj > dateToObj) {
            $scope.searchConditionMessage.verify_date_from = "Từ ngày không được lớn hơn đến ngày";
            $scope.searchConditionMessage.verify_date_to = "Từ ngày không được lớn hơn đến ngày";
            isValid = false;
        }
        return isValid;
    }

    $scope.clearSearchCondition = function() {
        $("#verify_id").val("");
        $("#citizen_verify_fullname").val("");
        $("#citizen_verify_cccd").val("");
        $("#verify_date_from").val("");
        $("#verify_date_to").val("");
        $("#order_id").val("");
        $scope.searchCondition.verify_status = "";
        resetSelectOption("verify_by");
    };

    $scope.viewDetail =  function(order_id) {
        callGetDetail(order_id);
        // $("#viewCitizenVerifyOrderDetail").modal('show');
    };

    function callGetDetail(verify_id){
        $("#viewCitizenInfoDetail").modal('show');
        $http.get(ospApiUrl + "/citizen-verifications/"+verify_id)
            .then(function (response) {
                if(response.status === 200){
                    $scope.citizenVerification = response.data;
                    $scope.citizenVerification.citizen_info = JSON.parse($scope.citizenVerification.citizen_info);
                    $("#viewCitizenInfoDetail").modal('show');
                    /*setHeightPopup();*/
                }
            });
    }

    $scope.export = function() {
        window.open(tcccApiUrl + "/citizen-verifications/export" + buildUrlSearch());
    };

    function buildUrlSearch(){
        var searchCondition = $scope.searchConditionOrigin;

        var urlSearch = "";
        if(searchCondition.verify_id) {
            urlSearch += (urlSearch ? "&" : "?") + "verify_id="+searchCondition.verify_id;
        }
        if(searchCondition.citizen_verify_fullname) {
            urlSearch += (urlSearch ? "&" : "?") + "citizen_verify_fullname="+searchCondition.citizen_verify_fullname;
        }
        if(searchCondition.citizen_verify_cccd) {
            urlSearch += (urlSearch ? "&" : "?") + "citizen_verify_cccd="+searchCondition.citizen_verify_cccd;
        }
        if(searchCondition.verify_by) {
            urlSearch += (urlSearch ? "&" : "?") + "verify_by="+searchCondition.verify_by;
        }
        if(searchCondition.verify_status) {
            urlSearch += (urlSearch ? "&" : "?") + "verify_status="+searchCondition.verify_status;
        }
        if(searchCondition.verify_date_from) {
            urlSearch += (urlSearch ? "&" : "?") + "verify_date_from="+searchCondition.verify_date_from;
        }
        if(searchCondition.verify_date_to) {
            urlSearch += (urlSearch ? "&" : "?") + "verify_date_to="+searchCondition.verify_date_to;
        }
        if(searchCondition.order_id) {
            urlSearch += (urlSearch ? "&" : "?") + "order_id="+searchCondition.order_id;
        }
        return urlSearch;
    }


    $scope.showBtnEditOrder = function() {
        var transactionPending = $scope.citizenVerifyOrder.transaction_hists.find(function(el){ return el.transaction_status === 'pending'});
        return !!transactionPending;
    };

    $scope.closePopup = function(idPopup) {
        $("#"+idPopup).modal('hide');
    };

    //reset modal height
    function setHeightPopup(){
        //body.modal-open
        $("div.modal-medium").height($("body.modal-open").height()+50);
    }

    $scope.convertIntToDateTime = function(number) {
        return convertIntToDateTime(number);
    };

    $scope.setCssByStatus = function(status) {
        return setCssByStatus(status);
    };

    function onDisplayNotify(){
        // Sau 5 giây, ẩn phần tử
        setTimeout(function() {
            $(".notifyMessage").fadeOut(1000); // Thời gian ẩn 1 giây
        }, 5000); // 5000ms = 5 giây
    }

    function setCssByStatus(status) {
        switch (status) {
            case "pending":
                return "status-box-pending";
            case "fail":
                return "status-box-fail";
            case "success":
                return "status-box-success";
            default:
                return ""
        }
    }
}]);