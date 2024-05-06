/**
 * Created by TuanNQ on 24/11/2020.
 */
myApp.controller("NotaryBookController",['$scope', '$http', '$filter', '$window', '$timeout', '$q', function($scope, $http, $filter, $window, $timeout, $q){
    $scope.searchCondition = {
        notary_book: ""
    };

    $scope.SO_CT_HD_GIAO_DICH = SO_CT_HD_GIAO_DICHS;
    $scope.SO_CT_BAN_SAO = SO_CT_BAN_SAOS;
    $scope.SO_CT_CHU_KY = SO_CT_CHU_KYS;
    $scope.STATUS_OPEN = STATUS_OPEN;
    $scope.STATUS_LOCK_UP = STATUS_LOCK_UP;

    $scope.listData = {items:"", rowCount:0, numberPerPage:20, pageNumber:1, pageList:[], pageCount:0}

    /*load all */
    $scope.loadCountData = function () {
        $http.get(url + "/notaryBook/counts",
            {
                params: {
                    notary_book: $scope.searchCondition.notary_book
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
        $http.get(url + "/notaryBook/list-page", {
            params: {
                offset: 0,
                number: $scope.listData.numberPerPage,
                notary_book: $scope.searchCondition.notary_book
            }
        })
            .then(function (response) {
                $scope.listData.items = response.data;
                $scope.tooltip();
            });
    };
    /*load tooltip*/
    $scope.tooltip = function () {
        var defer = $q.defer();
        $timeout(function () {
            $("[data-toggle=popover]").popover();
            defer.resolve();
        }, 1000);
    };

    $scope.loadPageData = function (pageNum) {
        $scope.listData.pageNumber = pageNum;
        $http.get(url + "/notaryBook/list-page", {
            params: {
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
    // search advance
    $scope.search = function (){
        $('#search_NataryBook').val($scope.searchCondition.notary_book.trim());
        $scope.searchCondition.basic = 1;
        $scope.listData.pageNumber = 1;
        $scope.loadCountData();
        $scope.loadList();
    };
    $scope.search();

    $scope.clearCondition = function () {
        $scope.searchCondition.notary_book="";
    };
}]);