package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.SystemProperties;
import com.vn.osp.common.util.ValidateParam;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.CertFee;
import com.vn.osp.modelview.SignCert;
import com.vn.osp.modelview.SignCertNumber;
import com.vn.osp.modelview.User;
import com.vn.osp.service.QueryFactory;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.vn.osp.util.StringUtils.trimAllFieldOfObject;

/**
 * Controller chứng thực chữ ký/bản sao
 * Created by DaiCQ on 13/08/2020.
 */
@Controller
@RequestMapping("/certificate")
public class CertificateController {
    @RequestMapping(value = "/list-{type}", method = RequestMethod.GET)
    public ModelAndView list(@PathVariable int type, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        String status = (String) session.getAttribute(Constants.SESSION_ACTION);
        session.removeAttribute(Constants.SESSION_ACTION);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("status", status);
        modelAndView.addObject("userId",userSession.getUserId());
        modelAndView.addObject("type", type);
        modelAndView.setViewName("certificate/signatureCertificate/list");
        return modelAndView;
    }

    @RequestMapping(value = "/add-view-{type}", method = RequestMethod.GET)
    public ModelAndView add(@PathVariable int type, Model model, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        SignCert item = new SignCert();
        model.addAttribute("item", item);
        model.addAttribute("type", type);
        return new ModelAndView("certificate/signatureCertificate/add");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(SignCert item, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        trimAllFieldOfObject(item);
        HttpSession session = request.getSession();
        String user_id = ((CommonContext) session.getAttribute(session.getId())).getUser().getUserId().toString();
        item.validate();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("item", item);
        modelAndView.addObject("type", item.getType());
        modelAndView.setViewName("certificate/signatureCertificate/add");
        if (item.getSuccess() == false) return modelAndView;

        List<SignCert> certExist = QueryFactory.getCertByCertNumber(item.getCert_number(), item.getType().toString(), user_id, item.getNotary_book());
        if(certExist != null && certExist.size()>0){
            item.setCert_number_(SystemMessageProperties.getSystemProperty("v3_field_existed"));
            return modelAndView;
        }

        Boolean result = QueryFactory.addCert(item.genAddObject(((CommonContext) session.getAttribute(session.getId())).getUser(),item));
        if (!result) {
            item.setSuccess(false);
            return modelAndView;
        }
        String listUrl = "certificate/list-"+item.getType();
        // add SignCertNumber tự tăng
        String[] certNumber = item.getCert_number().split("/");
        if(certNumber.length >= 2 && ValidateParam.isAlphanumeric(certNumber[0]) && ValidateParam.isAlphanumeric(certNumber[1])){
            String dt_code = ((CommonContext) session.getAttribute(session.getId())).getUser().getDistrict_code();
            String org_type = SystemProperties.getProperty("org_type");
            List<SignCertNumber> res = new ArrayList<>();
            SignCertNumber itemCertNumber = new SignCertNumber();

            itemCertNumber.setCert_number(Long.valueOf(certNumber[0]));
            itemCertNumber.setCert_type(item.getType());
            itemCertNumber.setDistrict_code(dt_code);
            itemCertNumber.setKind_id(certNumber[1]);
            itemCertNumber.setUser_id(Long.valueOf(user_id));
            res.add(itemCertNumber);

            Boolean rlt = QueryFactory.addCertNumber(itemCertNumber);
        }
        session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_add_success"));
        return new ModelAndView("redirect:/"+listUrl);

    }

    @RequestMapping(value = "/detail-view-{type}/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable("id") Long id,
                               @PathVariable("type") int type, HttpServletRequest request){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        SignCert signCert = QueryFactory.getCertById(id);
        if(signCert==null) return new ModelAndView("/404");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("item", signCert);
        modelAndView.addObject("type", type);
        modelAndView.setViewName("certificate/signatureCertificate/detail");
        return modelAndView;
    }

    @RequestMapping(value = "/edit-view-{type}/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id,
                             @PathVariable("type") int type, HttpServletRequest request){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        SignCert signCert = QueryFactory.getCertById(id);
        if(signCert==null) return new ModelAndView("/404");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("item", signCert);
        modelAndView.addObject("type", type);
        modelAndView.setViewName("certificate/signatureCertificate/edit");
        return modelAndView;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(SignCert item, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        view.addObject("item", item);
        view.addObject("type", item.getType());
        view.setViewName("certificate/signatureCertificate/edit");
        HttpSession session = request.getSession();
        String user_id = ((CommonContext) session.getAttribute(session.getId())).getUser().getUserId().toString();
        String listUrl = "certificate/list-"+item.getType();
        SignCert itemDB = QueryFactory.getCertById(Long.valueOf(item.getId()));
        if (itemDB != null) {
        /*set data số lượng bản sao + phí công chứng từ db*/
        item.setCert_doc_number(itemDB.getCert_doc_number());
        item.setCert_fee(itemDB.getCert_fee());
        /*END set data số lượng bản sao + phí công chứng từ db*/
        item.validate();
        if (!item.getSuccess()) return view;
            List<SignCert> certExist = QueryFactory.getCertByCertNumber(item.getCert_number(), item.getType().toString(), user_id, item.getNotary_book());
            if(certExist != null && (certExist.size()>1 || (certExist.size()==1 && !certExist.get(0).getId().equals(item.getId())))){
                item.setCert_number_(SystemMessageProperties.getSystemProperty("v3_field_existed"));
                return view;
            }
            Boolean resultUpdated = QueryFactory.updateCert(item.genUpdateObject(((CommonContext) session.getAttribute(session.getId())).getUser(),item));

            // add SignCertNumber tự tăng
            String[] certNumber = item.getCert_number().split("/");
            if(certNumber.length >= 2 && ValidateParam.isAlphanumeric(certNumber[0]) && ValidateParam.isAlphanumeric(certNumber[1])){
                String dt_code = ((CommonContext) session.getAttribute(session.getId())).getUser().getDistrict_code();
                List<SignCertNumber> res = new ArrayList<>();
                SignCertNumber itemCertNumber = new SignCertNumber();

                itemCertNumber.setCert_number(Long.valueOf(certNumber[0]));
                itemCertNumber.setCert_type(item.getType());
                itemCertNumber.setDistrict_code(dt_code);
                itemCertNumber.setKind_id(certNumber[1]);
                itemCertNumber.setUser_id(Long.valueOf(user_id));
                res.add(itemCertNumber);

                Boolean rlt = QueryFactory.addCertNumber(itemCertNumber);
            }

            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_update_success"));
            return new ModelAndView("redirect:/"+listUrl);
        } else {

            redirectAttributes.addFlashAttribute("errorCode", "Chứng thực này không tồn tại !");
            return new ModelAndView("redirect:/"+listUrl);
        }

    }

    @RequestMapping(value = "/delete-{type}/{id}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable("id") Long id,
                               @PathVariable("type") int type,HttpServletRequest request) {
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        /*Boolean result = true;*/
        Boolean result = QueryFactory.removeCert(id.toString());
        String listUrl = "certificate/list-"+type;
        if (result) {
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_success"));
            return new ModelAndView("redirect:/"+listUrl);
        } else {
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_not"));
            return new ModelAndView("redirect:/"+listUrl);
        }
    }

    @RequestMapping(value = "/report-signature-cert", method = RequestMethod.GET)
    public ModelAndView reportSign(String status, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        if(status == null || status.equals("")){status = "0";}
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("type", Constants.CERTIFICATE_TYPE_SIGNATURE);
        modelAndView.addObject("status", status);
        modelAndView.addObject("userId",userSession.getUserId());
        modelAndView.setViewName("certificate/report/signatureCertificate");
        return modelAndView;
    }

    @RequestMapping(value = "/report-copy-cert", method = RequestMethod.GET)
    public ModelAndView reportCopy(String status, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "36", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        if(status == null || status.equals("")){status = "0";}
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("type", Constants.CERTIFICATE_TYPE_COPY);
        modelAndView.addObject("status", status);
        modelAndView.addObject("userId",userSession.getUserId());
        modelAndView.setViewName("certificate/report/authenticatedCopies");
        return modelAndView;
    }

    @RequestMapping(value = "/export-signature-cert", method = RequestMethod.GET)
    public void exportSign(HttpServletRequest request, HttpServletResponse response,
                       @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                       @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo,
                       @RequestParam(name = "notary_book", required = false, defaultValue = "") String notary_book) {
        try {

            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
            Integer count = 0;
            List<SignCert> signCerts = new ArrayList<>();
            count = QueryFactory.countCert(userSession.getUserId().toString(), dateFrom, dateTo, notary_book, String.valueOf(Constants.CERTIFICATE_TYPE_SIGNATURE));
            signCerts = QueryFactory.getCerts(userSession.getUserId().toString(), dateFrom, dateTo, notary_book, String.valueOf(Constants.CERTIFICATE_TYPE_SIGNATURE));
            //     export(contractStasticsWrapper,response);
            Map<String, Object> beans = new HashMap<String, Object>();



            beans.put("dateFrom",dateFrom.substring(0,2));
        //    beans.put("dateFrom",dateFrom);
            beans.put("monthFrom",dateFrom.substring(3,5));
            beans.put("yearFrom",dateFrom.substring(6,10));
            beans.put("dateTo",dateTo.substring(0,2));
            beans.put("monthTo",dateTo.substring(3,5));
            beans.put("yearTo",dateTo.substring(6,10));
            beans.put("notary_book",notary_book);



          //  beans.put("fromdate", dateFrom);
            beans.put("todate", dateTo);
            beans.put("countTotal", count);
            beans.put("items", signCerts);

            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());

            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeChungThucChuKy.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);


            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_ThongKeChungThucChuKy.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-copy-cert", method = RequestMethod.GET)
    public void exportCert(HttpServletRequest request, HttpServletResponse response,
                       @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                       @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo,
                       @RequestParam(name = "notary_book", required = false, defaultValue = "") String notary_book){
        try{
            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
            Integer count = 0;
            List<SignCert> authenticatedCopies = new ArrayList<>();
            count = QueryFactory.countCert(userSession.getUserId().toString(), dateFrom, dateTo, notary_book, String.valueOf(Constants.CERTIFICATE_TYPE_COPY));
            authenticatedCopies = QueryFactory.getCerts(userSession.getUserId().toString(), dateFrom, dateTo, notary_book, String.valueOf(Constants.CERTIFICATE_TYPE_COPY));
            //     export(contractStasticsWrapper,response);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("dateFrom",dateFrom.substring(0,2));
            beans.put("monthFrom",dateFrom.substring(3,5));
            beans.put("yearFrom",dateFrom.substring(6,10));
            beans.put("dateTo",dateTo.substring(0,2));
            beans.put("monthTo",dateTo.substring(3,5));
            beans.put("yearTo",dateTo.substring(6,10));
            beans.put("notary_book",notary_book);

          //  beans.put("fromdate", dateFrom);
            beans.put("todate", dateTo);
            beans.put("countTotal", count);
            beans.put("items", authenticatedCopies);

            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());

            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongKeChungThucBanSao.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_ThongKeChungThucBanSao.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();

        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public boolean checkSignCertNumberAdd(String cert_number){
        List<SignCert> signCerts = QueryFactory.getCertByCertNumber(cert_number, "", "","");
        if(signCerts != null && !signCerts.isEmpty()) return false;
        else return true;
    }

    public boolean checkSignCertNumberUpdate(SignCert item){
        List<SignCert> signCerts = QueryFactory.getCertByCertNumber(item.getCert_number(), "", "","");
        if(signCerts == null || (signCerts.size()==1 && signCerts.get(0).getId().equals(item.getId()))) return true;
        else return false;
    }

    @ResponseBody
    @RequestMapping(value = "suggestCertFee", method = RequestMethod.GET,produces ="application/json" )
    public CertFee suggestNotaryFee(HttpServletRequest request, HttpServletResponse response){
        String type = request.getParameter("type");
        String soBan = request.getParameter("soBan");
        Long notaryCostLong = Long.valueOf(soBan);

        CertFee list = QueryFactory.suggestCertFee(Integer.valueOf(type));
        try{
            String result = "";
            String item[] = null;
            String giatri = "";
            boolean checkCharacter = false;
            boolean checkMax = list.getFormula_fee().contains("~");
            if(checkMax){
                item = list.getFormula_fee().split("~");
            //    list.setNotaryFeeMax(item[1]);
                giatri = item[0];
                checkCharacter = giatri.contains("a");
                if(checkCharacter){
                    giatri = giatri.replaceAll("a",soBan);
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
                list.setFeeNumber(result);
            }else {
                giatri = list.getFormula_fee();
                checkCharacter = giatri.contains("a");
                if(checkCharacter){
                    giatri = giatri.replaceAll("a",soBan);
                    ScriptEngineManager mgr = new ScriptEngineManager();
                    ScriptEngine engine = mgr.getEngineByName("JavaScript");
                    Long resultLong = ((Number)engine.eval(giatri)).longValue();
                    result = resultLong.toString();
                }else {
                    result = list.getFormula_fee();
                }
                list.setFeeNumber(result);
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
}
