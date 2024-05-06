package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.StringUtil;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.*;
import com.vn.osp.service.APIUtil;
import com.vn.osp.service.QueryFactory;
import com.vn.osp.service.factory.TemplateFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

/**
 * Created by minh on 6/2/2017.
 */
@Controller
@RequestMapping(value = "/system/osp")
public class OspController {
    @RequestMapping(value = "/bank-list", method = RequestMethod.GET)
    public ModelAndView bankList(BankListForm bankListForm, HttpServletRequest request, HttpServletResponse response) {
        bankListForm.setCode(StringUtil.escapeSpecialChar(bankListForm.getCode()));
        bankListForm.setName(StringUtil.escapeSpecialChar(bankListForm.getName()));
        if (!ValidationPool.checkRoleDetail(request, "28", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        int notaryListNumber = 1;
        int notaryTotalPage = 1;
        int page = 1;
        if (bankListForm != null) {
            notaryListNumber = bankListForm.getTotal();
            notaryTotalPage = bankListForm.getTotalPage();
            page = bankListForm.getPage();

        }


        if (page > notaryTotalPage) page = notaryTotalPage;
        if (page < 1) page = 1;

        String orderFilter = "";
        orderFilter = bankListForm.getOrderString();
        notaryListNumber = QueryFactory.countTotalBank(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);

        bankListForm.setPage(page);
        bankListForm.setTotal(notaryListNumber);
        bankListForm.setTotalPage(notaryTotalPage);


        List<Bank> bankList = QueryFactory.getBank(page, orderFilter);
        bankListForm.setBankList(bankList);


        return new ModelAndView("/system/SM0021", "bankListForm", bankListForm);
    }


    @RequestMapping(value = "/bank-update", method = RequestMethod.GET)
    public ModelAndView updateBank(BankAdd bankAdd, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "28", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        try {
            HttpSession session = request.getSession();
            List<Bank> bankListFromSTP;
            bankListFromSTP = QueryFactory.getBankFromOSP(" where 1=1");
            int countBankFromOSP;
            countBankFromOSP = QueryFactory.countTotalBankFromOSP("where 1=1");
            for (int i = 0; i < countBankFromOSP; i++) {
                Bank bankDetail = bankListFromSTP.get(i);
                bankAdd.setName(bankDetail.getName());
                bankAdd.setCode(bankDetail.getCode());
                User commonUser = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
                bankAdd.setEntry_user_name(commonUser.getFirst_name()+" "+commonUser.getFamily_name());
                bankAdd.setEntry_user_id(commonUser.getUserId());
                bankAdd.setActive(bankDetail.getActive());

                APIUtil.callAPI(Constants.VPCC_API_LINK + "/bank/AddBank", bankAdd.generateAddJson());
            }
            return new ModelAndView("redirect:/system/osp/bank-list");
        } catch (Exception e) {
            return new ModelAndView("redirect:/system/osp/bank-list");
        }

    }


    @RequestMapping(value = "/bank-view/{id}", method = RequestMethod.GET)
    public ModelAndView bankViewFromOSP(@PathVariable("id") Long bid, HttpServletRequest request, HttpServletResponse response) {
        BankListForm bankListForm = new BankListForm();
        Bank bank = new Bank();
        List<Bank> list = getBankById(bid);
        Bank bank1 = list.get(0);
        bankListForm.setBankDetail(bank1);
        return new ModelAndView("/system/SM0022", "bankListForm", bankListForm);

    }

    public List<Bank> getBankById(Long bid) {
        String filter = "where id = " + bid;

        List<Bank> result = APIUtil.getBankList(Constants.VPCC_API_LINK + "/bank/selectBank", filter);
        return result;
    }

    @RequestMapping(value = "/province-list", method = RequestMethod.GET)
    public ModelAndView provinceList(ProvinceListForm provinceListForm, HttpServletRequest request, HttpServletResponse response) {

        int notaryListNumber = 1;
        int notaryTotalPage = 1;
        int page = 1;
        if (provinceListForm != null) {
            notaryListNumber = provinceListForm.getTotal();
            notaryTotalPage = provinceListForm.getTotalPage();
            page = provinceListForm.getPage();

        }
        if (page > notaryTotalPage) page = notaryTotalPage;
        if (page < 1) page = 1;

        String orderFilter = "";
        orderFilter = provinceListForm.getOrderString();
        notaryListNumber = QueryFactory.countTotalProvince(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        provinceListForm.setPage(page);
        provinceListForm.setTotal(notaryListNumber);
        provinceListForm.setTotalPage(notaryTotalPage);


        List<ProvinceList> provinceList = QueryFactory.getProvince(page, orderFilter);
        provinceListForm.setProvinceList(provinceList);

        return new ModelAndView("/system/SM0023", "provinceListForm", provinceListForm);
    }

    @RequestMapping(value = "/province-update", method = RequestMethod.GET)
    public ModelAndView updateProvince(ProvinceAdd provinceAdd, HttpServletRequest request, HttpServletResponse response) {

        try {
            List<ProvinceList> provinceListFromSTP;
            provinceListFromSTP = QueryFactory.getProvinceFromOSP(" where 1=1");
            int countProvinceFromOSP;
            countProvinceFromOSP = QueryFactory.countTotalProvinceFromOSP("where 1=1");
            for (int i = 0; i < countProvinceFromOSP; i++) {
                ProvinceList provinceDetail = provinceListFromSTP.get(i);
                provinceAdd.setName(provinceDetail.getName());
                provinceAdd.setCode(provinceDetail.getCode());
                provinceAdd.setEntry_user_name(provinceDetail.getEntry_user_name());
                provinceAdd.setEntry_user_id(provinceDetail.getEntry_user_id());


                APIUtil.callAPI(Constants.VPCC_API_LINK + "/province/AddProvince", provinceAdd.generateAddJson());


            }

            return new ModelAndView("redirect:/system/osp/province-list");


        } catch (Exception e) {
            return new ModelAndView("redirect:/system/osp/province-list");
        }

    }


    @RequestMapping(value = "/province-view/{id}", method = RequestMethod.GET)
    public ModelAndView provinceViewFromOSP(@PathVariable("id") Long pid, HttpServletRequest request, HttpServletResponse response) {
        ProvinceListForm provinceListForm = new ProvinceListForm();

        ProvinceList province = new ProvinceList();


        List<ProvinceList> list = getProvinceById(pid);
        ProvinceList province1 = list.get(0);
        provinceListForm.setProvinceDetail(province1);


        return new ModelAndView("/system/SM0024", "provinceListForm", provinceListForm);

    }

    public List<ProvinceList> getProvinceById(Long bid) {
        String filter = "where id = " + bid;

        List<ProvinceList> result = APIUtil.getProvinceList(Constants.VPCC_API_LINK + "/province/findProvinceByFilter", filter);
        return result;
    }

    // COntractTemp
    @RequestMapping(value = "/contracttemplate-list", method = RequestMethod.GET)
    public ModelAndView contractTempList(ContractTempList contractTempList, String status, HttpServletRequest request, HttpServletResponse response) {
        contractTempList.setModel_open(StringUtil.escapeSpecialChar(contractTempList.getModel_open()));
        contractTempList.setName(StringUtil.escapeSpecialChar(contractTempList.getName()));
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        int notaryListNumber = 1;
        int notaryTotalPage = 1;
        int page = 1;
        String stringFilter = "where 1=1";
        List<ContractKind> result = APIUtil.getContractKind(Constants.VPCC_API_LINK + "/contract/findContractKindByFilter", stringFilter);
        contractTempList.setListContractKind(result);
        if (contractTempList != null) {
            contractTempList.setName(contractTempList.getName()==null?"":contractTempList.getName().trim());
            notaryListNumber = contractTempList.getTotal();
            notaryTotalPage = contractTempList.getTotalPage();
            page = contractTempList.getPage();

        }
        if (page > notaryTotalPage) page = notaryTotalPage;
        if (page < 1) page = 1;

        String orderFilter = "";
        orderFilter = contractTempList.getOrderString();
        notaryListNumber = QueryFactory.countTotalContractTemp(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        contractTempList.setPage(page);
        contractTempList.setTotal(notaryListNumber);
        contractTempList.setTotalPage(notaryTotalPage);


        List<ContractTempListByKindName> listContractTemp = QueryFactory.getContractTempByKindName(page, orderFilter);
        contractTempList.setContractTempListByKindNames(listContractTemp);
        contractTempList.setAction_status(status==null?"0":status);

        return new ModelAndView("/system/SM0025", "contractTempList", contractTempList);
    }

    @RequestMapping(value = "/contracttemplate-update", method = RequestMethod.GET)
    public ModelAndView updateContractTemp(ContractTemp contractTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        try {
            /* phần ContractKind */
            List<ContractKinds> contractKindListFromSTP;
            contractKindListFromSTP = QueryFactory.getContractKindFromOSP(" where 1=1");
            int countContractKindFromOSP;
            countContractKindFromOSP = QueryFactory.countTotalContractKindFromOSP("where 1=1");
            for (int j = 0; j < countContractKindFromOSP; j++) {
                ContractKinds contractKindDetail = contractKindListFromSTP.get(j);
                String kiemtrack = "where contract_kind_code = '" + contractKindDetail.getContract_kind_code() + "'";
                int countck = QueryFactory.countTotalContractKind(kiemtrack);
                if (countck < 1) {
                    ContractKindAdd contractKindAdd = new ContractKindAdd();
                    contractKindAdd.setId(contractKindDetail.getCkId());
                    contractKindAdd.setName(contractKindDetail.getName());
                    contractKindAdd.setCode(contractKindDetail.getContract_kind_code());

                    /*contractKindAdd.setUpdate_user_id(contractKindDetail.getUpdate_user_id());
                    contractKindAdd.setUpdate_user_name(contractKindDetail.getUpdate_user_name());*/


                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/contract/AddContractKind", contractKindAdd.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
                else {

                    ContractKindUpdate contractKindUpdate = new ContractKindUpdate();
                    contractKindUpdate.setCkId(contractKindDetail.getCkId());
                    contractKindUpdate.setName(contractKindDetail.getName());
                    contractKindUpdate.setContract_kind_code(contractKindDetail.getContract_kind_code());

                    /*contractKindUpdate.setUpdate_user_id(contractKindDetail.getUpdate_user_id());
                    contractKindUpdate.setUpdate_user_name(contractKindDetail.getUpdate_user_name());*/


                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/contract/UpdateContractKind", contractKindUpdate.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }

            }

            List<ContractTemp> contractTempListFromSTP;
            contractTempListFromSTP = QueryFactory.getContractTempFromOSP(" where 1=1");
            int countContractTempFromOSP;
            countContractTempFromOSP = QueryFactory.countTotalContractTempFromOSP("where 1=1");
            for (int i = 0; i < countContractTempFromOSP; i++) {
                ContractTemp contractTempDetail = contractTempListFromSTP.get(i);
                String kiemtra = "where code_template = '" + contractTempDetail.getCode_template() + "'";
                int count = QueryFactory.countTotalContractTemp(kiemtra);
                if (count < 1) {

                    contractTemp.setSid(contractTempDetail.getSid());
                    contractTemp.setName(contractTempDetail.getName());
                    contractTemp.setKind_id(contractTempDetail.getKind_id());
                    contractTemp.setKind_id_tt08(contractTempDetail.getKind_id_tt08());
                    contractTemp.setCode(contractTempDetail.getCode());
                    contractTemp.setDescription(contractTempDetail.getDescription());
                    contractTemp.setFile_name(contractTempDetail.getFile_name());
                    contractTemp.setFile_path(contractTempDetail.getFile_path());
                    contractTemp.setActive_flg(contractTempDetail.getActive_flg());
                    contractTemp.setRelate_object_number(contractTempDetail.getRelate_object_number());
                    contractTemp.setRelate_object_A_display(contractTempDetail.getRelate_object_A_display());
                    contractTemp.setRelate_object_B_display(contractTempDetail.getRelate_object_B_display());
                    contractTemp.setRelate_object_C_display(contractTempDetail.getRelate_object_C_display());
                    contractTemp.setPeriod_flag(contractTempDetail.getPeriod_flag());
                    contractTemp.setPeriod_req_flag(contractTempDetail.getPeriod_req_flag());
                    contractTemp.setMortage_cancel_func(contractTempDetail.getMortage_cancel_func());
                    contractTemp.setSync_option(contractTempDetail.getSync_option());
                    contractTemp.setEntry_user_name(contractTempDetail.getEntry_user_name());
                    contractTemp.setEntry_user_id(contractTempDetail.getEntry_user_id());
                    contractTemp.setUpdate_user_id(contractTempDetail.getUpdate_user_id());
                    contractTemp.setUpdate_user_name(contractTempDetail.getUpdate_user_name());
                    contractTemp.setKind_html(contractTempDetail.getKind_html());
                    contractTemp.setOffice_code(contractTempDetail.getOffice_code());
                    contractTemp.setCode_template(contractTempDetail.getCode_template());




                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/ContractTemplate/AddContractTemp", contractTemp.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
                else {

                    contractTemp.setSid(contractTempDetail.getSid());
                    contractTemp.setName(contractTempDetail.getName());
                    contractTemp.setKind_id(contractTempDetail.getKind_id());
                    contractTemp.setKind_id_tt08(contractTempDetail.getKind_id_tt08());
                    contractTemp.setCode(contractTempDetail.getCode());
                    contractTemp.setDescription(contractTempDetail.getDescription());
                    contractTemp.setFile_name(contractTempDetail.getFile_name());
                    contractTemp.setFile_path(contractTempDetail.getFile_path());
                    contractTemp.setActive_flg(contractTempDetail.getActive_flg());
                    contractTemp.setRelate_object_number(contractTempDetail.getRelate_object_number());
                    contractTemp.setRelate_object_A_display(contractTempDetail.getRelate_object_A_display());
                    contractTemp.setRelate_object_B_display(contractTempDetail.getRelate_object_B_display());
                    contractTemp.setRelate_object_C_display(contractTempDetail.getRelate_object_C_display());
                    contractTemp.setPeriod_flag(contractTempDetail.getPeriod_flag());
                    contractTemp.setPeriod_req_flag(contractTempDetail.getPeriod_req_flag());
                    contractTemp.setMortage_cancel_func(contractTempDetail.getMortage_cancel_func());
                    contractTemp.setSync_option(contractTempDetail.getSync_option());
                    contractTemp.setEntry_user_name(contractTempDetail.getEntry_user_name());
                    contractTemp.setEntry_user_id(contractTempDetail.getEntry_user_id());
                    contractTemp.setUpdate_user_id(contractTempDetail.getUpdate_user_id());
                    contractTemp.setUpdate_user_name(contractTempDetail.getUpdate_user_name());
                    contractTemp.setKind_html(contractTempDetail.getKind_html());
                    contractTemp.setOffice_code(contractTempDetail.getOffice_code());
                    contractTemp.setCode_template(contractTempDetail.getCode_template());


                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/ContractTemplate/UpdateContractTemp", contractTemp.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }

            }


            return new ModelAndView("redirect:/system/osp/contracttemplate-list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/system/osp/contracttemplate-list?status=4");
        }

    }

    @RequestMapping(value = "/contracttemplate-update-select", method = RequestMethod.POST)
    public ModelAndView updateContractTempSelect(ContractTemp contractTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
            HttpSession session = request.getSession();
        try{
            String listIdSelect = request.getParameter("listIdSelect").toString();
            List<String> listId = Arrays.asList(listIdSelect.split(";"));

            /* phần ContractKind */
            List<ContractKinds> contractKindListFromSTP;
            contractKindListFromSTP = QueryFactory.getContractKindFromOSP(" where 1=1");
            int countContractKindFromOSP;
            countContractKindFromOSP = QueryFactory.countTotalContractKindFromOSP("where 1=1");
            for (int j = 0; j < countContractKindFromOSP; j++) {
                ContractKinds contractKindDetail = contractKindListFromSTP.get(j);
                String kiemtrack = "where contract_kind_code = '" + contractKindDetail.getContract_kind_code() + "'";
                int countck = QueryFactory.countTotalContractKind(kiemtrack);
                if (countck < 1) {
                    ContractKindAdd contractKindAdd = new ContractKindAdd();
                    contractKindAdd.setId(contractKindDetail.getCkId());
                    contractKindAdd.setName(contractKindDetail.getName());
                    contractKindAdd.setCode(contractKindDetail.getContract_kind_code());

                    /*contractKindAdd.setUpdate_user_id(contractKindDetail.getUpdate_user_id());
                    contractKindAdd.setUpdate_user_name(contractKindDetail.getUpdate_user_name());*/

                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/contract/AddContractKind", contractKindAdd.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
                else {

                    ContractKindUpdate contractKindUpdate = new ContractKindUpdate();
                    contractKindUpdate.setCkId(contractKindDetail.getCkId());
                    contractKindUpdate.setName(contractKindDetail.getName());
                    contractKindUpdate.setContract_kind_code(contractKindDetail.getContract_kind_code());

                    /*contractKindUpdate.setUpdate_user_id(contractKindDetail.getUpdate_user_id());
                    contractKindUpdate.setUpdate_user_name(contractKindDetail.getUpdate_user_name());*/

                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/contract/UpdateContractKind", contractKindUpdate.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
            }

            //phần ContractTemp
            List<ContractTemp> contractTempListFromSTP = new ArrayList<>();

            for(int i = 0; i < listId.size(); i++) {
                if(listId.get(i) == null || listId.get(i).equals("")) break;
                int id = Integer.parseInt(listId.get(i));
                List<ContractTemp> contractTempFromSTPFillter;
                contractTempFromSTPFillter = QueryFactory.getContractTempFromOSP(" where id = " + id );
                if(contractTempFromSTPFillter.size() > 0)
                contractTempListFromSTP.add(contractTempFromSTPFillter.get(0));
            }

            for (int i = 0; i < contractTempListFromSTP.size(); i++) {
                ContractTemp contractTempDetail = contractTempListFromSTP.get(i);
                String kiemtra = "where code_template = '" + contractTempDetail.getCode_template() + "'";
                int count = QueryFactory.countTotalContractTemp(kiemtra);
                if (count < 1) {

                    contractTemp.setSid(contractTempDetail.getSid());
                    contractTemp.setName(contractTempDetail.getName());
                    contractTemp.setKind_id(contractTempDetail.getKind_id());
                    contractTemp.setKind_id_tt08(contractTempDetail.getKind_id_tt08());
                    contractTemp.setCode(contractTempDetail.getCode());
                    contractTemp.setDescription(contractTempDetail.getDescription());
                    contractTemp.setFile_name(contractTempDetail.getFile_name());
                    contractTemp.setFile_path(contractTempDetail.getFile_path());
                    contractTemp.setActive_flg(contractTempDetail.getActive_flg());
                    contractTemp.setRelate_object_number(contractTempDetail.getRelate_object_number());
                    contractTemp.setRelate_object_A_display(contractTempDetail.getRelate_object_A_display());
                    contractTemp.setRelate_object_B_display(contractTempDetail.getRelate_object_B_display());
                    contractTemp.setRelate_object_C_display(contractTempDetail.getRelate_object_C_display());
                    contractTemp.setPeriod_flag(contractTempDetail.getPeriod_flag());
                    contractTemp.setPeriod_req_flag(contractTempDetail.getPeriod_req_flag());
                    contractTemp.setMortage_cancel_func(contractTempDetail.getMortage_cancel_func());
                    contractTemp.setSync_option(contractTempDetail.getSync_option());
                    contractTemp.setEntry_user_name(contractTempDetail.getEntry_user_name());
                    contractTemp.setEntry_user_id(contractTempDetail.getEntry_user_id());
                    contractTemp.setUpdate_user_id(contractTempDetail.getUpdate_user_id());
                    contractTemp.setUpdate_user_name(contractTempDetail.getUpdate_user_name());
                    contractTemp.setKind_html(contractTempDetail.getKind_html());
                    contractTemp.setOffice_code(contractTempDetail.getOffice_code());
                    contractTemp.setCode_template(contractTempDetail.getCode_template());

                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/ContractTemplate/AddContractTemp", contractTemp.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
                else {

                    contractTemp.setSid(contractTempDetail.getSid());
                    contractTemp.setName(contractTempDetail.getName());
                    contractTemp.setKind_id(contractTempDetail.getKind_id());
                    contractTemp.setKind_id_tt08(contractTempDetail.getKind_id_tt08());
                    contractTemp.setCode(contractTempDetail.getCode());
                    contractTemp.setDescription(contractTempDetail.getDescription());
                    contractTemp.setFile_name(contractTempDetail.getFile_name());
                    contractTemp.setFile_path(contractTempDetail.getFile_path());
                    contractTemp.setActive_flg(contractTempDetail.getActive_flg());
                    contractTemp.setRelate_object_number(contractTempDetail.getRelate_object_number());
                    contractTemp.setRelate_object_A_display(contractTempDetail.getRelate_object_A_display());
                    contractTemp.setRelate_object_B_display(contractTempDetail.getRelate_object_B_display());
                    contractTemp.setRelate_object_C_display(contractTempDetail.getRelate_object_C_display());
                    contractTemp.setPeriod_flag(contractTempDetail.getPeriod_flag());
                    contractTemp.setPeriod_req_flag(contractTempDetail.getPeriod_req_flag());
                    contractTemp.setMortage_cancel_func(contractTempDetail.getMortage_cancel_func());
                    contractTemp.setSync_option(contractTempDetail.getSync_option());
                    contractTemp.setEntry_user_name(contractTempDetail.getEntry_user_name());
                    contractTemp.setEntry_user_id(contractTempDetail.getEntry_user_id());
                    contractTemp.setUpdate_user_id(contractTempDetail.getUpdate_user_id());
                    contractTemp.setUpdate_user_name(contractTempDetail.getUpdate_user_name());
                    contractTemp.setKind_html(contractTempDetail.getKind_html());
                    contractTemp.setOffice_code(contractTempDetail.getOffice_code());
                    contractTemp.setCode_template(contractTempDetail.getCode_template());

                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/ContractTemplate/UpdateContractTemp", contractTemp.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
            }

            return new ModelAndView("redirect:/system/osp/contracttemplate-list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/system/osp/contracttemplate-list?status=4");
        }
    }

    @RequestMapping(value = "/contracttemplate-view/{id}", method = RequestMethod.GET)
    public ModelAndView contractTempViewFromOSP(@PathVariable("id") Long pid, HttpServletRequest request, HttpServletResponse response) {
        ContractTempList contractTempList = new ContractTempList();

        List<ContractTemp> list = getContractTempById(pid);
        ContractTemp contractTemp = list.get(0);
        contractTempList.setContractTempDetail(contractTemp);

        String stringFilter = "where 1=1";
        List<ContractKind> result = APIUtil.getContractKind(Constants.VPCC_API_LINK + "/contract/findContractKindByFilter", stringFilter);
        contractTempList.setListContractKind(result);
        if(contractTemp.getKind_id() != null || contractTemp.getKind_id() != 0){  //template chiled
            // get parent template
            String filter = " where code_template = " + contractTemp.getKind_id();
            List<ContractTemp> parent = TemplateFactory.getContractTempByFilter(filter);
            if(parent != null && parent.size() > 0) {
                contractTempList.setParent_name_contractTempDetail(parent.get(0).getName());
            }
        }

        return new ModelAndView("/system/SM0026", "contractTempList", contractTempList);

    }

    public List<ContractTemp> getContractTempById(Long bid) {
        String filter = "where id = " + bid;

        List<ContractTemp> result = APIUtil.getContractTempList(Constants.VPCC_API_LINK + "/ContractTemplate/FindContractTempByFilter", filter);
        return result;
    }

    @RequestMapping(value = "/contracttemplate-add", method = RequestMethod.GET)
    public ModelAndView addContractTemp(HttpServletRequest request, HttpServletResponse response) {
        ContractTempList addOrUpdate = new ContractTempList();
        addOrUpdate.setAction_status("add");
        ContractTemp tem = new ContractTemp();
        addOrUpdate.setContractTempDetail(tem);
        return new ModelAndView("/system/SM0030", "itemCustum", addOrUpdate);
    }

    @RequestMapping(value = "/contracttemplate-add-custum", method = RequestMethod.POST)
    public ModelAndView addContractTempCustum(ContractTempString contractTempString, HttpServletRequest request, HttpServletResponse response) {
        ContractTemp tem = contractTempString.genContractTemp(contractTempString);
        ContractTempList addOrUpdate = new ContractTempList();
        addOrUpdate.setAction_status("custum_add");

        addOrUpdate.setContractTempDetail(tem);
        if(tem.getKind_id() == null || tem.getKind_id() == 0L) {    //template cấp cha
            addOrUpdate.setParent_name_contractTempDetail("true");
        } else {     //template cấp con
            String filter = " where code_template = " + tem.getKind_id();
            List<ContractTemp> parent = TemplateFactory.getContractTempByFilter(filter);
            if(parent != null && parent.size() > 0) {
                addOrUpdate.getContractTempDetail().setGetCode_template_(parent.get(0).getCode_template());
                addOrUpdate.getContractTempDetail().setName_(parent.get(0).getName());

                addOrUpdate.setParent_name_contractTempDetail("false");
            }
        }
        return new ModelAndView("/system/SM0030", "itemCustum", addOrUpdate);
    }

    @RequestMapping(value = "/contracttemplate-update-custum", method = RequestMethod.POST)
    public ModelAndView updateContractTempCustum(ContractTempString contractTempString, HttpServletRequest request, HttpServletResponse response) {
        ContractTemp tem = contractTempString.genContractTemp(contractTempString);
        ContractTempList addOrUpdate = new ContractTempList();
        addOrUpdate.setAction_status("custum_update");

        addOrUpdate.setContractTempDetail(tem);
        if(tem.getKind_id() == null || tem.getKind_id() == 0L) {    //template cấp cha
            addOrUpdate.setParent_name_contractTempDetail("true");
        } else {     //template cấp con
            String filter = " where code_template = " + tem.getKind_id();
            List<ContractTemp> parent = TemplateFactory.getContractTempByFilter(filter);
            if(parent != null && parent.size() > 0) {
                addOrUpdate.getContractTempDetail().setGetCode_template_(parent.get(0).getCode_template());
                addOrUpdate.getContractTempDetail().setName_(parent.get(0).getName());

                addOrUpdate.setParent_name_contractTempDetail("false");
            }
        }
        return new ModelAndView("/system/SM0030", "itemCustum", addOrUpdate);
    }

    @RequestMapping(value = "/contracttemplate-edit-view/{id}", method = RequestMethod.GET)
    public ModelAndView contractTempEditViewFromOSP(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) {
        if (StringUtils.isBlank(id)) {
            return new ModelAndView("redirect:/template/contract/list");
        }
        ContractTemplateBO item = TemplateFactory.getContractTemplate(id);
        if (!StringUtils.isBlank(item.getKind_html())) {
            item.setKind_html(StringUtil.removeSpecialCharactersNotHTML(item.getKind_html()));
            item.setKind_html(item.getKind_html().trim());
        }
        return new ModelAndView("/system/SM0031", "item", item);
    }

    @RequestMapping(value = "/contracttemplate-edit", method = RequestMethod.POST)
    public ModelAndView contractEditSave(ContractTemplateBO item, HttpServletRequest request, HttpServletResponse response) {
        //Escape special char
        //item.setCode(StringUtil.escapeSpecialChar(item.getCode()));
        item.setName(StringUtil.escapeSpecialChar(item.getName()));
        item.setRelate_object_a_display(StringUtil.escapeSpecialChar(item.getRelate_object_a_display()));
        item.setRelate_object_b_display(StringUtil.escapeSpecialChar(item.getRelate_object_b_display()));
        item.setRelate_object_c_display(StringUtil.escapeSpecialChar(item.getRelate_object_c_display()));
        item.setDescription(StringUtil.escapeSpecialChar(item.getDescription()));
        //END Escape special char
        if (item == null || item.getId() == 0) {
            return new ModelAndView("redirect:/system/osp/contracttemplate-list");
        }
        if (!StringUtils.isBlank(item.getKind_html())) {
            item.setKind_html(StringUtil.removeSpecialCharactersNotHTML(item.getKind_html()));
            item.setKind_html(item.getKind_html().trim());
        }
        CommonContext commonContext = (CommonContext) request.getSession().getAttribute(request.getSession().getId());
        User userSession = commonContext.getUser();
        item.setEntry_user_id(userSession.getEntry_user_id());
        item.setEntry_user_name(userSession.getEntry_user_name());
        item.setUpdate_user_id(userSession.getUserId());
        item.setUpdate_user_name(userSession.getUpdate_user_name());

        boolean checkUpdate = TemplateFactory.updateContractTemplate_(item);
        if (!checkUpdate) {
            return new ModelAndView("/system/SM0031", "item", item);
        }
        return new ModelAndView("redirect:/system/osp/contracttemplate-list?status=2");
    }

    @RequestMapping(value = "/config-db-master-view", method = RequestMethod.GET)
    public ModelAndView configDBMaster(configDBMasterDetail item,String status, HttpServletRequest request, HttpServletResponse response) {
        item.setConfigDBMaster(TemplateFactory.getConfigDBMaster());
        item.setStatus(status);
        return new ModelAndView("/masterConvert/configDB", "item", item);
    }

    @RequestMapping(value = "/data-master-view", method = RequestMethod.GET)
    public ModelAndView dataDBMaster(String status, HttpServletRequest request, HttpServletResponse response) {
        if(status == null){
            status = "-1";
        }
        return new ModelAndView("/masterConvert/dataMaster","status",status);
    }

    @RequestMapping(value = "/data-master-view/{id}", method = RequestMethod.GET)
    public ModelAndView dataDBMasterFinById(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) {
        if(!ValidationPool.checkRoleDetail(request,"25",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        MasterContract masterContract =TemplateFactory.getMasterContract(id);
        return new ModelAndView("/masterConvert/detailMasterContract","masterContract",masterContract);
    }
}
