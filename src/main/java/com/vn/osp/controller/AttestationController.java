package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.SystemProperties;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.Attestation;
import com.vn.osp.modelview.AttestationList;
import com.vn.osp.service.APIUtil;
import com.vn.osp.service.factory.TemplateFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/attestation-template")
public class AttestationController {
    @RequestMapping(value = "/list-view", method = RequestMethod.GET)
    public ModelAndView list_view() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("template/attestation/list");
        return modelAndView;
    }

    @RequestMapping(value = "/add-view", method = RequestMethod.GET)
    public ModelAndView add_view() {
        Attestation item = new Attestation();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("item", item);
        modelAndView.setViewName("/template/attestation/add");
        return modelAndView;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView addTempAction(Attestation attestationTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        try {
            APIUtil.callAPI(Constants.VPCC_API_LINK + "/api-attestation/add", attestationTemp.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
            return new ModelAndView("redirect:/attestation-template/list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/attestation-template/list?status=4");
        }

    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(AttestationList attestationTempList, String status, HttpServletRequest request, HttpServletResponse response) {
        /*attestationTempList.setName(StringUtil.escapeSpecialChar(attestationTempList.getName()));*/
        // contractTempList.setModel_open(StringUtil.escapeSpecialChar(contractTempList.getModel_open()));
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");

        List<Attestation> attestations = APIUtil.getAttestationTempList(Constants.VPCC_API_LINK + "/api-attestation/search?parent_code=000");

        return new ModelAndView("/template/attestation/list", "attestationTempList", attestations);
    }

    @RequestMapping(value = "/attestationtemplate-update", method = RequestMethod.GET)
    public ModelAndView updateTemp(Attestation attestationTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        try {
            int org_type = 0;
            if (SystemProperties.getProperty("org_type").equals("1")) org_type = 1;
            /* phần ContractKind */
            List<Attestation> attestationsListFromOSP;
            attestationsListFromOSP = TemplateFactory.getAttestationTempFromOSP(org_type, "", "000");


            int countAttestationFromOSP;
            countAttestationFromOSP = TemplateFactory.countTotalAttestationTempFromOSP(org_type, "", "000");
            for (int i = 0; i < countAttestationFromOSP; i++) {
                Attestation attestation = attestationsListFromOSP.get(i);
                //  String checkExist = "and bo.code = '" + attestation.getCode() + "'";
                int countck = TemplateFactory.countTotalAttestationTemp(attestation.getCode());
                if (countck < 1) {

                    Attestation attestationAdd = new Attestation();
                    attestationAdd.setName(attestation.getName());
                    attestationAdd.setCode(attestation.getCode());
                    attestationAdd.setParent_code(attestation.getParent_code());
                    attestationAdd.setKind_html(attestation.getKind_html());
                    attestationAdd.setDescription(attestation.getDescription());
                    attestationAdd.setActive_flg(attestation.getActive_flg());
                    attestationAdd.setType_org(attestation.getType_org());
                    attestationAdd.setType(attestation.getType());
                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/api-attestation/add", attestationAdd.generateAddJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));

                } else {
                    Attestation attestationUpdate = new Attestation();
                    attestationUpdate.setName(attestation.getName());
                    attestationUpdate.setCode(attestation.getCode());
                    attestationUpdate.setParent_code(attestation.getParent_code());
                    attestationUpdate.setKind_html(attestation.getKind_html());
                    attestationUpdate.setDescription(attestation.getDescription());
                    attestationUpdate.setActive_flg(attestation.getActive_flg());
                    attestationUpdate.setType_org(attestation.getType_org());
                    attestationUpdate.setType(attestation.getType());
                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/api-attestation/updateSync", attestationUpdate.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));

                }
            }

            return new ModelAndView("redirect:/attestation-template/list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/attestation-template/list?status=4");
        }

    }

    @RequestMapping(value = "/attestationtemplate-update-select", method = RequestMethod.GET)
    public ModelAndView updateTempSelect(Attestation attestationTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        try {
            String listCodeSelect = request.getParameter("listCodeSelect");
            List<String> listCode = Arrays.asList(listCodeSelect.split(";"));

            int org_type = 0;
            if (SystemProperties.getProperty("org_type").equals("1")) org_type = 1;


            for (int i = 0; i < listCode.size(); i++) {
                List<Attestation> attestationsFromOSP = TemplateFactory.getAttestationTempFromOSP(org_type, listCode.get(i), "");
                if (attestationsFromOSP != null && !attestationsFromOSP.isEmpty()) {
                    Attestation attestationFromOSP = attestationsFromOSP.get(0);
                    Attestation attestationUpdate = new Attestation();
                    attestationUpdate.setName(attestationFromOSP.getName());
                    attestationUpdate.setCode(attestationFromOSP.getCode());
                    attestationUpdate.setParent_code(attestationFromOSP.getParent_code());
                    attestationUpdate.setKind_html(attestationFromOSP.getKind_html());
                    attestationUpdate.setDescription(attestationFromOSP.getDescription());
                    attestationUpdate.setActive_flg(attestationFromOSP.getActive_flg());
                    attestationUpdate.setType_org(attestationFromOSP.getType_org());
                    attestationUpdate.setType(attestationFromOSP.getType());
                    APIUtil.callAPI(Constants.VPCC_API_LINK + "/api-attestation/updateSync", attestationUpdate.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));
                }
            }
            return new ModelAndView("redirect:/attestation-template/list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/attestation-template/list?status=4");
        }

    }


    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable(value = "id") Long id, HttpServletRequest request) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        Attestation item = TemplateFactory.getAttestationTempById(id);
        if (item == null) return new ModelAndView("/404");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/template/attestation/detail");
        if(!StringUtils.isBlank(item.getParent_code()) && !item.getParent_code().equals("000")){
            List<Attestation> listParent = TemplateFactory.getAttestationTemp("", item.getParent_code());
            if(listParent!=null && !listParent.isEmpty()) modelAndView.addObject("itemParent", listParent.get(0));
        }
        modelAndView.addObject("item", item);
        return modelAndView;
    }

    @RequestMapping(value = "/edit-view/{id}", method = RequestMethod.GET)
    public ModelAndView edit_view(@PathVariable(value = "id") Long id, HttpServletRequest request) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        Attestation item = TemplateFactory.getAttestationTempById(id);
        if (item == null) return new ModelAndView("/404");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/template/attestation/edit");
        if(!StringUtils.isBlank(item.getParent_code()) && !item.getParent_code().equals("000")){
            List<Attestation> listParent = TemplateFactory.getAttestationTemp("", item.getParent_code());
            if(listParent!=null && !listParent.isEmpty()) modelAndView.addObject("itemParent", listParent.get(0));
        }
        modelAndView.addObject("item", item);
        return modelAndView;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView updateTempAction(Attestation attestationTemp, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "12", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        try {
            Attestation itemDB = TemplateFactory.getAttestationTempById(attestationTemp.getId());
            if(itemDB==null) return new ModelAndView("/404");
            itemDB.setKind_html(attestationTemp.getKind_html());
            itemDB.setName(attestationTemp.getName());
            itemDB.setActive_flg(attestationTemp.getActive_flg());
            itemDB.setDescription(attestationTemp.getDescription());
            APIUtil.callAPI(Constants.VPCC_API_LINK + "/api-attestation/update", itemDB.generateUpdateJson(((CommonContext) session.getAttribute(request.getSession().getId())).getUser()));

            return new ModelAndView("redirect:/attestation-template/list?status=2");
        } catch (Exception e) {
            return new ModelAndView("redirect:/attestation-template/list?status=4");
        }

    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public ModelAndView contractDelete(@PathVariable("id") String id, HttpServletRequest request) {
        if (id == null) {
            return new ModelAndView("redirect:/attestation-template/list");
        }
        boolean item = TemplateFactory.deleteAttestationTemplate(id);
        return new ModelAndView("redirect:/attestation-template/list", "status", "3");
    }

}
