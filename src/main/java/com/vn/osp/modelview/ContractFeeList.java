package com.vn.osp.modelview;

import java.util.List;

/**
 * Created by Admin on 2018-05-22.
 */
public class ContractFeeList {

    private List<ContractFeeBO> contractFeeLists;
    private int total;
    private int page;
    private int totalPage;
    private List<ContractTemplate> listContractTemp;

    private List<ContractKind> contractKindList;

    private String action_status;
    /*private Boolean deleteStatus;*/
    /*private String titleFilter;
    private String name;*/
    private String code;
    private String nhomHD;

    public ContractFeeList() {
    }

    public ContractFeeList(List<ContractFeeBO> contractFeeLists, int total, int page, int totalPage, String action_status, String code,List<ContractTemplate> listContractTemp,List<ContractKind> contractKindList,String nhomHD) {
        this.contractFeeLists = contractFeeLists;
        this.total = total;
        this.page = page;
        this.totalPage = totalPage;
        this.action_status = action_status;
        this.code = code;
        this.listContractTemp = listContractTemp;
        this.nhomHD = nhomHD;
        this.contractKindList = contractKindList;
    }

    public List<ContractFeeBO> getContractFeeLists() {
        return contractFeeLists;
    }

    public void setContractFeeLists(List<ContractFeeBO> contractFeeLists) {
        this.contractFeeLists = contractFeeLists;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public String getAction_status() {
        return action_status;
    }

    public void setAction_status(String action_status) {
        this.action_status = action_status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public List<ContractTemplate> getListContractTemp() {
        return listContractTemp;
    }

    public void setListContractTemp(List<ContractTemplate> listContractTemp) {
        this.listContractTemp = listContractTemp;
    }

    public String getNhomHD() {
        return nhomHD;
    }

    public void setNhomHD(String nhomHD) {
        this.nhomHD = nhomHD;
    }

    public List<ContractKind> getContractKindList() {
        return contractKindList;
    }

    public void setContractKindList(List<ContractKind> contractKindList) {
        this.contractKindList = contractKindList;
    }

}
