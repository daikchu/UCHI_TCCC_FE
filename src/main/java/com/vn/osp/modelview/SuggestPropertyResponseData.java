package com.vn.osp.modelview;

import com.vn.osp.elasticsearch.Shards;

/**
 * Created by Admin on 29/1/2018.
 */
public class SuggestPropertyResponseData {
    private Shards _shards;
    private Boolean timed_out;
    private Long took;
    private SuggestPropertyHits hits;

    public SuggestPropertyResponseData() {
    }

    public SuggestPropertyResponseData(Shards _shards, Boolean timed_out, Long took, SuggestPropertyHits hits) {
        this._shards = _shards;
        this.timed_out = timed_out;
        this.took = took;
        this.hits = hits;
    }

    public Shards get_shards() {
        return _shards;
    }

    public void set_shards(Shards _shards) {
        this._shards = _shards;
    }

    public Boolean getTimed_out() {
        return timed_out;
    }

    public void setTimed_out(Boolean timed_out) {
        this.timed_out = timed_out;
    }

    public Long getTook() {
        return took;
    }

    public void setTook(Long took) {
        this.took = took;
    }

    public SuggestPropertyHits getHits() {
        return hits;
    }

    public void setHits(SuggestPropertyHits hits) {
        this.hits = hits;
    }
}
