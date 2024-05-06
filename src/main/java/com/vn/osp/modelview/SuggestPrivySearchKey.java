package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;

import java.util.List;

/**
 * Created by Admin on 12/1/2018.
 */
public class SuggestPrivySearchKey {
    private int id;
    private String sex;
    private String template;
    private String name;
    private String birthday;
    private String passport;
    private String certification_date;
    private String certification_place;
    private String address;
    private String position;
    private String description;
    private String org_name;
    private String org_address;
    private String org_code;
    private String first_registed_date;
    private String number_change_registed;
    private String change_registed_date;
    private String department_issue;
    private String value;

    public SuggestPrivySearchKey() {
    }

    public SuggestPrivySearchKey(int id, String sex, String template, String name, String birthday, String passport, String certification_date, String certification_place, String address, String position, String description, String org_name, String org_address, String org_code, String first_registed_date, String number_change_registed, String change_registed_date, String department_issue, String value) {
        this.id = id;
        this.sex = sex;
        this.template = template;
        this.name = name;
        this.birthday = birthday;
        this.passport = passport;
        this.certification_date = certification_date;
        this.certification_place = certification_place;
        this.address = address;
        this.position = position;
        this.description = description;
        this.org_name = org_name;
        this.org_address = org_address;
        this.org_code = org_code;
        this.first_registed_date = first_registed_date;
        this.number_change_registed = number_change_registed;
        this.change_registed_date = change_registed_date;
        this.department_issue = department_issue;
        this.value = value;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public String getCertification_date() {
        return certification_date;
    }

    public void setCertification_date(String certification_date) {
        this.certification_date = certification_date;
    }

    public String getCertification_place() {
        return certification_place;
    }

    public void setCertification_place(String certification_place) {
        this.certification_place = certification_place;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOrg_name() {
        return org_name;
    }

    public void setOrg_name(String org_name) {
        this.org_name = org_name;
    }

    public String getOrg_address() {
        return org_address;
    }

    public void setOrg_address(String org_address) {
        this.org_address = org_address;
    }

    public String getOrg_code() {
        return org_code;
    }

    public void setOrg_code(String org_code) {
        this.org_code = org_code;
    }

    public String getFirst_registed_date() {
        return first_registed_date;
    }

    public void setFirst_registed_date(String first_registed_date) {
        this.first_registed_date = first_registed_date;
    }

    public String getNumber_change_registed() {
        return number_change_registed;
    }

    public void setNumber_change_registed(String number_change_registed) {
        this.number_change_registed = number_change_registed;
    }

    public String getChange_registed_date() {
        return change_registed_date;
    }

    public void setChange_registed_date(String change_registed_date) {
        this.change_registed_date = change_registed_date;
    }

    public String getDepartment_issue() {
        return department_issue;
    }

    public void setDepartment_issue(String department_issue) {
        this.department_issue = department_issue;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String addJSON(){
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        //

        /*NotaryOffice.setMac_address("");

        NotaryOffice.setOffice_type(Long.valueOf(2));
        NotaryOffice.setEntry_user_name(user.getFirst_name()+" "+user.getFamily_name());
        NotaryOffice.setEntry_user_id(user.getUserId());
        NotaryOffice.setLast_connection_time(null);
        NotaryOffice.setHidden_flg(Long.valueOf(0));
        NotaryOffice.setLast_connection_time("2016-6-6");
        NotaryOffice.setSynchronize_type(Long.valueOf(2));
        NotaryOffice.setAuthentication_id(authenticationId);*/




        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
