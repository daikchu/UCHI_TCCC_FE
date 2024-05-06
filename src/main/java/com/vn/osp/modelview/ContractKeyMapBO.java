package com.vn.osp.modelview;

import java.sql.Timestamp;

public class ContractKeyMapBO {
    private Long id;

    private String key_name;

    private String next_key;

    private Long flg_inline;

    private Long type;

    private Long begin_or_close;

    private String first_word;

    private String end_word;

    private String map_var;

    private String map_var_search;

    private Long type_property;

    private String note;

    private Long entry_user_id;

    private String entry_user_name;

    private java.sql.Timestamp entry_date_time;

    private Long update_user_id;

    private String update_user_name;

    private java.sql.Timestamp update_date_time;

    public ContractKeyMapBO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getKey_name() {
        return key_name;
    }

    public void setKey_name(String key_name) {
        this.key_name = key_name;
    }

    public String getNext_key() {
        return next_key;
    }

    public void setNext_key(String next_key) {
        this.next_key = next_key;
    }

    public Long getFlg_inline() {
        return flg_inline;
    }

    public void setFlg_inline(Long flg_inline) {
        this.flg_inline = flg_inline;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public Long getBegin_or_close() {
        return begin_or_close;
    }

    public void setBegin_or_close(Long begin_or_close) {
        this.begin_or_close = begin_or_close;
    }

    public String getFirst_word() {
        return first_word;
    }

    public void setFirst_word(String first_word) {
        this.first_word = first_word;
    }

    public String getEnd_word() {
        return end_word;
    }

    public void setEnd_word(String end_word) {
        this.end_word = end_word;
    }

    public String getMap_var() {
        return map_var;
    }

    public void setMap_var(String map_var) {
        this.map_var = map_var;
    }

    public String getMap_var_search() {
        return map_var_search;
    }

    public void setMap_var_search(String map_var_search) {
        this.map_var_search = map_var_search;
    }

    public Long getType_property() {
        return type_property;
    }

    public void setType_property(Long type_property) {
        this.type_property = type_property;
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

    public String getEntry_user_name() {
        return entry_user_name;
    }

    public void setEntry_user_name(String entry_user_name) {
        this.entry_user_name = entry_user_name;
    }

    public Timestamp getEntry_date_time() {
        return entry_date_time;
    }

    public void setEntry_date_time(Timestamp entry_date_time) {
        this.entry_date_time = entry_date_time;
    }

    public Long getUpdate_user_id() {
        return update_user_id;
    }

    public void setUpdate_user_id(Long update_user_id) {
        this.update_user_id = update_user_id;
    }

    public String getUpdate_user_name() {
        return update_user_name;
    }

    public void setUpdate_user_name(String update_user_name) {
        this.update_user_name = update_user_name;
    }

    public Timestamp getUpdate_date_time() {
        return update_date_time;
    }

    public void setUpdate_date_time(Timestamp update_date_time) {
        this.update_date_time = update_date_time;
    }
}
