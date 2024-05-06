
/*myApp.controller('contractTemplateEditController',['$scope','$http','$filter','$window','$timeout','$q'
        ,function ($scope,$http,$filter,$window,$timeout,$q) {*/
var myApp = angular.module('osp', ['ngSanitize']);

myApp.controller('contractTemplateEditController',['$scope','$http','$filter','$window','fileUpload','$timeout','$q',function ($scope,$http,$filter,$window,fileUpload,$timeout,$q) {

    //$scope.myFile = {file:""};
    $scope.fileTemplateImport = {};

    $scope.importFileWord = function () {
        console.log("changed file");
        var s = $scope.myFile;
        if ($scope.fileTemplateImport.size > 5242000) {
            $("#errorMaxFile").modal('show');
        } else {
            var file = $scope.fileTemplateImport;
            var uploadUrl = url + "/ContractTemplate/get-html-of-doc-file";

            var formData = new FormData();
            formData.append('file', $scope.fileTemplateImport);

            $.ajax({
                url : url + '/ContractTemplate/get-html-of-doc-file',
                type : 'POST',
                data : formData,
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                success : function(data) {
                    //$("#editor").html(data);
                    CKEDITOR.instances.editor.setData( data );
                    $('#giatriKindHtml').val(data);
                    /* console.log(data);
                     alert(data);*/
                }
            });


        }
    }




}]);
myApp.$inject = ['$scope'];
myApp.service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function (file, uploadUrl) {
        var fd = new FormData();
        fd.append('file', file);

        $http.post(uploadUrl,fd,
            {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }).success(function (response) {
            deffered.resolve(response);

        }).error(function (response) {
            deffered.reject(response);
        });


        /*        return $http.post(uploadUrl, fd, {
                    transformRequest: angular.identity,
                    headers: {'Content-Type': undefined}
                })*/

    }
}]);

myApp.directive('fileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function(){
                scope.$apply(function(){
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}]);






