package com.vn.osp.modelview;

import lombok.Data;

import java.math.BigInteger;
import java.util.List;

@Data
public class ReportLuongGDBDSList {
    List<ReportLuongGDBDS> items;
    private Integer total_count_DNDO_phatTrienTheoDuAn = 0;
    private Integer total_count_DNDO_trongKhuDanCu = 0;
    private Integer total_count_NORL_phatTrienTheoDuAn = 0;
    private Integer total_count_NORL_trongKhuDanCu = 0;
    private Integer total_count_CHCC_dienTichDuoi70m2 = 0;
    private Integer total_count_CHCC_dienTichTu70Den120m2 = 0;
    private Integer total_count_CHCC_dienTichTren120m2 = 0;
    private Integer total_count_vanPhongChoThue = 0;
    private Integer total_count_matBangThuongMaiDichVu = 0;

    public void countTotal(List<ReportLuongGDBDS> items){
        ReportLuongGDBDSList result = new ReportLuongGDBDSList();
        for(int i=0;i<items.size();i++){
            ReportLuongGDBDS item = items.get(i);
            total_count_DNDO_phatTrienTheoDuAn += item.getCount_DNDO_phatTrienTheoDuAn();
            total_count_DNDO_trongKhuDanCu += item.getCount_DNDO_trongKhuDanCu();
            total_count_NORL_phatTrienTheoDuAn += item.getCount_NORL_phatTrienTheoDuAn();
            total_count_NORL_trongKhuDanCu += item.getCount_NORL_trongKhuDanCu();
            total_count_CHCC_dienTichDuoi70m2 += item.getCount_CHCC_dienTichDuoi70m2();
            total_count_CHCC_dienTichTu70Den120m2 += item.getCount_CHCC_dienTichTu70Den120m2();
            total_count_CHCC_dienTichTren120m2 += item.getCount_CHCC_dienTichTren120m2();
            total_count_vanPhongChoThue += item.getCount_vanPhongChoThue();
            total_count_matBangThuongMaiDichVu += item.getCount_matBangThuongMaiDichVu();
        }
    }
}
