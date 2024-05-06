package com.vn.osp.modelview;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;

/**
 * Created by Admin on 8/1/2018.
 */
public class MailTLSSendList {
    private String email;
    private String account;
    private String newPass;
    private String linkLogin;

    public MailTLSSendList() {
    }

    public MailTLSSendList(String email, String account, String newPass, String linkLogin) {
        this.email = email;
        this.account = account;
        this.newPass = newPass;
        this.linkLogin = linkLogin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getNewPass() {
        return newPass;
    }

    public void setNewPass(String newPass) {
        this.newPass = newPass;
    }

    public String getLinkLogin() {
        return linkLogin;
    }

    public void setLinkLogin(String linkLogin) {
        this.linkLogin = linkLogin;
    }

    public String generateAddJson() {
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
