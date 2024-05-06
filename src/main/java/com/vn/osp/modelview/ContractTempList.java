package com.vn.osp.modelview;

import java.util.List;

/**
 * Created by Admin on 7/6/2017.
 */
public class ContractTempList {
    private List<ContractTempListByKindName> contractTempListByKindNames;
    private ContractTemp contractTempDetail;
    private String name;
    private String code;
    private Long active_flg;
    private String relate_object_A_display;
    private String relate_object_B_display;
    private String relate_object_C_display;
    private String model_open;
    private List<ContractKind> listContractKind;

    private int page;
    private int totalPage;
    private int total;
    private String action_status;
    private String parent_name_contractTempDetail;

    public ContractTempList() {
    }

    public ContractTempList(List<ContractTempListByKindName> contractTempListByKindNames, ContractTemp contractTempDetail, String name, String code, Long active_flg, List<ContractKind> listContractKind, int page, int totalPage, int total, String action_status, String parent_name_contractTempDetail) {
        this.contractTempListByKindNames = contractTempListByKindNames;
        this.contractTempDetail = contractTempDetail;
        this.name = name;
        this.code = code;
        this.active_flg = active_flg;
        this.listContractKind = listContractKind;
        this.page = page;
        this.totalPage = totalPage;
        this.total = total;
        this.action_status = action_status;
        this.parent_name_contractTempDetail = parent_name_contractTempDetail;
    }

    public List<ContractTempListByKindName> getContractTempListByKindNames() {
        return contractTempListByKindNames;
    }

    public void setContractTempListByKindNames(List<ContractTempListByKindName> contractTempListByKindNames) {
        this.contractTempListByKindNames = contractTempListByKindNames;
    }

    public ContractTemp getContractTempDetail() {
        return contractTempDetail;
    }

    public void setContractTempDetail(ContractTemp contractTempDetail) {
        this.contractTempDetail = contractTempDetail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getActive_flg() {
        return active_flg;
    }

    public void setActive_flg(Long active_flg) {
        this.active_flg = active_flg;
    }

    public List<ContractKind> getListContractKind() {
        return listContractKind;
    }

    public void setListContractKind(List<ContractKind> listContractKind) {
        this.listContractKind = listContractKind;
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

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getAction_status() {
        return action_status;
    }

    public void setAction_status(String action_status) {
        this.action_status = action_status;
    }

    public String getRelate_object_A_display() {
        return relate_object_A_display;
    }

    public void setRelate_object_A_display(String relate_object_A_display) {
        this.relate_object_A_display = relate_object_A_display;
    }

    public String getRelate_object_B_display() {
        return relate_object_B_display;
    }

    public void setRelate_object_B_display(String relate_object_B_display) {
        this.relate_object_B_display = relate_object_B_display;
    }

    public String getRelate_object_C_display() {
        return relate_object_C_display;
    }

    public void setRelate_object_C_display(String relate_object_C_display) {
        this.relate_object_C_display = relate_object_C_display;
    }

    public String getModel_open() {
        return model_open;
    }

    public void setModel_open(String model_open) {
        this.model_open = model_open;
    }

    public String getParent_name_contractTempDetail() {
        return parent_name_contractTempDetail;
    }

    public void setParent_name_contractTempDetail(String parent_name_contractTempDetail) {
        this.parent_name_contractTempDetail = parent_name_contractTempDetail;
    }

    public String getOrderString(){
        String whereString ="where 1=1" ;
        String orderString1 ="";
        String orderString2 ="";
        String orderString3 ="";
        String orderBy = " ORDER BY nct.code,nct.name asc";
        if(name!= null && !name.equals("")){

            orderString1 = " and nct.name like '%"+name.trim()+"%'";
        }

        if(code!= null && !code.equals("")){

            orderString2 = " and code like '%"+code.trim()+"%'";
        }
        if(active_flg!= null && !active_flg.equals("")){

            orderString3 = " and active_flg = "+active_flg;
        }

        String query = whereString  + orderString1 + orderString2 + orderString3 + " and (kind_id is null or kind_id = 0) " + orderBy;
        return query;
    }
}
