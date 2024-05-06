package com.vn.osp.service;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.modelview.*;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.*;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by tranv on 12/7/2016.
 */
public class STPAPIUtil {
    private static final Logger LOG = LoggerFactory.getLogger(STPAPIUtil.class);

    public static List<DataPreventInfor> daTiepNhan(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<DataPreventInfor> list =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization","Bearer "+token);
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
          LOG.error("Have an error in method STPAPIUtil.daTiepNhan:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static List<TransactionProperty> getTransactionPropertyList(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<TransactionProperty> list =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization","Bearer "+token);
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
            }


        } catch (Exception e) {
            LOG.error("Have an error in method STPAPIUtil.getTransactionPropertyList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public static AnnouncementFromStpWrapper getAnnouncementFromStpWrapper(String token,String actionURL, String data) throws NoSuchAlgorithmException, KeyManagementException {
        HttpURLConnection conn =null;
        AnnouncementFromStpWrapper list =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
            URL url = new URL(actionURL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setAllowUserInteraction(true);
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization","Bearer "+token);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            //conn.setRequestProperty("Accept-Charset", "UTF-8");

            String input = data.toString();

            if(conn==null || conn.getOutputStream()==null){
                return null;
            }
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
            list = new AnnouncementFromStpWrapper();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                list = mapper.readValue(output, AnnouncementFromStpWrapper.class);
            }


        } catch (Exception e) {
            LOG.error("Have an error in method STPAPIUtil.getAnnouncementFromStpWrapper:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static PreventContractList getPreventContractList(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        PreventContractList list =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
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

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream()), "UTF-8"));

            String output;
            list = new PreventContractList();
            ObjectMapper mapper = new ObjectMapper();
            /*mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);*/
            mapper.disable(DeserializationFeature.FAIL_ON_MISSING_CREATOR_PROPERTIES);
            while ((output = br.readLine()) != null) {
                list = mapper.readValue(output, PreventContractList.class);
            }

        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("Have an error in method STPAPIUtil.getPreventContractList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<SynchonizeContractKey> synchronizeContract(String token,String actionURL, String data) {
        List<SynchonizeContractKey> list =null;
        HttpURLConnection conn =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
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
            list = new ArrayList<SynchonizeContractKey>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), SynchonizeContractKey.class));
                    }
                }
            }


        } catch (Exception e) {
            LOG.error("Have an error in method STPAPIUtil.synchronizeContract:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }
    public static List<AnnouncementFromStp> announcementFromSTPList(String token,String actionURL, String data) {
        List<AnnouncementFromStp> list =null;
        HttpURLConnection conn =null;
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(getAllHostsValid());
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
            list = new ArrayList<AnnouncementFromStp>();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            while ((output = br.readLine()) != null) {
                JSONArray jsonArray = new JSONArray(output);
                if (jsonArray != null) {
                    int len = jsonArray.length();
                    for (int i=0;i<len;i++){
                        list.add(mapper.readValue(jsonArray.get(i).toString(), AnnouncementFromStp.class));
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Have an error in method STPAPIUtil.announcementFromSTPList:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return list;
    }

    public Object getObj(Object obj) {
        if (obj instanceof Announcement) return (Announcement) obj;
        if (obj instanceof DataPreventInfor) return (DataPreventInfor) obj;
        if (obj instanceof PreventHistory) return (PreventHistory) obj;
        if (obj instanceof TransactionProperty) return (TransactionProperty) obj;
        if (obj instanceof ReportByGroupTotal) return (ReportByGroupTotal) obj;

        return obj;
    }


    //set ssl for https
    public static HostnameVerifier getAllHostsValid(){
        TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return null;
            }
            public void checkClientTrusted(X509Certificate[] certs, String authType) {
            }
            public void checkServerTrusted(X509Certificate[] certs, String authType) {
            }
        }
        };

        // Install the all-trusting trust manager
        try{
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

        } catch (Exception e){
            LOG.error(e.getMessage());
        }

        // Create all-trusting host name verifier
        HostnameVerifier allHostsValid = new HostnameVerifier() {
            public boolean verify(String hostname, SSLSession session) {
                return true;
            }
        };

        return allHostsValid;

    }

    public static Boolean callAPIResult(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        Boolean result=false;
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
            output = br.readLine();
            if (output.equals("true")) result= true;

        } catch (Exception e) {
            LOG.error("Have an error in method APIUtil.callAPIResult:"+e.getMessage());
        }finally {
            conn.disconnect();
        }
        return result;
    }

    public static int countTotalList(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        int result = 0;
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
    public static ArrayList<Authority> getAuthorityByFilter(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<Authority> list =null;
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
    public static ArrayList<User> getUserByFilter(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<User> list =null;
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
    public static String getSystemConfigByKey(String token,String actionURL, String data) {
        String result = "";
        HttpURLConnection conn =null;
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

    public static ArrayList<UserGroupRole> getUserGroupRoleByFilter(String token,String actionURL, String data) {
        HttpURLConnection conn =null;
        ArrayList<UserGroupRole> list =null;
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

}
