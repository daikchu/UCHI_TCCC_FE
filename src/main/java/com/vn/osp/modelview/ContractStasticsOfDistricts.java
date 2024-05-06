package com.vn.osp.modelview;

import java.util.List;

public class ContractStasticsOfDistricts {
    private String district_code;
    private String district_name;
    private List<ContractStasticsOfWards> contractStasticsOfWards;
    private Integer countContractOfDistrict;

    public ContractStasticsOfDistricts() {
    }

    public String getDistrict_code() {
        return district_code;
    }

    public void setDistrict_code(String district_code) {
        this.district_code = district_code;
    }

    public String getDistrict_name() {
        return district_name;
    }

    public void setDistrict_name(String district_name) {
        this.district_name = district_name;
    }

    public List<ContractStasticsOfWards> getContractStasticsOfWards() {
        return contractStasticsOfWards;
    }

    public void setContractStasticsOfWards(List<ContractStasticsOfWards> contractStasticsOfWards) {
        this.contractStasticsOfWards = contractStasticsOfWards;
    }

    public Integer getCountContractOfDistrict() {
        return countContractOfDistrict;
    }

    public void setCountContractOfDistrict(Integer countContractOfDistrict) {
        this.countContractOfDistrict = countContractOfDistrict;
    }
}
