package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.TimeUtil;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;

import java.sql.Timestamp;

@Data
public class NotaryBook {
    private Long id;
    private String notary_book;
    private Long status;
    private Long type;
    private String create_date;
    private String lock_day;
    private String note;

    private Long entry_user_id;
    private String entry_date_time;
    private Long update_user_id;
    private String update_date_time;

    private Boolean success;
    private String notary_book_;
    private String create_date_;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNotary_book() {
        return notary_book;
    }

    public void setNotary_book(String notary_book) {
        this.notary_book = notary_book;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getLock_day() {
        return lock_day;
    }

    public void setLock_day(String lock_day) {
        this.lock_day = lock_day;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    public String getNotary_book_() {
        return notary_book_;
    }

    public void setNotary_book_(String notary_book_) {
        this.notary_book_ = notary_book_;
    }

    public String getCreate_date_() {
        return create_date_;
    }

    public void setCreate_date_(String create_date_) {
        this.create_date_ = create_date_;
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

    public NotaryBook genAddObject(User user, NotaryBook item){
        item.setEntry_user_id(user.getUserId());
        item.setUpdate_user_id(user.getUserId());
        item.setEntry_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public NotaryBook genUpdateObject(User user, NotaryBook item){
        item.setUpdate_user_id(user.getUserId());
        item.setUpdate_date_time(TimeUtil.convertTimeStampToString(new Timestamp(System.currentTimeMillis())));
        return item;
    }

    public void validate() {
        this.success = true;
        if (StringUtils.isBlank(notary_book)) {
            this.success = false;
            this.notary_book_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }
        if (StringUtils.isBlank(create_date)) {
            this.success = false;
            this.create_date_ = SystemMessageProperties.getSystemProperty("v3_field_not_empty");
        }

    }
}
