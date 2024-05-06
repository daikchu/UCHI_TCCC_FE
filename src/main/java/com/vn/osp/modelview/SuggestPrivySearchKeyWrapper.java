package com.vn.osp.modelview;

import com.vn.osp.modelview.SuggestPrivySearchKey;

import java.util.List;

/**
 * Created by Admin on 13/1/2018.
 */
public class SuggestPrivySearchKeyWrapper {
    private String query;
    private List<SuggestPrivySearchKey> suggestions ;

    public SuggestPrivySearchKeyWrapper() {
    }

    public SuggestPrivySearchKeyWrapper(String query, List<SuggestPrivySearchKey> suggestions) {
        this.query = query;
        this.suggestions = suggestions;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public List<SuggestPrivySearchKey> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<SuggestPrivySearchKey> suggestions) {
        this.suggestions = suggestions;
    }
}
