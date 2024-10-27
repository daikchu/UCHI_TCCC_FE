

var socket;
var flagFistTime = 1;
var flagTimeOut = 0;
var wsTimeout;
var mapRequestID = new Map();

var isSecure = 'http';
var ip = '127.0.0.1';
var port = 9505;

// var url = isSecure + "://" + ip + ":" + port + "/ISPlugin";
var url = "127.0.0.1:9505/ISPlugin";
var websocketUrl = 'wss://127.0.0.1:9505/ISPlugin';
socket = new WebSocket(websocketUrl);

function shutdown() {
    flagTimeOut = 1;
    socket.close(1000, "work complete");
}


socket.onopen = function (event, cbConnected) {
    console.log("socket open");
    clearTimeout(wsTimeout);
    flagFistTime = 1;
    // cbConnected();
};
socket.onclose = function (event, cbDisconnected, cbStopped) {
    console.log('Closed ' + event.code);

    if (flagTimeOut === 0) {
        console.log("reconnect!!!");
        if (flagFistTime === 1) {
            flagFistTime = 0;
            cbDisconnected();
            wsTimeout = setTimeout(timeoutWS, 30000);

            function timeoutWS() {
                if (socket.readyState !== 1) {
                    flagTimeOut = 1;
                    console.log("connect failure!");
                    clearTimeout(wsTimeout);
                    flagFistTime = 1;
                    cbStopped();
                    socket.close(1000, "Connect failure");
                }
            }
        }

        /*new ISPluginClient(
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
        );*/
    }
};

socket.onmessage = function (event, cbConnectionDenied,
                             cbReceive, cbReceivedDocument, cbReceivedCardDetecionEvent,
                             cbReceivedBiometricAuth) {
    console.log("onmessage");
    var response = {};
    console.log(event);
    response = JSON.parse(event.data);
    console.log("response", response);

    debugger;
    if (!response) {
        console.log("Skip Response because response is null");
    } else {
        var cmd = response.cmdType;
        var id = response.requestID;
        var error = response.errorCode;
        var errorMsg = response.errorMessage;
        var data = response.data;

        if (!cmd) {
            console.log("Skip Response because cmdType is null");
            if (error && error === 1008) {
                cbConnectionDenied(errorMsg);
            }
        } else {
            if (cbReceive) {
                console.log("onmessage cbReceive === ", response);
                cbReceive(cmd, id, error, data);
            }
            if (cmd === "SendInfoDetails") {
                console.log("onmessage SendInfoDetails === ", response);
                getBiometricEvidence("faceID", 0,cbSuccess, cbError, cbTimeout );
                // cbReceivedDocument(response);
            } else if (cmd === "CardDetectionEvent") {
                console.log("onmessage CardDetectionEvent === ", response);
                cbReceivedCardDetecionEvent(response);
            } else if (cmd === "BiometricEvidence") {
                console.log("onmessage BiometricEvidence === ", response);
                // getFullBiometricFaceIdData(response);
                // displayAuthenedInformation(response);
                testBiometricAuthentication(response);
            }
            else if (cmd === "SendBiometricAuthentication") {
                console.log("onmessage SendBiometricAuthentication === ", response);
                getBiometricEvidence("faceID", 0,cbSuccess, cbError, cbTimeout );
                // cbReceivedBiometricAuth(response);
            } else if (mapRequestID.has(id)) {
                var req = mapRequestID.get(id);
                mapRequestID.delete(id);
                console.log("dzo dau na");
                if (!req) {
                } else if (req.cmdType !== cmd) {
                    //error if != cmdType
                    req.cb_error(
                        -1,
                        "cmdType does not match, got [" +
                        cmd +
                        "] but expect [" +
                        req.cmdType +
                        "]"
                    );
                } else if (error === 0) {
                    //success
                    if (req.cmdType === "BiometricAuthentication") {
                        console.log("dzo BiometricAuthentication");
                        req.cb_success(response);
                    } else {
                        console.log("dzo dong 114");
                        req.cb_success(data);
                    }
                } else {
                    //error
                    req.cb_error(error, errorMsg);
                }
            } else {
                console.log(
                    "Skip Response because not found requestID [" + id + "]"
                );
            }
        }
    }
};

function cbReceivedDocument(){
    getBiometricEvidence("faceID", 0,cbSuccess, cbError, cbTimeout );
}
function getFullBiometricFaceIdData(data) {
    var mapRequestID = {
        cmdType: "GetInfoDetails",
        cb_success: cbSuccess,
        cb_error: cbError,
        requestID: data.requestID
    };
    socket.send(
        JSON.stringify({
            cmdType: "GetInfoDetails",
            requestID: data.requestID,
            timeOutInterval: cbTimeout(data),
            data: {
                mrzEnabled: true,
                imageEnabled: true,
                dataGroupEnabled: true,
                optionalDetailsEnabled: true,
                canValue: '000956',
                challenge: '',
                caEnabled: true,
                taEnabled: true,
                paEnabled: true,
            },
        })
    );
}

function displayAuthenedInformation(data) {
    socket.send(
        JSON.stringify({
            cmdType: "DisplayInformation",
            requestID: data.requestID,
            timeOutInterval: cbTimeout(data),
            data: {
                title: "title",
                type: "TEXT",
                value: "value",
            },
        })
    );
}

function testBiometricAuthentication(data) {
    socket.send(
        JSON.stringify({
            cmdType: "BiometricAuthentication",
            requestID: data.requestID,
            timeOutInterval: cbTimeout(data),
            data: {
                biometricType: "faceID",
                cardNo: "040095000956",
                livenessEnabled: true,
                challengeType: "object",
                challenge: null,
                biometricEvidenceEnabled: true
            },
        })
    );
}

function cbSuccess(event) {
    console.log("success ========= ", event);
}
function cbError(event){
    console.log("error ========= ", event);
}
function cbTimeout(event){
    console.log("timeout ========= ", event);
}
/*function create_uuidv41() {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, (c) =>
        (
            c ^
            (crypto.getRandomValues(new Uint8Array(1))[0] & (15 >> (c / 4)))
        ).toString(16)
    );
    return "";
}*/

function create_uuidv4() {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, function (c) {
        return (
            c ^ (crypto.getRandomValues(new Uint8Array(1))[0] & (15 >> (c / 4)))
        ).toString(16);
    });
}

function getDeviceDetails(
    deviceDetailsEnabled,
    presenceEnabled,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "GetDeviceDetails",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "GetDeviceDetails",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                deviceDetailsEnabled: deviceDetailsEnabled,
                presenceEnabled: presenceEnabled,
            },
        })
    );

    var getDeviceDetailsTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout(); //callback when time out
        }
    }, timeOutInterval * 1000);
};

// = getInformationDetails old
function getDocumentDetails(
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
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "GetInfoDetails",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "GetInfoDetails",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
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
        })
    );

    var getDocumentDetailsTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function biometricAuthentication(
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
    var requestID = create_uuidv4();
    console.log("bat dau biometricAuthentication");
    mapRequestID.set(requestID, {
        cmdType: "BiometricAuthentication",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "BiometricAuthentication",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                biometricType: biometricType,
                cardNo: cardNo,
                livenessEnabled: livenessEnabled,
                challengeType: challengeType,
                challenge: challengeBiometric,
            },
        })
    );

    var biometricAuthenticationTimeOut = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
    console.log("biometricAuthentication ket thuc");
}

function connectToDevice(
    confirmEnabled,
    confirmCode,
    clientName,
    automaticEnabled,
    mrzEnabled,
    imageEnabled,
    dataGroupEnabled,
    optionalDetailsEnabled,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "ConnectToDevice",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "ConnectToDevice",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                clientName: clientName,
                confirmEnabled: confirmEnabled,
                confirmCode: confirmCode,
                configuration: {
                    automaticEnabled: automaticEnabled,
                    mrzEnabled: mrzEnabled,
                    imageEnabled: imageEnabled,
                    dataGroupEnabled: dataGroupEnabled,
                    optionalDetailsEnabled: optionalDetailsEnabled,
                },
            },
        })
    );

    var connectToDeviceTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function displayInformation(
    title,
    type,
    value,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "DisplayInformation",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "DisplayInformation",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                title: title,
                type: type,
                value: value,
            },
        })
    );
    var displayInformationTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function refreshReader(
    deviceDetailsEnabled,
    presenceEnabled,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "Refresh",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "Refresh",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                deviceDetailsEnabled: deviceDetailsEnabled,
                presenceEnabled: presenceEnabled,
            },
        })
    );

    var refreshReaderTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function scanDocument(
    scanType,
    saveEnabled,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "ScanDocument",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "ScanDocument",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                scanType: scanType,
                saveEnabled: saveEnabled,
            },
        })
    );

    var scanDocumentTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function getBiometricEvidence(
    biometricType,
    timeOutInterval,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "BiometricEvidence",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    socket.send(
        JSON.stringify({
            cmdType: "BiometricEvidence",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            data: {
                biometricType: biometricType,
            },
        })
    );

    var biometricEvidenceTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function getTokenCertificate(
    timeOutInterval,
    dllNameList,
    currentDomain,
    lang,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "GetTokenCertificates",
        cb_success: cbSuccess,
        cb_error: cbError,
    });

    socket.send(
        JSON.stringify({
            cmdType: "GetTokenCertificates",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            lang: lang,
            data: {
                // dllNames: ["cmcca_csp11_v1", "eps2003csp11"],
                dllNames: dllNameList,
                currentDomain: currentDomain,
            },
        })
    );

    var getTokenCertificateTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);
}

function signTokenCertificate(
    certId,
    certPin,
    signObjects,
    timeOutInterval,
    lang,
    cbSuccess,
    cbError,
    cbTimeout
) {
    var requestID = create_uuidv4();
    mapRequestID.set(requestID, {
        cmdType: "SignTokenCertificate",
        cb_success: cbSuccess,
        cb_error: cbError,
    });
    connectorLogRequest.pURL = "SignTokenCertificate";
    connectorLogRequest.pREQUEST = JSON.stringify({
        cmdType: "SignTokenCertificate",
        requestID: requestID,
        timeOutInterval: timeOutInterval,
        lang: lang,
        data: {
            certId: certId,
            certPin: certPin,
            currentDomain: "id.mobile-id.vn",
            signObjects: signObjects,
        },
    });
    socket.send(
        JSON.stringify({
            cmdType: "SignTokenCertificate",
            requestID: requestID,
            timeOutInterval: timeOutInterval,
            lang: lang,
            data: {
                certId: certId,
                certPin: certPin,
                currentDomain: "id.mobile-id.vn",
                signObjects: signObjects,
            },
        })
    );
    var signTokenCertificateTimeout = setTimeout(function () {
        if (mapRequestID.has(requestID)) {
            mapRequestID.delete(requestID);
            cbTimeout();
        }
    }, timeOutInterval * 1000);


}