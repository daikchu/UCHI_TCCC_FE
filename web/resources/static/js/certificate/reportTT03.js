myApp.controller('reportTT03CertController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.userId = userId;
    $scope.searchCondition = {
        timeType: 1,
        dateFrom:  moment().format("DD/MM/YYYY"),
        dateTo: moment().format("DD/MM/YYYY")
    };
    $scope.message = {
        dateFrom: "",
        dateTo: ""
    };
    $scope.reportTT03Cert = {cert_copies_number:0, cert_signature_number:0, cert_contract_number:0};


    $scope.timeTypeChange = function (timeType) {
        $('#rangeTime').hide();
        switch (timeType) {
            case 1:
                $scope.searchCondition.dateFrom = moment().format("DD/MM/YYYY");
                $scope.searchCondition.dateTo = moment().format("DD/MM/YYYY");
                break;
            case 2:
                $scope.searchCondition.dateFrom = moment().startOf('week').format("DD/MM/YYYY");
                $scope.searchCondition.dateTo = moment().format("DD/MM/YYYY");
                break;
            case 3:
                $scope.searchCondition.dateFrom = moment().startOf('month').format("DD/MM/YYYY");
                $scope.searchCondition.dateTo = moment().format("DD/MM/YYYY");
                break;
            case 4:
                $scope.searchCondition.dateFrom = moment().startOf('year').format("DD/MM/YYYY");
                $scope.searchCondition.dateTo = moment().format("DD/MM/YYYY");
                break;
            case 5:
                $('#rangeTime').show();
                break;
        }
    };

    /*load all */
    $scope.loadCountData = function () {
        $http.get(url + "/reportCertificate/tt03",
            {
                params: {
                    userId: $scope.userId,
                    dateFrom: $scope.searchCondition.dateFrom,
                    dateTo: $scope.searchCondition.dateTo
                }
            })
            .then(function (response) {
                $scope.reportTT03Cert = response.data;

            });
    };


    //search advance
    $scope.search = function () {
        if(!validateSearch()) return;
        $scope.searchCondition.basic = 1;
        $scope.loadCountData();
    };
    $scope.search();

    function validateSearch(){
        var valid = true;
        if($scope.searchCondition.timeType==5){
            $scope.searchCondition.dateFrom = $('#dateFrom').val();
            $scope.searchCondition.dateTo = $('#dateTo').val();
            if(isNullOrEmpty($scope.searchCondition.dateFrom)){
                valid = false;
                $scope.message.dateFrom = 'Trường không được phép bỏ trống!'
            }
            if(isNullOrEmpty($scope.searchCondition.dateTo)){
                valid = false;
                $scope.message.dateTo = 'Trường không được phép bỏ trống!'
            }
        }
        return valid;
    }

    $scope.clearCondition = function () {
        $scope.searchCondition.timeType = 0;
        $scope.searchCondition.dateFrom = "";
        $scope.searchCondition.dateTo = "";
    };

    $scope.export = function(){
        window.location.href = contextPath + exportUrl + "?dateFrom="+$scope.searchCondition.dateFrom+"&dateTo="+$scope.searchCondition.dateTo;
    };

    /*load tooltip*/
    $scope.tooltip = function () {
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            defer.resolve();
        }, 1000);
    };

}]);