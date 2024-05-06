package com.vn.osp.auth;

import com.vn.osp.common.global.Constants;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

/** Createdby: quyenlc on:01/03/2022
 */
@Controller
public class AuthController {
    private static final Logger LOG = LoggerFactory.getLogger(AuthController.class);


    public String authenticationSTP(boolean codeExits, HttpServletRequest request) {
        HttpSession session = request.getSession();
        HttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost(Constants.STP_API_LINK+"/authenticate");

        List<BasicNameValuePair> urlParameters = new ArrayList<BasicNameValuePair>();
        urlParameters.add(new BasicNameValuePair("username", "admin"));
        urlParameters.add(new BasicNameValuePair("password", "Admin123456"));

        String access_token = "";
        if (!codeExits) {
            if (session.getAttribute("access_token") == null || session.getAttribute("access_token") == "") {
                try {
                    post.setEntity(new UrlEncodedFormEntity(urlParameters));
                    HttpResponse response = client.execute(post);
                    BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
                    StringBuffer result = new StringBuffer();
                    String output = "";
                    while ((output = rd.readLine()) != null) {
                        result.append(output);
                        String result1 = "[" + result + "]";
                        JSONArray jsonArray = new JSONArray(result1);
                        if (jsonArray != null) {
                            access_token = jsonArray.getJSONObject(0).getString("access_token");
//                            String refresh_token = jsonArray.getJSONObject(0).getString("refresh_token");
//                            String id_token = jsonArray.getJSONObject(0).getString("id_token");
//                            long expires_in = jsonArray.getJSONObject(0).getLong("expires_in");
//                            long milliseconds = new Date().getTime();
                            session.setAttribute("token", access_token);
//                            session.setAttribute("refresh_token", refresh_token);
//                            session.setAttribute("id_token", id_token);
//                            session.setAttribute("expires_in", milliseconds + (expires_in * 1000));
                        }
                    }
                } catch (Exception e) {
                    LOG.error("Lỗi kết nối xác thực:" + e.getMessage());
                }
            } else {
                access_token = session.getAttribute("access_token").toString();
            }
        } else {
            access_token = session.getAttribute("access_token").toString();
        }
        return access_token;
    }

    public String getUserInfo(String token) throws JSONException {
        String result = "";
        try {
            MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
            headers.add("Authorization", "Bearer " + token);

            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(null, headers);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(0,new StringHttpMessageConverter(StandardCharsets.UTF_8));
            String user_info = restTemplate.postForObject(Constants.STP_API_LINK+"/authenticate", request, String.class);
            result = "[" + user_info + "]";
            return result;
        }catch (Exception ex){
            LOG.error("Có lỗi xảy ra:"+ex.getMessage());
            return result;
        }
    }
//    public void getRefreshToken(String refresh_token, HttpServletRequest req) {
//        try {
//            HttpSession session = req.getSession();
//            MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
//            String encodeBytes = Base64.getEncoder().encodeToString((client_id + ":" + client_secret).getBytes());
//            headers.add("Authorization", "Basic " + encodeBytes);
//            MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
//            requestParams.add("grant_type", "refresh_token");
//            requestParams.add("refresh_token", refresh_token);
//            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestParams, headers);
//            RestTemplate restTemplate = new RestTemplate();
//            String info_token = restTemplate.postForObject(token_endpoint, request, String.class);
//            info_token = "[" + info_token + "]";
//            JSONArray jsonArray = new JSONArray(info_token);
//            if (jsonArray != null) {
//                String access_token = jsonArray.getJSONObject(0).getString("access_token");
//                String refresh_tk = jsonArray.getJSONObject(0).getString("refresh_token");
//                String id_token = jsonArray.getJSONObject(0).getString("id_token");
//                long expires_in = jsonArray.getJSONObject(0).getLong("expires_in");
//                long milliseconds = new Date().getTime();
//                session.setAttribute("access_token", access_token);
//                session.setAttribute("refresh_token", refresh_tk);
//                session.setAttribute("id_token", id_token);
//                session.setAttribute("expires_in", milliseconds + (expires_in * 1000));
//            }
//        } catch (JSONException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // Validate token
//    public String getIntrospectToken(String access_token) throws JSONException {
//        String token_info = "";
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Authorization", "Bearer " + access_token);
//        MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
//        requestParams.add("token", access_token);
//        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestParams, headers);
//        RestTemplate restTemplate = new RestTemplate();
//        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
//        String info_token = restTemplate.postForObject(url_introspect, request, String.class);
//        token_info = info_token;
//        return token_info;
//    }

//    public String getTokenInfo(String user_name , String pass_word){
//        String token_info = "";
//        try{
//            if(user_name.equals("uchi") && pass_word.equals("Uchi@123")) {
//                MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
//                requestParams.add("grant_type", "client_credentials");
//                requestParams.add("client_id", client_id);
//                requestParams.add("client_secret", client_secret);
//                HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestParams, null);
//                RestTemplate restTemplate = new RestTemplate();
//                restTemplate.getMessageConverters().add(0,new StringHttpMessageConverter(StandardCharsets.UTF_8));
//                String info_token = restTemplate.postForObject(token_endpoint, request, String.class);
//                token_info = info_token;
//            }else {
//                LOG.error("Thông tin tài khoản hoặc mật khẩu lấy token không chính xác");
//            }
//        }catch (Exception ex){
//            ex.printStackTrace();
//        }
//        return token_info;
//    }
}
