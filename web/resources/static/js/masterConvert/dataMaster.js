
myApp.controller('contractListController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.search={basic:0,search_basic:"0",contract_kind:"",contract_template:"",contract_number:"",relation_object:"",property_info:"",time:"",fromTime:"",toTime:""};
    $scope.listDataMaster = {items:"",rowCount:0,numberPerPage:20,pageNumber:1,pageList:[],pageCount:0};
    var search= JSON.stringify($scope.search);
    $scope.tab = 0; //0 cơ bản, 1 trùng số , 2 trùng nội dung

    $http.get(url+"/masterConvert/selectContractMasterConvert", {params: {search:search,type:$scope.tab,offset:0,number:$scope.listDataMaster.numberPerPage}})
        .then(function (response) {
            $scope.listDataMaster.items=response.data;
            $scope.tooltip();
        });
    $http.get(url+"/masterConvert/countContractMasterConvert", {params: {search:search,type:$scope.tab}})
        .then(function (response) {
            $scope.listDataMaster.rowCount=response.data;
            $scope.listDataMaster.pageCount=getPageCountContract($scope.listDataMaster);
            $scope.listDataMaster.pageList=getPageList($scope.listDataMaster);

        });
    /*load for search*/
    $scope.showTime=false;
    $scope.changTime=function (time) {
        if(time==5){
            $scope.showTime=true;
        }else{
            $scope.showTime=false;
        }
    };

    //search advance
    $scope.searchAdvance=function () {
        $scope.tab = 3;
        if($scope.checkDate()){
            $scope.search.basic=1;
            $scope.listDataMaster.pageNumber=1;
            $scope.loadCountDataMasster();
            $scope.loadListDataMasster();

        }else{
            $("#errorFormatDate").modal('show');
        }
    };
    /*load all */
    $scope.loadCountDataMasster = function () {
        var search = JSON.stringify($scope.search);
        $http.get(url + "/masterConvert/countContractMasterConvert", {params: {search: search, type: $scope.tab}})
            .then(function (response) {
                $scope.listDataMaster.rowCount = response.data;
                $scope.listDataMaster.pageCount = getPageCountContract($scope.listDataMaster);
                $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);

            });
    };
    /*reload list*/
    $scope.loadListDataMasster=function () {
        var search = JSON.stringify($scope.search);
        $http.get(url + "/masterConvert/selectContractMasterConvert", {
            params: {
                search: search,
                type: $scope.tab,
                offset: 0,
                number: $scope.listDataMaster.numberPerPage
            }
        })
            .then(function (response) {
                $scope.listDataMaster.items = response.data;
                $scope.tooltip();
            });
    };

    $scope.loadPageDataMaster = function (index) {
        if(index>=1){
            $scope.listDataMaster.pageNumber=index;
            var search= JSON.stringify($scope.search);
            $http.get(url+"/masterConvert/selectContractMasterConvert", {params: {search:search,type:$scope.tab,offset:$scope.listDataMaster.numberPerPage*($scope.listDataMaster.pageNumber-1),number:$scope.listDataMaster.numberPerPage}})
                .then(function (response) {
                    $scope.listDataMaster.items=response.data;
                    $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);
                    $scope.tooltip();
                });
        }
    };

    /*load tooltip*/
    $scope.tooltip=function () {
        var defer = $q.defer();
        $timeout(function(){
            $("[data-toggle=popover]").popover();
            defer.resolve();
        },1000);
    };

    /*load tong trang va danh sach trang*/
    function getPageCountContract(pageResult) {
        var pageCount=Math.ceil(pageResult.rowCount/pageResult.numberPerPage);
        return pageCount;
    }

    function getPageList(pagingResult) {
        var pages=[];
        var from = pagingResult.pageNumber  - 3;
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

        for (var i=from; i<=to; i++ ) {
            pages.push(i);
        }
        return pages;
    }

    /*check todate and from date*/
    $scope.checkDate=function () {
        if($scope.search.fromTime !=null && $scope.search.fromTime.length>0){
            if($scope.search.fromTime.length!=10){
                $scope.fromDateError="Trường theo định dạng dd/MM/yyyy";
                return false;
            }else{
                if(moment($scope.search.fromTime,"DD/MM/YYYY",true).isValid()){
                    var dateFrom=$scope.formatDate($scope.search.fromTime);
                    if(dateFrom> new Date()){
                        $scope.fromDateError="Không thể lớn hơn ngày hiện tại!";
                        return false;
                    }
                    //kiem tra luon toTime so voi fromTime neu be hon thi bug
                    if($scope.search.toTime !=null && $scope.search.toTime.length>0){
                        if($scope.search.toTime.length!=10){
                            $scope.toDateError="Trường theo định dạng dd/MM/yyyy";
                            return false;
                        }else{
                            if(moment($scope.search.toTime,"DD/MM/YYYY",true).isValid()){
                                var dateTo=$scope.formatDate($scope.search.toTime);
                                if(dateTo> new Date()){
                                    $scope.toDateError="Không thể lớn hơn ngày hiện tại!";
                                }else{
                                    if(dateFrom>dateTo){
                                        $scope.fromDateError='"Từ ngày" không thể lớn hơn "Đến ngày"!';
                                        return false;
                                    }
                                    $scope.fromDateError="";
                                    $scope.fromDateError='';
                                    return true;
                                }
                            }else{
                                $scope.toDateError="Trường theo định dạng dd/MM/yyyy";
                                return false;
                            }
                        }
                    }

                }else{
                    $scope.fromDateError="Trường theo định dạng dd/MM/yyyy";
                    return false;
                }
            }
        }
        if($scope.search.toTime !=null && $scope.search.toTime.length>0){
            if($scope.search.toTime.length!=10){
                $scope.toDateError="Trường theo định dạng dd/MM/yyyy";
                return false;
            }else{
                if(moment($scope.search.toTime,"DD/MM/YYYY",true).isValid()){
                    var dateFrom=$scope.formatDate($scope.search.toTime);
                    if(dateFrom> new Date()){
                        $scope.toDateError="Không thể lớn hơn ngày hiện tại!";
                    }
                }else{
                    $scope.toDateError="Trường theo định dạng dd/MM/yyyy";
                    return false;
                }
            }
        }
        $scope.fromDateError="";
        $scope.fromDateError='';
        return true;
    };

    //convert date dd/mm/yyyy sang date cua he thong.
    $scope.formatDate = function (strDate) {
        if(strDate==null || strDate.length!=10) return null;
        var dateArray = strDate.split("/");
        var date = dateArray[2] + "-" + dateArray[1] + "-" + dateArray[0];
        if(moment(date,"YYYY/MM/DD",true).isValid()){
            return new Date(date);
        }else{
            return null;
        }

    };
    // Expect input as d/m/y
    function isValidDate(s) {
        var bits = s.split('/');
        var d = new Date(bits[2], bits[1] - 1, bits[0]);
        return d && (d.getMonth() + 1) == bits[1];
    };

    /*add id input*/
    $scope.addIdSelect = function (element, index,checkbox) {
        console.log(element.item, checkbox);
        var id_ = element.item.id;

        var listIdSelect = document.getElementById("listIdSelect").value;
        if(listIdSelect == null || listIdSelect == "") {
            if (checkbox == true) {
                document.getElementById("listIdSelect").value = id_;
            }
        } else {
            if (checkbox == true) {
                listIdSelect += ";" + id_;
                document.getElementById("listIdSelect").value = listIdSelect;
            } else {
                var idRemove = id_;
                var list = listIdSelect.split(";");

                var indexRemove;
                for(var i=0; i <= list.length; i++){
                    if(list[i] == idRemove){
                        indexRemove = i;
                        break;
                    }
                }

                list.splice(indexRemove,1); //xóa 1 phần tử tại vị trí indexRemove
                listIdSelect = list.join(";");
                document.getElementById("listIdSelect").value = listIdSelect;
            }
        }

        $('.onChangeSelectBox_').change(function(){

            if(false == $(this).prop("checked")){
                $("#select_all").prop('checked', false);
                $scope.selectAll = false;
            }

            if ($('.onChangeSelectBox_:checked').length == $('.onChangeSelectBox_').length ){
                $("#select_all").prop('checked', true);
                $scope.selectAll = true;
            }
        });
    };

    /*add all input*/
    $scope.select_all = function (element){
        console.log(element,$scope.listDataMaster.items.length);
        document.getElementById("listIdSelect").value = "";
        $scope.checkbox = false;
        var check = element;
        if(check == true){
            var listIdSelect = "";
            for(var i=0;i<$scope.listDataMaster.items.length;i++){
                if(i==0){
                    listIdSelect += $scope.listDataMaster.items[i].id;
                }else {
                    listIdSelect += ";" + $scope.listDataMaster.items[i].id;
                }
            }
            $scope.checkbox = true;
            document.getElementById("listIdSelect").value = listIdSelect;
        }

        $(".onChangeSelectBox_").prop('checked', check);
    };

    /*lọc trùng số*/
    $scope.searchCoincideNumber = function () {
        if($scope.checkDate()){
            $scope.search.basic=1;
            $scope.listDataMaster.pageNumber=1;
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/countContractMasterConvert", {params: {search: search, type: $scope.tab}})
                .then(function (response) {
                    $scope.listDataMaster.rowCount = response.data;
                    $scope.listDataMaster.pageCount = getPageCountContract($scope.listDataMaster);
                    $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);

                });
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/selectContractMasterConvert", {params: {search: search, type: $scope.tab, offset: 0, number: $scope.listDataMaster.numberPerPage}})
                .then(function (response) {
                    $scope.listDataMaster.items = response.data;
                    $scope.tooltip();
                });

        }else{
            $("#errorFormatDate").modal('show');
        }
    };

    /*lọc trùng nội dung*/
    $scope.searchCoincideContent = function () {
        $scope.tab = 2;
        if($scope.checkDate()){
            $scope.search.basic=1;
            $scope.listDataMaster.pageNumber=1;
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/countContractMasterConvert", {params: {search: search, type: $scope.tab}})
                .then(function (response) {
                    $scope.listDataMaster.rowCount = response.data;
                    $scope.listDataMaster.pageCount = getPageCountContract($scope.listDataMaster);
                    $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);

                });
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/selectContractMasterConvert", {params: {search: search, type: $scope.tab, offset: 0, number: $scope.listDataMaster.numberPerPage}})
                .then(function (response) {
                    $scope.listDataMaster.items = response.data;
                    $scope.tooltip();
                });

        }else{
            $("#errorFormatDate").modal('show');
        }
    };

    /*lọc chua chuyen doi*/
    $scope.searchTypeMasterToTransaction0 = function () {
        $scope.tab = 0;
        if($scope.checkDate()){
            $scope.search.basic=1;
            $scope.listDataMaster.pageNumber=1;
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/countContractMasterConvert", {params: {search: search, type: $scope.tab}})
                .then(function (response) {
                    $scope.listDataMaster.rowCount = response.data;
                    $scope.listDataMaster.pageCount = getPageCountContract($scope.listDataMaster);
                    $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);

                });
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/selectContractMasterConvert", {params: {search: search, type: $scope.tab, offset: 0, number: $scope.listDataMaster.numberPerPage}})
                .then(function (response) {
                    $scope.listDataMaster.items = response.data;
                    $scope.tooltip();
                });

        }else{
            $("#errorFormatDate").modal('show');
        }
    };

    /*lọc da chuyen doi*/
    $scope.searchTypeMasterToTransaction1 = function () {
        $scope.tab = 1;
        if($scope.checkDate()){
            $scope.search.basic=1;
            $scope.listDataMaster.pageNumber=1;
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/countContractMasterConvert", {params: {search: search, type: $scope.tab}})
                .then(function (response) {
                    $scope.listDataMaster.rowCount = response.data;
                    $scope.listDataMaster.pageCount = getPageCountContract($scope.listDataMaster);
                    $scope.listDataMaster.pageList = getPageList($scope.listDataMaster);

                });
            var search = JSON.stringify($scope.search);
            $http.get(url + "/masterConvert/selectContractMasterConvert", {params: {search: search, type: $scope.tab, offset: 0, number: $scope.listDataMaster.numberPerPage}})
                .then(function (response) {
                    $scope.listDataMaster.items = response.data;
                    $scope.tooltip();
                });

        }else{
            $("#errorFormatDate").modal('show');
        }
    };

    /*xóa hợp đồng*/
    $scope.deleteCondition = function () {
        var listIdSelect = document.getElementById("listIdSelect").value;
        if(typeof listIdSelect != "undefined" && listIdSelect != "") {
            $http.delete(url + "/masterConvert/deleteContractMasterConvertById", {params: {listIdSelect: listIdSelect}})
                .then(function (response) {
                    if(response.data == true){
                        $('#checkDelete').modal("hide");
                        $('#status-success-3').css("display","block");
                        $("#uchi-status").show();
                        setTimeout(function() {
                            $("#uchi-status").hide();
                            $('#status-success-3').css("display","none");
                        }, 3000);
                        $scope.searchAdvance();
                    }else {
                        $('#checkDelete').modal("hide");
                        $("#error").modal("show");
                    }
                });
        }else {
            $('#checkDelete').modal("hide");
            $("#errorDelete").modal("show");
        }
    };

    /*clear điều kiện tìm kiếm*/
    $scope.clearCondition = function () {
        $scope.search.search_basic="";
        $scope.search.contract_kind="";
        $scope.search.contract_template="";
        $scope.search.contract_number="";
        $scope.search.relation_object="";
        $scope.search.property_info="";
        $scope.search.time="";
        $scope.search.fromTime="";
        $scope.search.toTime="";
        $scope.showTime=false;
        $(".select2-selection__rendered").html('--Chọn--');
    };

    //chuyển đổi
    $scope.dataMasterToTransaction = {
        typeMasterToTransaction:1,
        entry_user_id:$scope.entry_user_id,
        entry_user_name:$scope.entry_user_name,
        data:""
    };
    $scope.addAllMasterToTransaction = function () {
        $scope.dataMasterToTransaction.typeMasterToTransaction = 1;
        $scope.dataMasterToTransaction.entry_user_id = $scope.entry_user_id;
        $scope.dataMasterToTransaction.entry_user_name = $scope.entry_user_name;
        var object = JSON.stringify($scope.dataMasterToTransaction);
        $http.get(url + "/masterConvert/addMasterToTransaction", {params: {object: object}});
        $("#addAllMasterToTransaction").modal("hide");

        $('#status-success-5').css("display","block");
        $("#uchi-status-2").show();
        setTimeout(function() {
            $("#uchi-status-2").hide();
            $('#status-success-5').css("display","none");
        }, 5000);
        var timer = setInterval(indexHandle, 1000);
    };

    function indexHandle(){
        if($scope.checkResponse != 100) {
            $.ajax({
                type: "GET",
                url: url + "/masterConvert/init-index-addMasterToTransaction-handle",
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',

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
        }else {
            $('#status-success-5').css("display","block");
            $("#uchi-status-2").show();
            window.clearInterval(timer);
            $('.progress').hide(500);
        }
    };

    $scope.addLimitMasterToTransaction = function () {
        $scope.dataMasterToTransaction.data = document.getElementById("listIdSelect").value;
        if(typeof $scope.dataMasterToTransaction.data != "undefined" && $scope.dataMasterToTransaction.data != "") {
            $scope.dataMasterToTransaction.typeMasterToTransaction = 2;
            $scope.dataMasterToTransaction.entry_user_id = $scope.entry_user_id;
            $scope.dataMasterToTransaction.entry_user_name = $scope.entry_user_name;
            var object = JSON.stringify($scope.dataMasterToTransaction);
            $http.get(url + "/masterConvert/addMasterToTransaction", {params: {object: object}})
                .then(function (response) {
                    $("#addLimitMasterToTransaction").modal("hide");
                    if(response.data == true){
                        $("#addMasterToTransactionSucsses").modal("show");
                    }else {
                        $("#error").modal("show");
                    }
                });
        }else {
            $("#addLimitMasterToTransaction").modal("hide");
            $("#errorDelete").modal("show");
        }
    };

}]);
