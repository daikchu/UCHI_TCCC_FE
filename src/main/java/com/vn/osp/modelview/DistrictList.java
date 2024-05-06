package com.vn.osp.modelview;

import org.apache.commons.lang3.StringUtils;

import java.util.List;

public class DistrictList {
    public static final String SESSION_KEY = "DistrictList";

    private List<District> items;
    private int total;
    private int totalPage;
    private int page;

    private String code;
    private String name;

    private String action_status;

    public DistrictList() {
    }

    public static String getSessionKey() {
        return SESSION_KEY;
    }

    public List<District> getItems() {
        return items;
    }

    public void setItems(List<District> items) {
        this.items = items;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAction_status() {
        return action_status;
    }

    public void setAction_status(String action_status) {
        this.action_status = action_status;
    }

    public String getFilter(){
        String whereString ="";
        String orderString =" ORDER BY di.name asc ";
        if(!StringUtils.isBlank(code)){
            whereString += " and di.code like '%"+code+"%' ";
        }
        if(!StringUtils.isBlank(name)){
            whereString += " and di.name like '%"+name+"%' ";
        }

        String query = whereString + orderString;
        ////System.out.println(query);
        return query;
    }
}
