package com.vn.osp.modelview;

/**
 * Created by minh on 5/29/2017.
 */
public class ContractStasticsOfWards {
    private Integer usid;
    private String family_name;
    private String first_name;
    private Integer number_of_contract;
    private Integer number_of_error_contract;
    private String districtName;
    private String districtCode;

    public ContractStasticsOfWards(){

    }

    public Integer getUsid() {
        return usid;
    }

    public void setUsid(Integer usid) {
        this.usid = usid;
    }

    public String getFamily_name() {
        return family_name;
    }

    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public Integer getNumber_of_contract() {
        return number_of_contract;
    }

    public void setNumber_of_contract(Integer number_of_contract) {
        this.number_of_contract = number_of_contract;
    }

    public Integer getNumber_of_error_contract() {
        return number_of_error_contract;
    }

    public void setNumber_of_error_contract(Integer number_of_error_contract) {
        this.number_of_error_contract = number_of_error_contract;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(String districtCode) {
        this.districtCode = districtCode;
    }
}
