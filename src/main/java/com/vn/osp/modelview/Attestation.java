package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import org.json.JSONObject;

import java.util.Date;

@Data
public class Attestation {
    private Long id;
    private String name;
    private String code;
    private String parent_code;
    private String kind_html;
    private String description;
    private int type;
    private int active_flg;
    private int type_org;
    private Long entry_user_id;
    private String entry_user_name;
    private Date entry_date_time;
    private Long update_user_id;
    private String update_user_name;
    private Date update_date_time;

    public String generateAddJson(User user) {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        this.setEntry_user_id(user.getUserId());
        this.setEntry_user_name(user.getAccount());
        this.setUpdate_user_id(user.getUserId());
        this.setUpdate_user_name(user.getAccount());
        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String generateUpdateJson(User user) {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        this.setUpdate_user_id(user.getUserId());
        this.setUpdate_user_name(user.getAccount());
        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
