package com.vn.osp.modelview;

import lombok.Data;

@Data
public class ReportCertByTT03CapHuyen {
    private Integer user_id;
    private String user_first_name;
    private String user_family_name;
    private String user_district_code;
    private String user_district_name;
    private String user_level_cert;
    private Integer cert_copies_number;
    private Integer cert_signature_number;
    private Integer cert_contract_number;
}
