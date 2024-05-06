package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * Created by minh on 5/5/2017.
 */
public class HistoryContract {
    private Integer hid;
    private Integer contract_id;
    private String contract_number;
    private String client_info;
    private String execute_date_time;
    private String execute_person;
    private String execute_content;
    private String contract_content;
    private String family_name;
    private String first_name;


    public HistoryContract() {
    }

    @JsonCreator
    public HistoryContract(
            @JsonProperty(value="hid",required= true) final Integer hid,
            @JsonProperty(value="contract_id",required= true) final Integer contract_id,
            @JsonProperty(value="contract_number",required= true) final String contract_number,
            @JsonProperty(value="client_info",required= true) final String client_info,
            @JsonProperty(value="execute_date_time",required= true) final String execute_date_time,
            @JsonProperty(value="execute_person",required= true) final String execute_person,
            @JsonProperty(value="execute_content",required= true) final String execute_content,
            @JsonProperty(value="contract_content",required= true) final String contract_content,
            @JsonProperty(value="family_name",required= true) final String family_name,
            @JsonProperty(value="first_name",required= true) final String first_name
    ) {
        this.hid = hid;
        this.contract_id = contract_id;
        this.contract_number = contract_number;
        this.client_info = client_info;
        this.execute_date_time = execute_date_time;
        this.execute_person = execute_person;
        this.execute_content = execute_content;
        this.contract_content = contract_content;
        this.family_name = family_name;
        this.first_name = first_name;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public Integer getContract_id() {
        return contract_id;
    }

    public void setContract_id(Integer contract_id) {
        this.contract_id = contract_id;
    }

    public String getContract_number() {
        return contract_number;
    }

    public void setContract_number(String contract_number) {
        this.contract_number = contract_number;
    }

    public String getClient_info() {
        return client_info;
    }

    public void setClient_info(String client_info) {
        this.client_info = client_info;
    }

    public String getExecute_date_time() {
        return execute_date_time;
    }

    public void setExecute_date_time(String execute_date_time) {
        this.execute_date_time = execute_date_time;
    }

    public String getExecute_person() {
        return execute_person;
    }

    public void setExecute_person(String execute_person) {
        this.execute_person = execute_person;
    }

    public String getExecute_content() {
        return execute_content;
    }

    public void setExecute_content(String execute_content) {
        this.execute_content = execute_content;
    }

    public String getContract_content() {
        return contract_content;
    }

    public void setContract_content(String contract_content) {
        this.contract_content = contract_content;
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


}
