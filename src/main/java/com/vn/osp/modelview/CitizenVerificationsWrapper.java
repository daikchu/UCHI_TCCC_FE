package com.vn.osp.modelview;

import lombok.Data;

import java.util.List;

@Data
public class CitizenVerificationsWrapper {
    private List<CitizenVerifications> citizenVerifications;
    private int total;
    private int page=1;
    private int totalPage;
//    private PagingResult page;

    private String verify_id;
    private String order_id;
    private String province_code;
    private String notary_office_id;
    private String verify_status;
    private String verify_by;
    private String verify_date_from;
    private String verify_date_to;
    private String citizen_verify_fullname;
    private String citizen_verify_cccd;

    private List<Status> transaction_statuses;
//    private List<Status> statuses;
    private List users;

}
