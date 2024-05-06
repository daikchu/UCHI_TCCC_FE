package com.vn.osp.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vn.osp.auth.JwtRequest;
import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.BaseController;
import com.vn.osp.common.util.Crypter;
import com.vn.osp.common.util.RelateDateTime;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.*;
import com.vn.osp.service.QueryFactory;
import com.vn.osp.service.STPQueryFactory;
import com.vn.osp.service.factory.ContractFactory;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/*import com.vn.osp.service.factory.UserFactory;*/

/**
 * Created by TienManh on 5/8/2017.
 */
@Controller
@RequestMapping("/contract")
public class ContractController extends BaseController {

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(ContractWrapper contractWrapper,String status, HttpServletRequest request){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        if(StringUtils.isBlank(status)){
            status="100";
        }
        setAccessHistory(((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser(), Constants.VIEW, request, "Xem danh sách hợp đồng công chứng." + "<br> Trạng thái : Thành công." + "<br> Url : " + request.getContextPath()+"/contract/list");
        return new ModelAndView("contract/offline/contract.list","status",status);
    }

    @RequestMapping(value = "/not-sync-list", method = RequestMethod.GET)
    public ModelAndView notSyncList( HttpServletRequest request,String status){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(StringUtils.isBlank(status)){
            status="100";
        }
        setAccessHistory(((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser(), Constants.VIEW, request, "Xem danh sách hợp đồng công chứng chưa đồng bộ." + "<br> Trạng thái : Thành công." + "<br> Url : " + request.getContextPath()+"/contract/not-sync-list");
        return new ModelAndView("contract/synchronize/list","status",status);
    }
    @RequestMapping(value = "/re-sync", method = RequestMethod.GET)
    public ModelAndView reSync( HttpServletRequest request){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        Long userId = ((CommonContext) session.getAttribute(session.getId())).getUser().getUserId();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
        try {
            List<TransactionProperty> properties = QueryFactory.getTransactionPropertyNotSync(userId);
            ArrayList<SynchronizeContractTag> tagArrayList = new ArrayList<SynchronizeContractTag>();

            if (properties != null && properties.size() > 0) {
                for (int i = 0; i < properties.size(); i++) {

                    TransactionProperty property = properties.get(i);
                    SynchronizeContractTag contractTag = new SynchronizeContractTag();
                    /*contractTag.setNotaryOfficeCode(CommonContext.authentication_id);*/
                    contractTag.setNotaryOfficeCode(property.getSynchronize_id());
                    contractTag.setContractKindCode(property.getContract_kind());
                    contractTag.setContractNumber(property.getContract_number());
                    contractTag.setTypeSynchronize(Constants.CREATE_CONTRACT);
                    contractTag.setContractName(property.getContract_name());
                    contractTag.setTransactionContent(property.getTransaction_content());
                    contractTag.setNotaryDate(RelateDateTime.formatDate(property.getNotary_date(), "dd/MM/yyyy", "yyyy-MM-dd"));
                    contractTag.setNotaryOfficeName(property.getNotary_office_name());
                    contractTag.setNotaryPerson(property.getNotary_person());
                    contractTag.setNotaryPlace(property.getNotary_place());
                    contractTag.setNotaryFee(property.getNotary_fee());
                    contractTag.setRemunerationCost(property.getRemuneration_cost());
                    contractTag.setNotaryCostTotal(property.getNotary_cost_total());
                    contractTag.setRelationObjects(property.getRelation_object());
                    contractTag.setContractPeriod(property.getContract_period());
                    contractTag.setMortageCancelFlag(property.getMortage_cancel_flag());
                    contractTag.setMortageCancelDate(RelateDateTime.formatDate(property.getMortage_cancel_date(), "dd/MM/yyyy", "yyyy-MM-dd"));
                    contractTag.setMortageCancelNote(property.getMortage_cancel_note());
                    contractTag.setCancelStatus(property.getCancel_status());
                    contractTag.setCancelDescription(property.getCancel_description());
                    contractTag.setEntryUserName(property.getEntry_user_name());
                    contractTag.setEntryDateTime(RelateDateTime.formatDate(property.getEntry_date_time(), "dd/MM/yyyy", "yyyy-MM-dd"));
                    contractTag.setUpdateUserName(property.getUpdate_user_name());
                    contractTag.setUpdateDateTime(RelateDateTime.formatDate(property.getUpdate_date_time(), "dd/MM/yyyy", "yyyy-MM-dd"));
                    contractTag.setBankCode(property.getBank_code());
                    contractTag.setContractNote(property.getNote());
                    contractTag.setPropertyInfo(property.getProperty_info());
                    contractTag.setJson_property(property.getJson_property());
                    contractTag.setJson_person(property.getJson_person());
                    contractTag.setCode_template(property.getCode_template());

                    tagArrayList.add(contractTag);
                }

                SynchonizeContractList contractList = new SynchonizeContractList();
                contractList.setSynAccount(QueryFactory.getSystemConfigByKey("synchronize_account"));
                contractList.setSynPass(QueryFactory.getSystemConfigByKey("synchronize_password"));
                /*contractList.setSynPass(Crypter.EncryptText(contractList.getSynPass()));*/
                contractList.setSynchonizeContractList(tagArrayList);

                //nhung~ hop dong dong bo thannh cong thi se co trong results, con ko thif ko co nen se update lai o tccc dung'
                List<SynchonizeContractKey> results = STPQueryFactory.synchronizeContract(token,contractList.convertToJson());
                if(results != null && results.size()>0){
                    for (int i=0;i<results.size();i++){
                        QueryFactory.synchronizeOK(results.get(i).toString());
                    }
                    //set lai so luong hop dong loi trong thong bao
                    CommonContext context=((CommonContext) request.getSession().getAttribute(request.getSession().getId()));
                    List<TransactionProperty> properties1 = QueryFactory.getTransactionPropertyNotSync(userId);
                    if (properties1 != null && properties1.size() > 0) context.setNotSyncContract(properties1.size());
                    else context.setNotSyncContract(0);
                    session.setAttribute(session.getId(), context);
                }else{
                    return new ModelAndView("redirect:/contract/not-sync-list?status=2");
                }
            }
            return new ModelAndView("redirect:/contract/not-sync-list?status=1");
        }catch (Exception e){
            e.printStackTrace();
            return new ModelAndView("redirect:/contract/not-sync-list?status=3");
        }

    }


    @RequestMapping(value = "/temporary/list", method = RequestMethod.GET)
    public ModelAndView listTemporary(String status, HttpServletRequest request){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        if(StringUtils.isBlank(status)){
            status="100";
        }
        setAccessHistory(((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser(), Constants.LOGIN, request, "Xem danh sách hợp đồng online." + "<br> Trạng thái : Thành công." + "<br> Url : " + request.getContextPath()+"/contract/temporary/list");
        return new ModelAndView("contract/temporary/list","status",status);
    }


    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView add(Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        return new ModelAndView("contract/offline/contract.add","contract",contract);
    }

    @RequestMapping(value = "/addBrowserFile", method = RequestMethod.GET)
    public ModelAndView addFromFile(Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        return new ModelAndView("contract/offline/contract.addFromFile","contract",contract);
    }

    @RequestMapping(value = "/addContractOfflineTemporary/{tcid}", method = RequestMethod.GET)
    public ModelAndView addContractOfflineTemporary(@PathVariable("tcid") String tcid, Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(tcid!=null || !tcid.equals("")){
            TemporaryContract contractTemp =ContractFactory.getTemporaryById(tcid);

            contract.setContract_template_id(contractTemp.getContract_template_id());
            contract.setContract_number(contractTemp.getContract_number());
            contract.setContract_value(contractTemp.getContract_value());
            contract.setNotary_id(contractTemp.getNotary_id());
            contract.setDrafter_id(contractTemp.getDrafter_id());
            contract.setReceived_date(contractTemp.getReceived_date());
            contract.setNotary_date(contractTemp.getNotary_date());
            contract.setCost_tt91(contractTemp.getCost_tt91());
            contract.setCost_draft(contractTemp.getCost_draft());
            contract.setCost_notary_outsite(contractTemp.getCost_notary_outsite());
            contract.setCost_other_determine(contractTemp.getCost_other_determine());
            contract.setCost_total(contractTemp.getCost_total());
            contract.setNotary_place(contractTemp.getNotary_place());
            contract.setNotary_place_flag(contractTemp.getNotary_place_flag());
            contract.setBank_service_fee(contractTemp.getBank_service_fee());
            contract.setCrediter_name(contractTemp.getCrediter_name());
            contract.setFile_name(contractTemp.getFile_name());
            contract.setFile_path(contractTemp.getFile_path());
            contract.setNote(contractTemp.getNote());
            contract.setSummary(contractTemp.getSummary());
            contract.setBank_code(contractTemp.getBank_code());
            contract.setId(contractTemp.getTcid());
            contract.setNumber_of_sheet(contractTemp.getNumber_of_sheet());
            contract.setNumber_of_page(contractTemp.getNumber_of_page());
            contract.setNumber_copy_of_contract(contractTemp.getNumber_copy_of_contract());
            contract.setOriginal_store_place(contractTemp.getOriginal_store_place());
            contract.setNotary_book(contractTemp.getNotary_book());
            contract.setContract_signer(contractTemp.getContract_signer());

        }

        return new ModelAndView("contract/offline/add.store","contract",contract);
    }

    @RequestMapping(value = "/addContractOfflineTemporary/restore/{tcid}", method = RequestMethod.GET)
    public ModelAndView addContractOfflineTemporaryStore(@PathVariable("tcid") String tcid, Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(tcid!=null || !tcid.equals("")){
            TemporaryContract contractTemp =ContractFactory.getTemporaryById(tcid);

            contract.setContract_template_id(contractTemp.getContract_template_id());
            contract.setContract_number(contractTemp.getContract_number());
            contract.setContract_value(contractTemp.getContract_value());
            contract.setNotary_id(contractTemp.getNotary_id());
            contract.setDrafter_id(contractTemp.getDrafter_id());
            contract.setReceived_date(contractTemp.getReceived_date());
            contract.setNotary_date(contractTemp.getNotary_date());
            contract.setCost_tt91(contractTemp.getCost_tt91());
            contract.setCost_draft(contractTemp.getCost_draft());
            contract.setCost_notary_outsite(contractTemp.getCost_notary_outsite());
            contract.setCost_other_determine(contractTemp.getCost_other_determine());
            contract.setCost_total(contractTemp.getCost_total());
            contract.setNotary_place(contractTemp.getNotary_place());
            contract.setNotary_place_flag(contractTemp.getNotary_place_flag());
            contract.setBank_service_fee(contractTemp.getBank_service_fee());
            contract.setCrediter_name(contractTemp.getCrediter_name());
            contract.setFile_name(contractTemp.getFile_name());
            contract.setFile_path(contractTemp.getFile_path());
            contract.setNote(contractTemp.getNote());
            contract.setSummary(contractTemp.getSummary());
            contract.setBank_code(contractTemp.getBank_code());
            contract.setId(contractTemp.getTcid());
           // contract.setAddition_status(contractTemp.get);
            contract.setNumber_of_sheet(contractTemp.getNumber_of_sheet());
            contract.setNumber_of_page(contractTemp.getNumber_of_page());
            contract.setNumber_copy_of_contract(contractTemp.getNumber_copy_of_contract());
            contract.setOriginal_store_place(contractTemp.getOriginal_store_place());
            contract.setNotary_book(contractTemp.getNotary_book());
            contract.setContract_signer(contractTemp.getContract_signer());
        }

        return new ModelAndView("contract/offline/restore.add","contract",contract);
    }

    @RequestMapping(value = "/temporary/add", method = RequestMethod.GET)
    public ModelAndView TemporaryAdd(TemporaryContract contractWrapper, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        return new ModelAndView("contract/temporary/add","contract",contractWrapper);
    }

    @RequestMapping(value = "/temporary/addBrowserFile", method = RequestMethod.GET)
    public ModelAndView TemporaryAddFromFile(TemporaryContract contractWrapper, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        return new ModelAndView("contract/temporary/addFromFile","contract",contractWrapper);
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable("id") String id,String from, Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }
        setAccessHistory(((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getUser(), Constants.VIEW, request, "Xem chi tiết hợp đồng công chứng số "+ id + "<br> Trạng thái : Thành công."+ "<br> Url : " + request.getContextPath()+"/contract/detail/"+id);
        return new ModelAndView("contract/offline/detail","contract",contract);
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") String id,String from,Contract contract, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }

        return new ModelAndView("contract/offline/contract.edit","contract",contract);
    }

    @RequestMapping(value = "/cancel/{id}", method = RequestMethod.GET)
    public ModelAndView cancel(@PathVariable("id") String id,String from, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        Contract contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }
        return new ModelAndView("contract/offline/contract.cancel","contract",contract);
    }

    @RequestMapping(value = "/addCoppy/{id}", method = RequestMethod.GET)
    public ModelAndView addCoppy(@PathVariable("id") String id,String from, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        Contract contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }
        return new ModelAndView("/contract/offline/add.coppy","contract",contract);
    }

    @RequestMapping(value = "/addendum/{id}", method = RequestMethod.GET)
    public ModelAndView addendum(@PathVariable("id") String id,String from, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"11",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        Contract contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }
        return new ModelAndView("/contract/offline/addendum","contract",contract);
    }

    @RequestMapping(value = "/temporary/detail/{id}", method = RequestMethod.GET)
    public ModelAndView temporaryDetail(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        TemporaryContract contract =ContractFactory.getTemporaryById(id);
        return new ModelAndView("contract/temporary/detail","contract",contract);
    }

    @RequestMapping(value = "/temporary/detailMark/{id}", method = RequestMethod.GET)
    public ModelAndView temporaryDetailMark(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        String status =request.getParameter("statusLoad");

        if(id==null || id.equals("")){}
        TemporaryContract contract =ContractFactory.getTemporaryById(id);
        ModelAndView view = new ModelAndView();
        view.setViewName("contract/temporary/detail.mark");
        view.addObject("statusLoad",status);
        view.addObject("contract",contract);
        return view;
        /*return new ModelAndView("contract/temporary/detail","contract",contract);*/
    }

    @RequestMapping(value = "/temporary/edit/{id}", method = RequestMethod.GET)
    public ModelAndView temporaryEdit(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        TemporaryContract contract =ContractFactory.getTemporaryById(id);
        return new ModelAndView("contract/temporary/edit","contract",contract);
    }

    @RequestMapping(value = "/temporary/addCoppy/{id}", method = RequestMethod.GET)
    public ModelAndView temporaryAddCoppy(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"14",Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        TemporaryContract contract =ContractFactory.getTemporaryById(id);
        return new ModelAndView("contract/temporary/addCoppy","contract",contract);
    }

    @ResponseBody
    @RequestMapping(value = "/get-kind", method = RequestMethod.GET)
    public String getkind(HttpServletRequest request) throws JSONException {
        String result = "";
        long kind_id = Long.valueOf(request.getParameter("kind_id"));
        List<ContractTemplate> contractTemplates = QueryFactory.getContractTemplate(" where 1=1 and kind_id="+kind_id);
        StringBuilder stringBuilder = new StringBuilder();
        for (int i=0; i< contractTemplates.size();i++){
            if(i!=0) result+=";";
            ContractTemplate contractTemplate = contractTemplates.get(i);
            //stringBuilder.append("<li><a href='/system/download" + "?filename=" + contractTemplate.getFile_name() + "&filepath=" + contractTemplate.getFile_path() + "'>" + contractTemplate.getName() + "</a></li><br>");
            stringBuilder.append("<li><a href='#'>" + contractTemplate.getName() + "</a></li><br>");
            result += contractTemplate.getContractTemplateId()+","+contractTemplate.getFile_name()+","+contractTemplate.getFile_path();
        }
        return stringBuilder.toString();
    }

    /*@ResponseBody
    @RequestMapping(value = "/get-kind", method = RequestMethod.GET)
    public ResultRequest multiDelete(HttpServletRequest request) throws JSONException {
        String result = "";
        ResultRequest resultRequest = new ResultRequest();
        long kind_id = Long.valueOf(request.getParameter("kind_id"));
        List<ContractTemplate> contractTemplates = QueryFactory.getContractTemplate(" where 1=1 and kind_id="+kind_id);
        for (int i=0; i< contractTemplates.size();i++){
            if(i!=0) result+=";";
            ContractTemplate contractTemplate = contractTemplates.get(i);
            result += contractTemplate.getContractTemplateId()+","+contractTemplate.getFile_name()+","+contractTemplate.getFile_path();
        }
        resultRequest.setResultObject(contractTemplates);
        return resultRequest;
    }*/

    @ResponseBody
    @RequestMapping(value = "/get-kinds", method = RequestMethod.GET)
    public String multiDelete(HttpServletRequest request) throws JSONException {
        String result = "";
        String kindcode = request.getParameter("kind_code");
        long kind_code = Long.valueOf(kindcode);
        List<ContractTemplate> contractTemplates = QueryFactory.getContractTemplate(" where 1=1 and (kind_id = 0 or kind_id is null) and code="+kind_code);
        for (int i=0; i< contractTemplates.size();i++){
            if(i!=0) result+=";";
            ContractTemplate contractTemplate = contractTemplates.get(i);
            result += contractTemplate.getContractTemplateId()+","+contractTemplate.getFile_name()+","+contractTemplate.getFile_path()+","+contractTemplate.getName();
        }
        return new JSONObject().put("result", result).toString();
    }

    @ResponseBody
    @RequestMapping(value = "/FindContractTempListByParentId", method = RequestMethod.GET)
    public String FindContractTempListByParentId(HttpServletRequest request) throws JSONException {
        String result = "";
        String idTemp = request.getParameter("idTemp");
        List<ContractTempListByKindName> contractTemplates = QueryFactory.FindContractTempListByParentId(idTemp);
        for (int i=0; i< contractTemplates.size();i++){
            if(i!=0) result+=";";
            ContractTempListByKindName contractTemplate = contractTemplates.get(i);
            result += contractTemplate.getId()+","+contractTemplate.getCode()+","+contractTemplate.getContractKindName()+","+contractTemplate.getName();
        }
        return new JSONObject().put("result", result).toString();
    }

    @ResponseBody
    @RequestMapping(value = "/addPrivyFunc",method = RequestMethod.GET,produces = "application/json")
    public void addPrivyFunc(HttpServletRequest request) throws IOException{
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }

        List<SuggestPrivy> list = new ArrayList<>();
        String result="";
        SuggestPrivyList listSuggest = new SuggestPrivyList();
        try{

            String addData = request.getParameter("addData");
            ObjectMapper mapper = new ObjectMapper();
            JSONArray jsonArray =new JSONArray(addData);

            if (jsonArray != null) {
                int len = jsonArray.length();
                for (int i=0;i<len;i++){
                    list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestPrivy.class));
                }
            }

            if(list !=null && list.size()>0){
                listSuggest.setSuggestPrivyList(list);

                STPQueryFactory.addSuggestPrivyAll(token,listSuggest.generateJson());

            }


        }catch (Exception e){
            e.printStackTrace();
        }

    }
    @ResponseBody
    @RequestMapping(value = "/addPrivyFuncOnline",method = RequestMethod.GET,produces = "application/json")
    public void addPrivyFuncOnline(HttpServletRequest request) throws IOException{
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
        List<SuggestPrivy> list = new ArrayList<>();
        String result="";
        SuggestPrivyListOnline listSuggest = new SuggestPrivyListOnline();
        try{

            String addData = request.getParameter("addData");
            String checkOnline = request.getParameter("statusOnline");
            ObjectMapper mapper = new ObjectMapper();
            JSONArray jsonArray =new JSONArray(addData);
            listSuggest.setStatusOnline(checkOnline);

            if (jsonArray != null) {
                int len = jsonArray.length();
                for (int i=0;i<len;i++){
                    list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestPrivy.class));
                }
            }

            if(list !=null && list.size()>0){
                listSuggest.setSuggestPrivyList(list);

                STPQueryFactory.addSuggestPrivyAllOnline(token,listSuggest.generateJson());

            }


        }catch (Exception e){
            String addData = request.getParameter("addData");
            String checkOnline = request.getParameter("statusOnline");
            e.printStackTrace();
        }

    }
    @ResponseBody
    @RequestMapping(value = "/addPropertyFunc",method = RequestMethod.GET,produces = "application/json")
    public void addPropertyFunc(HttpServletRequest request) throws IOException{
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
        List<SuggestProperty> list = new ArrayList<>();
        String result="";
        SuggestPropertyList listSuggest = new SuggestPropertyList();
        try{

            String addData = request.getParameter("addData");
            ObjectMapper mapper = new ObjectMapper();
            JSONArray jsonArray =new JSONArray(addData);
            if (jsonArray != null) {
                int len = jsonArray.length();
                for (int i=0;i<len;i++){
                    list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestProperty.class));
                }
            }

            if(list !=null && list.size()>0){
                listSuggest.setSuggestPropertyList(list);

                STPQueryFactory.addSuggestPropertyAll(token,listSuggest.generateJson());

            }


        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @ResponseBody
    @RequestMapping(value = "/addPropertyFuncOnline",method = RequestMethod.GET,produces = "application/json")
    public void addPropertyFuncOnline(HttpServletRequest request) throws IOException{
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
        List<SuggestProperty> list = new ArrayList<>();
        String result="";
        SuggestPropertyListOnline listSuggest = new SuggestPropertyListOnline();
        try{

            String addData = request.getParameter("addData");
            String checkOnline = request.getParameter("statusOnline");
            ObjectMapper mapper = new ObjectMapper();
            JSONArray jsonArray =new JSONArray(addData);
            listSuggest.setStatusOnline(checkOnline);
            if (jsonArray != null) {
                int len = jsonArray.length();
                for (int i=0;i<len;i++){
//                    SuggestProperty suggestProperty = new SuggestProperty();
//                    JSONObject jsonObject = (JSONObject) jsonArray.get(i);
//                    suggestProperty.setOwner_info_address(jsonObject.has("owner_info_address")?jsonObject.getString("owner_info_address"):null);
//                    suggestProperty.setType_real_estate(jsonObject.has("type_real_estate")?jsonObject.getString("type_real_estate"):null);
//                    suggestProperty.setType_real_estate_sub(jsonObject.has("type_real_estate_sub")?jsonObject.getString("type_real_estate_sub"):null);

                    list.add(mapper.readValue(jsonArray.get(i).toString(), SuggestProperty.class));
                }
            }

            if(list !=null && list.size()>0){
                listSuggest.setSuggestPropertyList(list);

                STPQueryFactory.addSuggestPropertyAllOnline(token,listSuggest.generateJson());

            }


        }catch (Exception e){
            e.printStackTrace();
        }

    }
    @ResponseBody
    @RequestMapping(value = "/getsuggest", method = RequestMethod.GET,produces = "application/json")
    public SuggestPrivySearchKeyWrapper getsuggest(String query , String template, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
         String jsonText="";


        List<SuggestPrivySearchKey> suggestPrivySearchKeys = new ArrayList<SuggestPrivySearchKey>();
        // phần chuyển tìm kiếm theo ES
        /*List<SuggestPrivyHit> listHit = ESQueryFactory.searchSuggestPrivyES(template,query);
        List<SuggestPrivy> list = new ArrayList<SuggestPrivy>();
        if(listHit != null){
            int i  =listHit.size();
            for(int j = 0; j<i;j++){
                SuggestPrivy test = listHit.get(j).get_source();
                list.add(test);
            }
        }*/

        List<SuggestPrivy> list = QueryFactory.searchSuggestPrivy(token,template,query);
        if (list != null){
            for(int i=0;i<list.size();i++){
                SuggestPrivySearchKey suggestPrivySearchKey = convertSearchValue(list.get(i),template);
                suggestPrivySearchKeys.add(suggestPrivySearchKey);
            }
        }
        SuggestPrivySearchKeyWrapper suggestPrivySearchKeyWrapper = new SuggestPrivySearchKeyWrapper();
        suggestPrivySearchKeyWrapper.setQuery("Unit");
        suggestPrivySearchKeyWrapper.setSuggestions(suggestPrivySearchKeys);


        return suggestPrivySearchKeyWrapper;



    }
    public SuggestPrivySearchKey convertSearchValue(SuggestPrivy suggestPrivy, String template){
        SuggestPrivySearchKey suggestPrivySearchKey = new SuggestPrivySearchKey();
        if(template.equals("1")){
            suggestPrivySearchKey.setTemplate(suggestPrivy.getTemplate());
            suggestPrivySearchKey.setSex(suggestPrivy.getSex());
            String namePrivy = suggestPrivy.getName().toUpperCase();
            suggestPrivySearchKey.setName(namePrivy);
            suggestPrivySearchKey.setBirthday(suggestPrivy.getBirthday());
            suggestPrivySearchKey.setPassport(suggestPrivy.getPassport());
            suggestPrivySearchKey.setCertification_date(suggestPrivy.getCertification_date());
            suggestPrivySearchKey.setCertification_place(suggestPrivy.getCertification_place());
            suggestPrivySearchKey.setAddress(suggestPrivy.getAddress());
            suggestPrivySearchKey.setPosition(suggestPrivy.getPosition());
            suggestPrivySearchKey.setDescription(suggestPrivy.getDescription());
            suggestPrivySearchKey.setOrg_address(suggestPrivy.getOrg_address());
            suggestPrivySearchKey.setOrg_name(suggestPrivy.getOrg_name());
            suggestPrivySearchKey.setOrg_code(suggestPrivy.getOrg_code());
            suggestPrivySearchKey.setFirst_registed_date(suggestPrivy.getFirst_registed_date());
            suggestPrivySearchKey.setNumber_change_registed(suggestPrivy.getNumber_change_registed());
            suggestPrivySearchKey.setChange_registed_date(suggestPrivy.getChange_registed_date());
            suggestPrivySearchKey.setDepartment_issue(suggestPrivy.getDepartment_issue());
            suggestPrivySearchKey.setValue(suggestPrivy.getName() +"|"+suggestPrivy.getPassport());
        }else if(template.equals("2")){
            suggestPrivySearchKey.setTemplate(suggestPrivy.getTemplate());
            suggestPrivySearchKey.setName(suggestPrivy.getName());
            suggestPrivySearchKey.setSex(suggestPrivy.getSex());
            suggestPrivySearchKey.setBirthday(suggestPrivy.getBirthday());
            suggestPrivySearchKey.setPassport(suggestPrivy.getPassport());
            suggestPrivySearchKey.setCertification_date(suggestPrivy.getCertification_date());
            suggestPrivySearchKey.setCertification_place(suggestPrivy.getCertification_place());
            suggestPrivySearchKey.setAddress(suggestPrivy.getAddress());
            suggestPrivySearchKey.setPosition(suggestPrivy.getPosition());
            suggestPrivySearchKey.setDescription(suggestPrivy.getDescription());
            suggestPrivySearchKey.setOrg_address(suggestPrivy.getOrg_address());
            String orgName = suggestPrivy.getOrg_name().toUpperCase();
            suggestPrivySearchKey.setOrg_name(orgName);
            suggestPrivySearchKey.setOrg_code(suggestPrivy.getOrg_code());
            suggestPrivySearchKey.setFirst_registed_date(suggestPrivy.getFirst_registed_date());
            suggestPrivySearchKey.setNumber_change_registed(suggestPrivy.getNumber_change_registed());
            suggestPrivySearchKey.setChange_registed_date(suggestPrivy.getChange_registed_date());
            suggestPrivySearchKey.setDepartment_issue(suggestPrivy.getDepartment_issue());
            suggestPrivySearchKey.setValue(suggestPrivy.getOrg_name() +"|"+suggestPrivy.getOrg_code());
        }
        return suggestPrivySearchKey;
    }

    @ResponseBody
    @RequestMapping(value = "/getsuggestProperty", method = RequestMethod.GET,produces = "application/json")
    public SuggestPropertySearchKeyWrapper getsuggestProperty(String query , String type, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        //check token stp
        String token=(String)session.getAttribute("tokenStp");
        if (token==null){
            JwtRequest beanAcc= new JwtRequest();
            beanAcc.setUsername(QueryFactory.getSystemConfigByKey("synchronize_account"));
            beanAcc.setPassword(Crypter.DecryptText(QueryFactory.getSystemConfigByKey("synchronize_password")));
            token= STPQueryFactory.authenticationSTP(beanAcc.generateJson());
            session.setAttribute("tokenStp", token);
        }
        String jsonText="";


        List<SuggestPropertySearchKey> suggestPropertySearchKeys = new ArrayList<SuggestPropertySearchKey>();
        /*List<SuggestPropertyHit> listHit = ESQueryFactory.searchSuggestPropertyES(type,query);
        List<SuggestProperty> list = new ArrayList<SuggestProperty>();
        if(listHit != null){
            int i  =listHit.size();
            for(int j = 0; j<i;j++){
                SuggestProperty test = listHit.get(j).get_source();
                list.add(test);
            }
        }*/
        List<SuggestProperty> list = QueryFactory.searchSuggestProperty(token,type,query);
        if (list != null){
            for(int i=0;i<list.size();i++){
                SuggestPropertySearchKey suggestPropertySearchKey = convertSearchValueProperty(list.get(i),type);
                suggestPropertySearchKeys.add(suggestPropertySearchKey);
            }
        }
        SuggestPropertySearchKeyWrapper suggestPropertySearchKeyWrapper = new SuggestPropertySearchKeyWrapper();
        suggestPropertySearchKeyWrapper.setQuery("Unit");
        suggestPropertySearchKeyWrapper.setSuggestions(suggestPropertySearchKeys);


        return suggestPropertySearchKeyWrapper;



    }
    public SuggestPropertySearchKey convertSearchValueProperty(SuggestProperty suggestProperty, String type){
        SuggestPropertySearchKey suggestPropertySearchKey = new SuggestPropertySearchKey();
        if(type.equals("01")){
            suggestPropertySearchKey.setOther_info(suggestProperty.getOther_info());
            suggestPropertySearchKey.setOwner_info(suggestProperty.getOwner_info());
            suggestPropertySearchKey.setRestrict(suggestProperty.getRestrict());
            suggestPropertySearchKey.setType("01");
            suggestPropertySearchKey.setType_view(suggestProperty.getType_view());
            suggestPropertySearchKey.setLand_certificate(suggestProperty.getLand_certificate());
            suggestPropertySearchKey.setLand_issue_place(suggestProperty.getLand_issue_place());
            suggestPropertySearchKey.setLand_issue_date(suggestProperty.getLand_issue_date());
            suggestPropertySearchKey.setLand_map_number(suggestProperty.getLand_map_number());
            suggestPropertySearchKey.setLand_number(suggestProperty.getLand_number());
            suggestPropertySearchKey.setLand_address(suggestProperty.getLand_address());
            suggestPropertySearchKey.setLand_area(suggestProperty.getLand_area());
            suggestPropertySearchKey.setLand_area_text(suggestProperty.getLand_area_text());
            suggestPropertySearchKey.setLand_public_area(suggestProperty.getLand_public_area());
            suggestPropertySearchKey.setLand_private_area(suggestProperty.getLand_private_area());
            suggestPropertySearchKey.setLand_use_purpose(suggestProperty.getLand_use_purpose());
            suggestPropertySearchKey.setLand_use_period(suggestProperty.getLand_use_period());
            suggestPropertySearchKey.setLand_use_origin(suggestProperty.getLand_use_origin());
            suggestPropertySearchKey.setLand_associate_property(suggestProperty.getLand_associate_property());
            suggestPropertySearchKey.setLand_street(suggestProperty.getLand_street());
            suggestPropertySearchKey.setLand_district(suggestProperty.getLand_district());
            suggestPropertySearchKey.setLand_province(suggestProperty.getLand_province());
            suggestPropertySearchKey.setLand_full_of_area(suggestProperty.getLand_full_of_area());
            // them 6 truong moi
            suggestPropertySearchKey.setLand_type(suggestProperty.getLand_type());
            suggestPropertySearchKey.setConstruction_area(suggestProperty.getConstruction_area());
            suggestPropertySearchKey.setBuilding_area(suggestProperty.getBuilding_area());
            suggestPropertySearchKey.setLand_use_type(suggestProperty.getLand_use_type());
            suggestPropertySearchKey.setLand_sort(suggestProperty.getLand_sort());
            suggestPropertySearchKey.setApartment_address(suggestProperty.getApartment_address());
            suggestPropertySearchKey.setApartment_number(suggestProperty.getApartment_number());
            suggestPropertySearchKey.setApartment_floor(suggestProperty.getApartment_floor());
            suggestPropertySearchKey.setApartment_area_use(suggestProperty.getApartment_area_use());
            suggestPropertySearchKey.setApartment_area_build(suggestProperty.getApartment_area_build());
            suggestPropertySearchKey.setApartment_structure(suggestProperty.getApartment_structure());
            suggestPropertySearchKey.setApartment_total_floor(suggestProperty.getApartment_total_floor());

            suggestPropertySearchKey.setValue(suggestProperty.getLand_certificate());

        }else if(type.equals("02")){
            suggestPropertySearchKey.setLand_street(suggestProperty.getLand_street());
            suggestPropertySearchKey.setOther_info(suggestProperty.getOther_info());
            suggestPropertySearchKey.setOwner_info(suggestProperty.getOwner_info());
            suggestPropertySearchKey.setRestrict(suggestProperty.getRestrict());
            suggestPropertySearchKey.setType("02");
            suggestPropertySearchKey.setType_view(suggestProperty.getType_view());
            suggestPropertySearchKey.setCar_license_number(suggestProperty.getCar_license_number());
            suggestPropertySearchKey.setCar_regist_number(suggestProperty.getCar_regist_number());
            suggestPropertySearchKey.setCar_issue_place(suggestProperty.getCar_issue_place());
            suggestPropertySearchKey.setCar_issue_date(suggestProperty.getCar_issue_date());
            suggestPropertySearchKey.setCar_frame_number(suggestProperty.getCar_frame_number());
            suggestPropertySearchKey.setCar_machine_number(suggestProperty.getCar_machine_number());
            suggestPropertySearchKey.setValue(suggestProperty.getCar_frame_number());
        }
        return suggestPropertySearchKey;
    }
    @ResponseBody
    @RequestMapping(value = "suggestNotaryFee", method = RequestMethod.GET,produces ="application/json" )
    public ContractFeeBO suggestNotaryFee(HttpServletRequest request, HttpServletResponse response){
        String codeTemplateId = request.getParameter("codeTemplateId");
        String notaryCost = request.getParameter("notaryFee");
        Long notaryCostLong = Long.valueOf(notaryCost);

        ContractFeeBO list = QueryFactory.suggestNotaryFee(codeTemplateId,notaryCostLong);
        try{
            String result = "";
            String item[] = null;
            String giatri = "";
            boolean checkCharacter = false;
            boolean checkMax = list.getFormula_fee().contains("~");
            if(checkMax){
                item = list.getFormula_fee().split("~");
                list.setNotaryFeeMax(item[1]);
                giatri = item[0];
                checkCharacter = giatri.contains("a");
                if(checkCharacter){
                    giatri = giatri.replaceAll("a",notaryCost);
                    ScriptEngineManager mgr = new ScriptEngineManager();
                    ScriptEngine engine = mgr.getEngineByName("JavaScript");
                    Long resultLong = ((Number)engine.eval(giatri)).longValue();
                    Long maxNumber = Long.valueOf(item[1]);
                    if(resultLong > maxNumber){
                        resultLong = maxNumber;
                    }
                    result = resultLong.toString();
                }else {
                    result = list.getFormula_fee();
                }
                list.setNotaryFeeNumber(result);
            }else {
                giatri = list.getFormula_fee();
                checkCharacter = giatri.contains("a");
                if(checkCharacter){
                    giatri = giatri.replaceAll("a",notaryCost);
                    ScriptEngineManager mgr = new ScriptEngineManager();
                    ScriptEngine engine = mgr.getEngineByName("JavaScript");
                    Long resultLong = ((Number)engine.eval(giatri)).longValue();
                    result = resultLong.toString();
                }else {
                    result = list.getFormula_fee();
                }
                list.setNotaryFeeNumber(result);
            }
            /*checkCharacter = giatri.contains("a");
            if(checkCharacter){
                giatri = giatri.replaceAll("a",notaryCost);
                ScriptEngineManager mgr = new ScriptEngineManager();
                ScriptEngine engine = mgr.getEngineByName("JavaScript");
                Long resultLong = ((Number)engine.eval(giatri)).longValue();
                result = resultLong.toString();
            }else {
                result = list.getFormula_fee();
            }


            list.setNotaryFeeNumber(result);*/

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }

    @RequestMapping(value = "/_delete/{id}", method = RequestMethod.GET)
    public ModelAndView deleteContract(@PathVariable("id") String id,String from, HttpServletRequest request, HttpServletResponse response){
        if(!ValidationPool.checkRoleDetail(request,"08",Constants.AUTHORITY_XOA)) return new ModelAndView("/404");
        if(id==null || id.equals("")){}
        Contract contract =ContractFactory.getById(id);
        if(!StringUtils.isBlank(from)){
            contract.setJsonstring(from);
        }
        return new ModelAndView("contract/temporary/list");
    }

    @RequestMapping(value = "/list-key-map-contract", method = RequestMethod.GET)
    public ModelAndView listKeyMapContract(String status, HttpServletRequest request, HttpServletResponse response){
        if(status == null || status.equals("")){status = "0";}
        return new ModelAndView("contract/createKeyMap/listKeyMap", "status", status);
    }

    @RequestMapping(value = "/add-key-map-contract", method = RequestMethod.GET)
    public ModelAndView createKeyMapContract(HttpServletRequest request, HttpServletResponse response){
        return new ModelAndView("contract/createKeyMap/addKeyMap");
    }

    @RequestMapping(value = "/detail-key-map-contract/{id}", method = RequestMethod.GET)
    public ModelAndView detailKeyMapContract(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        List<ContractKeyMapBO> result = QueryFactory.getContractKeyMapByFilter(" Where id = " + id);
        return new ModelAndView("contract/createKeyMap/detailKeyMap", "bo",result.get(0));
    }

    @RequestMapping(value = "/recommend-add-key-map-contract", method = RequestMethod.GET)
    public ModelAndView recommendAddKeyMap(HttpServletRequest request, HttpServletResponse response){
        return new ModelAndView("contract/createKeyMap/recommendAddKeyMap");
    }

    @RequestMapping(value = "/read-file-doc", method = RequestMethod.POST)
    public ModelAndView readfiledoc(ContractReadFileDoc contract, HttpServletRequest request, HttpServletResponse response){
        String[] fields_ = contract.getFields().split(",");
        contract.setFields_(fields_);
        return new ModelAndView("contract/createKeyMap/testMapfield","contract",contract);
    }

    /*public static void main(String[] args) {
        try{
            String a = "0.5*100";
            ScriptEngineManager mgr = new ScriptEngineManager();
            ScriptEngine engine = mgr.getEngineByName("JavaScript");
            *//*long m = ((Number) engine.eval(giatri)).longValue();
            System.out.println(m);*//*
            long resultLong = ((long)engine.eval(a));
        }catch (Exception e){

        e.printStackTrace();
    }
}*/
}
