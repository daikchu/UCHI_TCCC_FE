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
public class SuggestPrivyList {
    private List<SuggestPrivy> suggestPrivyList;

    public SuggestPrivyList() {
    }
    @JsonCreator
    public SuggestPrivyList(@JsonProperty(value="suggestPrivyList",required = true) final List suggestPrivyList ) {
        this.suggestPrivyList = suggestPrivyList;
    }

    public List<SuggestPrivy> getSuggestPrivyList() {
        return suggestPrivyList;
    }

    public void setSuggestPrivyList(List<SuggestPrivy> suggestPrivyList) {
        this.suggestPrivyList = suggestPrivyList;
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
