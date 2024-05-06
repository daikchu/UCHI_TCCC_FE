var myApp = angular.module('osp', ['ngSanitize']);
myApp.controller('citizenVerifyOrderController',['$scope','$http','$window','$sce',function ($scope,$http,$window,$sce) {
    //declare

    $scope.searchCondition = {
        province_code: $("#search_province_code").val(),
        notary_office_code: $("#search_notary_office_code").val(),
        order_id:"",
        transaction_status:$("#search_transaction_status").val(),
        status:$("#search_status").val(),
        order_time_from:"",
        order_time_to:""
    };
    $scope.searchConditionMessage = {
      order_time_from: "",
      order_time_to: ""
    };
    $scope.citizenVerifyOrder = {
        order_id: "",
        order_time: null,
        verify_number: 0,
        verify_fee: "",
        verify_fee_received: "",
        notary_office_code: "",
        notary_office_name: "",
        province_code: "",
        province_name: "",
        transaction_status: "",
        transaction_status_name: "",
        status: "",
        status_name: "",
        notary_officer: "",
        note: "",
        attach_files: "",
        update_by: "",
        payment_content: "",
        transaction_hists: []
    };

    $scope.transactionStatuses = [];
    $scope.additionalStatuses = [];

    function getTransactionStatuses(){
        $http.get(ospApiUrl + "/statuses?type=citizen_verify_transaction")
            .then(function (response) {
                if(response.status === 200){
                    $scope.transactionStatuses = response.data;
                }
            });
    }

    function getAdditionalStatuses() {
        $http.get(ospApiUrl + "/statuses?type=citizen_verify_transaction_additional")
            .then(function (response) {
                if(response.status === 200){
                    $scope.additionalStatuses = response.data;
                }
            });
    }

    getTransactionStatuses();
    getAdditionalStatuses();
    onDisplayNotify();

    //END init

    $scope.onSearchOrders = function() {
        $("#search_province_code").val($scope.searchCondition.province_code);
        $("#search_notary_office_code").val($scope.searchCondition.notary_office_code);
        $("#search_transaction_status").val($scope.searchCondition.transaction_status);
        $("#search_status").val($scope.searchCondition.status);
        if(!validateSearchCondition()) return;
        $("#page").val("1");
        $("#search-frm").submit();
    };

    function validateSearchCondition() {
        $scope.searchConditionMessage.order_time_from = "";
        $scope.searchConditionMessage.order_time_to = "";
        var isValid = true;
        var dateFromObj = getDateObjectFromDateStr($("#order_time_from").val());
        var dateToObj = getDateObjectFromDateStr($("#order_time_to").val());
        if(dateFromObj > dateToObj) {
            $scope.searchConditionMessage.order_time_from = "Từ ngày không được lớn hơn đến ngày";
            $scope.searchConditionMessage.order_time_to = "Từ ngày không được lớn hơn đến ngày";
            isValid = false;
        }
        return isValid;
    }

    $scope.clearSearchCondition = function() {
        $("#order_id").val("");
        $scope.searchCondition.transaction_status = "";
        $scope.searchCondition.notary_office_code = "";
        $scope.searchCondition.province_code = "";
        $scope.searchCondition.status = "";
        $("#order_time_from").val("");
        $("#order_time_to").val("");
        resetSelectOption("update_by");
    };

    $scope.viewDetail =  function(order_id) {
        callGetDetail(order_id);
        // $("#viewCitizenVerifyOrderDetail").modal('show');
    };

    function onDisplayNotify(){
        // Sau 5 giây, ẩn phần tử
        setTimeout(function() {
            $(".notifyMessage").fadeOut(1000); // Thời gian ẩn 1 giây
        }, 5000); // 5000ms = 5 giây
    }

    function callGetDetail(order_id){
        $http.get(ospApiUrl + "/citizen-verify-orders/"+order_id)
            .then(function (response) {
                if(response.status === 200){
                    $scope.citizenVerifyOrder = response.data;
                    $("#viewCitizenVerifyOrderDetail").modal('show');
                    // setHeightPopup();
                }
            });
    }

    $scope.export = function() {
        window.open(tcccApiUrl + "/citizen-verify-orders/export" + buildUrlSearch());
    };

    function buildUrlSearch(){
        $scope.searchCondition.order_id = $("#order_id").val();
        $scope.searchCondition.order_time_from = $("#order_time_from").val();
        $scope.searchCondition.order_time_to = $("#order_time_to").val();

        var urlSearch = "";
        if($scope.searchCondition.order_id) {
            urlSearch += (urlSearch ? "&" : "?") + "order_id="+$scope.searchCondition.order_id;
        }
        if($scope.searchCondition.transaction_status) {
            urlSearch += (urlSearch ? "&" : "?") + "transaction_status="+$scope.searchCondition.transaction_status;
        }
        if($scope.searchCondition.status) {
            urlSearch += (urlSearch ? "&" : "?") + "status="+$scope.searchCondition.status;
        }
        if($scope.searchCondition.order_time_from) {
            urlSearch += (urlSearch ? "&" : "?") + "order_time_from="+$scope.searchCondition.order_time_from;
        }
        if($scope.searchCondition.order_time_to) {
            urlSearch += (urlSearch ? "&" : "?") + "order_time_to="+$scope.searchCondition.order_time_to;
        }
        return urlSearch;
    }

    $scope.closePopup = function(idPopup) {
        $("#"+idPopup).modal('hide');
    };

    //reset modal height
   /* function setHeightPopup(){
        //body.modal-open
        $("div.modal-medium").height($("body.modal-open").height()+50);
    }*/

    //type are success, error
    function showNotifyMessage(message, idTag, type) {
        // Hiển thị phần tử
        $("#"+idTag).html(message);
        $("#"+idTag).removeClass("status-error status-success").addClass("status-"+type);
        $("#"+idTag).fadeIn(1000); // Thời gian hiển thị 1 giây

        // Sau 5 giây, ẩn phần tử
        setTimeout(function() {
            $("#"+idTag).fadeOut(1000); // Thời gian ẩn 1 giây
        }, 5000); // 5000ms = 5 giây
    }

    $scope.convertIntToDateTime = function(number) {
        return convertIntToDateTime(number);
    };

    $scope.convertIntToDateTimeHourBeforeDate = function(number) {
        return convertIntToDateTimeHourBeforeDate(number);
    };

    $scope.setCssByStatus = function(status) {
        return setCssByStatus(status);
    };

    $scope.setCssClassForPaymentAdditionStatus = function() {


    };

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
    $scope.formatNumber = function(number) {
        return formatNumberReturn(number);
    }
}]);