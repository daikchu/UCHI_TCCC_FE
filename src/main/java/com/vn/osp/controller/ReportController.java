package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.*;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.*;
import com.vn.osp.service.QueryFactory;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by minh on 5/16/2017.
 */
@Controller
@RequestMapping("/report")
public class ReportController {

    public Boolean checkGroupRole(HttpServletRequest request) {
        HttpSession session = request.getSession();
        CommonContext context = ((CommonContext) request.getSession().getAttribute(request.getSession().getId()));
        List<GrouproleAuthority> grouproleAuthorities = context.getGrouproleAuthorities();
        for (int i = 0; i < grouproleAuthorities.size(); i++) {
            int temp = grouproleAuthorities.get(i).getValue() & Constants.AUTHORITY_XEM;
            String authority_code = grouproleAuthorities.get(i).getAuthority_code();
            if (temp > 0 && authority_code.equals("19")) return true;
        }
        return false;
    }

    //MinhBQ
    @RequestMapping(value = "/group-bank", method = RequestMethod.GET)
    public ModelAndView BankGroup(ReportByBankForm reportByBankForm, HttpServletRequest request, HttpServletResponse response ) {
        //if (!checkGroupRole(request)) return new ModelAndView("/404", "message", null);
        if(!ValidationPool.checkRoleDetail(request,"24",Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        ModelAndView view = new ModelAndView();
        session.removeAttribute(ReportByBankForm.SESSION_KEY);
        if(reportByBankForm.getTimeType()== null){
            reportByBankForm.setTimeType("03");
            ValidateUtil.validate_msg_from_date ="";
            ValidateUtil.validate_msg_to_date ="";
        }

        ValidateUtil.validate_msg_from_date ="";
        ValidateUtil.validate_msg_to_date ="";
        ValidateUtil.validateDatefrom(reportByBankForm.getFromDate());
        ValidateUtil.validateDateto(reportByBankForm.getToDate());


        if(!StringUtils.isBlank(reportByBankForm.getTimeType())) {
            if(reportByBankForm.getTimeType().equals("05")) {
                if (!StringUtils.isBlank(reportByBankForm.getFromDate())) {
                    if (!StringUtils.isBlank(reportByBankForm.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByBankForm.getFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByBankForm.getToDate());
                        if(fromDate.getTime() > toDate.getTime()){
                            view.setViewName("/contract/CTR005");
                            view.addObject("reportByBankForm", reportByBankForm);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày !";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByBankForm.getFromDate()) == false || ValidateUtil.validateDateto(reportByBankForm.getToDate()) == false) {
                            view.setViewName("/contract/CTR005");
                            view.addObject("reportByBankForm", reportByBankForm);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH)+1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByBankForm.setToDate(toDate);
                        if(ValidateUtil.validateDatefrom(reportByBankForm.getFromDate())== false){
                            view.setViewName("/contract/CTR005");
                            view.addObject("reportByBankForm",reportByBankForm);
                            view.addObject("validate_msg_from_date",ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                    }
                } else {
                    view.setViewName("/contract/CTR005");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống !");
                    return view;
                }
            }
        }
        reportByBankForm.createFromToDate();

        int bankListNumber = 1;
        int bankTotalPage = 1;
        int page = 1;
        if (reportByBankForm != null) {
            bankListNumber = reportByBankForm.getTotal();
            bankTotalPage = reportByBankForm.getTotalPage();
            page = reportByBankForm.getPage();

        }

        List<Bank> bank = QueryFactory.getBankList(null);
        reportByBankForm.setBankList(bank);



        String orderFilter="";
        orderFilter = reportByBankForm.getOrderString();
        bankListNumber = QueryFactory.countTotalReportBankDetail(orderFilter);
        bankTotalPage = QueryFactory.countPage(bankListNumber);
        reportByBankForm.setTotal(bankListNumber);
        reportByBankForm.setTotalPage(bankTotalPage);

        if (page < 1) page = 1;
        if (bankListNumber < 1) bankListNumber = 1;
        if (bankTotalPage<1) bankTotalPage =1;
        if (page > bankTotalPage) page = bankTotalPage;

        reportByBankForm.setPage(page);
        orderFilter += "LIMIT " + ((page-1) * Constants.ROW_PER_PAGE)+",20";
        List<ReportByBankDetail> reportByBanks = QueryFactory.getReportBankDetail(page,orderFilter);

        reportByBankForm.setReportByBankDetails(reportByBanks);

        reportByBankForm.setBankList(bank);

        session.setAttribute(ReportByBankForm.SESSION_KEY, reportByBankForm);
        view.setViewName("/contract/CTR005");
        if(!reportByBankForm.getTimeType().equals("05")){
            reportByBankForm.setFromDate("");
            reportByBankForm.setToDate("");
        }

        if(reportByBankForm != null){
            if(reportByBankForm.getReportByBankDetails().size() > 0){
                for(int i = 0 ; i< reportByBankForm.getReportByBankDetails().size() ;i++){
                    if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content()) || !StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getProperty_info())){
                        if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content())){
                            reportByBankForm.getReportByBankDetails().get(i).setTransaction_content("Nội dung hợp đồng:<br>"+reportByBankForm.getReportByBankDetails().get(i).getTransaction_content());
                        }
                        if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getProperty_info())){
                            if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content())){
                                reportByBankForm.getReportByBankDetails().get(i).setTransaction_content(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content() + "<br>Thông tin tài sản:<br>"+reportByBankForm.getReportByBankDetails().get(i).getProperty_info());
                            }else{
                                reportByBankForm.getReportByBankDetails().get(i).setTransaction_content("<br>Thông tin tài sản:<br>"+reportByBankForm.getReportByBankDetails().get(i).getProperty_info());
                            }
                        }
                    }
                }
            }
        }
        view.addObject("reportByBankForm",reportByBankForm);
        view.addObject("validate_msg_from_date",ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date",ValidateUtil.validate_msg_to_date);
        return view;
    }
    @RequestMapping(value = "/export-bank", method = RequestMethod.GET)
    public void exportBankReport(HttpServletRequest request, HttpServletResponse response ) {
        String org_type = SystemProperties.getProperty("org_type");
        try {
            HttpSession session = request.getSession();
            ReportByBankForm reportByBankForm = (ReportByBankForm) session.getAttribute(ReportByBankForm.SESSION_KEY);
            List<Bank> bank = QueryFactory.getBankList(null);


            List<ReportByBankDetail> allReportByBank = QueryFactory.getAllReportByBank(reportByBankForm.getOrderString());
            String test = "";
            if(allReportByBank !=null){
                int i = allReportByBank.size();
                for(int j=0; j<i;j++){
                    if(!StringUtils.isBlank(allReportByBank.get(j).getRelation_object())){
                        allReportByBank.get(j).setRelation_object(allReportByBank.get(j).getRelation_object().replaceAll("\\\\r\\\\n|\\\\n","\n"));
                    }

                }
            }
            if(reportByBankForm != null){
                if(reportByBankForm.getReportByBankDetails().size() > 0){
                    for(int i = 0 ; i< reportByBankForm.getReportByBankDetails().size() ;i++){
                        if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content()) || !StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getProperty_info())){
                            if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content())){
                                reportByBankForm.getReportByBankDetails().get(i).setTransaction_content("Nội dung hợp đồng:<br>"+reportByBankForm.getReportByBankDetails().get(i).getTransaction_content());
                            }
                            if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getProperty_info())){
                                if(!StringUtils.isBlank(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content())){
                                    reportByBankForm.getReportByBankDetails().get(i).setTransaction_content(reportByBankForm.getReportByBankDetails().get(i).getTransaction_content() + "<br>Thông tin tài sản:<br>"+reportByBankForm.getReportByBankDetails().get(i).getProperty_info());
                                }else{
                                    reportByBankForm.getReportByBankDetails().get(i).setTransaction_content("<br>Thông tin tài sản:<br>"+reportByBankForm.getReportByBankDetails().get(i).getProperty_info());
                                }
                            }
                        }
                    }
                }
            }
            if(allReportByBank != null){
                if(allReportByBank.size() > 0){
                    for(int i = 0 ; i< allReportByBank.size() ;i++){
                        if(!StringUtils.isBlank(allReportByBank.get(i).getTransaction_content()) || !StringUtils.isBlank(allReportByBank.get(i).getProperty_info())){
                            if(!StringUtils.isBlank(allReportByBank.get(i).getTransaction_content())){
                                allReportByBank.get(i).setTransaction_content("Nội dung hợp đồng: \n"+allReportByBank.get(i).getTransaction_content());
                            }
                            if(!StringUtils.isBlank(allReportByBank.get(i).getProperty_info())){
                                if(!StringUtils.isBlank(allReportByBank.get(i).getTransaction_content())){
                                    allReportByBank.get(i).setTransaction_content(allReportByBank.get(i).getTransaction_content() + "\nThông tin tài sản: \n"+allReportByBank.get(i).getProperty_info());
                                }else{
                                    allReportByBank.get(i).setTransaction_content("\nThông tin tài sản: \n"+allReportByBank.get(i).getProperty_info());
                                }
                            }
                        }
                    }
                }
            }
            Map<String, Object> beans = new HashMap<String, Object>();

            beans.put("report", allReportByBank);
            beans.put("total", allReportByBank.size());

            beans.put("fromDate", reportByBankForm.getPrintFromDate());
            beans.put("toDate", reportByBankForm.getPrintToDate());
            beans.put("agency", ((CommonContext)request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("bank", reportByBankForm.getBankFilter());
            beans.put("org_type", org_type);

            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder=request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder+"BaocaoHDCCtheoNH.xls"));

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCtheoNH.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/group", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView forGroup_(ReportByGroupTotalList reportByGroupTotalList, HttpServletRequest request, HttpServletResponse response) {

        List<District> districts = new ArrayList<>();
        if(SystemProperties.getProperty("org_type").equals("1")){
            districts = QueryFactory.getDistricts();
        }
        //User user = new User();
        if (!ValidationPool.checkRoleDetail(request, "19", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        String kind_id = request.getParameter("nhomHD");
        CommonContext context = ((CommonContext)request.getSession().getAttribute(request.getSession().getId()));

        session.removeAttribute(ReportByGroupTotalList.SESSION_KEY);
        List<ContractTemplate> contractTemplates = null;
        ModelAndView view = new ModelAndView();
        view.addObject("districts", districts);


        reportByGroupTotalList.setUserId(context.getUser().getUserId());
        reportByGroupTotalList.setDistrict_code(context.getUser().getDistrict_code());
        reportByGroupTotalList.setLevel_cert(context.getUser().getLevel_cert());

        List<ContractKind> contractKinds = QueryFactory.getContractKind(" where 1=1");
        if (StringUtils.isBlank(kind_id) || Integer.parseInt(kind_id) <= 0) {
            contractTemplates = QueryFactory.getContractTemplate(" where 1=1 ");
        } else {
            contractTemplates = QueryFactory.getContractTemplate(" where code = " + kind_id);
        }

        reportByGroupTotalList.setContractKinds(contractKinds);
        reportByGroupTotalList.setContractTemplates(contractTemplates);

        if (reportByGroupTotalList.getTimeType() == null) {
            reportByGroupTotalList.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }
        if (reportByGroupTotalList.getTimeType().equals("05")) {

            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
            ValidateUtil.validateDateto(reportByGroupTotalList.getToDate());
            ValidateUtil.validateDatefrom(reportByGroupTotalList.getFromDate());

            if (!StringUtils.isBlank(reportByGroupTotalList.getFromDate())) {
                if (!StringUtils.isBlank(reportByGroupTotalList.getToDate())) {
                    if (ValidateUtil.validateDatefrom(reportByGroupTotalList.getFromDate()) == false || ValidateUtil.validateDateto(reportByGroupTotalList.getToDate()) == false) {
                        view.setViewName("/contract/CTR004");
                        view.addObject("reportByGroupTotalList", reportByGroupTotalList);
                        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                        return view;
                    } else if (ValidateUtil.validateDatefrom(reportByGroupTotalList.getFromDate()) == true && ValidateUtil.validateDateto(reportByGroupTotalList.getToDate()) == true) {
                        if (TimeUtil.stringToDate(reportByGroupTotalList.getFromDate()).getTime() > TimeUtil.stringToDate(reportByGroupTotalList.getToDate()).getTime()) {
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày ";
                            view.setViewName("/contract/CTR004");
                            view.addObject("reportByGroupTotalList", reportByGroupTotalList);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    }
                } else {
                    /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                    Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                    Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                    String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                    Date date = new Date();
                    SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                    String toDate = format.format(date);
                    reportByGroupTotalList.setToDate(toDate);
                }
            } else {
                view.setViewName("/contract/CTR004");
                view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                return view;
            }
        }
        reportByGroupTotalList.createFromToDate();
        if (reportByGroupTotalList.getNhomHD() == null) reportByGroupTotalList.setNhomHD(String.valueOf(0));
        if (reportByGroupTotalList.getTenHD() == null) reportByGroupTotalList.setTenHD(String.valueOf(0));
    //    if (reportByGroupTotalList.getDistrict_code() == null) reportByGroupTotalList.setDistrict_code(String.valueOf(0));

//        String userId = user.getUserId().toString();
//        String distUserId = user.getDistrict_code();
        List<ReportByGroupTotal> reportByGroupTotals = QueryFactory.getReportTotalListByGroup(reportByGroupTotalList.generateJson());

        reportByGroupTotalList.setReportByGroupTotals(reportByGroupTotals);
        long total = 0;
        ArrayList<ReportByGroupTableView> reportByGroupTableViews = new ArrayList<ReportByGroupTableView>();
        for (int i = 0; i < reportByGroupTotals.size(); i++) {
            total += reportByGroupTotals.get(i).getTemplate_number().longValue();
        }
        reportByGroupTotalList.setTotal(total);

        session.setAttribute(ReportByGroupTotalList.SESSION_KEY, reportByGroupTotalList);
        if (!reportByGroupTotalList.getTimeType().equals("05")) {
            reportByGroupTotalList.setFromDate("");
            reportByGroupTotalList.setToDate("");
        }
        if (!reportByGroupTotalList.getTimeType().equals("05")) {
            reportByGroupTotalList.setFromDate("");
            reportByGroupTotalList.setToDate("");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }
        view.setViewName("/contract/CTR004");
        view.addObject("districts", districts);
        view.addObject("reportByGroupTotalList", reportByGroupTotalList);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }

    @RequestMapping(value = "/group/export", method = RequestMethod.GET)
    public void groupExportExcel(HttpServletRequest request, HttpServletResponse response) {
        //if (!checkGroupRole(request)) return;
        try {
            HttpSession session = request.getSession();
            ReportByGroupTotalList reportByGroupTotalList = (ReportByGroupTotalList) session.getAttribute(ReportByGroupTotalList.SESSION_KEY);
            Map<String, Object> beans = new HashMap<String, Object>();

            beans.put("report", reportByGroupTotalList.getReportByGroupTotals());
            beans.put("total", reportByGroupTotalList.getTotal());
            beans.put("fromDate", reportByGroupTotalList.getPrintFromDate());
            beans.put("toDate", reportByGroupTotalList.getPrintToDate());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());

            if(!StringUtils.isBlank(reportByGroupTotalList.getDistrict_code())){
                //query get district name
                String filter = " and di.code = "+ reportByGroupTotalList.getDistrict_code();
                List<District> districts = QueryFactory.getDistrictsByFilter(filter);
                beans.put("districtName", districts.get(0).getName());

            }


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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaotheonhomHD.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaotheonhomHD.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/group-detail/export", method = RequestMethod.GET)
    public void groupdetailDetailExportExcel(HttpServletRequest request, HttpServletResponse response) {
        String org_type = SystemProperties.getProperty("org_type");
        //if (!checkGroupRole(request)) return;
        try {
            HttpSession session = request.getSession();
            ReportByGroupTotalList reportByGroupTotalList = (ReportByGroupTotalList) session.getAttribute(ReportByGroupTotalList.SESSION_KEY);
            reportByGroupTotalList.setPage(0);
            List<TransactionProperty> dsHopDong = new ArrayList<TransactionProperty>();
            dsHopDong = QueryFactory.getReportDetailByGroup(reportByGroupTotalList.generateJson());


            reportByGroupTotalList.setContractList(dsHopDong);
            int hopDongListNumber = QueryFactory.countDetailReportByGroup(reportByGroupTotalList.generateJson());

            reportByGroupTotalList.setContractListNumber(hopDongListNumber);
            reportByGroupTotalList.setTotalPage(QueryFactory.countPage(hopDongListNumber));
            Map<String, Object> beans = new HashMap<String, Object>();
            List<TransactionProperty> contractList = reportByGroupTotalList.getContractList();
            if (contractList != null) {
                int j = contractList.size();
                for (int i = 0; i < j; i++) {
                    if (!StringUtils.isBlank(contractList.get(i).getRelation_object()))
                        contractList.get(i).setRelation_object(contractList.get(i).getRelation_object().replaceAll("\\\\r\\\\n|\\\\n", "\n"));
                }
            }
            reportByGroupTotalList.setContractList(contractList);
            beans.put("report", reportByGroupTotalList.getContractList());
            beans.put("total", reportByGroupTotalList.getContractListNumber());
            beans.put("fromDate", reportByGroupTotalList.getFromDate());
            beans.put("toDate", reportByGroupTotalList.getToDate());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("contract_kind", reportByGroupTotalList.getNhomHDChiTiet());

            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            beans.put("org_type", org_type);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = null;
            if (reportByGroupTotalList.getSource().equals("2")) {
                fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCCDetail.xls"));

            }
            if (reportByGroupTotalList.getSource().equals("3")) {
                fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCT.xls"));

            }

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCDetail.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/group/detail/contract/{page}", method = RequestMethod.GET)
    public ModelAndView forGroupDetail(@PathVariable("page") int page,
                                       @RequestParam(value = "district_code", defaultValue = "", required = false) String district_code,
                                       HttpServletRequest request, HttpServletResponse response) {
        //if (!checkGroupRole(request)) return new ModelAndView("/404", "message", null);

        HttpSession session = request.getSession();
        ReportByGroupTotalList reportByGroupTotalList = (ReportByGroupTotalList) session.getAttribute(ReportByGroupTotalList.SESSION_KEY);
        reportByGroupTotalList.setSource("2");
        reportByGroupTotalList.setPage(page);
        reportByGroupTotalList.setDistrict_code(district_code);
        createContractList(reportByGroupTotalList, request);

        List<ContractKind> contractKinds = QueryFactory.getContractKind(" where contract_kind_code = " + reportByGroupTotalList.getNhomHD());
        reportByGroupTotalList.setNhomHDChiTiet(contractKinds.get(0).getName());
        String fromDate = reportByGroupTotalList.getNotaryDateFromFilter().substring(0, 10);
        String toDate = reportByGroupTotalList.getNotaryDateToFilter().substring(0, 10);
        String[] fromDateArr = fromDate.split("-");
        ArrayUtils.reverse(fromDateArr);
        fromDate = fromDateArr[0] + "/" + fromDateArr[1] + "/" + fromDateArr[2];
        String[] toDateArr = toDate.split("-");
        ArrayUtils.reverse(toDateArr);
        toDate = toDateArr[0] + "/" + toDateArr[1] + "/" + toDateArr[2];


        reportByGroupTotalList.setFromDate(fromDate);
        reportByGroupTotalList.setToDate(toDate);
        session.setAttribute(ReportByGroupTotalList.SESSION_KEY, reportByGroupTotalList);
        return new ModelAndView("/contract/CTR009", "reportByGroupTotalList", reportByGroupTotalList);
    }

    @RequestMapping(value = "/group/detail/pagging", method = RequestMethod.GET)
    public String forGroupPagging(ReportByGroupTotalList reportByGroupTotalListForm, HttpServletRequest request, HttpServletResponse response) {
        //if (!checkGroupRole(request)) return "/404";
        HttpSession session = request.getSession();
        ReportByGroupTotalList reportByGroupTotalList = (ReportByGroupTotalList) session.getAttribute(ReportByGroupTotalList.SESSION_KEY);
        reportByGroupTotalList.setPage(reportByGroupTotalListForm.getPage());
        session.setAttribute(ReportByGroupTotalList.SESSION_KEY, reportByGroupTotalList);
        return "redirect:/report/group/detail/contract/" + reportByGroupTotalListForm.getPage();
    }

    public ReportByGroupTotalList createContractList(ReportByGroupTotalList reportByGroupTotalList, HttpServletRequest request) {
        int page = 1;
        if (reportByGroupTotalList != null) {
            page = reportByGroupTotalList.getPage();
        }

        if (page < 1) page = 1;

        List<TransactionProperty> dsHopDong = new ArrayList<TransactionProperty>();
        dsHopDong = QueryFactory.getReportDetailByGroup(reportByGroupTotalList.generateJson());
        reportByGroupTotalList.setPage(page);

        reportByGroupTotalList.setContractList(dsHopDong);
        int hopDongListNumber = QueryFactory.countDetailReportByGroup(reportByGroupTotalList.generateJson());

        reportByGroupTotalList.setContractListNumber(hopDongListNumber);
        reportByGroupTotalList.setTotalPage(QueryFactory.countPage(hopDongListNumber));

        return reportByGroupTotalList;
    }
    /*Báo cáo theo công chứng viên
     * minhbq
     * 17/5/2017*/

    @RequestMapping(value = "/by-notary", method = RequestMethod.GET)
    public ModelAndView ReportByNotary(ReportByNotaryWrapper reportByNotaryWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "20", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(reportByNotaryWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();


        int notaryListNumber = 0;
        int notaryTotalPage = 1;
        int page = 1;
        if (reportByNotaryWrapper != null) {
            /*notaryListNumber = reportByNotaryWrapper.getTotal();
            notaryTotalPage = reportByNotaryWrapper.getTotalPage();*/
            page = reportByNotaryWrapper.getPage();
        }
        String orderString = "where role = 02";
        List<User> user = QueryFactory.getNotaryPersonByFilter(orderString);
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        reportByNotaryWrapper.setUsers(user);
        if (reportByNotaryWrapper.getTimeType() == null) {
            reportByNotaryWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        //replace special character
        reportByNotaryWrapper.setFromDate(StringUtil.escapeSpecialChar(reportByNotaryWrapper.getFromDate()));
        reportByNotaryWrapper.setToDate(StringUtil.escapeSpecialChar(reportByNotaryWrapper.getToDate()));
        //END replace special character

        if (!StringUtils.isBlank(reportByNotaryWrapper.getTimeType())) {
            if (reportByNotaryWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDateto(reportByNotaryWrapper.getToDate());
                ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate());

                if (!StringUtils.isBlank(reportByNotaryWrapper.getFromDate())) {
                    reportByNotaryWrapper.setFromDate(StringUtil.escapeSpecialChar(reportByNotaryWrapper.getFromDate()));
                    if (!StringUtils.isBlank(reportByNotaryWrapper.getToDate())) {

                        if ((!StringUtils.isBlank(reportByNotaryWrapper.getFromDate())
                                && ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate()) == false)
                                || (!StringUtils.isBlank(reportByNotaryWrapper.getToDate())
                                && ValidateUtil.validateDateto(reportByNotaryWrapper.getToDate()) == false)) {
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }

                        Date fromDate = TimeUtil.stringToDate(reportByNotaryWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByNotaryWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {

                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByNotaryWrapper.setToDate(toDate);
                        if(ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate())== false){
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper",reportByNotaryWrapper);
                            view.addObject("validate_msg_from_date",ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                    }
                } else {
                    view.setViewName("/contract/CTR006");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByNotaryWrapper.createFromToDate();
        String orderFilter = "";
        orderFilter = reportByNotaryWrapper.orderFilter();
        List<ReportByNotaryPerson> reportByNotaryPersons = QueryFactory.getReportByNotaryPerson(page, orderFilter);
        /*notaryListNumber = reportByNotaryPersons.size();*/
        notaryListNumber = QueryFactory.countTotalReportByNotary(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        reportByNotaryWrapper.setTotal(notaryListNumber);
        reportByNotaryWrapper.setTotalPage(notaryTotalPage);
        if (page < 1) page = 1;
        if (page > notaryTotalPage) page = notaryTotalPage;
        reportByNotaryWrapper.setPage(page);
        reportByNotaryWrapper.setReportByNotaryPersons(reportByNotaryPersons);
        session.setAttribute(ReportByNotaryWrapper.SESSION_KEY, reportByNotaryWrapper);
        if (reportByNotaryWrapper != null) {
            if (reportByNotaryWrapper.getReportByNotaryPersons().size() > 0) {
                for (int i = 0; i < reportByNotaryWrapper.getReportByNotaryPersons().size(); i++) {
                    if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary()) || !StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B())) {
                        if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary())) {
                            reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary("<div>Nội dung hợp đồng:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary());
                        }
                        if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B())) {
                            if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary())) {
                                reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary() + "<div>Thông tin tài sản:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B());
                            } else {
                                reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary("<div>Thông tin tài sản:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B());
                            }
                        }
                    }
                }
            }
        }
        view.setViewName("/contract/CTR006");
        view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }
    @RequestMapping(value = "/by-draft", method = RequestMethod.GET)
    public ModelAndView ReportByDraft(ReportByNotaryWrapper reportByNotaryWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "20", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(reportByNotaryWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();


        int notaryListNumber = 0;
        int notaryTotalPage = 1;
        int page = 1;
        if (reportByNotaryWrapper != null) {
            /*notaryListNumber = reportByNotaryWrapper.getTotal();
            notaryTotalPage = reportByNotaryWrapper.getTotalPage();*/
            page = reportByNotaryWrapper.getPage();
        }
        String orderString = "where role = 03";
        List<User> user = QueryFactory.getNotaryPersonByFilter(orderString);
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        reportByNotaryWrapper.setUsers(user);
        if (reportByNotaryWrapper.getTimeType() == null) {
            reportByNotaryWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }
        if (!StringUtils.isBlank(reportByNotaryWrapper.getTimeType())) {
            if (reportByNotaryWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDateto(reportByNotaryWrapper.getToDate());
                ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate());

                if (!StringUtils.isBlank(reportByNotaryWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(reportByNotaryWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByNotaryWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByNotaryWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate()) == false || ValidateUtil.validateDateto(reportByNotaryWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {

                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByNotaryWrapper.setToDate(toDate);
                        if(ValidateUtil.validateDatefrom(reportByNotaryWrapper.getFromDate())== false){
                            view.setViewName("/contract/CTR006");
                            view.addObject("reportByNotaryWrapper",reportByNotaryWrapper);
                            view.addObject("validate_msg_from_date",ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                    }
                } else {
                    view.setViewName("/contract/CTR016");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByNotaryWrapper.createFromToDate();
        String orderFilter = "";
        orderFilter = reportByNotaryWrapper.orderFilterDraft();
        List<ReportByNotaryPerson> reportByNotaryPersons = QueryFactory.getReportByDraftPerson(page, orderFilter);
        /*notaryListNumber = reportByNotaryPersons.size();*/
        notaryListNumber = QueryFactory.countTotalReportByDraft(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        reportByNotaryWrapper.setTotal(notaryListNumber);
        reportByNotaryWrapper.setTotalPage(notaryTotalPage);
        if (page < 1) page = 1;
        if (page > notaryTotalPage) page = notaryTotalPage;
        reportByNotaryWrapper.setPage(page);
        reportByNotaryWrapper.setReportByNotaryPersons(reportByNotaryPersons);
        session.setAttribute(ReportByNotaryWrapper.SESSION_KEY, reportByNotaryWrapper);
        if (reportByNotaryWrapper != null) {
            if (reportByNotaryWrapper.getReportByNotaryPersons().size() > 0) {
                for (int i = 0; i < reportByNotaryWrapper.getReportByNotaryPersons().size(); i++) {
                    if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary()) || !StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B())) {
                        if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary())) {
                            reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary("<div>Nội dung hợp đồng:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary());
                        }
                        if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B())) {
                            if (!StringUtils.isBlank(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary())) {
                                reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary(reportByNotaryWrapper.getReportByNotaryPersons().get(i).getSummary() + "<div>Thông tin tài sản:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B());
                            } else {
                                reportByNotaryWrapper.getReportByNotaryPersons().get(i).setSummary("<div>Thông tin tài sản:</div>" + reportByNotaryWrapper.getReportByNotaryPersons().get(i).getRelation_object_B());
                            }
                        }
                    }
                }
            }
        }
        view.setViewName("/contract/CTR016");
        view.addObject("reportByNotaryWrapper", reportByNotaryWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }

    @RequestMapping(value = "/export-by-notary", method = RequestMethod.GET)
    public void exportContractByNotary(HttpServletRequest request, HttpServletResponse response) {
        String org_type = SystemProperties.getProperty("org_type");
        try {
            HttpSession session = request.getSession();
            ReportByNotaryWrapper reportByNotaryWrapper = (ReportByNotaryWrapper) session.getAttribute(ReportByNotaryWrapper.SESSION_KEY);
            String orderFilter = "";
            orderFilter = reportByNotaryWrapper.orderFilter();
            List<ReportByNotaryPerson> reportByNotaryPersons = QueryFactory.getReportByNotaryPersonAll(1, orderFilter);
            if (reportByNotaryPersons != null) {
                int j = reportByNotaryPersons.size();
                for (int i = 0; i < j; i++) {

                    if (reportByNotaryPersons.get(i).getRelation_object_A() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_A(reportByNotaryPersons.get(i).getRelation_object_A().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));

                    }
                    if (reportByNotaryPersons.get(i).getRelation_object_B() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_B(reportByNotaryPersons.get(i).getRelation_object_B().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));
                    }
                    if (reportByNotaryPersons.get(i).getRelation_object_C() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_C(reportByNotaryPersons.get(i).getRelation_object_C().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));
                    }
                }
            }
            reportByNotaryWrapper.setReportByNotaryPersons(reportByNotaryPersons);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", reportByNotaryWrapper.getPrintFromDate());
            beans.put("todate", reportByNotaryWrapper.getPrintToDate());
            beans.put("report", reportByNotaryWrapper.getReportByNotaryPersons());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("total", reportByNotaryPersons.size());
            beans.put("org_type", org_type);


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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCCtheoCCV.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCtheoCCV.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/export-by-draft", method = RequestMethod.GET)
    public void exportContractByDraft(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            ReportByNotaryWrapper reportByNotaryWrapper = (ReportByNotaryWrapper) session.getAttribute(ReportByNotaryWrapper.SESSION_KEY);
            String orderFilter = "";
            orderFilter = reportByNotaryWrapper.orderFilterDraft();
            List<ReportByNotaryPerson> reportByNotaryPersons = QueryFactory.getReportByDraftPersonAll(1, orderFilter);
            if (reportByNotaryPersons != null) {
                int j = reportByNotaryPersons.size();
                for (int i = 0; i < j; i++) {

                    if (reportByNotaryPersons.get(i).getRelation_object_A() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_A(reportByNotaryPersons.get(i).getRelation_object_A().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));

                    }
                    if (reportByNotaryPersons.get(i).getRelation_object_B() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_B(reportByNotaryPersons.get(i).getRelation_object_B().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));
                    }
                    if (reportByNotaryPersons.get(i).getRelation_object_C() != null) {
                        reportByNotaryPersons.get(i).setRelation_object_C(reportByNotaryPersons.get(i).getRelation_object_C().replaceAll("(\\\\r\\\\n|\\\\n)", "\n"));
                    }
                }
            }
            reportByNotaryWrapper.setReportByNotaryPersons(reportByNotaryPersons);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", reportByNotaryWrapper.getPrintFromDate());
            beans.put("todate", reportByNotaryWrapper.getPrintToDate());
            beans.put("report", reportByNotaryWrapper.getReportByNotaryPersons());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("total", reportByNotaryPersons.size());


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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCCtheoCVST.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCtheocCVST.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    /*Báo cáo theo chuyên viên soạn thảo
     * Minhbq
     * 5/19/2017
     * */
    @RequestMapping(value = "/by-user", method = RequestMethod.GET)
    public ModelAndView ReportByUser(ReportByUserWrapper reportByUserWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "25", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(reportByUserWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();
        if (reportByUserWrapper.getTimeType() == null) {
            reportByUserWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }
        /*if(ValidateUtil.validateDatefrom(reportByUserWrapper.getFromDate())){
            ValidateUtil.validate_msg_from_date ="";
        }
        if(ValidateUtil.validateDateto(reportByUserWrapper.getToDate())){
            ValidateUtil.validate_msg_to_date ="";
        }*/
        if (!StringUtils.isBlank(reportByUserWrapper.getTimeType())) {
            if (reportByUserWrapper.getTimeType().equals("05")) {
                if (!StringUtils.isBlank(reportByUserWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(reportByUserWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByUserWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByUserWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR007");
                            view.addObject("reportByUserWrapper", reportByUserWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByUserWrapper.getFromDate()) == false || ValidateUtil.validateDateto(reportByUserWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR007");
                            view.addObject("reportByUserWrapper", reportByUserWrapper);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByUserWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR007");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByUserWrapper.createFromToDate();

        int notaryListNumber = 0;
        int notaryTotalPage = 1;
        int page = 1;
        if (reportByUserWrapper != null) {
            notaryListNumber = reportByUserWrapper.getTotal();
            notaryTotalPage = reportByUserWrapper.getTotalPage();
            page = reportByUserWrapper.getPage();

        }

        List<UserByRoleList> userByRoleLists = QueryFactory.getDrafter(null);
        reportByUserWrapper.setUserByRoleLists(userByRoleLists);


        String orderFilter = "";
        orderFilter = reportByUserWrapper.orderFilter();
        notaryListNumber = QueryFactory.countTotalReportByUser(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        reportByUserWrapper.setTotal(notaryListNumber);
        reportByUserWrapper.setTotalPage(notaryTotalPage);

        if (page < 1) page = 1;
        if (page > notaryTotalPage) page = notaryTotalPage;

        reportByUserWrapper.setPage(page);

        List<ReportByUser> reportByUsers = QueryFactory.getReportByUser(page, orderFilter);
        reportByUserWrapper.setReportByUsers(reportByUsers);


        session.setAttribute(ReportByUserWrapper.SESSION_KEY, reportByUserWrapper);
        view.setViewName("/contract/CTR007");
        view.addObject("reportByUserWrapper", reportByUserWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }


    /*Báo cáo theo hợp đồng lỗi
     * Minhbq
     * 5/22/2017
     * */
    @RequestMapping(value = "/contract-error", method = RequestMethod.GET)
    public ModelAndView reportContractError(ContractErrorWrapper contractErrorWrapper, HttpServletRequest request, HttpServletResponse response) {
        //if (!checkGroupRole(request)) return new ModelAndView("/404", "message", null);
        if (!ValidationPool.checkRoleDetail(request, "27", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(contractErrorWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        if (contractErrorWrapper.getTimeType() == null) {
            contractErrorWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        //replace special character
        contractErrorWrapper.setFromDate(StringUtil.escapeSpecialChar(contractErrorWrapper.getFromDate()));
        contractErrorWrapper.setToDate(StringUtil.escapeSpecialChar(contractErrorWrapper.getToDate()));
        //END replace special character

        if (!StringUtils.isBlank(contractErrorWrapper.getTimeType())) {
            if (contractErrorWrapper.getTimeType().equals("05")) {
                if (!StringUtils.isBlank(contractErrorWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(contractErrorWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(contractErrorWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(contractErrorWrapper.getToDate());
                        if ((!StringUtils.isBlank(contractErrorWrapper.getFromDate())
                                && ValidateUtil.validateDatefrom(contractErrorWrapper.getFromDate()) == false)
                                || (!StringUtils.isBlank(contractErrorWrapper.getToDate())
                                || ValidateUtil.validateDateto(contractErrorWrapper.getToDate()) == false)) {
                            view.setViewName("/contract/CTR008");
                            view.addObject("contractErrorWrapper", contractErrorWrapper);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR008");
                            view.addObject("contractErrorWrapper", contractErrorWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        contractErrorWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR008");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        contractErrorWrapper.createFromToDate();

        int notaryListNumber = 0;
        int notaryTotalPage = 1;
        int page = 1;
        if (contractErrorWrapper != null) {
            notaryListNumber = contractErrorWrapper.getTotal();
            notaryTotalPage = contractErrorWrapper.getTotalPage();
            page = contractErrorWrapper.getPage();

        }

        List<UserByRoleList> drafterName = QueryFactory.getDrafter(null);
        contractErrorWrapper.setDrafterName(drafterName);

        List<UserByRoleList> notaryName = QueryFactory.getNotaryPerson(null);
        contractErrorWrapper.setNotaryName(notaryName);

        String orderFilter = "";
        orderFilter = contractErrorWrapper.orderFilter();
        notaryListNumber = QueryFactory.countTotalReportByUser(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        contractErrorWrapper.setTotal(notaryListNumber);
        contractErrorWrapper.setTotalPage(notaryTotalPage);

        if (page < 1) page = 1;
        if (page > notaryTotalPage) page = notaryTotalPage;

        contractErrorWrapper.setPage(page);

        List<ContractError> reportContractError = QueryFactory.getReportContractError(page, orderFilter);
        if(reportContractError != null){
            int i = reportContractError.size();
            for(int j=0;j<i;j++){
                reportContractError.get(j).setNotaryDatePrint(TimeUtil.convertTimeStampToString(reportContractError.get(j).getNotary_date()));
            }
        }
        contractErrorWrapper.setContractErrors(reportContractError);
        session.setAttribute(ContractErrorWrapper.SESSION_KEY, contractErrorWrapper);
        view.setViewName("/contract/CTR008");
        view.addObject("contractErrorWrapper", contractErrorWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }

    @RequestMapping(value = "/export-contract-error", method = RequestMethod.GET)
    public void exportContractError(HttpServletRequest request, HttpServletResponse response) {
        String org_type = SystemProperties.getProperty("org_type");
        try {
            HttpSession session = request.getSession();
            ContractErrorWrapper contractErrorWrapper = (ContractErrorWrapper) session.getAttribute(ContractErrorWrapper.SESSION_KEY);
            List<ContractError> contractErrors = QueryFactory.getAllReportContractError(contractErrorWrapper.orderFilter());
            if(contractErrors != null){
                int i = contractErrors.size();
                for(int j = 0;j<i;j++){
                    if(contractErrors.get(j).getRelation_object_A()!= null){
                        contractErrors.get(j).setRelation_object_A(contractErrors.get(j).getRelation_object_A().replaceAll("\\\\r\\\\n|\\\\n", "\n"));


                    }
                    if(contractErrors.get(j).getNotary_date()!= null){
                        contractErrors.get(j).setNotaryDatePrint(TimeUtil.convertTimeStampToString(contractErrors.get(j).getNotary_date()));
                    }

                }
            }
            contractErrorWrapper.setContractErrors(contractErrors);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", contractErrorWrapper.getPrintFromDate());
            beans.put("todate", contractErrorWrapper.getPrintToDate());
            beans.put("report", contractErrorWrapper.getContractErrors());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("total", contractErrors.size());
            beans.put("org_type", org_type);

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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCCtheoHDH.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCtheoHDH.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/by-tt20", method = RequestMethod.GET)
    public ModelAndView tt20(ReportByTT20List reportByTT20List, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "23", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        HttpSession session = request.getSession();

        if (reportByTT20List.getTimeType() == null) {
            reportByTT20List.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        ValidateUtil.validate_msg_from_date = "";

        ValidateUtil.validate_msg_to_date = "";

        if (!StringUtils.isBlank(reportByTT20List.getTimeType())) {
            if (reportByTT20List.getTimeType().equals("05")) {
                ValidateUtil.validateDateto(reportByTT20List.getToDate());
                ValidateUtil.validateDatefrom(reportByTT20List.getFromDate());

                if (!StringUtils.isBlank(reportByTT20List.getFromDate())) {
                    if (!StringUtils.isBlank(reportByTT20List.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByTT20List.getFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByTT20List.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR0011");
                            view.addObject("reportByTT20List", reportByTT20List);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByTT20List.getFromDate()) == false || ValidateUtil.validateDateto(reportByTT20List.getToDate()) == false) {
                            view.setViewName("/contract/CTR0011");
                            view.addObject("reportByTT20List", reportByTT20List);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByTT20List.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR0011");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByTT20List.createFromToDate();
        String printFormDate = reportByTT20List.getPrintFromDate();
        String printToDate = reportByTT20List.getPrintToDate();
        reportByTT20List = QueryFactory.getReportByTT20List(reportByTT20List.generateJson()).get(0);
        reportByTT20List.setPrintFromDate(printFormDate);
        reportByTT20List.setPrintToDate(printToDate);
        session.setAttribute(ReportByTT20List.SESSION_KEY, reportByTT20List);
        view.setViewName("/contract/CTR0011");
        view.addObject("reportByTT20List", reportByTT20List);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }

    @RequestMapping(value = "/by-tt03", method = RequestMethod.GET)
    public ModelAndView tt03(ReportByTT03List reportByTT03List, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "32", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        HttpSession session = request.getSession();
        String validateToDate = "";
        String validateFromDate = "";
        ValidateUtil.validate_msg_from_date ="";
        ValidateUtil.validate_msg_to_date ="";



        if (reportByTT03List.getTimeType() == null) {
            validateToDate = "";
            validateFromDate = "";
            reportByTT03List.setTimeType("03");
        }
        if (ValidateUtil.validateDatefrom(reportByTT03List.getFromDate())) {
            validateFromDate = "";
        }
        if (ValidateUtil.validateDateto(reportByTT03List.getToDate())) {
            validateToDate = "";
        }
        if (!StringUtils.isBlank(reportByTT03List.getTimeType())) {
            if (reportByTT03List.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(reportByTT03List.getPrintFromDate());
                ValidateUtil.validateDateto(reportByTT03List.getPrintToDate());
                validateFromDate = ValidateUtil.validate_msg_from_date;
                validateToDate = ValidateUtil.validate_msg_to_date;
                if (!StringUtils.isBlank(reportByTT03List.getPrintFromDate())) {
                    if (!StringUtils.isBlank(reportByTT03List.getPrintToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByTT03List.getPrintFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByTT03List.getPrintToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/tt03");
                            view.addObject("reportByTT03List", reportByTT03List);
                            validateFromDate = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", validateFromDate);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByTT03List.getPrintFromDate()) == false || ValidateUtil.validateDateto(reportByTT03List.getPrintToDate()) == false) {
                            view.setViewName("/contract/tt03");
                            view.addObject("reportByTT03List", reportByTT03List);
                            view.addObject("validate_msg_from_date", validateFromDate);
                            view.addObject("validate_msg_to_date", validateToDate);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByTT03List.setPrintToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/tt03");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByTT03List.createFromToDate();
        //  reportByTT04List.setNameNotaryOffice(SystemProperties.getProperty("NameNotaryOffice"));
        List<ReportByTT03List> reportByTT03Lists= QueryFactory.getReportByTT03List(reportByTT03List.generateJson());
        if(reportByTT03Lists != null){
            if(reportByTT03Lists.size() > 0){
                reportByTT03List = reportByTT03Lists.get(0);
            }
        }
        /*reportByTT03List.setNumNotaryOffice(1);*/
        session.setAttribute(ReportByTT04List.SESSION_KEY, reportByTT03List);
        view.setViewName("/contract/tt03");
        view.addObject("reportByTT03List", reportByTT03List);
        view.addObject("tongPhiCongChung",BaseController.formatNumber(reportByTT03List.getTongPhiCongChung()));
        view.addObject("tongThuLao",BaseController.formatNumber(reportByTT03List.getThuLaoCongChung()));
        view.addObject("tongSoThuLao",BaseController.formatNumber(reportByTT03List.getThuLaoCongChung()));
        view.addObject("validate_msg_from_date", validateFromDate);
        view.addObject("validate_msg_to_date", validateToDate);
        return view;
    }



    @RequestMapping(value = "/by-tt04", method = RequestMethod.GET)
    public ModelAndView tt04(ReportByTT04List reportByTT04List, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "23", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        HttpSession session = request.getSession();
        String validateToDate = "";
        String validateFromDate = "";
        ValidateUtil.validate_msg_from_date ="";
        ValidateUtil.validate_msg_to_date ="";



        if (reportByTT04List.getTimeType() == null) {
            validateToDate = "";
            validateFromDate = "";
            reportByTT04List.setTimeType("03");
        }
        if (ValidateUtil.validateDatefrom(reportByTT04List.getFromDate())) {
            validateFromDate = "";
        }
        if (ValidateUtil.validateDateto(reportByTT04List.getToDate())) {
            validateToDate = "";
        }
        if (!StringUtils.isBlank(reportByTT04List.getTimeType())) {
            if (reportByTT04List.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(reportByTT04List.getPrintFromDate());
                ValidateUtil.validateDateto(reportByTT04List.getPrintToDate());
                validateFromDate = ValidateUtil.validate_msg_from_date;
                validateToDate = ValidateUtil.validate_msg_to_date;
                if (!StringUtils.isBlank(reportByTT04List.getPrintFromDate())) {
                    if (!StringUtils.isBlank(reportByTT04List.getPrintToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByTT04List.getPrintFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByTT04List.getPrintToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/tt04");
                            view.addObject("reportByTT04List", reportByTT04List);
                            validateFromDate = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", validateFromDate);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByTT04List.getPrintFromDate()) == false || ValidateUtil.validateDateto(reportByTT04List.getPrintToDate()) == false) {
                            view.setViewName("/contract/tt04");
                            view.addObject("reportByTT04List", reportByTT04List);
                            view.addObject("validate_msg_from_date", validateFromDate);
                            view.addObject("validate_msg_to_date", validateToDate);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByTT04List.setPrintToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/tt04");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByTT04List.createFromToDate();
        //  reportByTT04List.setNameNotaryOffice(SystemProperties.getProperty("NameNotaryOffice"));
        List<ReportByTT04List> reportByTT04Lists= QueryFactory.getReportByTT04List(reportByTT04List.generateJson());
        if(reportByTT04Lists != null){
            if(reportByTT04Lists.size() > 0){
                reportByTT04List = reportByTT04Lists.get(0);
            }
        }
        reportByTT04List.setNumNotaryOffice(1);
        session.setAttribute(ReportByTT04List.SESSION_KEY, reportByTT04List);
        view.setViewName("/contract/tt04");
        view.addObject("reportByTT04List", reportByTT04List);
        view.addObject("tongPhiCongChung",BaseController.formatNumber(reportByTT04List.getTongPhiCongChung()));
        view.addObject("tongThuLao",BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
        view.addObject("tongSoThuLao",BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
        view.addObject("validate_msg_from_date", validateFromDate);
        view.addObject("validate_msg_to_date", validateToDate);
        return view;
    }

    @RequestMapping(value = "/export-tt03", method = RequestMethod.GET)
    public void exportTT03(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            ReportByTT03List reportByTT03List = (ReportByTT03List) session.getAttribute(ReportByTT04List.SESSION_KEY);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", reportByTT03List.getPrintFromDate());
            beans.put("todate", reportByTT03List.getPrintToDate());
            /*   beans.put("numNotaryOffice", reportByTT03List.getNumNotaryOffice());*/
            beans.put("numberOfNotaryPerson", reportByTT03List.getNumberOfNotaryPerson());
            /*     beans.put("numberOfNotaryPersonHopDanh", reportByTT03List.getNumberOfNotaryPersonHopDanh());*/
            beans.put("numberOfTotalContract", reportByTT03List.getNumberOfTotalContract());
            beans.put("numberOfContractLand", reportByTT03List.getNumberOfContractLand());
            beans.put("numberOfContractOther", reportByTT03List.getNumberOfContractOther());
            beans.put("numberOfContractDanSu", reportByTT03List.getNumberOfContractDanSu());
            beans.put("numberOfThuaKe", reportByTT03List.getNumberOfThuaKe());
            beans.put("numberOfOther", reportByTT03List.getNumberOfOther());
            beans.put("tongPhiCongChung", BaseController.formatNumber(reportByTT03List.getTongPhiCongChung()));
            beans.put("tongThuLao", BaseController.formatNumber(reportByTT03List.getThuLaoCongChung()));
            beans.put("tongSoThuLao", BaseController.formatNumber(reportByTT03List.getThuLaoCongChung()));
            beans.put("congChungBanDichVaLoaiKhac", 0);
            beans.put("NameVPCC", QueryFactory.getSystemConfigByKey("notary_office_name"));
            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaoCaoTheoTT03.xls"));

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaoCaoTheoTT03.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-tt04", method = RequestMethod.GET)
    public void exportTT04(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            ReportByTT04List reportByTT04List = (ReportByTT04List) session.getAttribute(ReportByTT04List.SESSION_KEY);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", reportByTT04List.getPrintFromDate());
            beans.put("todate", reportByTT04List.getPrintToDate());
            beans.put("numNotaryOffice", reportByTT04List.getNumNotaryOffice());
            beans.put("numberOfNotaryPerson", reportByTT04List.getNumberOfNotaryPerson());
            beans.put("numberOfNotaryPersonHopDanh", reportByTT04List.getNumberOfNotaryPersonHopDanh());
            beans.put("numberOfTotalContract", reportByTT04List.getNumberOfTotalContract());
            beans.put("numberOfContractLand", reportByTT04List.getNumberOfContractLand());
            beans.put("numberOfContractOther", reportByTT04List.getNumberOfContractOther());
            beans.put("numberOfContractDanSu", reportByTT04List.getNumberOfContractDanSu());
            beans.put("numberOfThuaKe", reportByTT04List.getNumberOfThuaKe());
            beans.put("numberOfOther", reportByTT04List.getNumberOfOther());
            beans.put("tongPhiCongChung", BaseController.formatNumber(reportByTT04List.getTongPhiCongChung()));
            beans.put("tongThuLao", BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
            beans.put("tongSoThuLao", BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
            beans.put("congChungBanDichVaLoaiKhac", 0);
            beans.put("NameVPCC", QueryFactory.getSystemConfigByKey("notary_office_name"));
            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaoCaoTheoTT04.xls"));

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaoCaoTheoTT04.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-tt20", method = RequestMethod.GET)
    public void exportTT20(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            ReportByTT20List reportByTT20List = (ReportByTT20List) session.getAttribute(ReportByTT20List.SESSION_KEY);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", reportByTT20List.getFromDate());
            beans.put("todate", reportByTT20List.getToDate());
            beans.put("numberOfNotaryPerson", reportByTT20List.getNumberOfNotaryPerson());
            beans.put("numberOfTotalContract", reportByTT20List.getNumberOfTotalContract());
            beans.put("numberOfContractLand", reportByTT20List.getNumberOfContractLand());
            beans.put("numberOfContractOther", reportByTT20List.getNumberOfContractOther());
            beans.put("numberOfContractDanSu", reportByTT20List.getNumberOfContractDanSu());
            beans.put("numberOfThuaKe", reportByTT20List.getNumberOfThuaKe());
            beans.put("numberOfOther", reportByTT20List.getNumberOfOther());
            beans.put("tongPhiCongChung", reportByTT20List.getTongPhiCongChung());


            Date date = new Date(); // your date
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DAY_OF_MONTH);

            beans.put("year", year);
            beans.put("month", month);
            beans.put("day", day);
            String realPathOfFolder = request.getServletContext().getRealPath(SystemProperties.getProperty("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaoCaoTheoTT20.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaoCaoTheoTT20.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/contract-additional", method = RequestMethod.GET)
    public ModelAndView reportContractAdditional(ContractAdditionalWrapper contractAdditionalWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "26", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(contractAdditionalWrapper.SESSION_KEY);
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        ModelAndView view = new ModelAndView();
        if (contractAdditionalWrapper.getTimeType() == null) {
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
            contractAdditionalWrapper.setTimeType("03");
        }

        if (!StringUtils.isBlank(contractAdditionalWrapper.getTimeType())) {
            if (contractAdditionalWrapper.getTimeType().equals("05")) {
                if (!StringUtils.isBlank(contractAdditionalWrapper.getFromDate())) {
                    contractAdditionalWrapper.setFromDate(StringUtil.escapeSpecialChar(contractAdditionalWrapper.getFromDate()));
                    if (!StringUtils.isBlank(contractAdditionalWrapper.getToDate())) {
                        //replace special character
                        contractAdditionalWrapper.setToDate(StringUtil.escapeSpecialChar(contractAdditionalWrapper.getToDate()));
                        //END replace special character

                        Date fromDate = TimeUtil.stringToDate(contractAdditionalWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(contractAdditionalWrapper.getToDate());
                        if (ValidateUtil.validateDatefrom(contractAdditionalWrapper.getFromDate()) == false || ValidateUtil.validateDateto(contractAdditionalWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR012");
                            view.addObject("contractAdditionalWrapper", contractAdditionalWrapper);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR012");
                            view.addObject("contractAdditionalWrapper", contractAdditionalWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        contractAdditionalWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR012");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        contractAdditionalWrapper.createFromToDate();

        int notaryListNumber = 0;
        int notaryTotalPage = 1;
        int page = 1;
        if (contractAdditionalWrapper != null) {
            notaryListNumber = contractAdditionalWrapper.getTotal();
            notaryTotalPage = contractAdditionalWrapper.getTotalPage();
            page = contractAdditionalWrapper.getPage();

        }

        String orderFilter = "";
        orderFilter = contractAdditionalWrapper.orderFilter();
        notaryListNumber = QueryFactory.countTotalReportByUser(orderFilter);
        notaryTotalPage = QueryFactory.countPage(notaryListNumber);
        contractAdditionalWrapper.setTotal(notaryListNumber);
        contractAdditionalWrapper.setTotalPage(notaryTotalPage);

        if (page < 1) page = 1;
        if (page > notaryTotalPage) page = notaryTotalPage;
        contractAdditionalWrapper.setPage(page);
        List<ContractAdditional> reportContractAdditional = QueryFactory.getReportContractAdditional(page, orderFilter);
        if(reportContractAdditional != null){
            int i =reportContractAdditional.size();
            for(int j = 0 ; j<i ; j++){
                reportContractAdditional.get(j).setNotaryDatePrint(TimeUtil.convertTimeStampToString(reportContractAdditional.get(j).getNotary_date()));
            }
        }
        contractAdditionalWrapper.setContractAdditionals(reportContractAdditional);
        session.setAttribute(ContractAdditionalWrapper.SESSION_KEY, contractAdditionalWrapper);
        view.setViewName("/contract/CTR012");
        view.addObject("contractAdditionalWrapper", contractAdditionalWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }
    @RequestMapping(value = "/export-contract-additional", method = RequestMethod.GET)
    public void exportContractAdditional(HttpServletRequest request, HttpServletResponse response) {
        String org_type = SystemProperties.getProperty("org_type");
        try {
            HttpSession session = request.getSession();
            ContractAdditionalWrapper contractAdditionalWrapper = (ContractAdditionalWrapper) session.getAttribute(ContractAdditionalWrapper.SESSION_KEY);
            List<ContractAdditional> contractAdditionals = QueryFactory.getAllReportContractAdditional(contractAdditionalWrapper.orderFilter());
            if(contractAdditionals != null){
                int i = contractAdditionals.size();
                for(int j = 0;j<i;j++){
                    if(contractAdditionals.get(j).getRelation_object_A()!= null){
                        contractAdditionals.get(j).setRelation_object_A(contractAdditionals.get(j).getRelation_object_A().replaceAll("\\\\r\\\\n|\\\\n", "\n"));


                    }
                    if(contractAdditionals.get(j).getNotary_date() != null){
                        contractAdditionals.get(j).setNotaryDatePrint(TimeUtil.convertTimeStampToString(contractAdditionals.get(j).getNotary_date()));
                    }

                }
            }
            contractAdditionalWrapper.setContractAdditionals(contractAdditionals);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", contractAdditionalWrapper.getPrintFromDate());
            beans.put("todate", contractAdditionalWrapper.getPrintToDate());
            beans.put("reportt", contractAdditionalWrapper.getContractAdditionals());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("total", contractAdditionals.size());
            beans.put("org_type", org_type);

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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoHDCCtheoHDBS.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoHDCCtheoHDBS.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/contract-certify", method = RequestMethod.GET)
    public ModelAndView contractCertify(ContractCeritfyWrapper contractCeritfyWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "22", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        String org_type = SystemProperties.getProperty("org_type");
        ModelAndView view = new ModelAndView();
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        if (contractCeritfyWrapper.getTimeType() == null) {
            contractCeritfyWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        if (!StringUtils.isBlank(contractCeritfyWrapper.getTimeType())) {
            if (contractCeritfyWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDateto(contractCeritfyWrapper.getToDate());
                ValidateUtil.validateDatefrom(contractCeritfyWrapper.getFromDate());

                if (!StringUtils.isBlank(contractCeritfyWrapper.getFromDate())) {
                    contractCeritfyWrapper.setFromDate(StringUtil.escapeSpecialChar(contractCeritfyWrapper.getFromDate()));
                    if (!StringUtils.isBlank(contractCeritfyWrapper.getToDate())) {
                        //replace special character
                        contractCeritfyWrapper.setToDate(StringUtil.escapeSpecialChar(contractCeritfyWrapper.getToDate()));
                        //END replace special character

                        Date fromDate = TimeUtil.stringToDate(contractCeritfyWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(contractCeritfyWrapper.getToDate());
                        if (ValidateUtil.validateDatefrom(contractCeritfyWrapper.getFromDate()) == false || ValidateUtil.validateDateto(contractCeritfyWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR013");
                            view.addObject("contractCeritfyWrapper", contractCeritfyWrapper);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR013");
                            view.addObject("contractCeritfyWrapper", contractCeritfyWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        contractCeritfyWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR013");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }

        contractCeritfyWrapper.createFromToDate();
        List<ContractKind> contractKinds = QueryFactory.getContractKind(" where 1=1");
        contractCeritfyWrapper.setContractKinds(contractKinds);
        String kindIdList = contractCeritfyWrapper.getCbChild();
        if (kindIdList == null || kindIdList.equals(""))
            return new ModelAndView("/contract/CTR013", "contractCeritfyWrapper", contractCeritfyWrapper);

        String query = "";

        query = contractCeritfyWrapper.orderFilter();
        List<ContractCertify> contractCertifies = QueryFactory.getContractCertify(query);
        if (contractCertifies != null) {
            int i = contractCertifies.size();
            for (int j = 0; j < i; j++) {
                if (!StringUtils.isBlank(contractCertifies.get(j).getRelation_object_A())) {
                    contractCertifies.get(j).setRelation_object_A(contractCertifies.get(j).getRelation_object_A().replaceAll("\\\\r\\\\n|\\\\n", "\n"));
                }
                if (!StringUtils.isBlank(contractCertifies.get(j).getRelation_object_B())) {
                    contractCertifies.get(j).setRelation_object_B(contractCertifies.get(j).getRelation_object_B().replaceAll("\\\\r\\\\n|\\\\n", "\n"));
                }
                if (!StringUtils.isBlank(contractCertifies.get(j).getRelation_object_C())) {
                    contractCertifies.get(j).setRelation_object_C(contractCertifies.get(j).getRelation_object_C().replaceAll("\\\\r\\\\n|\\\\n", "\n"));
                }
                contractCertifies.get(j).setCost_total(contractCertifies.get(j).getCost_total().subtract(contractCertifies.get(j).getCost_tt91()));
            }
        }
        contractCeritfyWrapper.setContractCertifies(contractCertifies);
        try {
            Map<String, Object> beans = new HashMap<String, Object>();

            String province = QueryFactory.getSystemConfigByKey("notary_office_province");
            String dateFrom = contractCeritfyWrapper.getFromDate().substring(0,2);
            String monthFrom = contractCeritfyWrapper.getFromDate().substring(3,5);
            String yearFrom = contractCeritfyWrapper.getFromDate().substring(6,10);
            String dateTo = contractCeritfyWrapper.getToDate().substring(0,2);
            String monthTo = contractCeritfyWrapper.getToDate().substring(3,5);
            String yearTo = contractCeritfyWrapper.getToDate().substring(6,10);
            beans.put("report", contractCertifies);
            beans.put("total", contractCertifies.size());
            beans.put("fromDate", contractCeritfyWrapper.getFromDate());
            beans.put("dateFrom",dateFrom);
            beans.put("monthFrom",monthFrom);
            beans.put("yearFrom",yearFrom);
            beans.put("dateTo",dateTo);
            beans.put("monthTo",monthTo);
            beans.put("yearTo",yearTo);
            beans.put("toDate", contractCeritfyWrapper.getToDate());
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("province",province);
            beans.put("org_type", org_type);


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
//            if (SystemProperties.getProperty("org_type").equals("0")){
                InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "SoHDCC.xls"));
                ExcelTransformer transformer = new ExcelTransformer();
                transformer.addFixedSizeCollectionName("report");
                Workbook workbook = transformer.transform(fileIn, beans);

                response.setContentType("application/vnd.ms-excel");
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
                String dateDownload = dateFormat.format(new Date());
                response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_SoHDCC.xls");
                ServletOutputStream out = response.getOutputStream();
                workbook.write(out);
                out.flush();
                out.close();
//            }else {
//                InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "SoHopDongChungThuc.xls"));
//                ExcelTransformer transformer = new ExcelTransformer();
//                transformer.addFixedSizeCollectionName("report");
//                Workbook workbook = transformer.transform(fileIn, beans);
//
//                response.setContentType("application/vnd.ms-excel");
//                SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
//                String dateDownload = dateFormat.format(new Date());
//                response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_SoHopDongChungThuc.xls");
//                ServletOutputStream out = response.getOutputStream();
//                workbook.write(out);
//                out.flush();
//                out.close();
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        view.setViewName("/contract/CTR013");
        view.addObject("contractCeritfyWrapper", contractCeritfyWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        return view;
    }

    @RequestMapping(value = "/general-stastics", method = RequestMethod.GET)
    public ModelAndView reportContractStastics(ContractStasticsWrapper contractStasticsWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "21", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(contractStasticsWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        if (contractStasticsWrapper.getTimeType() == null) {
            contractStasticsWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        if (!StringUtils.isBlank(contractStasticsWrapper.getTimeType())) {
            if (contractStasticsWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(contractStasticsWrapper.getFromDate());
                ValidateUtil.validateDateto(contractStasticsWrapper.getToDate());
                if (!StringUtils.isBlank(contractStasticsWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(contractStasticsWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(contractStasticsWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(contractStasticsWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR014");
                            view.addObject("contractStasticsWrapper", contractStasticsWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(contractStasticsWrapper.getFromDate()) == false || ValidateUtil.validateDateto(contractStasticsWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR014");
                            view.addObject("contractCeritfyWrapper", contractStasticsWrapper);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        contractStasticsWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR014");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        contractStasticsWrapper.createFromToDate();
        String orderFilter = "";
        orderFilter = contractStasticsWrapper.generateJsonObject().toString();
        int totalContractByNotary = 0;
        int totalErrorContractByNotary = 0;
        int totalContractByDrafter = 0;
        int totalErrorContractByDrafter = 0;
        int totalContractBank = 0;

        List<ContractStastics> contractStasticsDrafter = QueryFactory.getContractStasticsDrafter(orderFilter);
        contractStasticsWrapper.setContractStasticsDrafter(contractStasticsDrafter);

        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractByDrafter(totalContractByDrafter);


        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalErrorContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_error_contract();

        }
        contractStasticsWrapper.setTotalErrorContractByDrafter(totalErrorContractByDrafter);

        List<ContractStastics> contractStasticsNotary = QueryFactory.getContractStasticsNotary(orderFilter);
        contractStasticsWrapper.setContractStasticsNotary(contractStasticsNotary);
        for (int i = 0; i < contractStasticsNotary.size(); i++) {
            totalContractByNotary += contractStasticsNotary.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractByNotary(totalContractByNotary);
        for (int i = 0; i < contractStasticsNotary.size(); i++) {
            totalErrorContractByNotary += contractStasticsNotary.get(i).getNumber_of_error_contract();

        }
        contractStasticsWrapper.setTotalErrorContractByNotary(totalErrorContractByNotary);
        List<ContractStasticsBank> contractStasticsBanks = QueryFactory.getContractStasticsBank(orderFilter);
        contractStasticsWrapper.setContractStasticsBanks(contractStasticsBanks);
        for (int i = 0; i < contractStasticsBanks.size(); i++) {
            totalContractBank += contractStasticsBanks.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractBank(totalContractBank);
        if (!contractStasticsWrapper.getTimeType().equals("05")) {
            contractStasticsWrapper.setFromDate("");
            contractStasticsWrapper.setToDate("");
        }
        view.setViewName("/contract/CTR014");
        view.addObject("contractStasticsWrapper", contractStasticsWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        session.setAttribute(ContractStasticsWrapper.SESSION_KEY, contractStasticsWrapper);

        return view;
    }

    @RequestMapping(value = "/tinh-hinh-nhap-hd-phuong-xa", method = RequestMethod.GET)
    public ModelAndView reportContractOfPhuongXa(ContractStasticsWrapper contractStasticsWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "33", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(contractStasticsWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        if (contractStasticsWrapper.getTimeType() == null) {
            contractStasticsWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        if (!StringUtils.isBlank(contractStasticsWrapper.getTimeType())) {
            if (contractStasticsWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(contractStasticsWrapper.getFromDate());
                ValidateUtil.validateDateto(contractStasticsWrapper.getToDate());
                if (!StringUtils.isBlank(contractStasticsWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(contractStasticsWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(contractStasticsWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(contractStasticsWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/CTR017");
                            view.addObject("contractStasticsWrapper", contractStasticsWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(contractStasticsWrapper.getFromDate()) == false || ValidateUtil.validateDateto(contractStasticsWrapper.getToDate()) == false) {
                            view.setViewName("/contract/CTR017");
                            view.addObject("contractCeritfyWrapper", contractStasticsWrapper);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        contractStasticsWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/CTR017");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        contractStasticsWrapper.createFromToDate();
        String orderFilter = "";
        orderFilter = contractStasticsWrapper.generateJsonObject().toString();
        int totalContractByNotary = 0;
        int totalContractByDistricts = 0;

/*        List<ContractStastics> contractStasticsDrafter = QueryFactory.getContractStasticsDrafter(orderFilter);
        contractStasticsWrapper.setContractStasticsDrafter(contractStasticsDrafter);

        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractByDrafter(totalContractByDrafter);


        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalErrorContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_error_contract();

        }
        contractStasticsWrapper.setTotalErrorContractByDrafter(totalErrorContractByDrafter);*/

//        List<ContractStasticsOfWards> contractStasticsOfWards = QueryFactory.getContractStasticsNotaryOfWards(orderFilter);
        List<ContractStasticsOfDistricts> contractStasticsOfDistricts = QueryFactory.getContractStasticsNotaryOfWards(orderFilter);


        contractStasticsWrapper.setContractStasticsOfDistricts(contractStasticsOfDistricts);
        for (int i = 0; i < contractStasticsOfDistricts.size(); i++) {
            totalContractByDistricts += contractStasticsOfDistricts.get(i).getCountContractOfDistrict();
        }
        contractStasticsWrapper.setTotalContractByNotaryOfDistricts(totalContractByDistricts);
        contractStasticsWrapper.setTotalContractByNotary(totalContractByNotary);
        if (!contractStasticsWrapper.getTimeType().equals("05")) {
            contractStasticsWrapper.setFromDate("");
            contractStasticsWrapper.setToDate("");
        }
        //      Map<String, List<ContractStasticsOfDistricts>> m =  contractStasticsOfDistricts.stream().collect(Collectors.groupingBy(ContractStasticsOfDistricts::getDistrictCode));
        view.setViewName("/contract/CTR017");
        view.addObject("contractStasticsWrapper", contractStasticsWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        session.setAttribute(ContractStasticsWrapper.SESSION_KEY, contractStasticsWrapper);

        return view;
    }

    @RequestMapping(value = "/sales", method = RequestMethod.GET)
    public ModelAndView reportContractStastics1(SalesWrapper salesWrapper, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "21", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        session.removeAttribute(salesWrapper.SESSION_KEY);
        ModelAndView view = new ModelAndView();
        ValidateUtil.validate_msg_from_date = "";
        ValidateUtil.validate_msg_to_date = "";
        if (salesWrapper.getTimeType() == null) {
            salesWrapper.setTimeType("03");
            ValidateUtil.validate_msg_from_date = "";
            ValidateUtil.validate_msg_to_date = "";
        }

        if (!StringUtils.isBlank(salesWrapper.getTimeType())) {
            if (salesWrapper.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(salesWrapper.getFromDate());
                ValidateUtil.validateDateto(salesWrapper.getToDate());
                if (!StringUtils.isBlank(salesWrapper.getFromDate())) {
                    if (!StringUtils.isBlank(salesWrapper.getToDate())) {
                        Date fromDate = TimeUtil.stringToDate(salesWrapper.getFromDate());
                        Date toDate = TimeUtil.stringToDate(salesWrapper.getToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("contract/tkdt");
                            view.addObject("salesWrapper", salesWrapper);
                            ValidateUtil.validate_msg_from_date = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(salesWrapper.getFromDate()) == false || ValidateUtil.validateDateto(salesWrapper.getToDate()) == false) {
                            view.setViewName("contract/tkdt");
                            view.addObject("salesWrapper", salesWrapper);
                            view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
                            view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
                            return view;
                        }
                    } else {
                        /*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*/
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        salesWrapper.setToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/tkdt");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        salesWrapper.createFromToDate();
        String orderFilter = "";
        /*orderFilter = salesWrapper.generateJsonObject().toString();*/
        /*int totalContractByNotary = 0;
        int totalErrorContractByNotary = 0;
        int totalContractByDrafter = 0;
        int totalErrorContractByDrafter = 0;
        int totalContractBank = 0;*/
        String toDate = salesWrapper.getNotaryDateToFilter().substring(0,10);
        String fromDate = salesWrapper.getNotaryDateFromFilter().substring(0,10);
        SalesWrapper itemdb = QueryFactory.getListSalesReport(fromDate,toDate);

        if(itemdb.getSalesByNotarysList() !=null && itemdb.getSalesByNotarysList().size()>0){
            salesWrapper.setSalesByNotarysList(itemdb.getSalesByNotarysList());
            Long cost91 = Long.valueOf(0);
            Long numberContract= Long.valueOf(0);
            Long costDraft = Long.valueOf(0);
            Long costOutsite = Long.valueOf(0) ;
            Long costDetermine= Long.valueOf(0);
            Long costTotal = Long.valueOf(0);
            for(int i = 0 ; i<salesWrapper.getSalesByNotarysList().size();i++){
                cost91 += salesWrapper.getSalesByNotarysList().get(i).getCost_tt91();
                numberContract += salesWrapper.getSalesByNotarysList().get(i).getNumberContract();
                costDraft += salesWrapper.getSalesByNotarysList().get(i).getCost_draft();
                costOutsite += salesWrapper.getSalesByNotarysList().get(i).getCost_notary_outside();
                costDetermine += salesWrapper.getSalesByNotarysList().get(i).getCost_other_determine();
                costTotal +=salesWrapper.getSalesByNotarysList().get(i).getCost_total();

            }
            salesWrapper.setNotary91Total(cost91);
            salesWrapper.setNotaryNumberContractTotal(numberContract);
            salesWrapper.setNotaryDraftTotal(costDraft);
            salesWrapper.setNotaryOutsideTotal(costOutsite);
            salesWrapper.setNotaryDetermineTotal(costDetermine);
            salesWrapper.setNotaryTotal(costTotal);

        }

        if(itemdb.getSalesByDraftsList() !=null && itemdb.getSalesByDraftsList().size()>0){
            salesWrapper.setSalesByDraftsList(itemdb.getSalesByDraftsList());
            Long cost91 = Long.valueOf(0);
            Long numberContract= Long.valueOf(0);
            Long costDraft = Long.valueOf(0);
            Long costOutsite = Long.valueOf(0) ;
            Long costDetermine= Long.valueOf(0);
            Long costTotal = Long.valueOf(0);
            for(int i = 0 ; i<salesWrapper.getSalesByDraftsList().size();i++){
                cost91 += salesWrapper.getSalesByDraftsList().get(i).getCost_tt91();
                numberContract += salesWrapper.getSalesByDraftsList().get(i).getNumberContract();
                costDraft += salesWrapper.getSalesByDraftsList().get(i).getCost_draft();
                costOutsite += salesWrapper.getSalesByDraftsList().get(i).getCost_notary_outside();
                costDetermine += salesWrapper.getSalesByDraftsList().get(i).getCost_other_determine();
                costTotal +=salesWrapper.getSalesByDraftsList().get(i).getCost_total();

            }
            salesWrapper.setDraft91Total(cost91);
            salesWrapper.setDraftNumberContractTotal(numberContract);
            salesWrapper.setDraftDraftTotal(costDraft);
            salesWrapper.setDraftOutsideTotal(costOutsite);
            salesWrapper.setDraftDetermineTotal(costDetermine);
            salesWrapper.setDraftTotal(costTotal);

        }
        if(itemdb.getSalesByKindContracts() !=null && itemdb.getSalesByKindContracts().size()>0){
            salesWrapper.setSalesByKindContracts(itemdb.getSalesByKindContracts());
            Long cost91 = Long.valueOf(0);
            Long numberContract= Long.valueOf(0);
            Long costDraft = Long.valueOf(0);
            Long costOutsite = Long.valueOf(0) ;
            Long costDetermine= Long.valueOf(0);
            Long costTotal = Long.valueOf(0);
            for(int i = 0 ; i<salesWrapper.getSalesByKindContracts().size();i++){
                cost91 += salesWrapper.getSalesByKindContracts().get(i).getCost_tt91();
                numberContract += salesWrapper.getSalesByKindContracts().get(i).getNumberContract();
                costDraft += salesWrapper.getSalesByKindContracts().get(i).getCost_draft();
                costOutsite += salesWrapper.getSalesByKindContracts().get(i).getCost_notary_outside();
                costDetermine += salesWrapper.getSalesByKindContracts().get(i).getCost_other_determine();
                costTotal +=salesWrapper.getSalesByKindContracts().get(i).getCost_total();

            }
            salesWrapper.setKind91Total(cost91);
            salesWrapper.setKindNumberContractTotal(numberContract);
            salesWrapper.setKindDraftTotal(costDraft);
            salesWrapper.setKindOutsideTotal(costOutsite);
            salesWrapper.setKindDetermineTotal(costDetermine);
            salesWrapper.setKindTotal(costTotal);

        }
        /*contractStasticsWrapper.setContractStasticsDrafter(contractStasticsDrafter);

        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractByDrafter(totalContractByDrafter);


        for (int i = 0; i < contractStasticsDrafter.size(); i++) {
            totalErrorContractByDrafter += contractStasticsDrafter.get(i).getNumber_of_error_contract();

        }
        contractStasticsWrapper.setTotalErrorContractByDrafter(totalErrorContractByDrafter);

        List<ContractStastics> contractStasticsNotary = QueryFactory.getContractStasticsNotary(orderFilter);
        contractStasticsWrapper.setContractStasticsNotary(contractStasticsNotary);
        for (int i = 0; i < contractStasticsNotary.size(); i++) {
            totalContractByNotary += contractStasticsNotary.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractByNotary(totalContractByNotary);
        for (int i = 0; i < contractStasticsNotary.size(); i++) {
            totalErrorContractByNotary += contractStasticsNotary.get(i).getNumber_of_error_contract();

        }
        contractStasticsWrapper.setTotalErrorContractByNotary(totalErrorContractByNotary);
        List<ContractStasticsBank> contractStasticsBanks = QueryFactory.getContractStasticsBank(orderFilter);
        contractStasticsWrapper.setContractStasticsBanks(contractStasticsBanks);
        for (int i = 0; i < contractStasticsBanks.size(); i++) {
            totalContractBank += contractStasticsBanks.get(i).getNumber_of_contract();
        }
        contractStasticsWrapper.setTotalContractBank(totalContractBank);*/
        if (!salesWrapper.getTimeType().equals("05")) {
            salesWrapper.setFromDate("");
            salesWrapper.setToDate("");
        }
        view.setViewName("/contract/tkdt");
        view.addObject("salesWrapper", salesWrapper);
        view.addObject("validate_msg_from_date", ValidateUtil.validate_msg_from_date);
        view.addObject("validate_msg_to_date", ValidateUtil.validate_msg_to_date);
        session.setAttribute(SalesWrapper.SESSION_KEY, salesWrapper);

        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/loadContractTemplate", method = RequestMethod.GET)
    public String loadContractTemplate(HttpServletRequest request) throws JSONException {
        Long contractKind = Long.valueOf(request.getParameter("contractKind"));
        String result = "";
        List<ContractTemplate> contractTemplates = null;
        if (contractKind == 0) {
            contractTemplates = QueryFactory.getContractTemplate("where 1=1");
        } else {
            contractTemplates = QueryFactory.getContractTemplate(" where code = " + contractKind);
        }
        for (int i = 0; i < contractTemplates.size(); i++) {
            result += contractTemplates.get(i).getCode_template() + "," + contractTemplates.get(i).getName() + ";";
        }

        return new JSONObject().put("result", result).toString();

    }

    @ResponseBody
    @RequestMapping(value = "/loadDetail", method = RequestMethod.GET)
    public String loadDetail(HttpServletRequest request, HttpServletResponse response) throws JSONException {
        HttpSession session = request.getSession();
        session.removeAttribute(ReportByGroupTotalList.SESSION_KEY);
        String tenHDCT = request.getParameter("loadDetail1");
        String[] idArr = tenHDCT.split("oOo");
        ReportByGroupTotalList reportByGroupTotalList = new ReportByGroupTotalList();
        reportByGroupTotalList.setNhomHD(idArr[1]);
        reportByGroupTotalList.setTenHD(idArr[0]);
        reportByGroupTotalList.setNotaryDateFromFilter(idArr[2]);
        reportByGroupTotalList.setNotaryDateToFilter(idArr[3]);
        reportByGroupTotalList.setCodeTemplate(idArr[4]);

        session.setAttribute(ReportByGroupTotalList.SESSION_KEY, reportByGroupTotalList);
        return new JSONObject().put("result", "ok").toString();
    }
    @RequestMapping(value = "/export-sales", method = RequestMethod.GET)
    public void exportSales(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            SalesWrapper salesWrapper = (SalesWrapper) session.getAttribute(SalesWrapper.SESSION_KEY);

            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", salesWrapper.getPrintFromDate());
            beans.put("todate", salesWrapper.getPrintToDate());
            beans.put("SalesByNotarysList", salesWrapper.getSalesByNotarysList());
            beans.put("SalesByDraftsList", salesWrapper.getSalesByDraftsList());
            beans.put("SalesByKindContracts", salesWrapper.getSalesByKindContracts());
            //
            beans.put("notaryNumberContractTotal", salesWrapper.getNotaryNumberContractTotal());
            beans.put("notary91Total", salesWrapper.getNotary91Total());
            beans.put("notaryDraftTotal", salesWrapper.getNotaryDraftTotal());
            beans.put("notaryOutsideTotal", salesWrapper.getNotaryOutsideTotal());
            beans.put("notaryDetermineTotal", salesWrapper.getNotaryDetermineTotal());
            beans.put("notaryTotal", salesWrapper.getNotaryTotal());
            beans.put("draftNumberContractTotal", salesWrapper.getDraftNumberContractTotal());
            beans.put("draft91Total", salesWrapper.getDraft91Total());
            beans.put("draftDraftTotal", salesWrapper.getDraftDraftTotal());
            beans.put("draftOutsideTotal", salesWrapper.getDraftOutsideTotal());
            beans.put("draftDetermineTotal", salesWrapper.getDraftDetermineTotal());
            beans.put("draftTotal", salesWrapper.getDraftTotal());
            beans.put("kindNumberContractTotal", salesWrapper.getKindNumberContractTotal());
            beans.put("kind91Total", salesWrapper.getKind91Total());
            beans.put("kindDraftTotal", salesWrapper.getKindDraftTotal());
            beans.put("kindOutsideTotal", salesWrapper.getKindOutsideTotal());
            beans.put("kindDetermineTotal", salesWrapper.getKindDetermineTotal());
            beans.put("kindTotal", salesWrapper.getKindTotal());



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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "BaocaoTKDT.xls"));


            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_BaocaoTKDT.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-general-stastics", method = RequestMethod.GET)
    public void exportGeneralStastistics(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            ContractStasticsWrapper contractStasticsWrapper = (ContractStasticsWrapper) session.getAttribute(ContractStasticsWrapper.SESSION_KEY);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", contractStasticsWrapper.getPrintFromDate());
            beans.put("todate", contractStasticsWrapper.getPrintToDate());
            beans.put("totalNotary", contractStasticsWrapper.getTotalContractByNotary());
            beans.put("totalErrorNotary", contractStasticsWrapper.getTotalErrorContractByNotary());
            beans.put("totalDrafter", contractStasticsWrapper.getTotalContractByDrafter());
            beans.put("totalErrorDrafter", contractStasticsWrapper.getTotalErrorContractByDrafter());
            beans.put("totalBank", contractStasticsWrapper.getTotalContractBank());
            beans.put("TotalNotary", contractStasticsWrapper.getTotalContractByNotary());
            beans.put("TotalErrorNotary", contractStasticsWrapper.getTotalErrorContractByNotary());

            beans.put("totalByNotary", contractStasticsWrapper.getContractStasticsNotary());
            beans.put("totalByDrafter", contractStasticsWrapper.getContractStasticsDrafter());
            beans.put("totalByBank", contractStasticsWrapper.getContractStasticsBanks());


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
            InputStream fileIn = null;
            if(SystemProperties.getProperty("org_type").equals("1")){//is phuong xa
                fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeChungThuc.xls"));
            }
            else{
                fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "Thongke.xls"));
            }

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_Thongke.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-export-tinh-hinh-nhap-hd-phuong-xa", method = RequestMethod.GET)
    public void exportGeneralStastisticsOfWards(HttpServletRequest request, HttpServletResponse response) {
        try {

            HttpSession session = request.getSession();
            ContractStasticsWrapper contractStasticsWrapper = (ContractStasticsWrapper) session.getAttribute(ContractStasticsWrapper.SESSION_KEY);
            //     export(contractStasticsWrapper,response);
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("fromdate", contractStasticsWrapper.getPrintFromDate());
            beans.put("todate", contractStasticsWrapper.getPrintToDate());
            beans.put("countTotalContractByNotaryOfDistricts", contractStasticsWrapper.getTotalContractByNotaryOfDistricts());

            beans.put("totalByDistricts", contractStasticsWrapper.getContractStasticsOfDistricts());


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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeTinhHinhPhuongXa.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_Thongke.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/export-temp-tinh-hinh-nhap-hd-phuong-xa", method = RequestMethod.GET)
    public void export(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        ContractStasticsWrapper contractStasticsWrapper = (ContractStasticsWrapper) session.getAttribute(ContractStasticsWrapper.SESSION_KEY);
        String agency = ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency();
        // Blank workbook
        HSSFWorkbook  workbook = new HSSFWorkbook ();

        // Create a blank sheet
        HSSFSheet sheet = workbook.createSheet("Thống kê");
        sheet.setDisplayGridlines(false);
        sheet.setColumnWidth(0, 10000);
        sheet.setColumnWidth(1, 5000);
        sheet.setColumnWidth(2, 8000);
        sheet.setColumnWidth(3, 8000);
        sheet.setColumnWidth(4, 10000);

        //set style text center
        HSSFCellStyle style_center = workbook.createCellStyle();
        /* Center Align Cell Contents */
        style_center.setAlignment(HSSFCellStyle .ALIGN_CENTER);
        style_center.setVerticalAlignment(HSSFCellStyle .VERTICAL_CENTER);



        //set style font bold
        HSSFCellStyle style_FontBold = workbook.createCellStyle();
        HSSFFont my_font_bold=workbook.createFont();
        my_font_bold.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        style_FontBold.setFont(my_font_bold);

        HSSFCellStyle  style_content = workbook.createCellStyle();
        style_content.setAlignment(HSSFCellStyle .ALIGN_CENTER);
        style_content.setVerticalAlignment(HSSFCellStyle .VERTICAL_CENTER);
        style_content.setBorderBottom(CellStyle.BORDER_THIN);
        style_content.setBorderTop(CellStyle.BORDER_THIN);
        style_content.setBorderRight(CellStyle.BORDER_THIN);
        style_content.setBorderLeft(CellStyle.BORDER_THIN);

        //set style for title
        HSSFCellStyle  style_title = workbook.createCellStyle();
        style_title.setAlignment(HSSFCellStyle .ALIGN_CENTER);
        style_title.setVerticalAlignment(HSSFCellStyle .VERTICAL_CENTER);
        style_title.setBorderBottom(CellStyle.BORDER_THIN);
        style_title.setBorderTop(CellStyle.BORDER_THIN);
        style_title.setBorderRight(CellStyle.BORDER_THIN);
        style_title.setBorderLeft(CellStyle.BORDER_THIN);
        style_title.setFont(my_font_bold);

        HSSFCellStyle style_ReportName = workbook.createCellStyle();
        HSSFFont my_font=workbook.createFont();
        my_font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        my_font.setFontHeightInPoints((short)14);
        style_ReportName.setFont(my_font);
        style_ReportName.setAlignment(HSSFCellStyle .ALIGN_CENTER);

        //set style for border bottom
        HSSFCellStyle  style_borderBottom = workbook.createCellStyle();
        style_borderBottom.setBorderBottom(CellStyle.BORDER_THIN);

        Row row0 = sheet.createRow(0);
        Cell cell0 = row0.createCell(0);
        cell0.setCellValue(agency);
        Cell cell4 = row0.createCell(4);
        cell4.setCellValue("Cộng Hòa Xã Hội Chủ Nghĩa Việt Nam");
        cell4.setCellStyle(style_center);

        Row row1 = sheet.createRow(1);
        Cell cell14 = row1.createCell(4);
        cell14.setCellValue("Độc Lập - Tự Do - Hạnh Phúc");
        cell14.setCellStyle(style_center);

        Row rowNameReport = sheet.createRow(3);
        Cell cellNameReport = rowNameReport.createCell(1);
        cellNameReport.setCellValue("BÁO CÁO THỐNG KÊ HỢP ĐỒNG CHỨNG THỰC");
        sheet.addMergedRegion(new CellRangeAddress(3,3,1,4));
        cellNameReport.setCellStyle(style_ReportName);

        Row rowDateReport = sheet.createRow(4);
        Cell cellDateReport = rowDateReport.createCell(1);
        cellDateReport.setCellValue("Từ ngày "+contractStasticsWrapper.getPrintFromDate()+" đến ngày "+contractStasticsWrapper.getPrintToDate());
        sheet.addMergedRegion(new CellRangeAddress(4,4,1,4));
        cellDateReport.setCellStyle(style_center);



        Row rowTitle = sheet.createRow(7);

        Cell cellSTTTitle = rowTitle.createCell(1);
        cellSTTTitle.setCellValue("STT");
        cellSTTTitle.setCellStyle(style_title);

        Cell cellQHTitle = rowTitle.createCell(2);
        cellQHTitle.setCellValue("Quận/huyện");
        cellQHTitle.setCellStyle(style_title);


        Cell cellPXTitle = rowTitle.createCell(3);
        cellPXTitle.setCellValue("Phường/xã");
        cellPXTitle.setCellStyle(style_title);

        Cell cellSLTitle = rowTitle.createCell(4);
        cellSLTitle.setCellValue("Tổng cộng");
        cellSLTitle.setCellStyle(style_title);

        int rownum = 8;
        for(int i = 0; i<contractStasticsWrapper.getContractStasticsOfDistricts().size(); i++){
            ContractStasticsOfDistricts thisContractStasticsOfDistricts = contractStasticsWrapper.getContractStasticsOfDistricts().get(i);
            for(int j = 0;j<thisContractStasticsOfDistricts.getContractStasticsOfWards().size();j++){
                ContractStasticsOfWards thisContractStasticsOfWards = thisContractStasticsOfDistricts.getContractStasticsOfWards().get(j);
                Row row = sheet.createRow(rownum++);
                Cell cellSTT = row.createCell(1);
                cellSTT.setCellValue(i+1);
                cellSTT.setCellStyle(style_content);
                Cell cellQH = row.createCell(2);
                cellQH.setCellValue(thisContractStasticsOfDistricts.getDistrict_name());
                cellQH.setCellStyle(style_content);
                Cell cellPX = row.createCell(3);
                cellPX.setCellValue(thisContractStasticsOfWards.getFamily_name()+ " " + thisContractStasticsOfWards.getFirst_name());
                cellPX.setCellStyle(style_content);
                Cell cellSL = row.createCell(4);
                cellSL.setCellValue(thisContractStasticsOfWards.getNumber_of_contract());
                cellSL.setCellStyle(style_content);

/*                if(j>0 && thisContractStasticsOfWards.getDistrictCode().equals(thisContractStasticsOfDistricts.getContractStasticsOfWards().get(j-1).getDistrictCode())){
                    try{
                        sheet.addMergedRegion(new CellRangeAddress(rownum-1,rownum,1,1));
                        sheet.addMergedRegion(new CellRangeAddress(rownum-1,rownum,2,2));
                    }
                    catch (Exception e){
                        e.printStackTrace();
                    }

                }*/
            }
        }

        //check and merge
        int indexMerge = 8;
        for (int i=8; i< rownum-1; i++) {
            Cell cell = sheet.getRow(i).getCell(1);
            if (!sheet.getRow(i).getCell(1).toString().equals( sheet.getRow(i+1).getCell(1).toString()))
            {
                CellRangeAddress cellRangeAddress = new CellRangeAddress(indexMerge,i,1,1);
                sheet.addMergedRegion(cellRangeAddress);
                CellRangeAddress cellRangeAddress2 = new CellRangeAddress(indexMerge,i,2,2);
                sheet.addMergedRegion(cellRangeAddress2);
                indexMerge=i+1;
            }

        }

        CellRangeAddress cellRangeAddress = new CellRangeAddress(indexMerge,rownum-1,1,1);
        sheet.addMergedRegion(cellRangeAddress);
        CellRangeAddress cellRangeAddress2 = new CellRangeAddress(indexMerge,rownum-1,2,2);
        sheet.addMergedRegion(cellRangeAddress2);



        Row rowTongSo = sheet.createRow(rownum);
        Cell cellTongSoTitle = rowTongSo.createCell(1);
        cellTongSoTitle.setCellValue("Tổng số");
        cellTongSoTitle.setCellStyle(style_title);

        Cell cellNullValue = rowTongSo.createCell(2);
        cellNullValue.setCellValue("");
        cellNullValue.setCellStyle(style_title);

        Cell cellNullValue2 = rowTongSo.createCell(3);
        cellNullValue2.setCellValue("");
        cellNullValue2.setCellStyle(style_title);

        sheet.addMergedRegion(new CellRangeAddress(rownum,rownum,1,3));

        Cell cellTongSoValue = rowTongSo.createCell(4);
        cellTongSoValue.setCellValue(contractStasticsWrapper.getTotalContractByNotaryOfDistricts());
        cellTongSoValue.setCellStyle(style_content);


        Row rowEnd = sheet.createRow(rownum+2);
        Cell cellEnd = rowEnd.createCell(3);
        cellEnd.setCellStyle(style_borderBottom);

        Date date = new Date(); // your date
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        Row rowDateExport = sheet.createRow(rownum+3);
        Cell cellDateExport = rowDateExport.createCell(3);
        cellDateExport.setCellValue("Ngày "+day+" tháng "+(month+1)+" năm "+year);
        cellDateExport.setCellStyle(style_center);

        Row rowPersonExport = sheet.createRow(rownum+4);
        Cell cellPersonExport = rowPersonExport.createCell(3);
        cellPersonExport.setCellValue("Người báo cáo");
        cellPersonExport.setCellStyle(style_center);
        try {
            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload+"_thong_ke_tinh_hinh_hd_px.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);

            // this Writes the workbook gfgcontribute
/*            FileOutputStream out = new FileOutputStream(new File("E:/thong_ke_tinh_hinh_hd_px.xls"));
            workbook.write(out);*/
            out.close();
            System.out.println("gfgcontribute.xlsx written successfully on disk.");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Báo cáo chứng thực theo thông tư 03
    /*@RequestMapping(value = "/certificate-by-tt03", method = RequestMethod.GET)
    public ModelAndView tt04(ReportByTT04List reportCertificateByTT03List, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "23", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        HttpSession session = request.getSession();
        String validateToDate = "";
        String validateFromDate = "";
        ValidateUtil.validate_msg_from_date ="";
        ValidateUtil.validate_msg_to_date ="";



        if (reportByTT04List.getTimeType() == null) {
            validateToDate = "";
            validateFromDate = "";
            reportByTT04List.setTimeType("03");
        }
        if (ValidateUtil.validateDatefrom(reportByTT04List.getFromDate())) {
            validateFromDate = "";
        }
        if (ValidateUtil.validateDateto(reportByTT04List.getToDate())) {
            validateToDate = "";
        }
        if (!StringUtils.isBlank(reportByTT04List.getTimeType())) {
            if (reportByTT04List.getTimeType().equals("05")) {
                ValidateUtil.validateDatefrom(reportByTT04List.getPrintFromDate());
                ValidateUtil.validateDateto(reportByTT04List.getPrintToDate());
                validateFromDate = ValidateUtil.validate_msg_from_date;
                validateToDate = ValidateUtil.validate_msg_to_date;
                if (!StringUtils.isBlank(reportByTT04List.getPrintFromDate())) {
                    if (!StringUtils.isBlank(reportByTT04List.getPrintToDate())) {
                        Date fromDate = TimeUtil.stringToDate(reportByTT04List.getPrintFromDate());
                        Date toDate = TimeUtil.stringToDate(reportByTT04List.getPrintToDate());
                        if (fromDate.getTime() > toDate.getTime()) {
                            view.setViewName("/contract/tt04");
                            view.addObject("reportByTT04List", reportByTT04List);
                            validateFromDate = "Từ ngày không được lớn hơn Đến ngày";
                            view.addObject("validate_msg_from_date", validateFromDate);
                            return view;
                        }
                        if (ValidateUtil.validateDatefrom(reportByTT04List.getPrintFromDate()) == false || ValidateUtil.validateDateto(reportByTT04List.getPrintToDate()) == false) {
                            view.setViewName("/contract/tt04");
                            view.addObject("reportByTT04List", reportByTT04List);
                            view.addObject("validate_msg_from_date", validateFromDate);
                            view.addObject("validate_msg_to_date", validateToDate);
                            return view;
                        }
                    } else {
                        *//*Integer year = (Integer) Calendar.getInstance().get(Calendar.YEAR);
                        Integer month = (Integer) Calendar.getInstance().get(Calendar.MONTH) + 1;
                        Integer date = (Integer) Calendar.getInstance().get(Calendar.DATE);
                        String toDate = date.toString() + "/" + month.toString() + "/" + year.toString();*//*
                        Date date = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                        String toDate = format.format(date);
                        reportByTT04List.setPrintToDate(toDate);
                    }
                } else {
                    view.setViewName("/contract/tt04");
                    view.addObject("validate_msg_from_date", "Trường từ ngày không được để trống");
                    return view;
                }
            }
        }
        reportByTT04List.createFromToDate();
        //  reportByTT04List.setNameNotaryOffice(SystemProperties.getProperty("NameNotaryOffice"));
        List<ReportByTT04List> reportByTT04Lists= QueryFactory.getReportByTT04List(reportByTT04List.generateJson());
        if(reportByTT04Lists != null){
            if(reportByTT04Lists.size() > 0){
                reportByTT04List = reportByTT04Lists.get(0);
            }
        }
        reportByTT04List.setNumNotaryOffice(1);
        session.setAttribute(ReportByTT04List.SESSION_KEY, reportByTT04List);
        view.setViewName("/contract/tt04");
        view.addObject("reportByTT04List", reportByTT04List);
        view.addObject("tongPhiCongChung",BaseController.formatNumber(reportByTT04List.getTongPhiCongChung()));
        view.addObject("tongThuLao",BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
        view.addObject("tongSoThuLao",BaseController.formatNumber(reportByTT04List.getThuLaoCongChung()));
        view.addObject("validate_msg_from_date", validateFromDate);
        view.addObject("validate_msg_to_date", validateToDate);
        return view;
    }*/


    @RequestMapping(value = "/luong-giao-dich-bds", method = RequestMethod.GET)
    public ModelAndView reportLuongGDBDS(HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "38", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userId", userSession.getUserId());
        modelAndView.setViewName("contract/tkGGBDS");
        return modelAndView;
    }


    @RequestMapping(value = "/export-luong-giao-dich-bds", method = RequestMethod.GET)
    public void exportLuongGDBDS(HttpServletRequest request, HttpServletResponse response,
                                   @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                                   @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo,
                                   @RequestParam(name = "districtCode", required = false, defaultValue = "") String districtCode) {
        try {

            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
            List<ReportLuongGDBDS> items = new ArrayList<>();
            items = QueryFactory.getReportLuongGDBDS(dateFrom, dateTo, districtCode);

            ReportLuongGDBDSList data = new ReportLuongGDBDSList();
            data.setItems(items);
            data.countTotal(items);

            String provinceName = QueryFactory.getSystemConfigByKey("notary_office_province");

            Map<String, Object> beans = new HashMap<String, Object>();

            String[] arrFromDate = dateFrom.split("/");
            String[] arrToDate = dateTo.split("/");
            beans.put("fromDate_day", arrFromDate[0]);
            beans.put("fromDate_month", arrFromDate[1]);
            beans.put("fromDate_year", arrFromDate[2]);
            beans.put("toDate_day", arrToDate[0]);
            beans.put("toDate_month", arrToDate[1]);
            beans.put("toDate_year", arrToDate[2]);
            beans.put("items", data.getItems());
            beans.put("data", data);
            beans.put("agency", ((CommonContext) request.getSession().getAttribute(request.getSession().getId())).getAgency());
            beans.put("provinceName", provinceName);

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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeGDBDS.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload + "ThongkeGDBDS.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}
