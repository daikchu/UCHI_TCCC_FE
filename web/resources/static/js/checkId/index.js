
/*
// sample WebSocket
var socket = new WebSocket(websocketUrl);

socket.onopen = function () {
    console.log("Status: Connected")
};

$scope.RX = function(event) {
    $scope.data = event.data;
    $scope.$apply();
    console.log(event.data);
};

socket.onmessage = $scope.RX;
console.log($scope.data)

*/

myApp.controller('indexFaceIdController', ['$scope', '$http', '$filter', '$window', 'fileUpload', '$timeout', '$q', '$interval', function ($scope, $http, $filter, $window, fileUpload, $timeout, $q, $interval) {

    var url = 'http://localhost:7171';
    var websocketUrl = 'ws://localhost:7171/finger-icao-ws';
    $scope.verify_number_available = 0;
    var TIME_COUNTDOWN_MINUTE = 15;
    var TIME_COUNTDOWN_SECOND = 00;

    $scope.errorListIdentity = [
        {
            code: -1,
            mesageEn: 'NOT YET INSTALL SOFTWARE											',
            messageVi: 'Chưa cài phần mềm kết nối thiết bị',
            messageFix: 'Chưa cài phần mềm kết nối thiết bị',
            messageHtml: 'Máy tính của bạn chưa có bộ cài đặt thiết bị xác thực danh tính.<br/> Để được hỗ trợ, vui lòng liên hệ qua hotline: <b>0986.083.003</b><br/>hoặc liên hệ qua địa chỉ <a href="https://zalo.me/+84986083003" target="_blank" style="color: #4285f4; font-weight:bold; text-decoration: underline">Zalo</a>'
        },
        {
            code: 0,
            mesageEn: 'SUCCESS											',
            messageVi: 'Thành công',
            messageFix: ''
        },
        {
            code: 200,
            mesageEn: 'FAILED TO GET READERS LIST							',
            messageVi: 'Lỗi khi lấy danh sách người đọc',
            messageFix: 'Không tìm thấy thiết bị xác thực!',
            messageHtml: 'Hãy đảm bảo thiết bị xác thực CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 202,
            mesageEn: 'NO CARD											',
            messageVi: 'Không tìm thấy thẻ CCCD!',
            messageFix: 'Không tìm thấy thẻ CCCD!',
            messageHtml: 'Vui lòng kiểm tra vị trí đặt thẻ và <br/> không di chuyển thẻ trong quá trình kiểm tra.'
        },
        {
            code: 203,
            mesageEn: 'CARD TIMEOUT										',
            messageVi: 'Không tìm thấy thẻ CCCD!',
            messageFix: 'Không tìm thấy thẻ CCCD!',
            messageHtml: 'Vui lòng kiểm tra vị trí đặt thẻ và <br/> không di chuyển thẻ trong quá trình kiểm tra.'
        },
        {
            code: 204,
            mesageEn: 'NOT MATCHED										',
            messageVi: 'Không khớp',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Dấu vân tay không trùng khớp với dữ liệu <br/> được lưu trong thẻ CCCD.'
        },
        {
            code: 205,
            mesageEn: 'SAM READER NOT FOUND								',
            messageVi: 'Không tìm thấy đầu đọc SAM',
            messageFix: 'Lỗi thiết bị!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 206,
            mesageEn: 'CARD EXCEPTION										',
            messageVi: 'Lỗi thẻ',
            messageFix: 'Lỗi thẻ!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 207,
            mesageEn: 'SPECIFIC READER IS STILL IN USE					',
            messageVi: 'Đầu đọc đang được sử dụng bởi người khác',
            messageFix: '',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 208,
            mesageEn: 'READER IS NOT REGISTERED							',
            messageVi: 'Đầu đọc chưa được đăng ký',
            messageFix: 'Không tìm thấy thiết bị xác thực!',
            messageHtml: 'Hãy đảm bảo thiết bị xác thực CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 209,
            mesageEn: 'FAILED TO GET DEVICES LIST							',
            messageVi: 'Lỗi khi lấy danh sách thiết bị',
            messageFix: 'Không tìm thấy thiết bị xác thực!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 210,
            mesageEn: 'CARD NOT FOUND										',
            messageVi: 'Không tìm thấy thẻ',
            messageFix: 'Không tìm thấy thẻ!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 211,
            mesageEn: 'VERIFY MOC FAILED									',
            messageVi: 'Xác minh MOC không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Dấu vân tay không trùng khớp với dữ liệu <br/> được lưu trong thẻ CCCD.'
        },
        {
            code: 212,
            mesageEn: 'VERIFY MOC ERROR									',
            messageVi: 'Lỗi xác minh MOC',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 213,
            mesageEn: 'CREATE TEMPLATE ERROR  							',
            messageVi: 'Lỗi khi tạo mẫu',
            messageFix: 'Xác thực định danh không thành công!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 214,
            mesageEn: 'FAILED TO GET DEVICE INFO							',
            messageVi: 'Lỗi khi lấy thông tin thiết bị',
            messageFix: 'Không tìm thấy thiết bị xác thực!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 215,
            mesageEn: 'NO TEMPLATE										',
            messageVi: 'Không có mẫu',
            messageFix: 'Xác thực danh tính thất bại!!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 216,
            mesageEn: 'VERIFY MOC FAILED, NO LEFT FINGER TEMPLATE			',
            messageVi: 'Xác minh MOC không thành công, không có mẫu vân tay trái',
            messageFix: 'Không tìm thấy dấu vân tay!',
            messageHtml: 'Vui lòng kiểm tra vị trí đặt ngón tay trỏ và <br/> không di chuyển ngón tay trong quá trình kiểm tra.'
        },
        {
            code: 217,
            mesageEn: 'VERIFY MOC FAILED, NO RIGHT FINGER TEMPLATE		',
            messageVi: 'Xác minh MOC không thành công, không có mẫu vân tay phải',
            messageFix: 'Không tìm thấy dấu vân tay!',
            messageHtml: 'Vui lòng kiểm tra vị trí đặt ngón tay trỏ và <br/> không di chuyển ngón tay trong quá trình kiểm tra.'
        },
        {
            code: 226,
            mesageEn: 'IMAGE QUALITY IS NOT ENOUGH						',
            messageVi: 'Chất lượng hình ảnh không đủ',
            messageFix: 'Không trích xuất được dấu vân tay!',
            messageHtml: 'Chất lượng hình ảnh vân tay không đủ, <br/> vui lòng thử lại.'
        },
        {
            code: 600, mesageEn: 'FAILED TO VERIFY SOD SIGNATURE						',
            messageVi: 'Xác minh chữ ký SOD không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 601,
            mesageEn: 'FAILED TO VERIFY SOD								',
            messageVi: 'Xác minh SOD không thành công',
            messageFix: 'Xác thực định danh không thành công!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 602,
            mesageEn: 'CARD AUTHENTICATION FAILED							',
            messageVi: 'Xác thực thẻ không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Dấu vân tay không trùng khớp với dữ liệu <br/> được lưu trong thẻ CCCD.'
        },
        {
            code: 603,
            mesageEn: 'AA FAILED											',
            messageVi: 'AA không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 604,
            mesageEn: 'CA FAILED											',
            messageVi: 'CA không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 605,
            mesageEn: 'TA FAILED											',
            messageVi: 'TA không thành công',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 999,
            mesageEn: 'UNKNOWN ERROR										',
            messageVi: 'Lỗi không xác định',
            messageFix: 'Lỗi không xác định!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 998,
            mesageEn: 'DATABASE ERROR										',
            messageVi: 'Lỗi cơ sở dữ liệu',
            messageFix: 'Xác thực danh tính thất bại!',
            messageHtml: 'Hãy đảm bảo thiết bị đầu đọc CCCD <br/> đã được kết nối vào máy tính'
        },
        {
            code: 1016,
            mesageEn: ' Finger scanner not found							',
            messageVi: 'Không tìm thấy máy quét vân tay',
            messageFix: 'Không tìm thấy thiết bị xác thực!',
            messageHtml: 'Hãy đảm bảo thiết bị xác thực CCCD <br/> đã được kết nối vào máy tính'
        }
    ];
    /*
    -2: Đang quét thiết bị
    -1 : lỗi
    0 : scan processing
    1 : chờ chấm vân tay
    2 : lấy dc vân tay
    3 : thành công
    * */
    var _webSocket = null;
    $scope.stateIdentity = 0;
    $scope.dataIdentity = {};
    $scope.errorIdentity = {};
    $scope.webSocketData = null;
    $scope.socketReader = {};
    $scope.isKeepPreBuyInfo = false;


    $scope.closeWebSocket = function () {
        if (_webSocket != null) {
            _webSocket.close();
        }
    };

    $scope.getErrorIdentity = function (code, minus_verify_number_yn, order_map_verification) {
        var errorStateFromDevice = $scope.stateIdentity;
        if (code == null) code = 1016;
        $scope.stateIdentity = -1;
        for (var i = 0; i < $scope.errorListIdentity.length; i++) {
            var er = $scope.errorListIdentity[i];
            if (code == er.code) {
                console.log(er);
                $scope.errorIdentity = er;
            }
        }
        $scope.closeWebSocket();
        var listErrorIndentityValid = [204,211,216,217,226];
        // xác thực thất bại nhưng bị trừ lượt
        if(listErrorIndentityValid.indexOf($scope.errorIdentity.code) > -1) {
            // lưu thông tin lượt xác thực danh tính thất bại
            $scope.citizenInformation = {
                verify_id: order_map_verification.verify_id,
                notary_office_id: notary_office,
                province_code: "100",
                verify_date: new Date(),
                verify_by: update_by,
                verify_by_name: notary_officer,
                verify_status: "fail",
                cccd_number: "",
                cmnd_number: "",
                full_name: "",
                date_of_birth: "",
                sex: "",
                country: "",
                ethnic: "",
                hometown: "",
                permanent_address: "",
                date_issuance: "",
                date_expiration: "",
                identification_characteristics: "",
                avatar_img: "",
                verified_count: 1,
                citizen_info: "",
                minus_verify_number_yn: errorStateFromDevice === 2 ? "Y" : "N",
                order_map_verification: order_map_verification
            };

            var citizenInformationJson = JSON.parse(JSON.stringify($scope.citizenInformation));
            console.log('citizenInformationJson', citizenInformationJson);
            // reset token
            $scope.tokenInfo = {
                access_token: "",
                token_type: "Bearer",
                create_date: 0,
                expires_in: 0
            };
            $scope.getTokenGenerate(function () {
                if ($scope.tokenInfo.access_token != "") {
                    $http.post(ospApiUrl + "/citizen-information", citizenInformationJson, {headers: {'Authorization': $scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token}})
                        .then(function (response) {
                                console.log('addCitizenInformation', response);
                                minusVerrifyNumber();
                                $scope.getVerifyNumberAvailable();
                            },
                            function (error) {
                                console.log('addCitizenInformation', error);
                            });
                }
            });
        }else {
            if(order_map_verification != null){
                $scope.getTokenGenerateOSP().then(function(token) {
                    $scope.order_map_verification = {
                        id: order_map_verification.id,
                        order_id: order_map_verification.order_id,
                        verify_id: order_map_verification.verify_id,
                        verify_status: 0
                    };
                    $http.post(ospApiUrl + "/citizen-verifications/update-status-verification", $scope.order_map_verification, {headers: {'Authorization': token.data.token_type + " " + token.data.access_token}})
                        .then(function (response) {
                                console.log('Cập nhật trạng thái sử dụng mã XT thành công', response.data.verify_id)
                            },
                            function (error) {
                                console.log('updateStatusVerification', error);
                            });
                });
            }
        }
    };

    $scope.showBtnRetry = function() {
        //Không tìm thấy thẻ CCCD: NO CARD HOẶC CARD TIMEOUT
        //click Thử lại -> Kiểm tra CCCD: status =
        //Không tìm thấy dấu vân tay: NO LEFT/RIGHT FINGER TEMPLATE
        //Không trích xuất được dấu vân tay: IMAGE QUALITY IS NOT ENOUGH
    };

    $scope.retryToVerify = function(errorCode) {
        //no card or timeout
        if (errorCode === 202 || errorCode === 203) {
            //Dieu huong den trang kiem tra CCCD
            $scope.stateIdentity = 0;
            $scope.checkCardPresent($scope.socketReader, true);
        }
        //khong tim tha dau van tay
        else if (errorCode === 216 || errorCode === 217) {
            // Dieu huong den trang kiem tra dau van tay
            // $scope.stateIdentity = 0;
            $scope.checkCardPresent($scope.socketReader, true);
        }
        //chat luong hinh anh khong du
        else if (errorCode === 226) {
            //dieu huong den trang kiem tra dau van tay
            // $scope.stateIdentity = 0;
            $scope.checkCardPresent($scope.socketReader, true);
        } else {
            //mo lai trang ket noi thiet bi
            $scope.devices();
        }

    };

    /* lấy danh sách thiết bị*/
    $scope.devices = function (isShowPopupBuyMore, isNoNeedFinDevice) {
        // $scope.showDialogNew('popupIdentification','buyNumberVerifyOrVerify');
        $scope.showDialogNew('buyNumberVerifyOrVerify','popupIdentification');
        $scope.showDialogNew('showPaymentTransactionSuccess','popupIdentification');
        $scope.stateIdentity = isNoNeedFinDevice ? 0 : -2;
        setTimeout(function () {
            $http.get(url + "/devices").then(function (response) {
                    /*
                        "data": {
                            "success": true,
                            "code": "0",
                            "message": "SUCCESS",
                            "data": {
                                "reader": "Circle CIR315 Dual & 1S PICC 0",
                                "camera": "",
                                "scanner": "Futronic FS26EU #1"
                            }
                        },
                        "status": 200,
                        "config": {
                            "method": "GET",
                            "transformRequest": [
                                null
                            ],
                            "transformResponse": [
                                null
                            ],
                            "jsonpCallbackParam": "callback",
                            "url": "http://localhost:7171/devices",
                            "headers": {
                                "Accept": "application/json, text/plain"
                                }
                        },
                            "statusText": ""
                    }
                    * */

                    console.log('devices', response.data);
                    //todo daicq fake
                    //  response.data = {success: true, data: {reader: null}};
                    //todo daicq fake END

                    if (response.data.success) {
                        // $scope.stateIdentity = 0;
                        $scope.socketReader = response.data.data.reader;
                        if(isShowPopupBuyMore){
                            if($scope.verify_number_available.verify_number_total > 0) {
                                $scope.showDialogNew('popupIdentification','buyNumberVerifyOrVerify');
                            } else {
                                $scope.showDialogNew('popupIdentification', 'buyNumberVerify');
                            }
                        } else {
                            $scope.stateIdentity = 0;
                            $scope.socketReader = response.data.data.reader;
                            $scope.checkCardPresent(response.data.data.reader, true);
                        }

                    } else {

                        $scope.getErrorIdentity(response.data.code, null);
                    }
                },
                function (error) {
                    //todo daicq fake
                    /* $scope.stateIdentity = 0;
                     if(isShowPopupBuyMore){
                        if($scope.verify_number_available.verify_number_total > 0) {
                            $scope.showDialogNew('popupIdentification','buyNumberVerifyOrVerify');
                        } else {
                            $scope.showDialogNew('popupIdentification', 'buyNumberVerify');
                        }
                        return;
                     } else {
                        $scope.checkCardPresent(null, true);
                        return;
                     }*/
                    //todo daicq fake END

                    console.log(error);
                    var code = -1;
                    if (error.data != null && error.data.code != null) {
                        code = error.data.code;
                    }
                    $scope.getErrorIdentity(code, null);
                });

         }, 1000);


            // else {
            //     console.log("Đã hết lượt xác thực");
            //     $scope.showDialogNew('popupIdentification', 'buyNumberVerify');
            // }

        // $scope.getTokenGenerate(function(){
        //     if($scope.tokenInfo.access_token != ""){
        //         $scope.generateVerifyId($scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token,notary_office);
        //
        //     }
        // });
    };



    /*
    * reader : string : thiết bị
    * isTimeout : true or false : chờ 5s check thẻ trên thiết bị, quá 5s chuyển báo lỗi
    * */
    $scope.checkCardPresent = function (reader, isTimeout) {

        //todo daicq fake
        // $scope.stateIdentity =2;
        /*$scope.getErrorIdentity(602, null, order_map_verification);
        return;*/
        //todo daicq fake END
        $scope.getTokenGenerateOSP().then(function(token) {
            return $scope.generateVerifyId(token.data.token_type + " " + token.data.access_token,notary_office);
        }).then(function (verification) {
            if (verification.status == 200 && verification.data != "") {
                $http.post(url + "/card/checkCardPresent", {reader: reader})
                    .then(function (response) {

                            console.log('checkCardPresent', response);

                            if (response.data.success) {
                                // $scope.stateIdentity = stateIdentity ? stateIdentity : 1;

                                /* start websocket */

                                _webSocket = new WebSocket(websocketUrl);

                                _webSocket.onopen = function () {
                                    console.log("Status: WebSocket Connected")
                                };

                                _webSocket.onmessage = function (event) {
                                    var call_api = false;
                                    $scope.webSocketData = JSON.parse(event.data);

                                    console.log('webSocketData', $scope.webSocketData.icaoResponse, $scope.webSocketData.verifyResponse);

                                    if ($scope.webSocketData.verifyResponse != null && $scope.webSocketData.verifyResponse != '') {
                                        if ($scope.webSocketData.verifyResponse.code == 0) {

                                            $scope.stateIdentity = 2;

                                        } else if ($scope.webSocketData.verifyResponse.code != 0) {
                                            $scope.getErrorIdentity($scope.webSocketData.verifyResponse.code, true, verification.data);
                                        }
                                    }

                                    if ($scope.webSocketData.icaoResponse != null && $scope.webSocketData.icaoResponse != '' && $scope.webSocketData.icaoResponse.code == 0) {
                                        $scope.closeWebSocket();
                                        call_api = true;
                                        $scope.stateIdentity = 3;
                                    }

                                    /* sét dữ liệu trong $scope có sự thay đổi */
                                    $scope.$apply();

                                    if (call_api) {
                                        minusVerrifyNumber();
                                        $scope.doneWebSocket($scope.webSocketData, verification.data);
                                    }

                                };

                                /* end websocket */

                            } else {

                                if (isTimeout) {
                                    $scope.getTokenGenerateOSP().then(function(token) {
                                        $scope.order_map_verification = {
                                            id: verification.data.id,
                                            order_id: verification.data.order_id,
                                            verify_id: verification.data.verify_id,
                                            verify_status: 0
                                        };
                                        $http.post(ospApiUrl + "/citizen-verifications/update-status-verification", $scope.order_map_verification, {headers: {'Authorization': token.data.token_type + " " + token.data.access_token}})
                                            .then(function (response) {
                                                    console.log('Cập nhật trạng thái sử dụng mã XT thành công', response.data.verify_id);
                                                    $timeout(function () {
                                                        $scope.checkCardPresent(reader, false);
                                                    }, 5 * 1000);
                                                },
                                                function (error) {
                                                    console.log('updateStatusVerification', error);
                                                });
                                    });

                                } else {
                                    $scope.getErrorIdentity(response.data.code, null);
                                }
                            }
                        },
                        function (error) {
                            //todo daicq fake
                            // $scope.stateIdentity = -1;
                            /*$scope.stateIdentity = stateIdentity ? stateIdentity : 1;
                            // error = {data: {code: 216}};
                            // return;
                            $scope.getErrorIdentity(226);
                            return;*/
                            //todo daicq fake END
                            console.log(error);
                            var code = null;
                            if (error.data != null && error.data.code != null) {
                                code = error.data.code;
                            }
                            $scope.getErrorIdentity(code, null);
                        });
            } else {
                console.log("Đã hết lượt xác thực");
                $scope.showDialogNew('popupIdentification', 'buyNumberVerify');
            }
        });
    };

    function minusVerrifyNumber() {
        $scope.verify_number_available.verify_number_total = Number($scope.verify_number_available.verify_number_total) - 1;
    };

    $scope.doneWebSocket = function (webSocketData, order_map_verification) {
        // lưu thông tin lượt xác thực danh tính thành công
        $scope.citizenInformation = {
            verify_id: order_map_verification.verify_id,
            notary_office_id: notary_office,
            province_code: "100",
            verify_date: new Date(),
            verify_by: update_by,
            verify_by_name: notary_officer,
            verify_status: "success",
            cccd_number: webSocketData.icaoResponse.data.dg13.idCardNo,
            cmnd_number: webSocketData.icaoResponse.data.dg13.oldIdCardNumber,
            full_name: webSocketData.icaoResponse.data.dg13.name,
            date_of_birth: webSocketData.icaoResponse.data.dg13.dateOfBirth,
            sex: webSocketData.icaoResponse.data.dg13.gender,
            country: webSocketData.icaoResponse.data.dg13.nationality,
            ethnic: webSocketData.icaoResponse.data.dg13.ethnic,
            hometown: webSocketData.icaoResponse.data.dg13.placeOfOrigin,
            permanent_address: webSocketData.icaoResponse.data.dg13.residenceAddress,
            date_issuance: webSocketData.icaoResponse.data.dg13.dateOfIssuance,
            date_expiration: webSocketData.icaoResponse.data.dg13.dateOfExpiry,
            identification_characteristics: webSocketData.icaoResponse.data.dg13.personalSpecificIdentification,
            avatar_img: webSocketData.icaoResponse.data.faceImage,
            verified_count: 1,
            citizen_info: JSON.stringify(webSocketData.icaoResponse.data),
            order_map_verification: order_map_verification
        };
        // reset token
        $scope.tokenInfo = {
            access_token: "",
            token_type: "Bearer",
            create_date: 0,
            expires_in: 0
        };
        $scope.getTokenGenerate(function(){
            if($scope.tokenInfo.access_token != ""){
                $scope.addCitizenInformation($scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token,$scope.citizenInformation);
            }
        });

        // lưu gợi ý tìm kiếm thông tin cá nhân trong chức năng soạn thảo văn bản
        var listProperty = [];
        $scope.persons = {
            template: 1,
            id: "",
            sex: webSocketData.icaoResponse.data.dg13.gender == 'Nam' ? "1" : "2", // {id: 1, name: "Ông"} : {id: 2, name: "Bà"},
            name: webSocketData.icaoResponse.data.dg13.name,
            birthday: webSocketData.icaoResponse.data.dg13.dateOfBirth,
            passport: webSocketData.icaoResponse.data.dg13.idCardNo,
            certification_date: webSocketData.icaoResponse.data.dg13.dateOfIssuance,
            certification_place: "Cục cảnh sát quản lý hành chính về trật tự xã hội",
            address: webSocketData.icaoResponse.data.dg13.placeOfOrigin,
            position: webSocketData.icaoResponse.data.dg13.residenceAddress,
            description: webSocketData.icaoResponse.data.dg13.personalSpecificIdentification,
            org_name: "",
            org_address: "",
            org_code: "",
            first_registed_date: "",
            number_change_registed: "",
            change_registed_date: "",
            department_issue: ""
        };

        listProperty.push($scope.persons);
        var listPersonAllJson = JSON.stringify(listProperty);
        console.log('listPersonAllJson', $scope.persons);

        $http.get(contextPath + "/contract/addPrivyFuncOnline", {
            params: {
                addData: listPersonAllJson,
                statusOnline: 0
            }
        })
            .then(function (response) {
                    console.log('addPrivyFuncOnline', response);
                },
                function (error) {
                    console.log('addPrivyFuncOnline', error);
                });
    };

    $scope.turnsVerifyCitizen = {
        unit_price: null,
        verify_number: 1,
        verify_fee: 0
    };

    $scope.error_unit_price = '';

    $scope.orderMapVerification = {
        order_id: "",
        verify_id: ""
    };

    $scope.generateVerifyId = function (authorization, notary_office_code){
        return $http.post(ospApiUrl + "/citizen-information/generate-verify-id", notary_office_code, {headers: {'Authorization': authorization}})
            .then(function (response) {
                    // $scope.orderMapVerification.order_id = response.data.order_id;
                    // $scope.orderMapVerification.verify_id = response.data.verify_id;
                    console.log('generateVerifyId', response.data);
                    return response;
                },
                function (error) {
                    console.log('generateVerifyId', error);
                    return error;
                });
    }


    $scope.addCitizenInformation = function (authorization, citizenInformation){
        var citizenInformationJson = JSON.parse(JSON.stringify(citizenInformation));
        console.log('listPersonAllJson', $scope.persons);
        $http.post(ospApiUrl + "/citizen-information", citizenInformationJson, {headers: {'Authorization': authorization}})
            .then(function (response) {
                    console.log('addCitizenInformation', response);
                    $scope.getVerifyNumberAvailable();
                },
                function (error) {
                    console.log('addCitizenInformation', error);
                });
    }

    $scope.handleTurnsVerify = function (plusOrMinus) {
        if(plusOrMinus == 'plus'){
            $scope.turnsVerifyCitizen.verify_number += 1;
        }else if(plusOrMinus == 'minus'){
            $scope.turnsVerifyCitizen.verify_number -= 1;
        }
        if($scope.turnsVerifyCitizen.verify_number > 99){
            $scope.turnsVerifyCitizen.verify_number = 99;
        }
        if($scope.turnsVerifyCitizen.unit_price > 0){
            $scope.turnsVerifyCitizen.verify_fee = ($scope.turnsVerifyCitizen.unit_price * $scope.turnsVerifyCitizen.verify_number);
        }
        $scope.countTotalPrice();
    }
    $scope.changeUnitPrice = function () {
        if($scope.turnsVerifyCitizen.verify_number >=1){
            $scope.turnsVerifyCitizen.verify_fee = ($scope.turnsVerifyCitizen.unit_price * $scope.turnsVerifyCitizen.verify_number);
        }
    };

    $scope.getVerifyNumberAvailable = function() {
        $http.get(ospApiUrl + "/citizen-verification-number/getByOfficeCode?office_code="+notary_office)
            .then(function (response) {
                    $scope.verify_number_available = response.data;
                },
                function (error) {
                    console.log('getVerifyNumberAvailable', error);
                });
    };
    $scope.getVerifyNumberAvailable();

    $scope.tokenInfo = {
        access_token: "",
        token_type: "Bearer",
        create_date: 0,
        expires_in: 0
    };
    $scope.formInputGenerateVietQR = {
        orderId: "",
        amount: "",
        genQRTransType: 1
    };

    $scope.resultCode = {
        status: "",
        message: "",
        data: {
            bankCode: "",
            bankName: "",
            bankAccount: "",
            userBankName: "",
            amount: "",
            content: "",
            qrCode: "",
            existing: 0,
            imgId: "",
            transactionId: "",
            imageQRCode: "",
            orderId: ""
        }
    };
    $scope.respPaymentTransaction = "";
    $scope.countTotalPrice = function(){
        $scope.turnsVerifyCitizen.unit_price = getNumberFromText($("#inputPrice").val());
        $scope.turnsVerifyCitizen.verify_fee = $scope.turnsVerifyCitizen.verify_number * $scope.turnsVerifyCitizen.unit_price;
        $("#totalPrice").text(formatNumberReturn($scope.turnsVerifyCitizen.verify_fee) + ' VNĐ');
    };
    $scope.checkValidateInputPrice = function() {
        $scope.error_unit_price = "";
        if($scope.turnsVerifyCitizen.unit_price % 10000 != 0){
            $scope.error_unit_price = "Vui lòng nhập đơn giá là bội số 10.000";
            return;
        }
        if($scope.turnsVerifyCitizen.unit_price < 20000){
            $scope.error_unit_price = "Vui lòng nhập đơn giá tối thiểu 20.000 VNĐ";
            return;
        }
        // if()
    };
    function setDisplayUnitPrice() {
        $("#inputPrice").val($scope.turnsVerifyCitizen.unit_price);
    }
    $scope.changeVerifyNumber = function() {
        validateVerifyNumber();
        $scope.countTotalPrice();
    };
    function validateVerifyNumber() {
        var input = $scope.turnsVerifyCitizen.verify_number;
        if(!input) $scope.turnsVerifyCitizen.verify_number = 1;
        // Kiểm tra nếu giá trị nhập vào không phải là số hoặc không có đúng 2 chữ số hoặc giá trị nhỏ hơn 1
        if (isNaN($scope.turnsVerifyCitizen.verify_number) || $scope.turnsVerifyCitizen.verify_number.length > 2 || parseInt($scope.turnsVerifyCitizen.verify_number) < 1) {
            $scope.turnsVerifyCitizen.verify_number = 1;
            return;
        }
        $scope.turnsVerifyCitizen.verify_number = Number($scope.turnsVerifyCitizen.verify_number);
    };
    $scope.changeUnitPrice = function() {
        $scope.turnsVerifyCitizen.unit_price = getNumberFromText($("#inputPrice").val());
        $scope.countTotalPrice();
        /*$scope.turnsVerifyCitizen.unit_price=  $("#inputPrice").val();
        var priceFormatted = formatNumberReturn($scope.turnsVerifyCitizen.unit_price);
        $scope.countTotalPrice();
        $("#inputPrice").val(priceFormatted);*/
        // $scope.turnsVerifyCitizen.unit_price = priceFormatted;
    };
    $scope.formatAmount = function(money) {
        return formatNumberReturn(money);
    }
    $scope.handlePaymentTurnsVerify = function () {

        if($scope.turnsVerifyCitizen.unit_price % 10000 != 0){
            $scope.error_unit_price = "Vui lòng nhập đơn giá là bội của 10.000";
            return;
        }
        if($scope.turnsVerifyCitizen.unit_price < 20000){
            $scope.error_unit_price = "Vui lòng nhập đơn giá tối thiểu là 20.000 VNĐ";
            return;
        }

        showHideLoadingIcon(true, "loadingQrCode");

        $scope.citizenVerifyOrder = {
            order_time: new Date(),
            verify_number: $scope.turnsVerifyCitizen.verify_number,
            verify_fee: $scope.turnsVerifyCitizen.verify_fee,
            notary_office_code: notary_office,
            province_code: province_code,
            transaction_status: "pending",
            notary_officer: notary_officer,
            update_by: update_by,
            update_by_name: update_by_name
        };

        var citizenVerifyOrderJson = JSON.parse(JSON.stringify($scope.citizenVerifyOrder));
        console.log('citizenVerifyOrderJson', $scope.citizenVerifyOrder);
        $http.post(ospApiUrl + "/citizen-verify-orders", citizenVerifyOrderJson)
            .then(function (response) {
                    console.log('addCitizenVerifyOrder', response.data);
                    // ham get token viet qr
                    $scope.responseTokenVietQR = "";
                    if(response.status == 200 && response.data.order_id != null){
                        $scope.responseTokenVietQR = $scope.getTokenGenerate(function(){
                            $scope.infoVietQRCode = "";
                            if($scope.tokenInfo.access_token != ""){
                                // ham tao ma qr code
                                $scope.formInputGenerateVietQR.orderId = response.data.order_id;
                                $scope.formInputGenerateVietQR.amount = response.data.verify_fee;
                                $scope.formInputGenerateVietQR.genQRTransType = 1;
                                $scope.infoVietQRCode = $scope.generateVietQRCode($scope.formInputGenerateVietQR);
                            }
                        });
                    }

                    /*if($scope.infoVietQRCode != ""){
                        $('#paymentTransaction').modal('show');
                        $('#buyNumberVerify').modal('hide');
                        // $scope.addPaymentTransaction($scope.infoVietQRCode);
                    }*/
                    // $scope.responsePaymentTransaction = "";
                    // if($scope.infoVietQRCode != "" && $scope.infoVietQRCode != undefined){
                    //     $scope.responsePaymentTransaction = $scope.addPaymentTransaction($scope.infoVietQRCode);
                    // }
                    // if($scope.responsePaymentTransaction.id != null && $scope.responsePaymentTransaction.id > 0){
                    //     $('#paymentTransaction').modal('show');
                    //     $('#buyNumberVerify').modal('hide');
                    // }
                },
                function (error) {
                    console.log('addCitizenVerifyOrder', error);
                });
    };

    function showHideLoadingIcon(isShow, idTag) {
        var loadingCircle = document.querySelector('#'+idTag);
        loadingCircle.style.display = isShow ? 'block' : 'none';
    }

    $scope.user_pass_authen = "G+y7Ltc/oRkXQ4UvR8qbHg==" + ":" + "wJ2/cuf4CJzSxKw//5hxgw==";
    $scope.user_pass_authen_base64 = 'Basic ' + btoa($scope.user_pass_authen);
    $scope.getTokenGenerate = function(callback){
        $http.post(ospApiUrl + "/payment/token_generate", null,
            {headers: {'Authorization': $scope.user_pass_authen_base64}})
            .then(function (response) {
                    console.log('token_generate', response.data);
                    $scope.tokenInfo.access_token = response.data.access_token;
                    $scope.tokenInfo.token_type = response.data.token_type;
                    $scope.tokenInfo.create_date = response.data.create_date;
                    $scope.tokenInfo.expires_in = response.data.expires_in;
                    callback();
                    return response;
                },
                function (error) {
                    console.log('token_generate', error);
                    return error;
                });
    };
    // $scope.getTokenGenerateOSP = function(){
    //     $http.post(ospApiUrl + "/payment/token_generate", null,
    //         {headers: {'Authorization': $scope.user_pass_authen_base64}})
    //         .then(function (response) {
    //                 return response;
    //             },
    //             function (error) {
    //                 console.log('token_generate', error);
    //                 return error;
    //             });
    // };
    $scope.getTokenGenerateOSP = function(){
        return $http.post(ospApiUrl + "/payment/token_generate", null,
            {headers: {'Authorization': $scope.user_pass_authen_base64}})
            .then(function (response) {
                    return response;
                },
                function (error) {
                    console.log('token_generate', error);
                    return error;
                });
    };

    var minutes = TIME_COUNTDOWN_MINUTE;
    var seconds = TIME_COUNTDOWN_SECOND;

    $scope.generateVietQRCode = function(formInputGenerateVietQR){
        $http.post(ospApiUrl + "/payment/generateVietQRCode", formInputGenerateVietQR ,
            {headers: {'Authorization': $scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token}})
            .then(function (response) {
                    $scope.addPaymentTransaction(response.data);
                    console.log('generateVietQRCode', response.data);
                    $scope.resultCode.status = response.data.status;
                    $scope.resultCode.message = response.data.message;
                    $scope.resultCode.data.bankCode = response.data.data.bankCode;
                    $scope.resultCode.data.bankName = response.data.data.bankName;
                    $scope.resultCode.data.bankAccount = response.data.data.bankAccount;
                    $scope.resultCode.data.userBankName = response.data.data.userBankName;
                    $scope.resultCode.data.amount = response.data.data.amount;
                    $scope.resultCode.data.content = response.data.data.content;
                    $scope.resultCode.data.qrCode = response.data.data.qrCode;
                    $scope.resultCode.data.existing = response.data.data.existing;
                    $scope.resultCode.data.imgId = response.data.data.imgId;
                    $scope.resultCode.data.transactionId = response.data.data.transactionId;
                    $scope.resultCode.data.imageQRCode = response.data.data.imageQRCode;
                    $scope.resultCode.data.orderId = response.data.data.orderId;

                    $scope.infoVietQRCode = response;
                    if($scope.infoVietQRCode != ""){
                        showHideLoadingIcon(false, "loadingQrCode");
                        displayQRCodeFromBarCode($scope.resultCode.data.qrCode);
                        $('#paymentTransaction').modal('show');
                        $('#buyNumberVerify').modal('hide');
                        $('#showPaymentTransactionError').modal('hide');
                        minutes = TIME_COUNTDOWN_MINUTE;
                        seconds = TIME_COUNTDOWN_SECOND;
                        countdownPaymentTime(minutes, seconds);
                        checkStatusAgain($scope.resultCode.data.orderId);

                    }

                    return response;
                },
                function (error) {
                    console.log('generateVietQRCode', error);
                    return error;
                });
    };

    function displayQRCodeFromBarCode(qrCodeData) {
        // Create QRious instance
        var qr = new QRious({
            element: document.getElementById("qrcode-canvas"),
            value: qrCodeData,
            size: 200
        });
    }

    var timer; // Khai báo biến timer ở mức độ toàn cục

    function countdownPaymentTime(minutes, seconds) {
        // Bắt đầu đếm ngược sau mỗi giây
        timer = setInterval(function() {
            countdown("timeoutToPayment");
        }, 1000);
    }

// Định nghĩa hàm đếm ngược
    function countdown(idTagToShow) {
        // Hiển thị thời gian đếm ngược
        // console.log(minutes + " phút " + seconds + " giây");

        // Giảm số giây đi 1
        seconds--;

        // Nếu số giây âm, giảm số phút đi 1 và đặt lại số giây thành 59
        if (seconds < 0) {
            minutes--;
            seconds = 59;
        }
        $("#" + idTagToShow).html((minutes < 10 ? '0' +  minutes : minutes) + ":" + (seconds < 10 ? '0' + seconds : seconds));
        // Kiểm tra nếu đã đếm ngược xong
        if (minutes === 0 && seconds === 0) {
            //$scope.clearTurnsVerifyCitizen();
            // show màn hìn thanh toán thất bại
            $('#showPaymentTransactionError').modal('show');
            $('#paymentTransaction').modal('hide');
            console.log("Đếm ngược kết thúc");
            clearInterval(timer);
        }
    }

    $scope.addPaymentTransaction = function(infoVietQRCode){
        $scope.paymentTransaction = {
            order_id: infoVietQRCode.data.orderId,
            bank_account: infoVietQRCode.data.bankAccount,
            amount: infoVietQRCode.data.amount,
            content: infoVietQRCode.data.content,
            trans_type: "C",
            transaction_status: "pending"
        };
        var paymentTransactionJson = JSON.parse(JSON.stringify($scope.paymentTransaction));
        $http.post(ospApiUrl + "/payment/addPaymentTransaction",paymentTransactionJson,
            {headers: {'Authorization': $scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token}})
            .then(function (response) {
                    console.log('addPaymentTransaction', response.data);
                    // $scope.respPaymentTransaction = response.data;
                    // if($scope.respPaymentTransaction != undefined && $scope.respPaymentTransaction != ""){
                    //     if($scope.respPaymentTransaction.id != null && $scope.respPaymentTransaction.id > 0) {
                    //         $('#paymentTransaction').modal('show');
                    //         $('#buyNumberVerify').modal('hide');
                    //     }
                    // }
                },
                function (error) {
                    console.log('addPaymentTransaction', error);
                });
    };

    var secondsRedirect = 5;
    var timerRedirect;

    function countdownRedirect() {
        // Bắt đầu đếm ngược sau mỗi giây
        timerRedirect = setInterval(function() {
            countdown2("timeCountdown");
        }, 1000);
    }

// Định nghĩa hàm đếm ngược
    function countdown2(idTagToShow) {
        // $("#" + idTagToShow).html(secondsRedirect);
        // Giảm số giây đi 1
        secondsRedirect--;
        $("#" + idTagToShow).html(secondsRedirect + ' giây');
        // Kiểm tra nếu đã đếm ngược xong
        if (secondsRedirect == 0) {
            // điều hướng đến trang sẵn sàng quét CCCD
            $scope.devices(false, true);
            $('#popupIdentification').modal('show');
            $('#showPaymentTransactionSuccess').modal('hide');
            clearInterval(timerRedirect);
        }
    }
    var timercheckStatusAgain;
    function checkStatusAgain(order_id) {
        // Bắt đầu đếm ngược sau mỗi phút
        timercheckStatusAgain = setInterval(function () {
            if($('#paymentTransaction').is(':visible') == true) {
                $scope.checkOrderOfTransaction(order_id);
            }else {
                clearInterval(timercheckStatusAgain);
            }
            }, 60000);
    }

    $scope.checkOrderOfTransaction = function(order_id) {
        $scope.getTokenGenerateOSP().then(function(token) {
            $http.post(ospApiUrl + "/payment/transactions/check-order-status",order_id,
                {headers: {'Authorization': token.data.token_type + " " + token.data.access_token}})
                .then(function (response) {
                       if(response.data.id != null){
                           if(response.data.transaction_status == 'success'){
                               clearInterval(timercheckStatusAgain);
                               // Kiểm tra xem modal có đang hiển thị hay không
                               if($('#paymentTransaction').is(':visible') == true){
                                   $('#showPaymentTransactionSuccess').modal('show');
                                   $('#paymentTransaction').modal('hide');
                                   secondsRedirect = 5;
                                   $("#timeCountdown").html(secondsRedirect + ' giây');
                                   countdownRedirect();
                               }else {
                                   //$scope.clearTurnsVerifyCitizen();
                               }
                           }else if(response.data.transaction_status == 'fail'){
                               clearInterval(timercheckStatusAgain);
                               if($('#paymentTransaction').is(':visible') == true) {
                                   $('#showPaymentTransactionError').modal('show');
                                   $('#paymentTransaction').modal('hide');
                               }else {
                                   //$scope.clearTurnsVerifyCitizen();
                               }
                           }
                       }
                    },
                    function (error) {
                        console.log('check-order-status', error);
                    });
        });
    }

    // $scope.checkOrderOfTransaction = function() {
    //     clearInterval(timer);
    //     $scope.formInputCheckOrderOfTransaction = {
    //         bankAccount: $scope.resultCode.data.bankAccount,
    //         orderId: $scope.resultCode.data.orderId
    //     }
    //     var inputJson = JSON.parse(JSON.stringify($scope.formInputCheckOrderOfTransaction));
    //     // reset token
    //     $scope.tokenInfo = {
    //         access_token: "",
    //         token_type: "Bearer",
    //         create_date: 0,
    //         expires_in: 0
    //     };
    //     $scope.responseTokenVietQR = $scope.getTokenGenerate(function(){
    //         if($scope.tokenInfo.access_token != ""){
    //             // ham check order id
    //             $scope.checkOrder($scope.tokenInfo.token_type + " " + $scope.tokenInfo.access_token,inputJson);
    //         }
    //     });
    //
    //
    // }
    // $scope.checkOrder = function(authorization,inputJson){
    //     $http.post(ospApiUrl + "/payment/transactions/check-order",inputJson,
    //         {headers: {'Authorization': authorization}})
    //         .then(function (response) {
    //                 console.log('checkOrderOfTransaction success', response.data);
    //                 response.data.data[0].status == 1;
    //                 if(response.data.status == '200'
    //                     // && response.data.data[0].status == 1
    //                 ){
    //                     $('#showPaymentTransactionSuccess').modal('show');
    //                     $('#paymentTransaction').modal('hide');
    //                     secondsRedirect = 5;
    //                     $("#timeCountdown").html(secondsRedirect + ' giây');
    //                     countdownRedirect();
    //                 }
    //             },
    //             function (error) {
    //                 console.log('checkOrderOfTransaction error', error);
    //                 error.data.status = 'OK';
    //                 $('#showPaymentTransactionError').modal('show');
    //                 $('#paymentTransaction').modal('hide');
    //             });
    // }



    $scope.showDialogNew = function(dialog_hide, dialog_show, isNoResetPurchaseInfo){
        if(dialog_show === 'buyNumberVerify' && !$scope.isKeepPreBuyInfo) {
            resetPurcharseInfo();
        }
        $('#' + dialog_show).modal('show');
        $('#' + dialog_hide).modal('hide');
    }

    function resetPurcharseInfo() {
        $scope.turnsVerifyCitizen = {
            unit_price: null,
            verify_number: 1,
            verify_fee: 0
        };
        $("#inputPrice").val(null);
        $("#verifyNumber").val(1);
        $scope.countTotalPrice();
    }

    $scope.showDlgBuyNumberVerify = function(isKeepPrevInfo, otherPopupIsClosed) {
        if(isKeepPrevInfo) $scope.isKeepPreBuyInfo = true;
        if(otherPopupIsClosed) {
            $("#"+otherPopupIsClosed).modal('hide');
        }
        $scope.showDialogNew('showPaymentTransactionError', 'buyNumberVerify');
        if(!isKeepPrevInfo || !$scope.isKeepPreBuyInfo){
            resetPurcharseInfo();
        }
    }

    $scope.ClosePopupPurchase = function(isResetPreBuyInfo) {
        $("#paymentTransaction").modal('hide');
        $("#confirmClosePopupPurchase").modal('hide');
        $("#buyNumberVerify").modal('hide');
        if(isResetPreBuyInfo) {
            $scope.isKeepPreBuyInfo = false;
            resetPurcharseInfo();
        } else $scope.isKeepPreBuyInfo = true;
    }

    $scope.closeCitizenVerifyPopup = function() {
        $("#popupIdentification").modal('hide');
        $("#confirmClosePopupVerify").modal('hide');
        $scope.closeWebSocket();
    }
    $scope.clearTurnsVerifyCitizen = function () {
        $scope.turnsVerifyCitizen = {
            unit_price: null,
            verify_number: 1,
            verify_fee: 0
        };
    }
}]);


