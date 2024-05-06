myApp.controller('certAddController', ['$scope', '$http', '$filter', '$window', '$timeout', '$q', 'fileUpload', function ($scope, $http, $filter, $window, $timeout, $q, fileUpload) {
    $scope.cert = {
        id: "",
        cert_number: "",
        cert_date: "",
        cert_request_user: "",
        cert_request_doc: "",
        cert_sign_user: "",
        cert_doc_number: "",
        entry_user_id: "",
        cert_fee: "",
        note: "",
        attestation_template_code: "",
        kind_html: "",
        notary_book:"",
        attestation_template_code_parent: "000",
        convert_cert_date: "",

    };
    $scope.certNumber = {
        kind_id:"",
        cert_number:""
    };
    $scope.listAttestationTempParent = [];
    $scope.listAttestationTemp = [];
    $scope.attestationTempParrent = "";
    $scope.attestationTemp = "";
    $scope.userId = $scope.cert.entry_user_id;
    $scope.submitForm=function() {
        $('#kind_html').val($('#contentKindHtml').html());

        $('#notary_book').val($scope.cert.notary_book);
        $('#formAdd').submit();
    };

    /* function submitForm() {
         $('#kind_html').val($('#contentKindHtml').html());
         $('#notary_book').val($scope.cert.notary_book);
         $('#formAdd').submit();
     }*/


    $scope.typingCertNumber = function () {
        var cert_number = $('#cert_number').val();
        $scope.cert.cert_number = cert_number;
    };

    $scope.getCertFee = function () {
        var type = '${type}';
        var typeFee = '${Constants.FEE_CERT_CHU_KY}';
        if (type == '${Constants.CERTIFICATE_TYPE_SIGNATURE}') typeFee = '${Constants.FEE_CERT_CHU_KY}';
        else if (type == '${Constants.CERTIFICATE_TYPE_COPY}') typeFee = '${Constants.FEE_CERT_BAN_SAO}';
        var soBan = $('#cert_doc_number').val();
        if (isNullOrEmpty(soBan)) soBan = 1;
        $http.get(contextPath + "/certificate/suggestCertFee", {
            params: {
                type: typeFee,
                soBan: soBan
            }
        })
            .then(function (response) {
                $scope.certFee = response.data;
                console.log("cong thuc" + $scope.certFee.formula_fee);
                // $scope.contract.cost_tt91 = $scope.certFee.notaryFeeNumber;
                $('#cert_fee').val($scope.certFee.feeNumber);
                //tinh lai phi tong
                //    $scope.calculateTotal();
                /*if ($scope.certFee.circulars_fee == null || $scope.certFee.circulars_fee == '') {

                } else {
                    $scope.announcement.certFee = "Căn cứ: " + $scope.certFee.circulars_fee;
                    $("#fee-status").show();
                    setTimeout(function () {
                        $("#fee-status").hide();
                    }, 5000);

                }*/
            });

    };

    $scope.getCertFee();

    $http.get(url + '/api-attestation/search', {
        params: {
            parent_code: '000'
        }
    }).then(function (response) {
        $scope.listAttestationTempParent = response.data;
        /*$scope.tooltip();*/
    });

    $scope.changeTemplateParent = function (parent_code) {
        $scope.listAttestationTemp = [];
        if (parent_code == '' || parent_code == '000') {
            $scope.cert.kind_html = '';
            /*CKEDITOR.instances.editor.setData('');*/
            $("#contentKindHtml").html('');
            $('#kind_html').val('');
            $('#attestation_template_code').val('');
            return;
        }
        //     $scope.changeTemplate(parent_code);
        $http.get(url + "/api-attestation/search", {params: {code: parent_code}})
            .then(function (response) {
                var templates = response.data;
                if (templates != null && templates.length > 0) {
                    var template = templates[0];
                    $scope.cert.kind_html = template.kind_html;
                    //   CKEDITOR.instances.editor.setData(template.kind_html);
                    $('#kind_html').val(template.kind_html);
                    $("#contentKindHtml").html(template.kind_html);
                    $('#attestation_template_code').val(template.code);
                    $scope.attestationTempParrent = template;
                }

            });

        $http.get(url + "/api-attestation/search", {params: {parent_code: parent_code}})
            .then(function (response) {
                $scope.listAttestationTemp = response.data;
                if ($scope.listAttestationTemp == null || $scope.listAttestationTemp.length == 0) {
                    $scope.cert.attestation_template_code = $scope.cert.attestation_template_code_parent;
                    //     $scope.changeTemplate($scope.cert.attestation_template_code);
                }

            });
    };

    $scope.changeTemplate = function (code) {
        if (isNullOrEmpty(code) || code == '000') {
            $('#kind_html').val($scope.attestationTempParrent.kind_html);
            $("#contentKindHtml").html($scope.attestationTempParrent.kind_html);
            return;
        }
        $http.get(url + "/api-attestation/search", {params: {code: code}})
            .then(function (response) {
                var templates = response.data;

                if (templates != null && templates.length > 0) {
                    var template = templates[0];
                    $scope.cert.kind_html = template.kind_html;
                    //   CKEDITOR.instances.editor.setData(template.kind_html);
                    $('#kind_html').val(template.kind_html);
                    $("#contentKindHtml").html(template.kind_html);
                    $('#attestation_template_code').val(template.code);
                }

            });

    };

    /*$scope.listCertTemplatefieldMap = [];

    getListCertTemplateFieldMap();
    function getListCertTemplateFieldMap() {
        $http.get(url + '/certificate/getListCertTemplateFieldMap').then(function (response) {
            $scope.listCertTemplatefieldMap = response.data;
            $scope.tooltip();
        })
    }*/

    $scope.changeCertDate = function (value) {
        if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
            var dateArray = value.split("/");
            var date = dateArray[0];
            var month = dateArray[1];
            var year = dateArray[2];
            $scope.cert.cert_date_date = date;
            $scope.cert.cert_date_month = month;
            $scope.cert.cert_date_year = year;
            var ngay = $scope.cert.cert_date_date + "/" + $scope.cert.cert_date_month + "/" + $scope.cert.cert_date_year;
            $scope.cert.convert_cert_date = docngaythang(ngay);

        }
    }

    /*danh sách sổ công chứng*/
    $http.get(url + "/notaryBook/getAllNotaryBook")
        .then(function (response) {
            $scope.notaryBook = response.data;
        });
    /* Lấy gợi ý sổ công chứng - chứng thực  , {params: {year: now.getFullYear(), userId: userEntryId}} , {params: {year: now.getFullYear(), userId: 0}}*/
    if (type == 1) {
        $http.get(url + "/certificate/certificateNumber",{params: {userId: userEntryId}})
            .then(function (response) {
                $scope.certNumber = response.data;
                $scope.cert.cert_number = $scope.certNumber[0].kind_id + "/" + userEntryId + "/" + $scope.certNumber[0].cert_number;
                return response;
            });
    } else {
        $http.get(url + "/certificate/certificateNumber",{params: {userId: 0}})
            .then(function (response) {
                $scope.certNumber = response.data;
                $scope.cert.cert_number = $scope.certNumber[0].kind_id + "/" + $scope.certNumber[0].cert_number;
                return response;
            });
    }

    // $scope.changeDateNotary = function (value) {
    //     if (value != null && value.length == 10 && moment(value, "DD/MM/YYYY", true).isValid()) {
    //         var dateArray = value.split("/");
    //         var year = dateArray[2];
    //         if (year != now.getFullYear()) {
    //             if (Number(year) && 1900 < year && year < 2100) {
    //                 //kiem tra xem co phai phuong xa khong.(Neu la phuong xa 1 project thi contract_number= year/userId/contract_number)
    //                 if (org_type == 1) {
    //                     $http.get(url + "/certificate/certificateNumber", {params: {year: year, userId: userEntryId}})
    //                         .then(function (response) {
    //                             $scope.cert.cert_number = year + "/" + userEntryId + "/" + response.data;
    //                             return response;
    //                         });
    //                 } else {
    //                     $http.get(url + "/certificate/certificateNumber", {params: {year: year, userId: 0}})
    //                         .then(function (response) {
    //                             $scope.cert.cert_number = year + "/" + response.data;
    //                             return response;
    //                         });
    //                 }
    //
    //             }
    //         }
    //     }
    // };

}]);