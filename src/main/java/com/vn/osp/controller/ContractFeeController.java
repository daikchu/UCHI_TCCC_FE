package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.modelview.*;
import com.vn.osp.service.APIUtil;
import com.vn.osp.service.QueryFactory;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Admin on 2018-05-22.
 */
@Controller
@RequestMapping(value = "/fee")
public class ContractFeeController {


    @RequestMapping (value = "/list", method= RequestMethod.GET)
    public ModelAndView listContractFeeView(ContractFeeList contractFeeList, HttpServletRequest request, HttpServletResponse response){
        int page = 1;
        int totalPage;
        int totalListNumber;


        HttpSession session = request.getSession();
        String action = (String)session.getAttribute(Constants.SESSION_ACTION);
        contractFeeList.setAction_status(action);
        session.removeAttribute(Constants.SESSION_ACTION);
        List<ContractKind> listContractKind = QueryFactory.getContractKind("where 1=1");
        List<ContractTemplate> listContractTemp = QueryFactory.getContractTemplate("where 1=1");
        contractFeeList.setListContractTemp(listContractTemp);
        contractFeeList.setContractKindList(listContractKind);
        if(contractFeeList != null){
            page = contractFeeList.getPage();
            totalPage = contractFeeList.getTotalPage();
            totalListNumber = contractFeeList.getTotal();
        }

        if(contractFeeList.getCode() == null){
            contractFeeList.setCode("");
        }
        if(contractFeeList.getNhomHD() == null){
            contractFeeList.setNhomHD("");
        }





        totalListNumber = QueryFactory.countTotalContractFee(contractFeeList.getCode(),contractFeeList.getNhomHD());
        totalPage = QueryFactory.countPage(totalListNumber);


        if(page > totalPage) page = totalPage;
        if(page < 1) page = 1;
        contractFeeList.setPage(page);
        contractFeeList.setTotalPage(totalPage);
        contractFeeList.setTotal(totalListNumber);

        List<ContractFeeBO> result = QueryFactory.getContractFeeCode(page,contractFeeList.getCode(),contractFeeList.getNhomHD());
        /*if(result!= null && result.size()>0){
            for(int i =0;i<result.size();i++){
                if(listContractTemp != null && listContractTemp.size()>0){
                    for (int j =0;j<listContractTemp.size();j++){
                        if(result.get(i).getCt_template_code() == listContractTemp.get(j).getCode_template() ){
                            result.get(i).setNameCode(listContractTemp.get(j).getName());
                        }

                    }
                }

            }
        }*/
        contractFeeList.setContractFeeLists(result);
        return new ModelAndView("/contractfee/CTF002","contractFeeList",contractFeeList);


    }
    @ResponseBody
    @RequestMapping(value = "/loadContractTemplate", method = RequestMethod.GET)
    public String loadContractTemplate(HttpServletRequest request) throws JSONException {
        String contractKind = request.getParameter("contractKind");
        String result = "";
        List<ContractTemplate> contractTemplates = null;
        if (contractKind.equals("")) {
            contractTemplates = QueryFactory.getContractTemplate("where 1=1");
        } else {
            contractTemplates = QueryFactory.getContractTemplate(" where code = "+ contractKind);
        }
        for (int i = 0; i < contractTemplates.size(); i++) {
            result += contractTemplates.get(i).getCode_template() + "o0o" + contractTemplates.get(i).getName() + ";";
        }

        return new JSONObject().put("result", result).toString();

    }

}
