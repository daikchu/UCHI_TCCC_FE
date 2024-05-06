package com.vn.osp.modelview;

/**
 * Created by Admin on 29/1/2018.
 */
public class SuggestPrivyHit {
    private Long _id;
    private String _index;
    private String _type;
    private Long _score;
    private SuggestPrivy _source;

    public SuggestPrivyHit() {
    }

    public SuggestPrivyHit(Long _id, String _index, String _type, Long _score, SuggestPrivy _source) {
        this._id = _id;
        this._index = _index;
        this._type = _type;
        this._score = _score;
        this._source = _source;
    }

    public Long get_id() {
        return _id;
    }

    public void set_id(Long _id) {
        this._id = _id;
    }

    public String get_index() {
        return _index;
    }

    public void set_index(String _index) {
        this._index = _index;
    }

    public String get_type() {
        return _type;
    }

    public void set_type(String _type) {
        this._type = _type;
    }

    public Long get_score() {
        return _score;
    }

    public void set_score(Long _score) {
        this._score = _score;
    }

    public SuggestPrivy get_source() {
        return _source;
    }

    public void set_source(SuggestPrivy _source) {
        this._source = _source;
    }
}
