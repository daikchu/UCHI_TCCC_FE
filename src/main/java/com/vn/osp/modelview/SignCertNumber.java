package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import org.json.JSONObject;

@Data
public class SignCertNumber {
    private Long id;

    private String kind_id;
    private Long cert_number;
    private Integer cert_type;
    private Long user_id;
    private String village_code;
    private String district_code;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getKind_id() {
        return kind_id;
    }

    public void setKind_id(String kind_id) {
        this.kind_id = kind_id;
    }

    public Long getCert_number() {
        return cert_number;
    }

    public void setCert_number(Long cert_number) {
        this.cert_number = cert_number;
    }

    public Integer getCert_type() {
        return cert_type;
    }

    public void setCert_type(Integer cert_type) {
        this.cert_type = cert_type;
    }

    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    public String getVillage_code() {
        return village_code;
    }

    public void setVillage_code(String village_code) {
        this.village_code = village_code;
    }

    public String getDistrict_code() {
        return district_code;
    }

    public void setDistrict_code(String district_code) {
        this.district_code = district_code;
    }

    public String generateAddJson(User user) {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();
        this.setUser_id(user.getUserId());
        try {
            String xml_content = mapper.writeValueAsString(this);
            return xml_content;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }

}
