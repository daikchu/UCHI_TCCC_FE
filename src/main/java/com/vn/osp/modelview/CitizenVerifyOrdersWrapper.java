package com.vn.osp.modelview;

import lombok.*;

import java.util.List;

@Data
public class CitizenVerifyOrdersWrapper {
    private List<CitizenVerifyOrders> citizenVerifyOrders;
    private int total;
    private int page=1;
    private int totalPage;
//    private PagingResult page;

    private String order_id;
    private String province_code;
    private String notary_office_code;
    private String transaction_status;
    private String status;
    private String update_by;
    private String update_by_name;
    private String order_time_from;
    private String order_time_to;

    private List<Status> transaction_statuses;
    private List<Status> statuses;
    private List user_updates;

}
