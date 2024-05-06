myApp.controller("NotaryBookController",['$http','$scope', function($http,$scope){
    $scope.addCondition = {
        id:"",
        create_date: "",
        lock_day: "",
        notary_book: "",
        type:"",
        status:""
    };
    $scope.message = {
        create_date: "",
        lock_day: "",
        notary_book: "",
        type:"",
        status:""
    };
    $scope.org_type = org_type;
    $scope.check_add = function (){

        if(validateAdd() == true){
            $scope.message.notary_book = "";
            $scope.addCondition.notary_book = $('#notary_book').val();
            $scope.addCondition.id = $('#id').val();
            $scope.addCondition.type = $('#type').val();

            if (!isNullOrEmpty($scope.addCondition.notary_book)) {
                $http.get(url + "/notaryBook/checkNotaryNumber", {params: {notary_book: $scope.addCondition.notary_book,id: $scope.addCondition.id,type: $scope.addCondition.type}})
                    .then(function (response) {
                        if (response.status == 200 && response.data == true) {
                            if($scope.org_type == 1){
                                $scope.message.notary_book = 'Sổ chứng thực này đã tồn tại. Bạn hãy thay sổ chứng thực khác.';
                            }else {
                                $scope.message.notary_book = 'Sổ công chứng này đã tồn tại. Bạn hãy thay sổ chứng thực khác.';
                            }
                        }else {
                            $( "#panel1" ).submit();
                        }
                    });
            }else {
                $( "#panel1" ).submit();
            }

        }else {
            return;
        }

    };

    function validateAdd(){
        $scope.message.create_date = "";
        $scope.message.lock_day = "";
        $scope.message.notary_book = "";
        $scope.message.type = "";
        $scope.message.status ="";
        var valid = true;
        var curDate = new Date();
        $scope.addCondition.create_date = $('#create_date').val();
        $scope.addCondition.lock_day = $('#lock_day').val();
        $scope.addCondition.notary_book = $('#notary_book').val();
        $scope.addCondition.type = $('#type').val();
        $scope.addCondition.status = $('#status').val();
        if($scope.addCondition.status == 1){
            var month=0;
            var day=0;
            month=curDate.getMonth()<10?("0"+(curDate.getMonth() + 1)):(curDate.getMonth() + 1);
            day=curDate.getDate()<10?("0"+curDate.getDate()):curDate.getDate();
            $scope.addCondition.lock_day=day+"/"+month+"/"+curDate.getFullYear();
            $('#lock_day').val($scope.addCondition.lock_day);

        }else {
            $scope.addCondition.lock_day = null;
        }
        if ($scope.org_type == 1){
            if (isNullOrEmpty($scope.addCondition.type)){
                valid = false;
                $scope.message.type = 'Trường không được bỏ trống!';
            }
        }
        if(isNullOrEmpty($scope.addCondition.notary_book)){
            valid = false;
            $scope.message.notary_book = 'Trường không được bỏ trống!';
        }
        if(isNullOrEmpty($scope.addCondition.create_date)){
            valid = false;
            $scope.message.create_date = 'Trường không được bỏ trống!';
        }


        if(!isNullOrEmpty($scope.addCondition.create_date)){
            var dateFromObj = stringToDate($scope.addCondition.create_date, "dd/MM/yyyy", "/");
            console.log("time = "+dateFromObj.getTime());
            if(!isValidDateDDMMYYYY($scope.addCondition.create_date)){
                valid = false;
                $scope.message.create_date = 'Thời gian nhập không hợp lệ (dd/MM/yyyy)';
            }
            else if(dateFromObj.getTime() > curDate.getTime()) {
                valid = false;
                $scope.message.create_date = 'Trường mở ngày không được lớn hơn ngày hiện tại!';
            }
        }

        // if(!isNullOrEmpty($scope.addCondition.lock_day)){
        //     var dateToObj = stringToDate($scope.addCondition.lock_day, "dd/MM/yyyy", "/");
        //     if(!isValidDateDDMMYYYY($scope.addCondition.lock_day)){
        //         valid = false;
        //         $scope.message.lock_day = 'Thời gian nhập không hợp lệ (dd/MM/yyyy)'
        //     }
        //     else if(dateToObj.getTime() > curDate.getTime()) {
        //         valid = false;
        //         $scope.message.lock_day = 'Trường khóa ngày không được lớn hơn ngày hiện tại!';
        //     }
        //     else if(!isNullOrEmpty($scope.addCondition.create_date)){
        //         var dateFromObj = stringToDate($scope.addCondition.create_date, "dd/MM/yyyy", "/");
        //         if(isValidDateDDMMYYYY($scope.addCondition.create_date) && dateFromObj.getTime() > dateToObj.getTime() ) {
        //             valid = false;
        //             $scope.message.create_date = 'Trường mở ngày không được lớn hơn khóa ngày!';
        //         }
        //     }
        //
        // }

        return valid;
    };
    $scope.check_status = function () {
        var curDate = new Date();
        $scope.addCondition.status = $('#status').val();
        if($scope.addCondition.status == 1){
            var month="";
            var day="";
            month=curDate.getMonth()<10?("0"+curDate.getMonth()):curDate.getMonth();
            day=curDate.getDate()<10?("0"+curDate.getDate()):curDate.getDate();
            $scope.addCondition.lock_day=day+"/"+month+"/"+curDate.getFullYear();
        }else {
            $scope.addCondition.lock_day = null;
        }
    }

}]);