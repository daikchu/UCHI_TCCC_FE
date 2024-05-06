package com.vn.osp.modelview;

/**
 * Created by DaiCQ on 13/08/2020.
 */
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.TimeUtil;
import com.vn.osp.service.QueryFactory;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;

import java.sql.Timestamp;

@Data
public class SignCert {
    private Long id;
    private String cert_number;
    private String cert_date;
    private String cert_request_user;
    private String cert_request_doc;
    private String cert_sign_user;
    private Integer cert_doc_number;
    private String cert_fee;
    private String note;
    private String attestation_template_code;
    private String kind_html;
    private String notary_book;

    private Long entry_user_id;
    private Long update_user_id;
    private String entry_date_time;
    private String update_date_time;

    private Boolean success;
    private String cert_number_;
    private String cert_date_;
    private String cert_request_user_;
    private String cert_request_doc_;
    private String cert_sign_user_;
    private String cert_doc_number_;
    private String notary_book_;
    private Integer type;

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

    public SignCert genAddObject(User user, SignCert item){
        item.setEntry_user_id(user.getUserId());
        item.setUpdate_user_id(user.getUserId());
        item.setEntry_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public SignCert genUpdateObject(User user, SignCert item){
        item.setUpdate_user_id(user.getUserId());
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public void validate(){
        this.success = true;
        if(StringUtils.isBlank(cert_number)){
            this.success = false;
            this.cert_number_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(cert_date)){
            this.success = false;
            this.cert_date_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(cert_request_user)){
            this.success = false;
            this.cert_request_user_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(cert_request_doc)){
            this.success = false;
            this.cert_request_doc_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(cert_sign_user)){
            this.success = false;
            this.cert_sign_user_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(cert_doc_number==null){
            this.success = false;
            this.cert_doc_number_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(cert_request_user)){
            this.success = false;
            this.cert_request_user_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if(StringUtils.isBlank(notary_book)){
            this.success = false;
            this.notary_book_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }

    }

}
