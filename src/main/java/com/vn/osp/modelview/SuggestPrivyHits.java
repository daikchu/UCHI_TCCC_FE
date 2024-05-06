package com.vn.osp.modelview;

import java.util.List;

/**
 * Created by Admin on 29/1/2018.
 */
public class SuggestPrivyHits {
    private Long total;
    private Long max_score;
    private List<SuggestPrivyHit> hits;

    public SuggestPrivyHits() {
    }

    public SuggestPrivyHits(Long total, Long max_score, List<SuggestPrivyHit> hits) {
        this.total = total;
        this.max_score = max_score;
        this.hits = hits;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Long getMax_score() {
        return max_score;
    }

    public void setMax_score(Long max_score) {
        this.max_score = max_score;
    }

    public List<SuggestPrivyHit> getHits() {
        return hits;
    }

    public void setHits(List<SuggestPrivyHit> hits) {
        this.hits = hits;
    }
}
