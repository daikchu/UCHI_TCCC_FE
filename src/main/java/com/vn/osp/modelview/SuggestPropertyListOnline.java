package com.vn.osp.modelview;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;

import java.util.List;

/**
 * Created by Admin on 2018-04-18.
 */
public class SuggestPropertyListOnline {
    private List<SuggestProperty> suggestPropertyList;
    private String statusOnline;
    public SuggestPropertyListOnline() {
    }
    @JsonCreator
    public SuggestPropertyListOnline(@JsonProperty(value = "suggestPropertyList",required = true)final List suggestPropertyList,
                                     @JsonProperty(value = "statusOnline",required = true)final String statusOnline
                                     ){
        this.statusOnline = statusOnline;
        this.suggestPropertyList = suggestPropertyList;
    }

    public List<SuggestProperty> getSuggestPropertyList() {
        return suggestPropertyList;
    }

    public void setSuggestPropertyList(List<SuggestProperty> suggestPropertyList) {
        this.suggestPropertyList = suggestPropertyList;
    }

    public String getStatusOnline() {
        return statusOnline;
    }

    public void setStatusOnline(String statusOnline) {
        this.statusOnline = statusOnline;
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
