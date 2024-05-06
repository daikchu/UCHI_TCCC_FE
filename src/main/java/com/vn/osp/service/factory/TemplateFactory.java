package com.vn.osp.service.factory;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.EditString;
import com.vn.osp.common.util.PagingResult;
import com.vn.osp.modelview.*;
import com.vn.osp.service.APIUtil;
import com.vn.osp.service.Client.Client;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by TienManh on 8/21/2017.
 */
public class TemplateFactory {
    private static final Logger LOG  = LoggerFactory.getLogger(TemplateFactory.class);

    public static PagingResult listContractTemplate(PagingResult page){
        if(page.getPageNumber()<1) page.setNumberPerPage(1);
        int offset=page.getNumberPerPage()*(page.getPageNumber()-1);
        String param2[]={"offset",String.valueOf(offset)};
        String param3[]={"number",String.valueOf(page.getNumberPerPage())};
        List<String[]> params=new ArrayList<String[]>();
        params.add(param2);
        params.add(param3);

        String response= Constants.VPCC_API_LINK + "/ContractTemplate/list-page";
        response=Client.getObjectByParams(response,params);

        String path="/ContractTemplate/total";
        path=Client.getObject(path);

        List<ContractTemplateBO> items=new ArrayList<ContractTemplateBO>();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        try{
            items = Arrays.asList(objectMapper.readValue(response, ContractTemplateBO[].class));
            page.setItems(items);
            if(EditString.isNumber(path)){
                page.setRowCount(Integer.parseInt(path));
            }
        }catch (Exception e){
            LOG.error("error roi TemplateFacotory.listContractTemplate: "+e.getMessage());
        }

        return page;
    }
    public static List<ContractKind> listContractKind(){

        String response="/contract/list-contract-kind";
        response=Client.getObject(response);

        List<ContractKind> items=new ArrayList<ContractKind>();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        try{
            items = Arrays.asList(objectMapper.readValue(response, ContractKind[].class));

        }catch (Exception e){
            LOG.error("error roi TemplateFacotory.listContractKind: "+e.getMessage());
        }

        return items;
    }

    public static ContractTemplateBO getContractTemplate(String id){
        String response="/ContractTemplate/";
        response=Client.getObjectByFilter(response,"id",id);
        ContractTemplateBO item=new ContractTemplateBO();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            item=objectMapper.readValue(response, ContractTemplateBO.class);
            return item;
        }catch (Exception e){
            LOG.error("error roi getContractTemplate: "+e.getMessage());
        }

        return null;
    }

    public static List<ContractTemp> getContractTempByFilter(String filter) {
        List<ContractTemp> result = APIUtil.getContractTempList(Constants.VPCC_API_LINK + "/ContractTemplate/FindContractTempByFilter", filter);
        return result;
    }

    public static Boolean updateContractTemplate(ContractTemplateBO item){
        String response=Constants.VPCC_API_LINK +"/ContractTemplate/";

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            response=Client.putObject(response,objectMapper.writeValueAsString(item));
            return Boolean.parseBoolean(response);
        }catch (Exception e){
            LOG.error("error roi updateContractTemplate: "+e.getMessage());
        }

        return false;
    }

    public static Boolean updateContractTemplate_(ContractTemplateBO item){
        String response=Constants.VPCC_API_LINK +"/ContractTemplate/UpdateContractTempHibernate";

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            response=Client.putObject(response,objectMapper.writeValueAsString(item));
            return Boolean.parseBoolean(response);
        }catch (Exception e){
            LOG.error("error roi updateContractTemplate_: "+e.getMessage());
        }

        return false;
    }

    public static Boolean deleteContractTemplate(String id){
        String response=Constants.VPCC_API_LINK +"/ContractTemplate/deleteContractTempHibernate";

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            response=Client.postToOSP(response,objectMapper.writeValueAsString(id));
            return Boolean.parseBoolean(response);
        }catch (Exception e){
            LOG.error("error roi updateContractTemplate: "+e.getMessage());
        }

        return false;
    }

    public static ConfigDBMaster getConfigDBMaster(){
        String response="/masterConvert/getConfigDBMaster";
        response = Client.getObject(response);
        ConfigDBMaster item=new ConfigDBMaster();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            item = objectMapper.readValue(response, ConfigDBMaster.class);
            return item;
        }catch (Exception e){
            LOG.error("error roi getConfigDBMaster: "+e.getMessage());
        }
        return null;
    }

    public static MasterContract getMasterContract(String id){
        String response="/masterConvert/selectContractMasterConvertById";
        response = Client.getObjectByFilter(response,"id",id);
        MasterContract item=new MasterContract();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            item = objectMapper.readValue(response, MasterContract.class);
            return item;
        }catch (Exception e){
            LOG.error("error loi selectContractMasterConvertById: "+e.getMessage());
        }
        return null;
    }


    /**attestation*/
    public static Attestation getAttestationTempById(Long id) {
        String response = Constants.VPCC_API_LINK + "/api-attestation/get";
        String param[] = {"id", String.valueOf(id)};
        List<String[]> params = new ArrayList<String[]>();
        params.add(param);
        response = Client.getObjectByParams(response, params);
        Attestation item = null;
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try {
            item=objectMapper.readValue(response, Attestation.class);
        } catch (Exception e) {
            LOG.error("Lỗi rồi : ----" + e.getMessage() + "----");
        }
        return item;
    }

    public static int countTotalAttestationTemp(String code) {
        Integer result = APIUtil.getCount(Constants.VPCC_API_LINK + "/api-attestation/count?code="+code);
        return result;
    }

    public static List<Attestation> getAttestationTemp(String code, String parent_code) {
        List<Attestation> result = APIUtil.getAttestationTempList(Constants.VPCC_API_LINK + "/api-attestation/search?code="+code+"&parent_code="+parent_code);
        return result;
    }

    public static int countTotalAttestationTempFromOSP(int org_type, String code, String parent_code) {
        Integer result = APIUtil.getCount(Constants.OSP_API_LINK + "/api-attestation/count?org_type="+org_type+"&code="+code+"&parent_code="+parent_code);
        return result;
    }

    public static List<Attestation> getAttestationTempFromOSP(int org_type, String code, String parent_code) {
        List<Attestation> result = APIUtil.getAttestationTempList(Constants.OSP_API_LINK + "/api-attestation/list?org_type="+org_type+"&code="+code+"&parent_code="+parent_code);
        return result;
    }

    public static Boolean deleteAttestationTemplate(String id){
        String response=Constants.VPCC_API_LINK +"/api-attestation/delete";

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try{
            response=Client.deleteObject(response,"id",id);
            return Boolean.parseBoolean(response);
        }catch (Exception e){
            LOG.error("error roi TemplateFactory.deleteAttestationTemplate: "+e.getMessage());
        }

        return false;
    }

    /**END attestation*/
}
