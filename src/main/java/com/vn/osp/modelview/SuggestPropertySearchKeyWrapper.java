package com.vn.osp.modelview;

import java.util.List;

/**
 * Created by Admin on 16/1/2018.
 */
public class SuggestPropertySearchKeyWrapper {
    private String query;
    private List<SuggestPropertySearchKey> suggestions ;

    public SuggestPropertySearchKeyWrapper() {
    }

    public SuggestPropertySearchKeyWrapper(String query, List<SuggestPropertySearchKey> suggestions) {
        this.query = query;
        this.suggestions = suggestions;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public List<SuggestPropertySearchKey> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<SuggestPropertySearchKey> suggestions) {
        this.suggestions = suggestions;
    }
}
