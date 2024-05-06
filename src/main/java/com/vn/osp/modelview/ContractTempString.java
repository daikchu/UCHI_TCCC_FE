package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class ContractTempString {
    private String id;
    private String name;
    private String kind_id;
    private String kind_id_tt08;
    private String code;
    private String description;
    private String file_name;
    private String file_path;
    private String active_flg;
    private String relate_object_number;
    private String relate_object_A_display;
    private String relate_object_B_display;
    private String relate_object_C_display;
    private String period_flag;
    private String period_req_flag;
    private String mortage_cancel_func;
    private String sync_option;
    private String entry_user_id;
    private String entry_user_name;
    private String entry_date_time;
    private String update_user_id;
    private String update_user_name;
    private String update_date_time;
    private String kind_html;
    private String office_code;
    private String code_template;
    private String getCode_template_;
    @JsonIgnore
    private List<ContractKind> listContractKind;
    @JsonIgnore
    private String name_;
    @JsonIgnore
    private String code_;
    @JsonIgnore
    private String description_;
    @JsonIgnore
    private String relate_object_number_;
    @JsonIgnore
    private String office_code_;
    @JsonIgnore
    private Boolean success;

    @JsonCreator
    public ContractTempString(
            @JsonProperty(value = "id") final String id,
            @JsonProperty(value = "name") final String name,
            @JsonProperty(value = "kind_id") final String kind_id,
            @JsonProperty(value = "kind_id_tt08")final String kind_id_tt08,
            @JsonProperty(value = "code") final String code,
            @JsonProperty(value = "description") final String description,
            @JsonProperty(value = "file_name") final String file_name,
            @JsonProperty(value = "file_path") final String file_path,
            @JsonProperty(value = "active_flg") final String active_flg,
            @JsonProperty(value = "relate_object_number") final String relate_object_number,
            @JsonProperty(value = "relate_object_A_display") final String relate_object_A_display,
            @JsonProperty(value = "relate_object_B_display") final String relate_object_B_display,
            @JsonProperty(value = "relate_object_C_display") final String relate_object_C_display,
            @JsonProperty(value = "period_flag") final String period_flag,
            @JsonProperty(value = "period_req_flag") final String period_req_flag,
            @JsonProperty(value = "mortage_cancel_func") final String mortage_cancel_func,
            @JsonProperty(value = "sync_option") final String sync_option,
            @JsonProperty(value = "entry_user_id") final String entry_user_id,
            @JsonProperty(value = "entry_user_name") final String entry_user_name,
            @JsonProperty(value = "entry_date_time") final String entry_date_time,
            @JsonProperty(value = "update_user_id") final String update_user_id,
            @JsonProperty(value = "update_user-name") final String update_user_name,
            @JsonProperty(value = "update_date_time") final String update_date_time,
            @JsonProperty(value = "kind_html") final String kind_html,
            @JsonProperty(value = "office_code") final String office_code,
            @JsonProperty(value = "code_template") final String code_template
    ){
        this.id = id;
        this.name = name;
        this.kind_id = kind_id;
        this.kind_id_tt08 = kind_id_tt08;
        this.code = code;
        this.description = description;
        this.file_name = file_name;
        this.file_path = file_path;
        this.active_flg = active_flg;
        this.relate_object_number = relate_object_number;
        this.relate_object_A_display = relate_object_A_display;
        this.relate_object_B_display = relate_object_B_display;
        this.relate_object_C_display = relate_object_C_display;
        this.period_flag = period_flag;
        this.period_req_flag = period_req_flag;
        this.mortage_cancel_func = mortage_cancel_func;
        this.sync_option = sync_option;
        this.entry_user_id = entry_user_id;
        this.entry_user_name = entry_user_name;
        this.entry_date_time = entry_date_time;
        this.update_user_id = update_user_id;
        this.update_user_name = update_user_name;
        this.update_date_time = update_date_time;
        this.kind_html = kind_html;
        this.office_code = office_code;
        this.code_template = code_template;

    }
    public ContractTempString(){}

    public ContractTemp genContractTemp(ContractTempString form) {
        ContractTemp bo = new ContractTemp();
        if (form.getId() != null && !"".equals(form.getId())){
            bo.setId((form.getId()==null || form.getId().equals("") || form.getId().equals("null"))?0L:Long.parseLong(form.getId()));
        }
        if (form.getName() != null && !"".equals(form.getName())){
            bo.setName(form.getName());
        }
        if (form.getKind_id() != null && !"".equals(form.getKind_id())){
            bo.setKind_id((form.getKind_id()==null || form.getKind_id().equals("") || form.getKind_id().equals("null"))?0L:Long.parseLong(form.getKind_id()));
        }
        if (form.getKind_id_tt08() != null && !"".equals(form.getKind_id_tt08())){
            bo.setKind_id_tt08((form.getKind_id_tt08()==null || form.getKind_id_tt08().equals("") || form.getKind_id_tt08().equals("null"))?0L:Long.parseLong(form.getKind_id_tt08()));
        }
        if (form.getCode() != null && !"".equals(form.getCode())){
            bo.setCode(form.getCode());
        }
        if (form.getDescription() != null && !"".equals(form.getDescription())){
            bo.setDescription(form.getDescription());
        }
        if (!form.getFile_name().equals("null") && form.getFile_name() != null && !"".equals(form.getFile_name())){
            bo.setFile_name(form.getFile_name());
        }
        if (!form.getFile_path().equals("null") && form.getFile_path() != null && !"".equals(form.getFile_path())){
            bo.setFile_path(form.getFile_path());
        }
        if (form.getActive_flg() != null && !"".equals(form.getActive_flg())){
            bo.setActive_flg((form.getActive_flg()==null || form.getActive_flg().equals("") || form.getActive_flg().equals("null"))?0L:Long.parseLong(form.getActive_flg()));
        }
        if (form.getRelate_object_number() != null && !"".equals(form.getRelate_object_number())){
            bo.setRelate_object_number((form.getRelate_object_number()==null || form.getRelate_object_number().equals("") || form.getRelate_object_number().equals("null"))?0L:Long.parseLong(form.getRelate_object_number()));
        }
        if (form.getRelate_object_A_display() != null && !"".equals(form.getRelate_object_A_display())){
            bo.setRelate_object_A_display(form.getRelate_object_A_display());
        }
        if (form.getRelate_object_B_display() != null && !"".equals(form.getRelate_object_B_display())){
            bo.setRelate_object_B_display(form.getRelate_object_B_display());
        }
        if (form.getRelate_object_C_display() != null && !"".equals(form.getRelate_object_C_display())){
            bo.setRelate_object_C_display(form.getRelate_object_C_display());
        }
        if (form.getPeriod_flag() != null && !"".equals(form.getPeriod_flag())){
            bo.setPeriod_flag((form.getPeriod_flag()==null || form.getPeriod_flag().equals("") || form.getPeriod_flag().equals("null"))?0L:Long.parseLong(form.getPeriod_flag()));
        }
        if (form.getPeriod_req_flag() != null && !"".equals(form.getPeriod_req_flag())){
            bo.setPeriod_req_flag((form.getPeriod_req_flag()==null || form.getPeriod_req_flag().equals("") || form.getPeriod_req_flag().equals("null"))?0L:Long.parseLong(form.getPeriod_req_flag()));
        }
        if (form.getMortage_cancel_func() != null && !"".equals(form.getMortage_cancel_func())){
            bo.setMortage_cancel_func((form.getMortage_cancel_func()==null || form.getMortage_cancel_func().equals("") || form.getMortage_cancel_func().equals("null"))?0L:Long.parseLong(form.getMortage_cancel_func()));
        }
        if (form.getSync_option() != null && !"".equals(form.getSync_option())){
            bo.setSync_option((form.getSync_option()==null || form.getSync_option().equals("") || form.getSync_option().equals("null"))?0L:Long.parseLong(form.getSync_option()));
        }
        if (form.getEntry_user_id() != null && !"".equals(form.getEntry_user_id())){
            bo.setEntry_user_id((form.getEntry_user_id()==null || form.getEntry_user_id().equals("") || form.getEntry_user_id().equals("null"))?0L:Long.parseLong(form.getEntry_user_id()));
        }
        if (form.getEntry_user_name() != null && !"".equals(form.getEntry_user_name())){
            bo.setEntry_user_name(form.getEntry_user_name());
        }
        if (form.getEntry_date_time() != null && !"".equals(form.getEntry_date_time())){
            bo.setEntry_date_time(form.getEntry_date_time());
        }
        if (form.getUpdate_user_id() != null && !"".equals(form.getUpdate_user_id())){
            bo.setUpdate_user_id((form.getUpdate_user_id()==null || form.getUpdate_user_id().equals("") || form.getUpdate_user_id().equals("null"))?0L:Long.parseLong(form.getUpdate_user_id()));
        }
        if (form.getUpdate_user_name() != null && !"".equals(form.getUpdate_user_name())){
            bo.setUpdate_user_name(form.getUpdate_user_name());
        }
        if (form.getUpdate_date_time() != null && !"".equals(form.getUpdate_date_time())){
            bo.setUpdate_date_time(form.getUpdate_date_time());
        }
        if (form.getKind_html() != null && !"".equals(form.getKind_html())){
            bo.setKind_html(form.getKind_html());
        }
        if (form.getOffice_code() != null && !"".equals(form.getOffice_code())){
            bo.setOffice_code(form.getOffice_code());
        }
        if (form.getCode_template() != null && !"".equals(form.getCode_template())){
            bo.setCode_template(form.getCode_template());
        }

        return bo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCode_template() {
        return code_template;
    }

    public void setCode_template(String code_template) {
        this.code_template = code_template;
    }

    public String getGetCode_template_() {
        return getCode_template_;
    }

    public void setGetCode_template_(String getCode_template_) {
        this.getCode_template_ = getCode_template_;
    }

    public String getSid() {
        return id;
    }

    public void setSid(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKind_id() {
        return kind_id;
    }

    public void setKind_id(String kind_id) {
        this.kind_id = kind_id;
    }

    public String getKind_id_tt08() {
        return kind_id_tt08;
    }

    public void setKind_id_tt08(String kind_id_tt08) {
        this.kind_id_tt08 = kind_id_tt08;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getFile_path() {
        return file_path;
    }

    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }

    public String getActive_flg() {
        return active_flg;
    }

    public void setActive_flg(String active_flg) {
        this.active_flg = active_flg;
    }

    public String getRelate_object_number() {
        return relate_object_number;
    }

    public void setRelate_object_number(String relate_object_number) {
        this.relate_object_number = relate_object_number;
    }

    public String getPeriod_flag() {
        return period_flag;
    }

    public void setPeriod_flag(String period_flag) {
        this.period_flag = period_flag;
    }

    public String getPeriod_req_flag() {
        return period_req_flag;
    }

    public void setPeriod_req_flag(String period_req_flag) {
        this.period_req_flag = period_req_flag;
    }

    public String getMortage_cancel_func() {
        return mortage_cancel_func;
    }

    public void setMortage_cancel_func(String mortage_cancel_func) {
        this.mortage_cancel_func = mortage_cancel_func;
    }

    public String getSync_option() {
        return sync_option;
    }

    public void setSync_option(String sync_option) {
        this.sync_option = sync_option;
    }

    public String getEntry_user_id() {
        return entry_user_id;
    }

    public void setEntry_user_id(String entry_user_id) {
        this.entry_user_id = entry_user_id;
    }

    public String getEntry_user_name() {
        return entry_user_name;
    }

    public void setEntry_user_name(String entry_user_name) {
        this.entry_user_name = entry_user_name;
    }

    public String getEntry_date_time() {
        return entry_date_time;
    }

    public void setEntry_date_time(String entry_date_time) {
        this.entry_date_time = entry_date_time;
    }

    public String getUpdate_user_id() {
        return update_user_id;
    }

    public void setUpdate_user_id(String update_user_id) {
        this.update_user_id = update_user_id;
    }

    public String getUpdate_user_name() {
        return update_user_name;
    }

    public void setUpdate_user_name(String update_user_name) {
        this.update_user_name = update_user_name;
    }

    public String getUpdate_date_time() {
        return update_date_time;
    }

    public void setUpdate_date_time(String update_date_time) {
        this.update_date_time = update_date_time;
    }

    public String getKind_html() {
        return kind_html;
    }

    public void setKind_html(String kind_html) {
        this.kind_html = kind_html;
    }

    public String getOffice_code() {
        return office_code;
    }

    public void setOffice_code(String office_code) {
        this.office_code = office_code;
    }

    public List<ContractKind> getListContractKind() {
        return listContractKind;
    }

    public void setListContractKind(List<ContractKind> listContractKind) {
        this.listContractKind = listContractKind;
    }

    public String getName_() {
        return name_;
    }

    public void setName_(String name_) {
        this.name_ = name_;
    }

    public String getCode_() {
        return code_;
    }

    public void setCode_(String code_) {
        this.code_ = code_;
    }

    public String getDescription_() {
        return description_;
    }

    public void setDescription_(String description_) {
        this.description_ = description_;
    }

    public String getRelate_object_number_() {
        return relate_object_number_;
    }

    public void setRelate_object_number_(String relate_object_number_) {
        this.relate_object_number_ = relate_object_number_;
    }

    public String getOffice_code_() {
        return office_code_;
    }

    public void setOffice_code_(String office_code_) {
        this.office_code_ = office_code_;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
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
}
