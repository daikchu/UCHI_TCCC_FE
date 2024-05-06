package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.common.util.Crypter;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.TimeUtil;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;

import java.sql.Timestamp;

public class District {

    private Long id;
    private String code;
    private String name;
    private String province_code;
    private Long entry_user_id;
    private String entry_date_time;
    private Long update_user_id;
    private String update_date_time;

    private Boolean success;
    private String code_;
    private String name_;

    public District() {
    }

    public District(Long id, String code, String name, String province_code, Long entry_user_id, String entry_date_time, Long update_user_id, String update_date_time) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.province_code = province_code;
        this.entry_user_id = entry_user_id;
        this.entry_date_time = entry_date_time;
        this.update_user_id = update_user_id;
        this.update_date_time = update_date_time;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getProvince_code() {
        return province_code;
    }

    public void setProvince_code(String province_code) {
        this.province_code = province_code;
    }

    public Long getEntry_user_id() {
        return entry_user_id;
    }

    public void setEntry_user_id(Long entry_user_id) {
        this.entry_user_id = entry_user_id;
    }

    public String getEntry_date_time() {
        return entry_date_time;
    }

    public void setEntry_date_time(String entry_date_time) {
        this.entry_date_time = entry_date_time;
    }

    public Long getUpdate_user_id() {
        return update_user_id;
    }

    public void setUpdate_user_id(Long update_user_id) {
        this.update_user_id = update_user_id;
    }

    public String getUpdate_date_time() {
        return update_date_time;
    }

    public void setUpdate_date_time(String update_date_time) {
        this.update_date_time = update_date_time;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String getCode_() {
        return code_;
    }

    public void setCode_(String code_) {
        this.code_ = code_;
    }

    public String getName_() {
        return name_;
    }

    public void setName_(String name_) {
        this.name_ = name_;
    }

    public String generateAddJson(User user) {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        this.setEntry_user_id(user.getUserId());
        try {
            String xml_content = mapper.writeValueAsString(this);
            return xml_content;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public District genAddObject(User user, District item){
        item.setEntry_user_id(user.getUserId());
        item.setUpdate_user_id(user.getUserId());
        item.setEntry_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public String generateUpdateJsons(Long id,User userUpdated,User user) {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        this.setUpdate_user_id(user.getUserId());
        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public District genUpdateObject(User user, District item){
        item.setUpdate_user_id(user.getUserId());
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public void validate(){
        this.success = true;
        if(StringUtils.isBlank(code)){
            this.success = false;
            this.code_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        else if(code.length()>50){
            this.success = false;
            this.code_ = SystemMessageProperties.getSystemProperty("v3_district_validate_code_length");
        }
        if(StringUtils.isBlank(name)){
            this.success = false;
            this.name_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        else if(name.length()>200){
            this.success = false;
            this.name_ = SystemMessageProperties.getSystemProperty("v3_district_validate_name_length");
        }
    }
}
