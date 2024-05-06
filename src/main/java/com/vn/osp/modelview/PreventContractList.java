package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import org.json.JSONObject;

import java.util.List;

/**
 * Created by tranv on 12/22/2016.
 */
@Data
public class PreventContractList {
    private long user_id;
    private List<DataPreventInfor> daDuyetList;
    private int daDuyetListNumber;
    private int daDuyetTotalPage;

    private List<DataPreventInfor> thamKhaoList;
    private int thamKhaoListNumber;
    private int thamKhaoTotalPage;

    private List<TransactionProperty> hopDongList;
    private int hopDongListNumber;
    private int hopDongTotalPage;

    private int defaultTabOpen;
    private int daDuyetPage;
    private int thamKhaoPage;
    private int hopDongPage;

    //is advance search
    private String isAdvanceSearch;
    private String propertyType;
    private String propertyInfo;
    private String ownerInfo;

    //is key search
    private String stringKey;
    private String listKey;
    private boolean basicAreaSearch;
    private boolean advanceAreaSearch;
    private String searchTime;

    private String notary_office_code;

    public String generateJson(){
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
