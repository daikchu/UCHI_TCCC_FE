package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.EditString;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.ValidationPool;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

@Data
public class PropertyPrevent {
    private Long id;
    private String type;
    private String property_info;
    private String owner_info;
    private String other_info;
    private String land_certificate;
    private String land_issue_place;
    private String land_issue_date;
    private String land_paper_number;
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
    private String car_license_number;
    private String car_regist_number;
    private String car_issue_place;
    private String car_issue_date;
    private String car_frame_number;
    private String car_machine_number;

    @JsonIgnore
    private String property_info_disp;

    private Long prevent_id;
    private Integer release_flg;
    private String release_regist_agency;
    private String release_in_book_number;
    private String release_person_info;
    private String release_doc_number;
    private String release_doc_date;
    private String release_doc_receive_date;
    private String release_input_date;
    private String release_doc_summary;
    private String release_file_name;
    private String release_file_path;
    private String release_note;
    private String[] arrReleaseFileName;

    //validate
    private Boolean success;
    private Long id_;
    private String type_;
    private String property_info_;
    private String owner_info_;
    private String other_info_;
    private String land_certificate_;
    private String land_issue_place_;
    private String land_issue_date_;
    private String land_paper_number_;
    private String land_map_number_;
    private String land_number_;
    private String land_address_;
    private String land_area_;
    private String land_public_area_;
    private String land_private_area_;
    private String land_use_purpose_;
    private String land_use_period_;
    private String land_use_origin_;
    private String land_associate_property_;
    private String land_street_;
    private String land_district_;
    private String land_province_;
    private String car_license_number_;
    private String car_regist_number_;
    private String car_issue_place_;
    private String car_issue_date_;
    private String car_frame_number_;
    private String car_machine_number_;

    @JsonCreator
    public PropertyPrevent(@JsonProperty(value = "id", required = true) final Long id,
                           @JsonProperty(value = "type", required = true) final String type,
                           @JsonProperty(value = "property_info", required = true) final String property_info,
                           @JsonProperty(value = "owner_info", required = false) final String owner_info,
                           @JsonProperty(value = "other_info", required = false) final String other_info,
                           @JsonProperty(value = "land_certificate", required = false) final String land_certificate,
                           @JsonProperty(value = "land_issue_place", required = false) final String land_issue_place,
                           @JsonProperty(value = "land_issue_date", required = false) final String land_issue_date,
                           @JsonProperty(value = "land_paper_number", required = false) final String land_paper_number,
                           @JsonProperty(value = "land_map_number", required = false) final String land_map_number,
                           @JsonProperty(value = "land_number", required = false) final String land_number,
                           @JsonProperty(value = "land_address", required = false) final String land_address,
                           @JsonProperty(value = "land_area", required = false) final String land_area,
                           @JsonProperty(value = "land_public_area", required = false) final String land_public_area,
                           @JsonProperty(value = "land_private_area", required = false) final String land_private_area,
                           @JsonProperty(value = "land_use_purpose", required = false) final String land_use_purpose,
                           @JsonProperty(value = "land_use_period", required = false) final String land_use_period,
                           @JsonProperty(value = "land_use_origin", required = false) final String land_use_origin,
                           @JsonProperty(value = "land_associate_property", required = false) final String land_associate_property,
                           @JsonProperty(value = "land_street", required = false) final String land_street,
                           @JsonProperty(value = "land_district", required = false) final String land_district,
                           @JsonProperty(value = "land_province", required = false) final String land_province,
                           @JsonProperty(value = "car_license_number", required = false) final String car_license_number,
                           @JsonProperty(value = "car_regist_number", required = false) final String car_regist_number,
                           @JsonProperty(value = "car_issue_place", required = false) final String car_issue_place,
                           @JsonProperty(value = "car_issue_date", required = false) final String car_issue_date,
                           @JsonProperty(value = "car_frame_number", required = false) final String car_frame_number,
                           @JsonProperty(value = "car_machine_number", required = false) final String car_machine_number,
                           @JsonProperty(value = "prevent_id", required = false) final Long prevent_id,
                           @JsonProperty(value = "release_flg", required = false) final Integer release_flg,
                           @JsonProperty(value = "release_regist_agency", required = false) final String release_regist_agency,
                           @JsonProperty(value = "release_in_book_number", required = false) final String release_in_book_number,
                           @JsonProperty(value = "release_person_info", required = false) final String release_person_info,
                           @JsonProperty(value = "release_doc_number", required = false) final String release_doc_number,
                           @JsonProperty(value = "release_doc_date", required = false) final String release_doc_date,
                           @JsonProperty(value = "release_doc_receive_date", required = false) final String release_doc_receive_date,
                           @JsonProperty(value = "release_input_date", required = false) final String release_input_date,
                           @JsonProperty(value = "release_doc_summary", required = false) final String release_doc_summary,
                           @JsonProperty(value = "release_file_name", required = false) final String release_file_name,
                           @JsonProperty(value = "release_file_path", required = false) final String release_file_path,
                           @JsonProperty(value = "release_note", required = false) final String release_note,
                           @JsonProperty(value = "arrReleaseFileName", required = false) final String[] arrReleaseFileName) {
        this.id = id;
        this.type = type;
        this.property_info = property_info;
        this.owner_info = owner_info;
        this.other_info = other_info;
        this.land_certificate = land_certificate;
        this.land_issue_place = land_issue_place;
        this.land_issue_date = land_issue_date;
        this.land_paper_number = land_paper_number;
        this.land_map_number = land_map_number;
        this.land_number = land_number;
        this.land_address = land_address;
        this.land_area = land_area;
        this.land_public_area = land_public_area;
        this.land_private_area = land_private_area;
        this.land_use_purpose = land_use_purpose;
        this.land_use_period = land_use_period;
        this.land_use_origin = land_use_origin;
        this.land_associate_property = land_associate_property;
        this.land_street = land_street;
        this.land_district = land_district;
        this.land_province = land_province;
        this.car_license_number = car_license_number;
        this.car_regist_number = car_regist_number;
        this.car_issue_place = car_issue_place;
        this.car_issue_date = car_issue_date;
        this.car_frame_number = car_frame_number;
        this.car_machine_number = car_machine_number;

        this.prevent_id = prevent_id;
        this.release_flg = release_flg;
        this.release_regist_agency = release_regist_agency;
        this.release_in_book_number = release_in_book_number;
        this.release_person_info = release_person_info;
        this.release_doc_number = release_doc_number;
        this.release_doc_date = release_doc_date;
        this.release_doc_receive_date = release_doc_receive_date;
        this.release_input_date = release_input_date;
        this.release_doc_summary = release_doc_summary;
        this.release_file_name = release_file_name;
        this.release_file_path = release_file_path;
        this.release_note = release_note;
        this.arrReleaseFileName = arrReleaseFileName;
    }

    public String loaiTaiSan() {
        if (this.type.equals(Constants.NHA_DAT)) return "Nhà đất";
        else if (this.type.equals(Constants.OTO_XEMAY)) return "Ô tô - Xe máy";
        else if (this.type.equals(Constants.TAI_SAN_KHAC)) return "Tài sản khác";
        else return "";
    }

    public void getArrayReleaseFileName(){
        String listFileName[] = null;
        if (!StringUtils.isBlank(release_file_name)) {
            listFileName = release_file_name.split(",");
        }
        arrReleaseFileName = listFileName;
        // return listFileName;

    }


    /*public void validate() {
        success = true;
        String truong = SystemMessageProperties.getSystemProperty("v3_truong") +" ";
        String notEmpty = SystemMessageProperties.getSystemProperty("v3_not_empty");
        String max_length = SystemMessageProperties.getSystemProperty("v3_max_length");
        String min_length = SystemMessageProperties.getSystemProperty("v3_min_length");
        String ky_tu = SystemMessageProperties.getSystemProperty("v3_ky_tu");
        String thap_phan = SystemMessageProperties.getSystemProperty("v3_thap_phan");
        //nha dat
        if(type.equals("01")){
            if (land_address == null || land_address.equals("")){
                land_address_=(truong + SystemMessageProperties.getSystemProperty("v3_dia_chi") + notEmpty);
                success = false;
            }else if(!land_address.matches(ValidationPool.length(1,200))){
                land_address_=(truong + SystemMessageProperties.getSystemProperty("v3_dia_chi") + max_length + EditString.SPACE+ 200 + ky_tu);
                success = false;
            }
            if (land_certificate == null || land_certificate.equals("")){
                land_certificate_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_chung_nhan") + notEmpty);
                success = false;
            }else if(!land_certificate.matches(ValidationPool.length(1,50))){
                land_certificate_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_chung_nhan") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (land_paper_number == null || land_paper_number.equals("")){
                land_paper_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_vao_so") + notEmpty);
                success = false;
            }else if(!land_paper_number.matches(ValidationPool.length(1,50))){
                land_paper_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_vao_so") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (land_use_period == null || land_use_period.equals("")){
            }else if(!land_use_period.matches(ValidationPool.length(1,200))){
                land_use_period_=(truong + SystemMessageProperties.getSystemProperty("v3_thoi_han_sd") + max_length + EditString.SPACE+ 200 + ky_tu);
                success = false;
            }
            if (land_issue_place == null || land_issue_place.equals("")){
                land_issue_place_=(truong + SystemMessageProperties.getSystemProperty("v3_noi_cap") + notEmpty);
                success = false;
            }else if(!land_issue_place.matches(ValidationPool.length(1,100))){
                land_issue_place_=(truong + SystemMessageProperties.getSystemProperty("v3_noi_cap") + max_length + EditString.SPACE+ 100 + ky_tu);
                success = false;
            }
            if (land_number == null || land_number.equals("")){
                land_number_=(truong + SystemMessageProperties.getSystemProperty("v3_thua_dat_so") + notEmpty);
                success = false;
            }else if(!land_number.matches(ValidationPool.length(1,50))){
                land_number_=(truong + SystemMessageProperties.getSystemProperty("v3_thua_dat_so") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (land_map_number == null || land_map_number.equals("")){
                land_map_number_=(truong + SystemMessageProperties.getSystemProperty("v3_to_ban_do_so") + notEmpty);
                success = false;
            }else if(!land_map_number.matches(ValidationPool.length(1,50))){
                land_map_number_=(truong + SystemMessageProperties.getSystemProperty("v3_to_ban_do_so") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (land_area == null || land_area.equals("")){
                land_area_=(truong + SystemMessageProperties.getSystemProperty("v3_dien_tich") + notEmpty);
                success = false;
            }else{
                if(!ValidationPool.checkDecimal(land_area)){
                    land_area_=(truong + SystemMessageProperties.getSystemProperty("v3_dien_tich") + thap_phan);
                    success = false;
                }
            }
            if(land_private_area != null && !land_private_area.equals("")){
                if(!ValidationPool.checkDecimal(land_private_area)){
                    land_private_area_=(truong + SystemMessageProperties.getSystemProperty("v3_rieng") + thap_phan);
                    success = false;
                }
            }
            if(land_use_purpose != null && !land_use_purpose.equals("")){
                if(!land_use_purpose.matches(ValidationPool.length(1,500))){
                    land_use_purpose_=(truong + SystemMessageProperties.getSystemProperty("v3_muc_dich_sd") + max_length + EditString.SPACE+ 500 + ky_tu);
                    success = false;
                }
            }
            if(land_public_area != null && !land_public_area.equals("")){
                if(!ValidationPool.checkDecimal(land_public_area)){
                    land_public_area_=(truong + SystemMessageProperties.getSystemProperty("v3_chung") + thap_phan);
                    success = false;
                }
            }

            if (land_use_origin == null || land_use_origin.equals("")){
                land_use_origin_=(truong + SystemMessageProperties.getSystemProperty("v3_nguoc_goc_sd") + notEmpty);
                success = false;
            }else if(!land_use_origin.matches(ValidationPool.length(1,500))){
                land_use_origin_=(truong + SystemMessageProperties.getSystemProperty("v3_nguoc_goc_sd") + max_length + EditString.SPACE+ 500 + ky_tu);
                success = false;
            }
            if(land_associate_property != null && !land_associate_property.equals("")){
                if(!land_associate_property.matches(ValidationPool.length(1,200))){
                    land_associate_property_=(truong + SystemMessageProperties.getSystemProperty("v3_ts_gan_lien_voi_dat") + max_length + EditString.SPACE+ 200 + ky_tu);
                    success = false;
                }
            }

            if(land_issue_date != null && !land_issue_date.equals("")){
                if(!ValidationPool.checkDateFormat(land_issue_date)){
                    land_issue_date_=(truong + SystemMessageProperties.getSystemProperty("v3_date_format"));
                    success = false;
                }else if(!ValidationPool.compareToday(land_issue_date)){
                    land_issue_date_=(truong + SystemMessageProperties.getSystemProperty("v3_ngay_cap")+SystemMessageProperties.getSystemProperty("v3_compare_today"));
                    success = false;
                }

            }

        }
        //Oto xe may
        if(type.equals("02")){
            if (car_license_number == null || car_license_number.equals("")){
                car_license_number_=(truong + SystemMessageProperties.getSystemProperty("v3_bien_kiem_soat") + notEmpty);
                success = false;
            }else if(!car_license_number.matches(ValidationPool.length(1,50))){
                car_license_number_=(truong + SystemMessageProperties.getSystemProperty("v3_bien_kiem_soat") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (car_regist_number == null || car_regist_number.equals("")){
                car_regist_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_dky") + notEmpty);
                success = false;
            }else if(!car_regist_number.matches(ValidationPool.length(1,100))){
                car_regist_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_giay_dky") + max_length + EditString.SPACE+ 100 + ky_tu);
                success = false;
            }
            if (car_issue_place == null || car_issue_place.equals("")){
                car_issue_place_=(truong + SystemMessageProperties.getSystemProperty("v3_noi_cap") + notEmpty);
                success = false;
            }else if(!car_issue_place.matches(ValidationPool.length(1,100))){
                car_issue_place_=(truong + SystemMessageProperties.getSystemProperty("v3_noi_cap") + max_length + EditString.SPACE+ 100 + ky_tu);
                success = false;
            }
            if (car_frame_number == null || car_frame_number.equals("")){
                car_frame_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_khung") + notEmpty);
                success = false;
            }else if(!car_frame_number.matches(ValidationPool.length(1,50))){
                car_frame_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_khung") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if (car_machine_number == null || car_machine_number.equals("")){
                car_machine_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_may") + notEmpty);
                success = false;
            }else if(!car_machine_number.matches(ValidationPool.length(1,50))){
                car_machine_number_=(truong + SystemMessageProperties.getSystemProperty("v3_so_may") + max_length + EditString.SPACE+ 50 + ky_tu);
                success = false;
            }
            if(car_issue_date != null && !car_issue_date.equals("")){
                if(!ValidationPool.compareToday(car_issue_date)){
                    car_issue_date_=(truong + SystemMessageProperties.getSystemProperty("v3_ngay_cap") + SystemMessageProperties.getSystemProperty("v3_compare_today"));
                    success = false;
                }
            }
        }
        //Tai san khac
        if(type.equals("99")){
            if (property_info == null || property_info.equals("")){
                property_info_=(truong + SystemMessageProperties.getSystemProperty("v3_tt_tai_san") + notEmpty);
                success = false;
            }else if(!property_info.matches(ValidationPool.length(1,1000))){
                property_info_=(truong + SystemMessageProperties.getSystemProperty("v3_tt_tai_san") + max_length + EditString.SPACE+ 1000 + ky_tu);
                success = false;
            }
        }
        if (owner_info == null || owner_info.equals("")){
            owner_info_=(truong + SystemMessageProperties.getSystemProperty("v3_thong_tin_chu_so_huu") + notEmpty);
            success = false;
        }else if(!owner_info.matches(ValidationPool.length(1,500))){
            owner_info_=(truong + SystemMessageProperties.getSystemProperty("v3_thong_tin_chu_so_huu") + max_length + EditString.SPACE+ 500 + ky_tu);
            success = false;
        }
        if(other_info != null && !other_info.equals("")){
            if(!other_info.matches(ValidationPool.length(1,1000))){
                other_info_=(truong + SystemMessageProperties.getSystemProperty("v3_ts_gan_lien_voi_dat") + max_length + EditString.SPACE+ 1000 + ky_tu);
                success = false;
            }
        }
    }
*/
    public void genneratePropertyInfor() {
        String result = "";
        if (type.equals(Constants.NHA_DAT)) {
            if (land_address != null && !land_address.equals("")) result += "Địa chỉ: " + land_address + "; ";
            if (land_certificate != null && !land_certificate.equals(""))
                result += "Số giấy chứng nhận: " + land_certificate + "; ";
            if (land_issue_place != null && !land_issue_place.equals(""))
                result += "Nơi cấp: " + land_issue_place + "; ";
            if (land_issue_date != null && !land_issue_date.equals("")) result += "Ngày cấp: " + land_issue_date + "; ";
            if (land_paper_number != null && !land_paper_number.equals("")) result += "Số giấy vào sổ: " + land_paper_number + "; ";
            if (land_number != null && !land_number.equals("")) result += "Thửa đất số: " + land_number + "; ";
            if (land_map_number != null && !land_map_number.equals(""))
                result += "Tờ bản đồ số: " + land_map_number + "; ";
            if (land_area != null && !land_area.equals("")) result += "Diện tích (m2): " + land_area + "; ";
            if (land_private_area != null && !land_private_area.equals(""))
                result += "Diện tích sử dụng riêng: " + land_private_area + "; ";
            if (land_public_area != null && !land_public_area.equals(""))
                result += "Diện tích sử dụng chung: " + land_public_area +"; ";
            if (land_use_purpose != null && !land_use_purpose.equals(""))
                result += "Mục đích sử dụng: " + land_use_purpose + "; ";
            if (land_use_period != null && !land_use_period.equals(""))
                result += "Thời hạn sử dụng: " + land_use_period + "; ";
            if (land_associate_property != null && !land_associate_property.equals(""))
                result += "Tài sản gắn liền với đất: " + land_associate_property + "; ";
            if (owner_info != null && !owner_info.equals("")) result += "Thông tin chủ sở hữu: " + owner_info + "; ";
            if (other_info != null && !other_info.equals("")) result += "Thông tin khác: " + other_info;
        }
        if (type.equals(Constants.OTO_XEMAY)) {
            if (car_license_number != null && !car_license_number.equals(""))
                result += "Biển kiểm soát: " + car_license_number + "; ";
            if (car_regist_number != null && !car_regist_number.equals(""))
                result += "Số giấy đăng ký: " + land_address + "; ";
            if (car_issue_place != null && !car_issue_place.equals("")) result += "Nơi cấp: " + land_address + "; ";
            if (car_issue_date != null && !car_issue_date.equals("")) result += "Ngày cấp: " + land_address + "; ";
            if (car_frame_number != null && !car_frame_number.equals("")) result += "Số khung: " + land_address + "; ";
            if (car_machine_number != null && !car_machine_number.equals(""))
                result += "Số máy: " + car_machine_number + "; ";
            if (owner_info != null && !owner_info.equals("")) result += "Thông tin chủ sở hữu: " + owner_info + "; ";
            if (other_info != null && !other_info.equals("")) result += "Thông tin khác: " + other_info;
        }
        if (type.equals(Constants.TAI_SAN_KHAC)) {
            if (property_info != null && !property_info.equals(""))
                result += "Thông tin tài sản: " + property_info + "; ";
            if (owner_info != null && !owner_info.equals("")) result += "Thông tin chủ sở hữu: " + owner_info + "; ";
            if (other_info != null && !other_info.equals("")) result += "Thông tin khác: " + other_info;
        }

        this.property_info = result;
    }
}
