myApp.controller('preventViewController', ['$scope', '$http','$cookies','$cookieStore', function ($scope, $http, $cookies, $cookieStore) {


    /*download file */

    $scope.downloadFileBytoken = function () {
		
		let customHeaders = new Headers({ Authorization: "Bearer " + localStorage.getItem("token")});
		const requestOptions: RequestOptionsArgs = { headers: customHeaders };
		return $http.get("/api/orders", requestOptions);
		var config = {headers:  {'Authorization': 'Bearer '+ localStorage.getItem("token")'} };


    };


}]);