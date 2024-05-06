myApp.controller('reportGDBDSController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.userId = userId;
    $scope.districtCode = districtCode;
    $scope.searchCondition = {
        timeType: 1,
        dateFrom:  moment().format("DD/MM/YYYY"),
        dateTo: moment().format("DD/MM/YYYY"),

    };
    $scope.message = {
        dateFrom: "",
        dateTo: ""
    };
    $scope.dataReport = [];


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

    $scope.loadCountDataCapHuyen = function () {

        $http.get(url + "/reportCertificate/luong-giao-dich-bds",
            {
                params: {
                    dateFrom: $scope.searchCondition.dateFrom,
                    dateTo: $scope.searchCondition.dateTo,
                    district_code: districtCode,
                    level_cert: levelCert
                }
            })
            .then(function (response) {
                $scope.dataReport = response.data;
                countTotal();
            });
    };


    $scope.totalData = {
        total_count_DNDO_phatTrienTheoDuAn: 0,
        total_count_DNDO_trongKhuDanCu: 0,
        total_count_NORL_phatTrienTheoDuAn: 0,
        total_count_NORL_trongKhuDanCu: 0,
        total_count_CHCC_dienTichDuoi70m2: 0,
        total_count_CHCC_dienTichTu70Den120m2: 0,
        total_count_CHCC_dienTichTren120m2:0,
        total_count_vanPhongChoThue:0,
        total_count_matBangThuongMaiDichVu:0
    };
    function countTotal(){
        $scope.totalData.total_count_DNDO_phatTrienTheoDuAn = 0;
        $scope.totalData.total_count_DNDO_trongKhuDanCu = 0;
        $scope.totalData.total_count_NORL_phatTrienTheoDuAn = 0;
        $scope.totalData.total_count_NORL_trongKhuDanCu = 0;
        $scope.totalData.total_count_CHCC_dienTichDuoi70m2 = 0;
        $scope.totalData.total_count_CHCC_dienTichTu70Den120m2 = 0;
        $scope.totalData.total_count_CHCC_dienTichTren120m2 = 0;
        $scope.totalData.total_count_vanPhongChoThue = 0;
        $scope.totalData.total_count_matBangThuongMaiDichVu = 0;

        var data = $scope.dataReport;
        for(var i = 0;i<data.length;i++){
            $scope.totalData.total_count_DNDO_phatTrienTheoDuAn += Number(data[i].count_DNDO_phatTrienTheoDuAn);
            $scope.totalData.total_count_DNDO_trongKhuDanCu += Number(data[i].count_DNDO_trongKhuDanCu);
            $scope.totalData.total_count_NORL_phatTrienTheoDuAn += Number(data[i].count_NORL_phatTrienTheoDuAn);
            $scope.totalData.total_count_NORL_trongKhuDanCu += Number(data[i].count_NORL_trongKhuDanCu);
            $scope.totalData.total_count_CHCC_dienTichDuoi70m2 += Number(data[i].count_CHCC_dienTichDuoi70m2);
            $scope.totalData.total_count_CHCC_dienTichTu70Den120m2 += Number(data[i].count_CHCC_dienTichTu70Den120m2);
            $scope.totalData.total_count_CHCC_dienTichTren120m2 += Number(data[i].count_CHCC_dienTichTren120m2);
            $scope.totalData.total_count_vanPhongChoThue += Number(data[i].count_vanPhongChoThue);
            $scope.totalData.total_count_matBangThuongMaiDichVu += Number(data[i].count_matBangThuongMaiDichVu);
        }
    }


    //search advance
    $scope.search = function () {
        if(!validateSearch()) return;
        $scope.searchCondition.basic = 1;
        $scope.loadCountDataCapHuyen();
    };
    $scope.search();

    function validateSearch(){
        var valid = true;
        if($scope.searchCondition.timeType==5){
            $scope.searchCondition.dateFrom = $('#dateFrom').val();
            $scope.searchCondition.dateTo = $('#dateTo').val();
            if(isNullOrEmpty($scope.searchCondition.dateFrom)){
                valid = false;
                $scope.message.dateFrom = 'Trường không được phép bỏ trống!';
            }
            if(isNullOrEmpty($scope.searchCondition.dateTo)){
                valid = false;
                $scope.message.dateTo = 'Trường không được phép bỏ trống!';
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