myApp.controller('signCertReportController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.userId = userId;
    $scope.cert={};
    $scope.searchCondition = {
        timeType: 1,
        dateFrom: moment().format("DD/MM/YYYY"),
        dateTo: moment().format("DD/MM/YYYY"),
        cert_number: "",
        type: type,
        notary_book: ""
    };
    $scope.message = {
        notary_book:"",
        dateFrom: "",
        dateTo: ""
    };

    $scope.listData = {items: "", rowCount: 0, numberPerPage: 20, pageNumber: 1, pageList: [], pageCount: 0};

    $scope.showTime=false;
    $scope.timeTypeChange = function (timeType) {
        $scope.showTime=false;
        $scope.message.dateFrom = "";
        $scope.message.dateTo = "";
        switch (timeType) {
            case 0:
                $scope.searchCondition.dateFrom = "";
                $scope.searchCondition.dateTo = "";
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
                $scope.showTime=true;
                //$('#rangeTime').show();
                break;
        }
    };

    /*load all */
    $scope.loadCountData = function () {
        $http.get(url + "/certificate/count",
            {
                params: {
                    userId: $scope.userId,
                    notary_book: $scope.cert.notary_book,
                    dateFrom: $scope.searchCondition.dateFrom,
                    dateTo: $scope.searchCondition.dateTo,
                    type: $scope.searchCondition.type
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
        $http.get(url + "/certificate/list-page", {
            params: {
                userId: $scope.userId,
                notary_book: $scope.cert.notary_book,
                dateFrom: $scope.searchCondition.dateFrom,
                dateTo: $scope.searchCondition.dateTo,
                type: $scope.searchCondition.type,
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
        $scope.message.dateFrom = "";
        $scope.message.dateTo = "";
        $scope.message.notary_book ="";
        var valid = true;
        if($scope.searchCondition.timeType==5){
            var curDate = new Date();
            $scope.searchCondition.dateFrom = $('#dateFrom').val();
            $scope.searchCondition.dateTo = $('#dateTo').val();
            if(isNullOrEmpty($scope.searchCondition.dateFrom)){
                valid = false;
                $scope.message.dateFrom = 'Trường không được phép bỏ trống!'
            }
            else{
               /* var dateFromObj = new Date($scope.message.dateFrom);*/
                var dateFromObj = stringToDate($scope.searchCondition.dateFrom, "dd/MM/yyyy", "/");
                //console.log("is valid time = "+dateFromObj.isValid());
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

            if(isNullOrEmpty($scope.searchCondition.dateTo)){
                $scope.searchCondition.dateTo = moment().format("DD/MM/YYYY");
            }
            else{
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
        // if (index >= 1) {
        $scope.listData.pageNumber = pageNum;
        $http.get(url + "/certificate/list-page", {
            params: {
                userId: $scope.userId,
                notary_book: $scope.cert.notary_book,
                dateFrom: $scope.searchCondition.dateFrom,
                dateTo: $scope.searchCondition.dateTo,
                type: $scope.searchCondition.type,
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
        $scope.showTime=false;
        $(".select2-selection__rendered").html('--Chọn--');
    };

    $scope.export = function(){
        if (!isNullOrEmpty($scope.cert.notary_book)){
            window.location.href = contextPath + exportUrl + "?dateFrom="+$scope.searchCondition.dateFrom+"&dateTo="+$scope.searchCondition.dateTo+"&notary_book="+$scope.cert.notary_book;
            $scope.message.notary_book ="";
        }else {
            $scope.message.notary_book = 'Trường không được để trống!';
        }
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
    /*danh sách sổ công chứng*/
    $http.get(url + "/notaryBook/listSattusNotarybook", {
        params: {
            type: type
        }
    })
        .then(function (response) {
            $scope.notaryBook = response.data;
        });
}]);