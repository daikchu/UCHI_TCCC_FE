package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

/**
 * Created by Admin on 2018-05-18.
 */
public class ContractFeeBO {
    private int id;
    private Long ct_template_code;
    private Long from_fee;
    private Long to_fee;
    private String formula_fee;
    private String circulars_fee;

    private String notaryFeeNumber;
    private String notaryFeeMax;

    private String code_kind;
    private String template_name;
    private String kind_name;
    @JsonIgnore
    private List<ContractKind> contractKindList;
    @JsonIgnore
    private List<ContractTemp> contractTempList;
    @JsonIgnore
    private String formula_fee_;
    @JsonIgnore
    private Boolean success;
    @JsonIgnore
    private String ct_template_code_;
    @JsonIgnore
    private String kindCode;

    @JsonIgnore
    private Boolean status;

    @JsonIgnore
    private String nhomHD;
    @JsonIgnore
    private String nameCode;

    @JsonIgnore
    private String from_fee_;

    @JsonIgnore
    private String space_;

    @JsonIgnore
    private String to_fee_;

    public ContractFeeBO() {
    }

    public ContractFeeBO(int id, Long ct_template_code, Long from_fee, Long to_fee, String formula_fee,String notaryFeeNumber) {
        this.id = id;
        this.ct_template_code = ct_template_code;
        this.from_fee = from_fee;
        this.to_fee = to_fee;
        this.formula_fee = formula_fee;
        this.notaryFeeNumber = notaryFeeNumber;
    }

    public String getNotaryFeeNumber() {
        return notaryFeeNumber;
    }

    public void setNotaryFeeNumber(String notaryFeeNumber) {
        this.notaryFeeNumber = notaryFeeNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Long getCt_template_code() {
        return ct_template_code;
    }

    public void setCt_template_code(Long ct_template_code) {
        this.ct_template_code = ct_template_code;
    }

    public Long getFrom_fee() {
        return from_fee;
    }

    public void setFrom_fee(Long from_fee) {
        this.from_fee = from_fee;
    }

    public Long getTo_fee() {
        return to_fee;
    }

    public void setTo_fee(Long to_fee) {
        this.to_fee = to_fee;
    }

    public String getFormula_fee() {
        return formula_fee;
    }

    public void setFormula_fee(String formula_fee) {
        this.formula_fee = formula_fee;
    }

    public String getCode_kind() {
        return code_kind;
    }

    public void setCode_kind(String code_kind) {
        this.code_kind = code_kind;
    }

    public String getTemplate_name() {
        return template_name;
    }

    public void setTemplate_name(String template_name) {
        this.template_name = template_name;
    }

    public String getKind_name() {
        return kind_name;
    }

    public void setKind_name(String kind_name) {
        this.kind_name = kind_name;
    }

    public List<ContractKind> getContractKindList() {
        return contractKindList;
    }

    public void setContractKindList(List<ContractKind> contractKindList) {
        this.contractKindList = contractKindList;
    }

    public List<ContractTemp> getContractTempList() {
        return contractTempList;
    }

    public void setContractTempList(List<ContractTemp> contractTempList) {
        this.contractTempList = contractTempList;
    }

    public String getFormula_fee_() {
        return formula_fee_;
    }

    public void setFormula_fee_(String formula_fee_) {
        this.formula_fee_ = formula_fee_;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String getCt_template_code_() {
        return ct_template_code_;
    }

    public void setCt_template_code_(String ct_template_code_) {
        this.ct_template_code_ = ct_template_code_;
    }

    public String getKindCode() {
        return kindCode;
    }

    public void setKindCode(String kindCode) {
        this.kindCode = kindCode;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getNhomHD() {
        return nhomHD;
    }

    public void setNhomHD(String nhomHD) {
        this.nhomHD = nhomHD;
    }

    public String getNameCode() {
        return nameCode;
    }

    public void setNameCode(String nameCode) {
        this.nameCode = nameCode;
    }

    public String getFrom_fee_() {
        return from_fee_;
    }

    public void setFrom_fee_(String from_fee_) {
        this.from_fee_ = from_fee_;
    }

    public String getSpace_() {
        return space_;
    }

    public void setSpace_(String space_) {
        this.space_ = space_;
    }

    public String getTo_fee_() {
        return to_fee_;
    }

    public void setTo_fee_(String to_fee_) {
        this.to_fee_ = to_fee_;
    }

    public String getNotaryFeeMax() {
        return notaryFeeMax;
    }

    public void setNotaryFeeMax(String notaryFeeMax) {
        this.notaryFeeMax = notaryFeeMax;
    }

    public String getCirculars_fee() {
        return circulars_fee;
    }

    public void setCirculars_fee(String circulars_fee) {
        this.circulars_fee = circulars_fee;
    }
}
