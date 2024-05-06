
myApp.controller('contractTemplateController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {

    $scope.deleteContractTemplate = function (id) {

            $http.get(url + "/contract/get-contract-template-by-code-template", {params: {code_temp: code}})
                .then(function (response) {
                    $scope.contract_template = response.data;
                    if(type_custum != 'custum_update'){
                        $("#editor").html($scope.contract_template.kind_html)
                    }
                });
    };


}]);