package com.vn.osp.modelview;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class CitizenVerifyOrders {
    private String order_id;

    private LocalDateTime order_time;

    private String verify_number;

    private String verify_fee;

    private String verify_fee_received;

    private String notary_office_code;

    private String notary_office_name;

    private String province_code;

    private String province_name;

    private String transaction_status;

    private String status_name;

    private String transaction_status_name;

    private String notary_officer;

    private String note;

    private String attach_files;

    private String update_by;

    private String update_by_name;

    private String payment_content;

    private String order_time_formatted;

    private List transaction_hists;
}
