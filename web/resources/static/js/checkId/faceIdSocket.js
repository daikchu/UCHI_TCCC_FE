var socket;
var flagFistTime = 1;
var flagTimeOut = 0;
var wsTimeout;
var mapRequestID = new Map();
var isReConnectAfterClosed = false;
function ISPluginClient(
    ip,
    port,
    isSecure,
    cbReceivedDocument,
    cbReceivedBiometricAuth,
    cbReceivedCardDetecionEvent,
    cbConnected,
    cbDisconnected,
    cbStopped,
    cbConnectionDenied,
    cbReceive
) {
    var url = isSecure + "://" + ip + ":" + port + "/ISPlugin";
    // socket = new WebSocket(url);
    if (socket && socket.readyState !== socket.CLOSED) {
        isReConnectAfterClosed = true;
        shutdown();
    } else {
        socket = new WebSocket(url);
    }

    function create_uuidv4() {
        return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, function (c) {
            return (
                c ^
                (crypto.getRandomValues(new Uint8Array(1))[0] & (15 >> (c / 4)))
            ).toString(16);
        });
    }

    function shutdown() {
        flagTimeOut = 1;
        if(socket.readyState !== WebSocket.CLOSED) {
            socket.close(1000, "work complete");
        }
    }

    socket.onopen = function () {
        console.log("faceIdSocket socket open");
        clearTimeout(wsTimeout);
        flagFistTime = 1;
        cbConnected();
    };

    socket.onclose = function (event) {
        console.log("faceIdSocket Closed " + event.code);
        // socket = new WebSocket(url);
        if(isReConnectAfterClosed) {
            ISPluginClient(
                ip,
                port,
                isSecure,
                cbReceivedDocument,
                cbReceivedBiometricAuth,
                cbReceivedCardDetecionEvent,
                cbConnected,
                cbDisconnected,
                cbStopped,
                cbConnectionDenied,
                cbReceive
            );
            isReConnectAfterClosed = false;
        }

        /*if (flagTimeOut === 0) {
            console.log("reconnect!!!");
            if (flagFistTime === 1) {
                flagFistTime = 0;
                cbDisconnected();
                wsTimeout = setTimeout(function timeoutWS() {
                    if (socket.readyState !== 1) {
                        flagTimeOut = 1;
                        console.log("connect failure!");
                        clearTimeout(wsTimeout);
                        flagFistTime = 1;
                        cbStopped();
                        socket.close(1000, "Connect failure");
                    }
                }, 30000);
            }

            ISPluginClient(
                ip,
                port,
                isSecure,
                cbReceivedDocument,
                cbReceivedBiometricAuth,
                cbReceivedCardDetecionEvent,
                cbConnected,
                cbDisconnected,
                cbStopped,
                cbConnectionDenied,
                cbReceive
            );
        }*/
    };

    socket.onmessage = function (event) {
        console.log("faceIdSocket onmessage event: ",event);
        var response = JSON.parse(event.data);
        if (!response) {
            console.log("faceIdSocket Skip Response because response is null");
            return;
        }

        var cmd = response.cmdType;
        var id = response.requestID;
        var error = response.errorCode;
        var errorMsg = response.errorMessage;
        var data = response.data;

        if (!cmd) {
            console.log("faceIdSocket Skip Response because cmdType is null");
            if (error && error === 1008) {
                cbConnectionDenied(errorMsg);
            }
        } else {
            if (cbReceive) {
                cbReceive(cmd, id, error, data);
            }
            handleCommand(cmd, id, error, errorMsg, data, response);
        }
    };

    function handleCommand(cmd, id, error, errorMsg, data, response) {
        if (cmd === "SendInfoDetails") {
            console.log("faceIdSocket onmessage SendInfoDetails === ", response);
            cbReceivedDocument(response);
        } else if (cmd === "CardDetectionEvent") {
            console.log("faceIdSocket onmessage CardDetectionEvent === ", response);
            cbReceivedCardDetecionEvent(response);
        } else if (cmd === "SendBiometricAuthentication") {
            console.log("faceIdSocket onmessage SendBiometricAuthentication === ", response);
            cbReceivedBiometricAuth(response);
        } else if (mapRequestID.has(id)) {
            var req = mapRequestID.get(id);
            mapRequestID.delete(id);

            if (!req) return;

            if (req.cmdType !== cmd) {
                req.cb_error(-1, "cmdType does not match, got [" + cmd + "] but expect [" + req.cmdType + "]");
            } else if (error === 0) {
                if (req.cmdType === "BiometricAuthentication") {
                    req.cb_success(response);
                } else {
                    req.cb_success(data);
                }
            } else {
                req.cb_error(error, errorMsg);
            }
        } else {
            console.log("faceIdSocket Skip Response because not found requestID [" + id + "]");
        }
    }

    function sendCommand(cmdType, data, timeOutInterval, cbSuccess, cbError, cbTimeout) {
        var requestID = create_uuidv4();
        mapRequestID.set(requestID, { cmdType: cmdType, cb_success: cbSuccess, cb_error: cbError });

        socket.send(
            JSON.stringify({
                cmdType: cmdType,
                requestID: requestID,
                timeOutInterval: timeOutInterval,
                data: data,
            })
        );

        setTimeout(function () {
            if (mapRequestID.has(requestID)) {
                mapRequestID.delete(requestID);
                cbTimeout();
            }
        }, timeOutInterval * 1000);
    }

    return {
        getDeviceDetails: function (deviceDetailsEnabled, presenceEnabled, timeOutInterval, cbSuccess, cbError, cbTimeout) {
            sendCommand(
                "GetDeviceDetails",
                { deviceDetailsEnabled: deviceDetailsEnabled, presenceEnabled: presenceEnabled },
                timeOutInterval,
                cbSuccess,
                cbError,
                cbTimeout
            );
        },
        getDocumentDetails: function (
            mrzEnabled,
            imageEnabled,
            dataGroupEnabled,
            optionalDetailsEnabled,
            canValue,
            challenge,
            caEnabled,
            taEnabled,
            paEnabled,
            timeOutInterval,
            cbSuccess,
            cbError,
            cbTimeout
        ) {
            sendCommand(
                "GetInfoDetails",
                {
                    mrzEnabled: mrzEnabled,
                    imageEnabled: imageEnabled,
                    dataGroupEnabled: dataGroupEnabled,
                    optionalDetailsEnabled: optionalDetailsEnabled,
                    canValue: canValue,
                    challenge: challenge,
                    caEnabled: caEnabled,
                    taEnabled: taEnabled,
                    paEnabled: paEnabled,
                },
                timeOutInterval,
                cbSuccess,
                cbError,
                cbTimeout
            );
        },
        biometricAuthentication: function (
            biometricType,
            challengeBiometric,
            challengeType,
            livenessEnabled,
            cardNo,
            timeOutInterval,
            cbSuccess,
            cbError,
            cbTimeout
        ) {
            sendCommand(
                "BiometricAuthentication",
                {
                    biometricType: biometricType,
                    cardNo: cardNo,
                    livenessEnabled: livenessEnabled,
                    challengeType: challengeType,
                    challenge: challengeBiometric,
                },
                timeOutInterval,
                cbSuccess,
                cbError,
                cbTimeout
            );
        },
        shutdown: shutdown,
    };
}
