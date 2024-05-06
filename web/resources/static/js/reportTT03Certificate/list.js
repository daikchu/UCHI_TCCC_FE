myApp.controller('reportTT03CertListController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.searchCondition = {
        timeType: 1,
        dateFrom:  moment().format("DD/MM/YYYY"),
        dateTo: moment().format("DD/MM/YYYY")
    };
    $scope.message = {
        dateFrom: "",
        dateTo: ""
    };

    $scope.listData = {items: "", rowCount: 0, numberPerPage: 20, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.timeTypeChange = function (timeType) {
        $('#rangeTime').hide();
        $scope.message.dateFrom = "";
        $scope.message.dateTo = "";
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
        $http.get(url + "/reportTT03Certificate/count",
            {
                params: {
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
        $http.get(url + "/reportTT03Certificate/list-page", {
            params: {
                dateFrom: $scope.searchCondition.dateFrom,
                dateTo: $scope.searchCondition.dateTo,
                offset: 0,
                number: $scope.listData.numberPerPage
            }
        })
            .then(function (response) {
                $scope.listData.items = response.data;
                $scope.tooltip();
            });
    };

    //search advance
    $scope.search = function () {
        if(!validateSearch()) return;
        $scope.searchCondition.basic = 1;
        $scope.listData.pageNumber = 1;
        $scope.loadCountData();
        $scope.loadList();
    };
    $scope.search();

    function validateSearch(){
        var valid = true;
        if($scope.searchCondition.timeType==5){
            var curDate = new Date();
            $scope.searchCondition.dateFrom = $('#dateFrom').val();
            $scope.searchCondition.dateTo = $('#dateTo').val();
            if(isNullOrEmpty($scope.searchCondition.dateFrom)){
                valid = false;
                $scope.message.dateFrom = 'Trường không được phép bỏ trống!'
            }

        }
        return valid;
    }

    $scope.loadPageData = function (pageNum) {
        // if (index >= 1) {
        $scope.listData.pageNumber = pageNum;
        $http.get(url + "/reportTT03Certificate/list-page", {
            params: {
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
        // }
    };


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