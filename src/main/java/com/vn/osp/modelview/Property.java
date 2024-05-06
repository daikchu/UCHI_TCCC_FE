package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.sql.Timestamp;

/**
 * Created by TienManh on 5/15/2017.
 */
public class Property {
    private int id;
    private String type;
    private String property_info;
    private String owner_info;
    private String other_info;
    private String land_certificate;
    /*09/09/2020 Bổ sung trường vào sổ cấp số giấy chứng nhận số*/
    private String land_certificate_number_input;
    /*END 09/09/2020 Bổ sung trường vào sổ cấp số giấy chứng nhận số*/
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

    /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
    private String owner_info_address;
    private String airplane_name;
    private String airplane_regist_number;
    private String airplane_type;
    private String airplane_engine_number;
    private String airplane_max_weight;
    private String airplane_producer;
    private String airplane_year_manufacture;
    private String airplane_factory_number;
    private String airplane_regist_number_vietnam;
    private String ship_name;
    private String ship_regist_number;
    private String ship_level;
    private String ship_function;
    private String ship_year_place_construction;
    private String ship_design_length;
    private String ship_max_length;
    private String ship_design_height;
    private String ship_max_height;
    private String ship_width;
    private String ship_dimension_sinking;
    private String ship_freeboard;
    private String ship_hull_material;
    /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/

    public Property(){}

    @JsonCreator
    public Property(
            @JsonProperty(value="id",required= true) final int id,
            @JsonProperty(value="type", required = true) final String type,
            @JsonProperty(value="property_info", required= true) final String property_info,
            @JsonProperty(value="owner_info", required= true) final String owner_info,
            @JsonProperty(value="other_info", required= true) final String other_info,
            @JsonProperty(value="land_certificate", required= true) final String land_certificate,
            /*09/09/2020 Bổ sung trường vào sổ cấp số giấy chứng nhận số*/
            @JsonProperty(value="land_certificate_number_input", required= false) final String land_certificate_number_input,
            /*END 09/09/2020 Bổ sung trường vào sổ cấp số giấy chứng nhận số*/
            @JsonProperty(value="land_issue_place", required= true) final String land_issue_place,
            @JsonProperty(value="land_issue_date", required= true) final String land_issue_date,
            @JsonProperty(value="land_map_number", required= true) final String land_map_number,
            @JsonProperty(value="land_number", required= true) final String land_number,
            @JsonProperty(value="land_address", required= true) final String land_address,
            @JsonProperty(value="land_area", required= true) final String land_area,
            @JsonProperty(value="land_public_area", required= true) final String land_public_area,
            @JsonProperty(value="land_private_area", required= true) final String land_private_area,
            @JsonProperty(value="land_use_purpose", required= true) final String land_use_purpose,
            @JsonProperty(value="land_use_period", required= true) final String land_use_period,
            @JsonProperty(value="land_use_origin", required= true) final String land_use_origin,
            @JsonProperty(value="land_associate_property", required= true) final String land_associate_property,
            @JsonProperty(value="land_street", required= true) final String land_street,
            @JsonProperty(value="land_district", required= true) final String land_district,
            @JsonProperty(value="land_province", required= true) final String land_province,
            @JsonProperty(value="land_full_of_area", required= true) final String land_full_of_area,
            @JsonProperty(value="car_license_number", required= true) final String car_license_number,
            @JsonProperty(value="car_regist_number", required= true) final String car_regist_number,
            @JsonProperty(value="car_issue_place", required= true) final String car_issue_place,
            @JsonProperty(value="car_issue_date", required= true) final String car_issue_date,
            @JsonProperty(value="car_frame_number", required= true) final String car_frame_number,
            @JsonProperty(value="car_machine_number", required= true) final String car_machine_number,

            /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
            @JsonProperty(value="owner_info_address", required= true) final String owner_info_address,
            @JsonProperty(value="airplane_name", required= true) final String airplane_name,
            @JsonProperty(value="airplane_regist_number", required= true) final String airplane_regist_number,
            @JsonProperty(value="airplane_type", required= true) final String airplane_type,
            @JsonProperty(value="airplane_engine_number", required= true) final String airplane_engine_number,
            @JsonProperty(value="airplane_max_weight", required= true) final String airplane_max_weight,
            @JsonProperty(value="airplane_producer", required= true) final String airplane_producer,
            @JsonProperty(value="airplane_year_manufacture", required= true) final String airplane_year_manufacture,
            @JsonProperty(value="airplane_factory_number", required= true) final String airplane_factory_number,
            @JsonProperty(value="airplane_regist_number_vietnam", required= true) final String airplane_regist_number_vietnam,
            @JsonProperty(value="ship_name", required= true) final String ship_name,
            @JsonProperty(value="ship_regist_number", required= true) final String ship_regist_number,
            @JsonProperty(value="ship_level", required= true) final String ship_level,
            @JsonProperty(value="ship_function", required= true) final String ship_function,
            @JsonProperty(value="ship_year_place_construction", required= true) final String ship_year_place_construction,
            @JsonProperty(value="ship_design_length", required= true) final String ship_design_length,
            @JsonProperty(value="ship_max_length", required= true) final String ship_max_length,
            @JsonProperty(value="ship_design_height", required= true) final String ship_design_height,
            @JsonProperty(value="ship_max_height", required= true) final String ship_max_height,
            @JsonProperty(value="ship_width", required= true) final String ship_width,
            @JsonProperty(value="ship_dimension_sinking", required= true) final String ship_dimension_sinking,
            @JsonProperty(value="ship_freeboard", required= true) final String ship_freeboard,
            @JsonProperty(value="ship_hull_material", required= true) final String ship_hull_material
            /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
    ){

        this.id=id;
        this.type=type;
        this.property_info=property_info;
        this.owner_info=owner_info;
        this.other_info=other_info;
        this.land_certificate=land_certificate;
        this.land_certificate_number_input = land_certificate_number_input;
        this.land_issue_place=land_issue_place;
        this.land_issue_date=land_issue_date;
        this.land_map_number=land_map_number;
        this.land_number=land_number;
        this.land_address=land_address;
        this.land_area=land_area;
        this.land_public_area=land_public_area;
        this.land_private_area=land_private_area;
        this.land_use_purpose=land_use_purpose;
        this.land_use_period=land_use_period;
        this.land_use_origin=land_use_origin;
        this.land_associate_property=land_associate_property;
        this.land_street=land_street;
        this.land_district=land_district;
        this.land_province=land_province;
        this.land_full_of_area=land_full_of_area;
        this.car_license_number=car_license_number;
        this.car_regist_number=car_regist_number;
        this.car_issue_place=car_issue_place;
        this.car_issue_date=car_issue_date;
        this.car_frame_number=car_frame_number;
        this.car_machine_number=car_machine_number;

        /*05/09/2020 Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/
        this.owner_info_address = owner_info_address;
        this.airplane_name = airplane_name;
        this.airplane_regist_number = airplane_regist_number;
        this.airplane_type = airplane_type;
        this.airplane_engine_number = airplane_engine_number;
        this.airplane_max_weight = airplane_max_weight;
        this.airplane_producer = airplane_producer;
        this.airplane_year_manufacture = airplane_year_manufacture;
        this.airplane_factory_number = airplane_factory_number;
        this.airplane_regist_number_vietnam = airplane_regist_number_vietnam;
        this.ship_name = ship_name;
        this.ship_regist_number = ship_regist_number;
        this.ship_level = ship_level;
        this.ship_function = ship_function;
        this.ship_year_place_construction = ship_year_place_construction;
        this.ship_design_length = ship_design_length;
        this.ship_max_length = ship_max_length;
        this.ship_design_height = ship_design_height;
        this.ship_max_height = ship_max_height;
        this.ship_width = ship_width;
        this.ship_dimension_sinking = ship_dimension_sinking;
        this.ship_freeboard = ship_freeboard;
        this.ship_hull_material = ship_hull_material;
        /*END Bổ sung trường tài sản phương tiện vận tài là "Tàu bay" và "Phương tiện thủy nội địa"*/

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getLand_certificate_number_input() {
        return land_certificate_number_input;
    }

    public void setLand_certificate_number_input(String land_certificate_number_input) {
        this.land_certificate_number_input = land_certificate_number_input;
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

    public String getOwner_info_address() {
        return owner_info_address;
    }

    public void setOwner_info_address(String owner_info_address) {
        this.owner_info_address = owner_info_address;
    }

    public String getAirplane_name() {
        return airplane_name;
    }

    public void setAirplane_name(String airplane_name) {
        this.airplane_name = airplane_name;
    }

    public String getAirplane_regist_number() {
        return airplane_regist_number;
    }

    public void setAirplane_regist_number(String airplane_regist_number) {
        this.airplane_regist_number = airplane_regist_number;
    }

    public String getAirplane_type() {
        return airplane_type;
    }

    public void setAirplane_type(String airplane_type) {
        this.airplane_type = airplane_type;
    }

    public String getAirplane_engine_number() {
        return airplane_engine_number;
    }

    public void setAirplane_engine_number(String airplane_engine_number) {
        this.airplane_engine_number = airplane_engine_number;
    }

    public String getAirplane_max_weight() {
        return airplane_max_weight;
    }

    public void setAirplane_max_weight(String airplane_max_weight) {
        this.airplane_max_weight = airplane_max_weight;
    }

    public String getAirplane_producer() {
        return airplane_producer;
    }

    public void setAirplane_producer(String airplane_producer) {
        this.airplane_producer = airplane_producer;
    }

    public String getAirplane_year_manufacture() {
        return airplane_year_manufacture;
    }

    public void setAirplane_year_manufacture(String airplane_year_manufacture) {
        this.airplane_year_manufacture = airplane_year_manufacture;
    }

    public String getAirplane_factory_number() {
        return airplane_factory_number;
    }

    public void setAirplane_factory_number(String airplane_factory_number) {
        this.airplane_factory_number = airplane_factory_number;
    }

    public String getAirplane_regist_number_vietnam() {
        return airplane_regist_number_vietnam;
    }

    public void setAirplane_regist_number_vietnam(String airplane_regist_number_vietnam) {
        this.airplane_regist_number_vietnam = airplane_regist_number_vietnam;
    }

    public String getShip_name() {
        return ship_name;
    }

    public void setShip_name(String ship_name) {
        this.ship_name = ship_name;
    }

    public String getShip_regist_number() {
        return ship_regist_number;
    }

    public void setShip_regist_number(String ship_regist_number) {
        this.ship_regist_number = ship_regist_number;
    }

    public String getShip_level() {
        return ship_level;
    }

    public void setShip_level(String ship_level) {
        this.ship_level = ship_level;
    }

    public String getShip_function() {
        return ship_function;
    }

    public void setShip_function(String ship_function) {
        this.ship_function = ship_function;
    }

    public String getShip_year_place_construction() {
        return ship_year_place_construction;
    }

    public void setShip_year_place_construction(String ship_year_place_construction) {
        this.ship_year_place_construction = ship_year_place_construction;
    }

    public String getShip_design_length() {
        return ship_design_length;
    }

    public void setShip_design_length(String ship_design_length) {
        this.ship_design_length = ship_design_length;
    }

    public String getShip_max_length() {
        return ship_max_length;
    }

    public void setShip_max_length(String ship_max_length) {
        this.ship_max_length = ship_max_length;
    }

    public String getShip_design_height() {
        return ship_design_height;
    }

    public void setShip_design_height(String ship_design_height) {
        this.ship_design_height = ship_design_height;
    }

    public String getShip_max_height() {
        return ship_max_height;
    }

    public void setShip_max_height(String ship_max_height) {
        this.ship_max_height = ship_max_height;
    }

    public String getShip_width() {
        return ship_width;
    }

    public void setShip_width(String ship_width) {
        this.ship_width = ship_width;
    }

    public String getShip_dimension_sinking() {
        return ship_dimension_sinking;
    }

    public void setShip_dimension_sinking(String ship_dimension_sinking) {
        this.ship_dimension_sinking = ship_dimension_sinking;
    }

    public String getShip_freeboard() {
        return ship_freeboard;
    }

    public void setShip_freeboard(String ship_freeboard) {
        this.ship_freeboard = ship_freeboard;
    }

    public String getShip_hull_material() {
        return ship_hull_material;
    }

    public void setShip_hull_material(String ship_hull_material) {
        this.ship_hull_material = ship_hull_material;
    }
}
