package com.vn.osp.modelview;

import java.sql.Timestamp;

/**
 * Created by TienManh on 5/16/2017.
 */
public class TemporaryContract {
    private Long tcid;
    private Long type;
    private Long contract_template_id;
    private String contract_number;
    private String contract_value;
    private String relation_object_a;
    private String relation_object_b;
    private String relation_object_c;
    private Long notary_id;
    private Long drafter_id;
    private String received_date;
    private String notary_date;
    private String user_require_contract;
    private String property_type;
    private String property_info;
    private String owner_info;
    private String other_info;
    private String land_certificate;
    private String land_issue_place;
    private String land_issue_date;
    private String land_map_number;
    private String land_number;
    private String land_address;
    private String land_area;
    private String land_public_area;
    private String land_private_area;
    private String land_use_purpose;
    private String land_use_period;
    private String land_use_origin;
    private String land_associate_property;
    private String land_street;
    private String land_district;
    private String land_province;
    private String land_full_of_area;
    private String car_license_number;
    private String car_regist_number;
    private String car_issue_place;
    private String car_issue_date;
    private String car_frame_number;
    private String car_machine_number;
    private String number_copy_of_contract;
    private String number_of_sheet;
    private String number_of_page;
    private Long cost_tt91;
    private Long cost_draft;
    private Long cost_notary_outsite;
    private Long cost_other_determine;
    private Long cost_total;
    private Long notary_place_flag;
    private String notary_place;
    private Long bank_id;
    private String bank_service_fee;
    private String crediter_name;
    private String file_name;
    private String file_path;
    private String original_store_place;
    private String note;
    private String summary;
    private Long entry_user_id;
    private String entry_user_name;
    private java.sql.Timestamp entry_date_time;
    private Long update_user_id;
    private String update_user_name;
    private java.sql.Timestamp update_date_time;
    private String jsonstring;
    private String kindhtml;
    private String json_property;
    private String json_person;
    private String bank_code;
    private Long sub_template_id;
    private String notary_book;

    private String contract_signer;
    private String request_recipient;

    public TemporaryContract(){}

    public Long getTcid() {
        return tcid;
    }

    public void setTcid(Long tcid) {
        this.tcid = tcid;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public Long getContract_template_id() {
        return contract_template_id;
    }

    public void setContract_template_id(Long contract_template_id) {
        this.contract_template_id = contract_template_id;
    }

    public String getContract_number() {
        return contract_number;
    }

    public void setContract_number(String contract_number) {
        this.contract_number = contract_number;
    }

    public String getContract_value() {
        return contract_value;
    }

    public void setContract_value(String contract_value) {
        this.contract_value = contract_value;
    }

    public String getRelation_object_a() {
        return relation_object_a;
    }

    public void setRelation_object_a(String relation_object_a) {
        this.relation_object_a = relation_object_a;
    }

    public String getRelation_object_b() {
        return relation_object_b;
    }

    public void setRelation_object_b(String relation_object_b) {
        this.relation_object_b = relation_object_b;
    }

    public String getRelation_object_c() {
        return relation_object_c;
    }

    public void setRelation_object_c(String relation_object_c) {
        this.relation_object_c = relation_object_c;
    }

    public Long getNotary_id() {
        return notary_id;
    }

    public void setNotary_id(Long notary_id) {
        this.notary_id = notary_id;
    }

    public Long getDrafter_id() {
        return drafter_id;
    }

    public void setDrafter_id(Long drafter_id) {
        this.drafter_id = drafter_id;
    }

    public String getUser_require_contract() {
        return user_require_contract;
    }

    public void setUser_require_contract(String user_require_contract) {
        this.user_require_contract = user_require_contract;
    }

    public String getProperty_type() {
        return property_type;
    }

    public void setProperty_type(String property_type) {
        this.property_type = property_type;
    }

    public String getProperty_info() {
        return property_info;
    }

    public void setProperty_info(String property_info) {
        this.property_info = property_info;
    }

    public String getOwner_info() {
        return owner_info;
    }

    public void setOwner_info(String owner_info) {
        this.owner_info = owner_info;
    }

    public String getOther_info() {
        return other_info;
    }

    public void setOther_info(String other_info) {
        this.other_info = other_info;
    }

    public String getLand_certificate() {
        return land_certificate;
    }

    public void setLand_certificate(String land_certificate) {
        this.land_certificate = land_certificate;
    }

    public String getLand_issue_place() {
        return land_issue_place;
    }

    public void setLand_issue_place(String land_issue_place) {
        this.land_issue_place = land_issue_place;
    }

    public String getLand_map_number() {
        return land_map_number;
    }

    public void setLand_map_number(String land_map_number) {
        this.land_map_number = land_map_number;
    }

    public String getLand_number() {
        return land_number;
    }

    public void setLand_number(String land_number) {
        this.land_number = land_number;
    }

    public String getLand_address() {
        return land_address;
    }

    public void setLand_address(String land_address) {
        this.land_address = land_address;
    }

    public String getLand_area() {
        return land_area;
    }

    public void setLand_area(String land_area) {
        this.land_area = land_area;
    }

    public String getLand_public_area() {
        return land_public_area;
    }

    public void setLand_public_area(String land_public_area) {
        this.land_public_area = land_public_area;
    }

    public String getLand_private_area() {
        return land_private_area;
    }

    public void setLand_private_area(String land_private_area) {
        this.land_private_area = land_private_area;
    }

    public String getLand_use_purpose() {
        return land_use_purpose;
    }

    public void setLand_use_purpose(String land_use_purpose) {
        this.land_use_purpose = land_use_purpose;
    }

    public String getLand_use_period() {
        return land_use_period;
    }

    public void setLand_use_period(String land_use_period) {
        this.land_use_period = land_use_period;
    }

    public String getLand_use_origin() {
        return land_use_origin;
    }

    public void setLand_use_origin(String land_use_origin) {
        this.land_use_origin = land_use_origin;
    }

    public String getLand_associate_property() {
        return land_associate_property;
    }

    public void setLand_associate_property(String land_associate_property) {
        this.land_associate_property = land_associate_property;
    }

    public String getLand_street() {
        return land_street;
    }

    public void setLand_street(String land_street) {
        this.land_street = land_street;
    }

    public String getLand_district() {
        return land_district;
    }

    public void setLand_district(String land_district) {
        this.land_district = land_district;
    }

    public String getLand_province() {
        return land_province;
    }

    public void setLand_province(String land_province) {
        this.land_province = land_province;
    }

    public String getLand_full_of_area() {
        return land_full_of_area;
    }

    public void setLand_full_of_area(String land_full_of_area) {
        this.land_full_of_area = land_full_of_area;
    }

    public String getCar_license_number() {
        return car_license_number;
    }

    public void setCar_license_number(String car_license_number) {
        this.car_license_number = car_license_number;
    }

    public String getCar_regist_number() {
        return car_regist_number;
    }

    public void setCar_regist_number(String car_regist_number) {
        this.car_regist_number = car_regist_number;
    }

    public String getCar_issue_place() {
        return car_issue_place;
    }

    public void setCar_issue_place(String car_issue_place) {
        this.car_issue_place = car_issue_place;
    }

    public String getReceived_date() {
        return received_date;
    }

    public void setReceived_date(String received_date) {
        this.received_date = received_date;
    }

    public String getNotary_date() {
        return notary_date;
    }

    public void setNotary_date(String notary_date) {
        this.notary_date = notary_date;
    }

    public String getLand_issue_date() {
        return land_issue_date;
    }

    public void setLand_issue_date(String land_issue_date) {
        this.land_issue_date = land_issue_date;
    }

    public String getCar_issue_date() {
        return car_issue_date;
    }

    public void setCar_issue_date(String car_issue_date) {
        this.car_issue_date = car_issue_date;
    }

    public String getCar_frame_number() {
        return car_frame_number;
    }

    public void setCar_frame_number(String car_frame_number) {
        this.car_frame_number = car_frame_number;
    }

    public String getCar_machine_number() {
        return car_machine_number;
    }

    public void setCar_machine_number(String car_machine_number) {
        this.car_machine_number = car_machine_number;
    }

    public String getNumber_copy_of_contract() {
        return number_copy_of_contract;
    }

    public void setNumber_copy_of_contract(String number_copy_of_contract) {
        this.number_copy_of_contract = number_copy_of_contract;
    }

    public String getNumber_of_sheet() {
        return number_of_sheet;
    }

    public void setNumber_of_sheet(String number_of_sheet) {
        this.number_of_sheet = number_of_sheet;
    }

    public String getNumber_of_page() {
        return number_of_page;
    }

    public void setNumber_of_page(String number_of_page) {
        this.number_of_page = number_of_page;
    }

    public Long getCost_tt91() {
        return cost_tt91;
    }

    public void setCost_tt91(Long cost_tt91) {
        this.cost_tt91 = cost_tt91;
    }

    public Long getCost_draft() {
        return cost_draft;
    }

    public void setCost_draft(Long cost_draft) {
        this.cost_draft = cost_draft;
    }

    public Long getCost_notary_outsite() {
        return cost_notary_outsite;
    }

    public void setCost_notary_outsite(Long cost_notary_outsite) {
        this.cost_notary_outsite = cost_notary_outsite;
    }

    public Long getCost_other_determine() {
        return cost_other_determine;
    }

    public void setCost_other_determine(Long cost_other_determine) {
        this.cost_other_determine = cost_other_determine;
    }

    public Long getCost_total() {
        return cost_total;
    }

    public void setCost_total(Long cost_total) {
        this.cost_total = cost_total;
    }

    public Long getNotary_place_flag() {
        return notary_place_flag;
    }

    public void setNotary_place_flag(Long notary_place_flag) {
        this.notary_place_flag = notary_place_flag;
    }

    public String getNotary_place() {
        return notary_place;
    }

    public void setNotary_place(String notary_place) {
        this.notary_place = notary_place;
    }

    public Long getBank_id() {
        return bank_id;
    }

    public void setBank_id(Long bank_id) {
        this.bank_id = bank_id;
    }

    public String getBank_service_fee() {
        return bank_service_fee;
    }

    public void setBank_service_fee(String bank_service_fee) {
        this.bank_service_fee = bank_service_fee;
    }

    public String getCrediter_name() {
        return crediter_name;
    }

    public void setCrediter_name(String crediter_name) {
        this.crediter_name = crediter_name;
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

    public String getOriginal_store_place() {
        return original_store_place;
    }

    public void setOriginal_store_place(String original_store_place) {
        this.original_store_place = original_store_place;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
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

    public String getJsonstring() {
        return jsonstring;
    }

    public void setJsonstring(String jsonstring) {
        this.jsonstring = jsonstring;
    }

    public String getKindhtml() {
        return kindhtml;
    }

    public void setKindhtml(String kindhtml) {
        this.kindhtml = kindhtml;
    }

    public String getJson_property() {
        return json_property;
    }

    public void setJson_property(String json_property) {
        this.json_property = json_property;
    }

    public String getJson_person() {
        return json_person;
    }

    public void setJson_person(String json_person) {
        this.json_person = json_person;
    }

    public String getBank_code() {
        return bank_code;
    }

    public void setBank_code(String bank_code) {
        this.bank_code = bank_code;
    }

    public Long getSub_template_id() {
        return sub_template_id;
    }

    public void setSub_template_id(Long sub_template_id) {
        this.sub_template_id = sub_template_id;
    }

    public String getNotary_book() {
        return notary_book;
    }

    public void setNotary_book(String notary_book) {
        this.notary_book = notary_book;
    }

    public String getContract_signer() {
        return contract_signer;
    }

    public void setContract_signer(String contract_signer) {
        this.contract_signer = contract_signer;
    }

    public String getRequest_recipient() {
        return request_recipient;
    }

    public void setRequest_recipient(String request_recipient) {
        this.request_recipient = request_recipient;
    }
}
