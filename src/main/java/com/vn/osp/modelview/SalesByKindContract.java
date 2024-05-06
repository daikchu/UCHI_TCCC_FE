package com.vn.osp.modelview;

/**
 * Created by Admin on 2018-05-25.
 */
public class SalesByKindContract {

    private String kindName;
    private Long numberContract;
    private Long cost_tt91;
    private Long cost_draft;
    private Long cost_notary_outside;
    private Long cost_other_determine;
    private Long cost_total;

    public SalesByKindContract() {
    }

    public SalesByKindContract(String kindName, Long numberContract, Long cost_tt91, Long cost_draft, Long cost_notary_outside, Long cost_other_determine, Long cost_total) {
        this.kindName = kindName;
        this.numberContract = numberContract;
        this.cost_tt91 = cost_tt91;
        this.cost_draft = cost_draft;
        this.cost_notary_outside = cost_notary_outside;
        this.cost_other_determine = cost_other_determine;
        this.cost_total = cost_total;
    }

    public String getKindName() {
        return kindName;
    }

    public void setKindName(String kindName) {
        this.kindName = kindName;
    }

    public Long getNumberContract() {
        return numberContract;
    }

    public void setNumberContract(Long numberContract) {
        this.numberContract = numberContract;
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

    public Long getCost_notary_outside() {
        return cost_notary_outside;
    }

    public void setCost_notary_outside(Long cost_notary_outside) {
        this.cost_notary_outside = cost_notary_outside;
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
}
