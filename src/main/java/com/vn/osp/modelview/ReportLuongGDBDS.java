package com.vn.osp.modelview;

import lombok.Data;

import java.math.BigInteger;

@Data
public class ReportLuongGDBDS {
    private String district_code;
    private String district_name;
    private Integer count_DNDO_phatTrienTheoDuAn;
    private Integer count_DNDO_trongKhuDanCu;
    private Integer count_NORL_phatTrienTheoDuAn;
    private Integer count_NORL_trongKhuDanCu;
    private Integer count_CHCC_dienTichDuoi70m2;
    private Integer count_CHCC_dienTichTu70Den120m2;
    private Integer count_CHCC_dienTichTren120m2;
    private Integer count_vanPhongChoThue;
    private Integer count_matBangThuongMaiDichVu;
}
