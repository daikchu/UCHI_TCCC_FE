package com.vn.osp.elasticsearch;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by tranv on 3/25/2017.
 */
public class TransactionPropertyResponseData {
    private Shards _shards;
    private Boolean timed_out;
    private Long took;
    private TransactionPropertyHits hits;

    @JsonCreator
    public TransactionPropertyResponseData(@JsonProperty(value = "_shards", required = false) final Shards _shards,
                                           @JsonProperty(value = "timed_out", required = false) final Boolean timed_out,
                                           @JsonProperty(value = "took", required = false) final Long took,
                                           @JsonProperty(value = "hits", required = false) final TransactionPropertyHits hits) {
        this._shards = _shards;
        this.timed_out = timed_out;
        this.took = took;
        this.hits = hits;
    }

    public TransactionPropertyResponseData() {
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

    public TransactionPropertyHits getHits() {
        return hits;
    }

    public void setHits(TransactionPropertyHits hits) {
        this.hits = hits;
    }
}
