
myApp.controller('detailMaster', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $http.get(url+"/masterConvert/selectContractMasterConvertById", {params: {id:id}})
        .then(function (response) {
            $scope.listDataMaster=response.data;
        });

    $scope.editMasterContract = function () {
        $scope.listDataMasterCopy_ = angular.copy($scope.listDataMaster);
        $scope.listDataMaster.entry_user_id = $scope.entry_user_id;
        $scope.listDataMaster.entry_user_name = $scope.entry_user_name;
        $scope.listDataMaster.update_date_time = new Date();
        $scope.listDataMaster.entry_date_time = new Date();
        $scope.listDataMaster.notary_date = new Date();

        var dataMaster = JSON.stringify($scope.listDataMaster);
        $http.post(url+"/masterConvert/editContractMasterConvert", dataMaster, {headers: {'Content-Type': 'application/json'} })
            .then(function (response) {
                if(response.data == true){
                    $("#editContract").modal("hide");
                    $("#editContractSucsses").modal("show");
                    $http.get(url+"/masterConvert/selectContractMasterConvertById", {params: {id:id}})
                        .then(function (response) {
                            $scope.listDataMaster=response.data;
                        });
                }else {
                    $("#error").modal("show");
                    $scope.listDataMasterCopy = $scope.listDataMasterCopy_;
                }
            });
    };
}]);