package com.vn.osp.modelview;

import lombok.Data;

import java.util.List;

@Data
public class AttestationList {
    private List<Attestation> attestationList;
    private String name;
    private int page;
    private int totalPage;
    private int total;

    public String getOrderString(){
        String whereString ="where 1=1" ;
        String orderString1 ="";
        String orderString2 ="";
        String orderString3 ="";
      //  String orderBy = " ORDER BY nct.code,nct.name asc";
        if(name!= null && !name.equals("")){

            orderString1 = " and bo.name like '%"+name.trim()+"%'";
        }


        String query = whereString  + orderString1 + orderString2 + orderString3;
        return query;
    }
}
