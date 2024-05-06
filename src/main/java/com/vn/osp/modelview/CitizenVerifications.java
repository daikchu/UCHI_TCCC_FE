package com.vn.osp.modelview;

import lombok.Data;

@Data
public class CitizenVerifications {
    private String verify_id;
    private String transaction_id;
    private String notary_office_id;
    private String province_code;
    private java.sql.Timestamp verify_date;
    private String verify_by;
    private String verify_status;
    private String citizen_verify_cccd;
    private String citizen_verify_fullname;
    private String citizen_info;

    private String notary_office_name;
    private String province_name;
    private String verify_status_name;
    private String verify_by_name;
    private String verify_date_formatted;
}
