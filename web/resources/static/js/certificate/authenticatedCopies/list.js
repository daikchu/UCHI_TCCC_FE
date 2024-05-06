/**
 * Created by TuanNQ on 19/08/2020.
 */
myApp.controller("AuthenticatedCopiesController",['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function($scope, $http, $filter, $window, $timeout, $q, fileUpload){
    $scope.userId = userId;
    $scope.searchCondition = {
        timeType: 0,
        dateFrom: "",
        dateTo: "",
        cert_number: ""

    };
    $scope.message = {
        dateFrom: "",
        dateTo: ""
    };

    $scope.listData = {items:"", rowCount:0, numberPerPage:20, pageNumber:1, pageList:[], pageCount:0}

    $scope.showTime = false;
    $scope.timeTypeChange = function (timeType) {
        $scope.showTime = false;
        switch (timeType) {
            case 0:
                $scope.searchCondition.dateFrom = moment().format("");
                $scope.searchCondition.dateTo = moment().format("");
                break;
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
                $scope.showTime = true;
                break;
        }
    };
    /*load all */
    $scope.loadCountData = function () {
        $http.get(url + "/authenticatedCopies/counts",
            {
                params: {
                    userId: $scope.userId,
                    cert_number: $scope.searchCondition.cert_number,
                    dateFrom: $scope.searchCondition.dateFrom,
                    dateTo: $scope.searchCondition.dateTo
                }
            })
            .then(function (response) {
                $scope.listData.rowCount = response.data;
                $scope.listData.pageCount = getPageCount($scope.listData);
                $scope.listData.pageList = getPageList($scope.listData);

            });
    };

    /*reload list*/
    $scope.loadList = function () {
            $http.get(url + "/authenticatedCopies/list-page", {
                params: {
                    userId: $scope.userId,
                    dateFrom: $scope.searchCondition.dateFrom,
                    dateTo: $scope.searchCondition.dateTo,
                    offset: 0,
                    number: $scope.listData.numberPerPage,
                    cert_number: $scope.searchCondition.cert_number
                }
            })
                .then(function (response) {
                    $scope.listData.items = response.data;
                    $scope.tooltip();
                });
    };

    // search advance
    $scope.search = function (){
        $('#search_CartNumber').val($scope.searchCondition.cert_number.trim());
        if(!validateSearch()) return;
        $scope.searchCondition.basic = 1;
        $scope.listData.pageNumber = 1;
        $scope.loadCountData();
        $scope.loadList();
    };
    $scope.search();

    function validateSearch(){
        $scope.message.dateFrom = "";
        $scope.message.dateTo = "";
        var valid = true;
        if($scope.searchCondition.timeType==5){
            var curDate = new Date();
            $scope.searchCondition.dateFrom = $('#dateFrom').val();
            $scope.searchCondition.dateTo = $('#dateTo').val();

            if(!isNullOrEmpty($scope.searchCondition.dateFrom)){
                var dateFromObj = stringToDate($scope.searchCondition.dateFrom, "dd/MM/yyyy", "/");
                console.log("time = "+dateFromObj.getTime());
                if(!isValidDateDDMMYYYY($scope.searchCondition.dateFrom)){
                    valid = false;
                    $scope.message.dateFrom = 'Thời gian nhập không hợp lệ (dd/MM/yyyy)'
                }
                else if(dateFromObj.getTime() > curDate.getTime()) {
                    valid = false;
                    $scope.message.dateFrom = 'Trường Từ ngày không được lớn hơn ngày hiện tại!'
                }
            }

            if(!isNullOrEmpty($scope.searchCondition.dateTo)){
                var dateToObj = stringToDate($scope.searchCondition.dateTo, "dd/MM/yyyy", "/");
                if(!isValidDateDDMMYYYY($scope.searchCondition.dateTo)){
                    valid = false;
                    $scope.message.dateTo = 'Thời gian nhập không hợp lệ (dd/MM/yyyy)'
                }
                else if(dateToObj.getTime() > curDate.getTime()) {
                    valid = false;
                    $scope.message.dateTo = 'Trường Đến ngày không được lớn hơn ngày hiện tại!'
                }
                else if(!isNullOrEmpty($scope.searchCondition.dateFrom)){
                    var dateFromObj = stringToDate($scope.searchCondition.dateFrom, "dd/MM/yyyy", "/");
                    if(isValidDateDDMMYYYY($scope.searchCondition.dateFrom) && dateFromObj.getTime() > dateToObj.getTime() ) {
                        valid = false;
                        $scope.message.dateFrom = 'Trường Từ ngày không được lớn hơn Đến ngày!'
                    }
                }

            }
        }
        return valid;
    }

    $scope.loadPageData = function (pageNum) {
        $scope.listData.pageNumber = pageNum;
        $http.get(url + "/authenticatedCopies/list-page", {
            params: {
                userId: $scope.userId,
                cert_number: $scope.searchCondition.cert_number,
                dateFrom: $scope.searchCondition.dateFrom,
                dateTo: $scope.searchCondition.dateTo,
                offset: $scope.listData.numberPerPage * ($scope.listData.pageNumber - 1),
                number: $scope.listData.numberPerPage
            }
        })
            .then(function (response) {
                $scope.listData.items = response.data;
                $scope.listData.pageList = getPageList($scope.listData);
                $scope.tooltip();
            });
    };

    $scope.clearCondition = function () {
        $scope.searchCondition.timeType = 0;
        $scope.searchCondition.dateFrom = "";
        $scope.searchCondition.dateTo = "";
        $scope.searchCondition.cert_number="";
        $scope.showTime = false;
        $(".select2-selection__rendered").html('--Chọn--');
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
    /*load tong trang va danh sach trang*/
    function getPageCount(pageResult) {
        var pageCount = Math.ceil(pageResult.rowCount / pageResult.numberPerPage);
        return pageCount;
    }

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
    }
}]);