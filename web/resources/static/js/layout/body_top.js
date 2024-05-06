/**
 * Created by DaiCQ on 10/02/2020.
 */
var myApp = angular.module('osp', []);
myApp.$inject = ['$scope'];
myApp.controller('bodyTopController',['$scope','$http','$filter','$window','$sce','$timeout',function ($scope,$http,$filter,$window,$sce,$timeout) {
    $scope.listQA = {};
    $scope.countListQA = 0;

    $scope.getQA = function () {
        $http.get(ospApiUrl + "/question-help/search", {params: {page: 1, search:"", type:typeQATCCC}})
            .then(function (response) {
                $scope.listQA = response.data;
                /*if(response.status == 200){
                    $("#errorDelete").modal('show');
                }*/
            });

       /* $http.get(ospApiUrl + "/question-help/count", {params: {search:"", type:typeQATCCC}})
            .then(function (response) {
                $scope.countListQA = response.data;
            });*/
    }


}]);



//khai bao directive dung` gen html
myApp.directive('dynamic', function ($compile) {
    return {
        restrict: 'A',
        replace: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic, function(html) {
                ele.html(html);
                $compile(ele.contents())(scope);
            });
        }
    };
});

