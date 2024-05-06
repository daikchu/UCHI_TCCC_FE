package com.vn.osp.service;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.util.Maps;
import com.google.gson.Gson;
import com.vn.osp.auth.ApiResponse;
import com.vn.osp.auth.JwtResponse;
import com.vn.osp.common.util.PagingResult;
import com.vn.osp.common.util.ResultRequest;
import com.vn.osp.modelview.*;
import org.apache.http.client.utils.URIBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static com.vn.osp.service.STPAPIUtil.getAllHostsValid;

/**
 * Created by tranv on 12/7/2016.
 */
public class APIUtil {
    private static final Logger LOG = LoggerFactory.getLogger(APIUtil.class);
    public static List<PropertyTemplate> getPropertyTemplateByPage(String path, int firstResult, int maxResult) {
        List<PropertyTemplate> propertyTemplateList = new ArrayList<PropertyTemplate>();
        try{
            URIBuilder uriBuilder = new URIBuilder();
            uriBuilder.setPath(path);
            uriBuilder.addParameter("offset", String.valueOf(firstResult));
            uriBuilder.addParameter("number", String.valueOf(maxResult));
            URI uri = uriBuilder.build();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            RestTemplate restTemplate = new RestTemplate();
            HttpEntity<String> requestEntity = new HttpEntity<String>(headers);
            ResponseEntity<PropertyTemplate[]> responseEntity = restTemplate.exchange(uri.toString().substring(1), HttpMethod.GET, requestEntity, PropertyTemplate[].class);
            PropertyTemplate[] propertyTemplates = responseEntity.getBody();
            for(PropertyTemplate propertyTemplate : propertyTemplates) {
                propertyTemplateList.add(propertyTemplate);
            }

        }catch (URISyntaxException e){
            e.printStackTrace();
        }finally {
        }
        return propertyTemplateList;
    }

    public static List<PrivyTemplate> getPrivyTemplateByPage(String path, int firstResult, int maxResult) {
        List<PrivyTemplate> privyList = new ArrayList<PrivyTemplate>();
        try{
            URIBuilder uriBuilder = new URIBuilder();
            uriBuilder.setPath(path);
            uriBuilder.addParameter("offset", String.valueOf(firstResult));
            uriBuilder.addParameter("number", String.valueOf(maxResult));
            URI uri = uriBuilder.build();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            RestTemplate restTemplate = new RestTemplate();
            HttpEntity<String> requestEntity = new HttpEntity<String>(headers);
            ResponseEntity<PrivyTemplate[]> responseEntity = restTemplate.exchange(uri.toString().substring(1), HttpMethod.GET, requestEntity, PrivyTemplate[].class);
            PrivyTemplate[] privyTemplates = responseEntity.getBody();
            for(PrivyTemplate privyTemplate : privyTemplates) {
                privyList.add(privyTemplate);
            }
        }catch (URISyntaxException e){
            e.printStackTrace();
        }
        return privyList;
    }

    /*public static List<PrivyTemplate> getPrivyTemplateByPage(String path) {
        List<PrivyTemplate> privyList = new ArrayList<PrivyTemplate>();

        try{
            URIBuilder uriBuilder = new URIBuilder();
            uriBuilder.setPath(Constants.OSP_API_LINK+path);
            URI uri = uriBuilder.build();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            RestTemplate restTemplate = new RestTemplate();
            HttpEntity<String> requestEntity = new HttpEntity<String>(headers);
            ResponseEntity<PrivyTemplate[]> responseEntity = restTemplate.exchange(uri.toString().substring(1), HttpMethod.GET, requestEntity, PrivyTemplate[].class);
            PrivyTemplate[] privyTemplates = responseEntity.getBody();
            for(PrivyTemplate privyTemplate : privyTemplates) {
                privyList.add(privyTemplate);
            }
        }catch (URISyntaxException e){
            e.printStackTrace();
        }
        return privyList;
    }*/

    public static void callAPI(String actionURL, String data) {
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
    }

    public static Boolean callAPIResult(String actionURL, String data) {
        HttpURLConnection conn =null;
        Boolean result=false;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            output = br.readLine();
            if (output.equals("true")) result= true;

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAPIResult:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static ResultRequest callApiGetMethodReturnObject(String actionURL) {
        HttpURLConnection conn =null;
        ResultRequest result = null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            result = convertResponseToResultRequest(conn, result);

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            Object object = new JSONObject();
            String output;
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                object = output;
                result.setObject(new JSONObject(output));
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callApiGetMethodReturnObject:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static Object callAPIResultObject(String actionURL, String data) {
        HttpURLConnection conn =null;
        Object result= new Object();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            result = br.readLine();

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAPIResult:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static Long callAddPreventAPI(String actionURL, String data) {
        HttpURLConnection conn =null;
        Long prevent_id = Long.valueOf(0);
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            while ((output = br.readLine()) != null) {
                prevent_id = Long.parseLong(output);
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAddPreventAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return prevent_id;
    }
    public static Long callUpdatePreventAPI(String actionURL, String data) {
        Long prevent_id = Long.valueOf(0);
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
                prevent_id = Long.parseLong(output);
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAddPreventAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return prevent_id;
    }

    public static Long addUserAPI(String actionURL, String data) {
        HttpURLConnection conn =null;
        Long prevent_id = Long.valueOf(0);
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
                prevent_id = Long.parseLong(output);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.addUserAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return prevent_id;
    }
    public static Boolean addTransactionPropertyAPI(String actionURL, String data) {
        Boolean result = false;
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
                result = Boolean.parseBoolean(output);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.addTransactionPropertyAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }
    public static Boolean synchronizeOK(String actionURL, String data) {
        HttpURLConnection conn =null;
        Boolean result = false;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
                result = Boolean.parseBoolean(output);
            }

        } catch (ConnectException e) {
            LOG.error("Have an error in method APIUtil.synchronizeOK:"+e.getMessage());
        }catch (IOException e) {
            LOG.error("Have an error in method APIUtil.synchronizeOK:"+e.getMessage());
        }catch (Exception e) {
            LOG.error("Have an error in method APIUtil.synchronizeOK:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static Boolean updateUserAPI(String actionURL, String data) {
        HttpURLConnection conn =null;
        Boolean result = false;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            while ((output = br.readLine()) != null) {
                result = Boolean.parseBoolean(output);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.updateUserAPI:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static ArrayList<User> getUserByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<User> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<User>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), User.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUserByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static ArrayList<UnitRequest> getUnitRequestByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UnitRequest> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<UnitRequest>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), UnitRequest.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUnitRequestByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static ArrayList<GrouproleAuthority> getGroupRoleAuthorityFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<GrouproleAuthority> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<GrouproleAuthority>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), GrouproleAuthority.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getGroupRoleAuthorityFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static ArrayList<UserAuthority> getUserAuthorityFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UserAuthority> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<UserAuthority>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), UserAuthority.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUserAuthorityFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static ArrayList<Authority> getAuthorityByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Authority> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<Authority>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), Authority.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAuthorityByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static ArrayList<GroupRole> getGroupRoleByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<GroupRole> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<GroupRole>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), GroupRole.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getGroupRoleByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static ArrayList<GroupRole> getGroupRoleByFilter(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<GroupRole> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<GroupRole>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), GroupRole.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getGroupRoleByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static ArrayList<UserGroupRole> getUserGroupRoleByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UserGroupRole> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<UserGroupRole>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), UserGroupRole.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUserGroupRoleByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<DataPreventInfor> daTiepNhan(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<DataPreventInfor> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<DataPreventInfor>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), DataPreventInfor.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.daTiepNhan:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static int countTotalList(String actionURL, String data) {
        HttpURLConnection conn =null;
        int result = 0;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            while ((output = br.readLine()) != null) {
                result = Integer.parseInt(output);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.countTotalList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static List<PreventHistory> getPreventHistoryList(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<PreventHistory> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<PreventHistory>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), PreventHistory.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getPreventHistoryList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<TransactionProperty> getTransactionPropertyList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<TransactionProperty> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<TransactionProperty>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), TransactionProperty.class));

                    }
                }
                ////System.out.println("output="+output);
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getTransactionPropertyList:"+e.getMessage());
        }finally {
            conn.disconnect();

        }
        return list;
    }

    public static List<ReportByGroupTotal> getReportByGroupList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByGroupTotal> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<ReportByGroupTotal>();
            ObjectMapper mapper = new ObjectMapper();
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByGroupTotal.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByGroupList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
//
//    public static List<ReportByGroupTotal> getReportByGroupList(String actionURL) {
//        HttpURLConnection conn =null;
//        ArrayList<ReportByGroupTotal> list =null;
//        try {
//            URL url = new URL(actionURL);
//            conn = (HttpURLConnection) url.openConnection();
//            conn.setDoOutput(true);
//            conn.setRequestMethod("GET");
//            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
//            conn.setRequestProperty("Accept-Charset", "UTF-8");
//
//            if (conn.getResponseCode() != 200) {
//                throw new RuntimeException("Failed : HTTP error code : "
//                        + conn.getResponseCode());
//            }
//            BufferedReader br = new BufferedReader(new InputStreamReader(
//                    (conn.getInputStream()), "UTF-8"));
//            String output;
//            list = new ArrayList<ReportByGroupTotal>();
//            ObjectMapper mapper = new ObjectMapper();
//            while ((output = br.readLine()) != null) {
//                JSONArray jsonArray = new JSONArray(output);
//                if (jsonArray != null) {
//                    int len = jsonArray.length();
//                    for (int i = 0; i < len; i++) {
//                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByGroupTotal.class));
//                    }
//                }
//            }
//
//
//        } catch (Exception e) {
//            LOG.error("Have an error in method APIUtil.getReportByGroupList:"+e.getMessage());
//        }finally {
//            conn.disconnect();
//        }
//        return list;
//    }
    // Get Announcement List STP
    public static List<Announcement> getAnnouncementList(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<Announcement> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Announcement>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {

                        list.add(mapper.readValue(jsonArray.get(i).toString(), Announcement.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAnnouncementList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    // Get Announcement List Px
    public static List<Announcement> getAnnouncementList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Announcement> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");
            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Announcement>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {

                        list.add(mapper.readValue(jsonArray.get(i).toString(), Announcement.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAnnouncementList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<Announcement> getAnnouncementList(String token, String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Announcement> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");
            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Announcement>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {

                        list.add(mapper.readValue(jsonArray.get(i).toString(), Announcement.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAnnouncementList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<Contract> getContractList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Contract> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Contract>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {

                        list.add(mapper.readValue(jsonArray.get(i).toString(), Contract.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAnnouncementList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static String getSystemConfigByKey(String actionURL, String data) {
        String result = "";
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                result = output;
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getSystemConfigByKey:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }
    public static List<NotaryOfficeList> getNotaryOfficeList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<NotaryOfficeList> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();


            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            ////System.out.println("in "+ input);
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<NotaryOfficeList>();
            ObjectMapper mapper = new ObjectMapper();
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);

                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryOfficeList.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getNotaryOfficeList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<NotaryName> getNotaryName(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<NotaryName> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();


            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            ////System.out.println("in "+ input);
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<NotaryName>();
            ObjectMapper mapper = new ObjectMapper();
            while ((output = br.readLine()) != null) {

                JSONArray jsonArray = new JSONArray(output);

                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryName.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getNotaryName:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<EntryUserName> getEntryUserName(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<EntryUserName> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();


            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<EntryUserName>();
            ObjectMapper mapper = new ObjectMapper();
            while ((output = br.readLine()) != null) {
                ////System.out.println("out:"+output);
                JSONArray jsonArray = new JSONArray(output);

                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), EntryUserName.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getEntryUserName:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<Bank> getBankList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Bank> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Bank>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {

                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), Bank.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getBankList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<Manual> getManual(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Manual> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<Manual>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), Manual.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getManual:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<UnitRequest> getUnitRequest(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UnitRequest> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<UnitRequest>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), UnitRequest.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUnitRequest:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<Role> getRole(String actionURL, String data) {
        HttpURLConnection conn=null;
        ArrayList<Role> list =null;
        try {
                URL url = new URL(actionURL);
                conn = (HttpURLConnection) url.openConnection();
                conn.setDoOutput(true);
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                String input = data.toString();
                OutputStream os = conn.getOutputStream();
                os.write(input.getBytes("UTF-8"));
                os.flush();
                if (conn.getResponseCode() != 200) {
                    throw new RuntimeException("Failed : HTTP error code : "
                            + conn.getResponseCode());
                }
                BufferedReader br = new BufferedReader(new InputStreamReader(
                        (conn.getInputStream()), "UTF-8"));
                String output;
                list = new ArrayList<Role>();
                ObjectMapper mapper = new ObjectMapper();
                mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
                while ((output = br.readLine()) != null) {
                    JSONArray jsonArray = new JSONArray(output);
                    if (jsonArray != null) {
                        int len = jsonArray.length();
                        for (int i = 0; i < len; i++) {
                            list.add(mapper.readValue(jsonArray.get(i).toString(), Role.class));
                        }
                    }
                }
            } catch (Exception e) {
                LOG.error("Have an error in method APIUtil.getRole:"+e.getMessage());
            }finally {
                conn.disconnect();
            }
            return list;

    }
    /*Get Notary Office*/
    public static List<NotaryOffice> getNotaryOffice(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<NotaryOffice> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<NotaryOffice>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryOffice.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getNotaryOffice:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    /*Get Notary Office By Announcement*/
    public static List<NotaryOfficeByAnnouncement> getNotaryOfficeByAnnouncement(String actionURL, String data) {
        ArrayList<NotaryOfficeByAnnouncement> list =null;
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<NotaryOfficeByAnnouncement>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryOfficeByAnnouncement.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getNotaryOfficeByAnnouncement:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<AccessHistory> getAccessHistory(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<AccessHistory> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<AccessHistory>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), AccessHistory.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAccessHistory:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<SuggestPrivy> searchSuggestPrivy(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<SuggestPrivy> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            /*String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<SuggestPrivy>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestPrivy.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAccessHistory:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<SuggestPrivy> searchSuggestPrivy(String token,String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<SuggestPrivy> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            /*String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<SuggestPrivy>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestPrivy.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAccessHistory:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<SuggestProperty> searchSuggestProperty(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<SuggestProperty> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            /*String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<SuggestProperty>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestProperty.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAccessHistory:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<SuggestProperty> searchSuggestProperty(String token,String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<SuggestProperty> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            /*String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<SuggestProperty>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestProperty.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAccessHistory:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ProvinceList> getProvinceList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ProvinceList> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ProvinceList>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ProvinceList.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getProvinceList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ContractKind> getContractKind(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractKind> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractKind>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractKind.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractKind:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractTemplate> getContractTemplate(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractTemplate> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractTemplate>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractTemplate.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractTemplate:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }


    public static List<ReportByBank> getReportByBank(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByBank> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByBank>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByBank.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByBank:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<TransactionProperty> getTransactionProperty(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<TransactionProperty> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<TransactionProperty>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), TransactionProperty.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getTransactionProperty:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<HistoryContract> getHistoryContract(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<HistoryContract> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<HistoryContract>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), HistoryContract.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getHistoryContract:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<UserByRoleList> getUserByRoleList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UserByRoleList> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<UserByRoleList>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), UserByRoleList.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getUserByRoleList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ReportByNotaryPerson> getReportByNotaryPerson(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByNotaryPerson> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByNotaryPerson>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByNotaryPerson.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByNotaryPerson:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ReportByUser> getReportByUser(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByUser> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByUser>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByUser.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByUser:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ContractError> getContractError(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractError> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractError>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractError.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractError:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractAdditional> getContractAdditonal(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractAdditional> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractAdditional>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractAdditional.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractError:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ReportByTT20List> getReportByTT20List(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByTT20List> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByTT20List>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByTT20List.class));
                    }
                }
            }
            conn.disconnect();
            return list;
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByTT20List:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ReportByTT03List> getReportByTT03List(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByTT03List> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByTT03List>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByTT03List.class));
                    }
                }
            }
            conn.disconnect();
            return list;
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByTT04List:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ReportByTT04List> getReportByTT04List(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByTT04List> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByTT04List>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByTT04List.class));
                    }
                }
            }
            conn.disconnect();
            return list;
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByTT04List:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ContractAdditional> getReportContractAdditional(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractAdditional> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractAdditional>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractAdditional.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportContractAdditional:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractCertify> getContractCertify(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractCertify> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractCertify>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractCertify.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractCertify:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractStastics> getContractStastics(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractStastics> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractStastics>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractStastics.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractStastics:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ContractStasticsOfDistricts> getContractStasticsOfDistricts(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractStasticsOfDistricts> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractStasticsOfDistricts>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractStasticsOfDistricts.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractStasticsOfDistricts:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<ContractStasticsBank> getContractStasticsBank(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractStasticsBank> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractStasticsBank>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractStasticsBank.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractStasticsBank:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<Bank> getBankFromOSP(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Bank> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            String result = "";
            list = new ArrayList<Bank>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), Bank.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getBankFromOSP:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractTemp> getContractTempList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractTemp> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractTemp>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractTemp.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractTempList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractTempListByKindName> getContractTempListByKindName(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractTempListByKindName> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
             list = new ArrayList<ContractTempListByKindName>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractTempListByKindName.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractTempListByKindName:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<ContractKinds> getContractKindList(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractKinds> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ContractKinds>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractKinds.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractKindList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    /**get data attestation*/

    public static List<Attestation> getAttestationTempList(String actionURL) {
        HttpURLConnection conn =null;
        List<Attestation> result = new ArrayList<>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;


            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        result.add(mapper.readValue(jsonArray.get(i).toString(), Attestation.class));
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getAttestationTempList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    /**END get data attestation*/



    public static List<ReportByBankDetail> getReportByBankDetail(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ReportByBankDetail> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new ArrayList<ReportByBankDetail>();
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ReportByBankDetail.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getReportByBank:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static int countUserExistContract(String actionURL) {
        HttpURLConnection conn =null;
        int result = 0;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            while ((output = br.readLine()) != null) {
                result = Integer.parseInt(output);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.countUserExistContract:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }
    // download announcement from stp
    public static void downloadAnnouncementSTP(String actionURL) {
        HttpURLConnection conn =null;
        int result = 0;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            /*while ((output = br.readLine()) != null) {
                result = Integer.parseInt(output);
            }*/
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.downloadAnnouncementSTP:"+e.getMessage());
        }finally {
            conn.disconnect();
        }

    }

    // suggestNotaryFee

    public static ContractFeeBO suggestNotaryFee(String actionURL) {
        HttpURLConnection conn =null;
        ContractFeeBO result = new ContractFeeBO();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;


            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                result = mapper.readValue(output.toString(),ContractFeeBO.class);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.suggestNotaryFee:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static int getCount(String actionURL) {
        int result = 0;
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            while ((output = br.readLine()) != null) {
                result = Integer.parseInt(output);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static int countTotalContractFee(String actionURL) {
        int result = 0;
        HttpURLConnection conn =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            while ((output = br.readLine()) != null) {
                result = Integer.parseInt(output);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static ArrayList<ContractFeeBO> getContractFeeCode(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<ContractFeeBO> list = new ArrayList<ContractFeeBO>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractFeeBO.class));
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return list.size()>0 ? list:null;
    }

    public static SalesWrapper getListSalesReport(String actionURL) {
        HttpURLConnection conn =null;
        SalesWrapper salesWrapper = new SalesWrapper();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                salesWrapper = mapper.readValue(output.toString(),SalesWrapper.class);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return salesWrapper;
    }

    public static ArrayList<ContractKeyMapBO> getContractKeyMapByFilter(String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<ContractKeyMapBO> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<ContractKeyMapBO>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), ContractKeyMapBO.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getContractKeyMapBOById:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static ArrayList<District> getDistricts(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<District> list = new ArrayList<District>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), District.class));
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return list.size()>0 ? list:null;
    }

    public static ArrayList<District> getDistrictsByFilter(String actionURL, String filter) {
        HttpURLConnection conn =null;
        ArrayList<District> list =null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = filter.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<District>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), District.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getDistrictsByFilter:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }


    /*API FOR SIGNATURE CERTIFICATE*/
    public static ArrayList<SignCert> getCerts(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<SignCert> list = new ArrayList<SignCert>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SignCert.class));
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return list.size()>0 ? list:null;
    }

    /*END API FOR SIGNATURE CERTIFICATE*/
    /*API FOR Notary Book*/

    public static ArrayList<NotaryBook> getNotaryBook(String actionURL) {
        /*try {
            actionURL = URLEncoder.encode(actionURL,"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }*/
        HttpURLConnection conn =null;
        ArrayList<NotaryBook> list = new ArrayList<>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryBook.class));
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return list.size()>0 ? list:null;
    }

    /*public static ArrayList<NotaryBook> getNotaryBook(String actionURL) {
        HttpURLConnection conn =null;
        ArrayList<NotaryBook> list = new ArrayList<NotaryBook>();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        list.add(mapper.readValue(jsonArray.get(i).toString(), NotaryBook.class));
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return list.size()>0 ? list:null;
    }*/

    /*End API FOR Notary Book*/

    /**Phi chung thuc*/
    public static CertFee suggestCertFee(String actionURL) {
        HttpURLConnection conn =null;
        CertFee result = new CertFee();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            /*String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();*/
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;


            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                result = mapper.readValue(output.toString(),CertFee.class);
            }
        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.suggestCertFee:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }
    /**END Phi chung thuc*/

    public static String callAPIGetAuthen(String actionURL, String data) {
        HttpURLConnection conn =null;
        ApiResponse apiRes=new ApiResponse();
        JwtResponse beanToken=null;
        String token=null;
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            ObjectMapper mapper = new ObjectMapper();

            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                apiRes = mapper.readValue(output.toString(), ApiResponse.class);
                if(0==apiRes.getErrorCode()){
                    LinkedHashMap<Object, Object> originalMap = (LinkedHashMap)apiRes.getData();
                    token=originalMap.get("token").toString();
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAPIGetAuthen:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return token;
    }

    public static List<PropertyPrevent> getPropertyPreventByFilter(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<PropertyPrevent> list=null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            String input = data.toString();
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes("UTF-8"));
            os.flush();
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;
            list = new ArrayList<PropertyPrevent>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i = 0; i < len; i++) {
                        PropertyPrevent propertyPrevent = mapper.readValue(jsonArray.get(i).toString(), PropertyPrevent.class);
                        list.add(propertyPrevent);
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.getPropertyPreventById:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static PagingResult getReturnObject(String actionURL) {
        HttpURLConnection conn =null;
        PagingResult result = new PagingResult();
        try {
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));
            String output;

            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

            while ((output = br.readLine()) != null) {
                result = mapper.readValue(output, PagingResult.class);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            conn.disconnect();
        }
        return result;
    }

    private static ResultRequest convertResponseToResultRequest(HttpURLConnection conn, ResultRequest resultRequest) throws IOException {
        if(conn == null) return resultRequest;
        if(resultRequest == null) resultRequest = new ResultRequest();
        try{
            if(conn.getResponseCode() == -1){
                resultRequest.setMessageCode("-1");
                resultRequest.setMessage("Không thể kết nối đến API server");
            } else {
                resultRequest.setMessageCode(String.valueOf(conn.getResponseCode()));
                resultRequest.setMessage(conn.getResponseMessage());
            }
        } catch (Exception e) {
            resultRequest.setMessageCode("-1");
            resultRequest.setMessage("Không thể kết nối đến API server");
        }

        return resultRequest;
    }

}
