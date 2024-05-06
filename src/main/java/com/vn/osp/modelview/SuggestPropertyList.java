package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;

import java.util.List;

/**
 * Created by Admin on 2018-04-06.
 */
public class SuggestPropertyList {
    private List<SuggestProperty> suggestPropertyList;

    public SuggestPropertyList() {
    }
    @JsonCreator
    public SuggestPropertyList(@JsonProperty(value = "suggestPropertyList",required = true)final List suggestPropertyList){
        this.suggestPropertyList = suggestPropertyList;
    }

    public List<SuggestProperty> getSuggestPropertyList() {
        return suggestPropertyList;
    }

    public void setSuggestPropertyList(List<SuggestProperty> suggestPropertyList) {
        this.suggestPropertyList = suggestPropertyList;
    }

    public String generateJson() {
        JSONObject obj = new JSONObject();
        ObjectMapper mapper = new ObjectMapper();

        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
