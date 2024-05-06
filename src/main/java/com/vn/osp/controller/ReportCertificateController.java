package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.Constant;
import com.vn.osp.common.util.SystemProperties;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.ReportCertByTT03;
import com.vn.osp.modelview.ReportCertByTT03CapHuyen;
import com.vn.osp.modelview.ReportCertByTT03CapTinh;
import com.vn.osp.modelview.User;
import com.vn.osp.service.QueryFactory;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("/reportCertificate")
public class ReportCertificateController {
    /*@RequestMapping(value = "/tt03", method = RequestMethod.GET)
    public ModelAndView tt03CapXa(HttpServletRequest request) {
        if (!ValidationPool.checkRoleDetail(request, "37", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userId", userSession.getUserId());
        modelAndView.setViewName("certificate/report/tt03");
        return modelAndView;
    }*/

    @RequestMapping(value = "/tt03", method = RequestMethod.GET)
    public ModelAndView tt03(HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "37", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userId", userSession.getUserId());
        modelAndView.addObject("districtCode", userSession.getDistrict_code());
        modelAndView.addObject("level_cert", userSession.getLevel_cert());
        if (userSession.getLevel_cert().equals(Constants.LEVEL_CERT_TINH)) {
            modelAndView.setViewName("certificate/report/tt03-cap-tinh");
        }
        else if (userSession.getLevel_cert().equals(Constants.LEVEL_CERT_HUYEN)){
            modelAndView.setViewName("certificate/report/tt03-cap-huyen");
        }
        else modelAndView.setViewName("certificate/report/tt03");
        return modelAndView;
    }

    @RequestMapping(value = "/tt03-export", method = RequestMethod.GET)
    public void exportTT03(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                           @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo) {
        try {
            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();

            ReportCertByTT03 item = new ReportCertByTT03();
            item = QueryFactory.getReportCertByTT03(userSession.getUserId().toString(), dateFrom, dateTo);
            Map<String, Object> beans = new HashMap<String, Object>();
            /*beans.put("fromdate", dateFrom);
            beans.put("todate", dateTo);*/

            String[] arrFromDate = dateFrom.split("/");
            String[] arrToDate = dateTo.split("/");
            beans.put("fromDate_day", arrFromDate[0]);
            beans.put("fromDate_month", arrFromDate[1]);
            beans.put("fromDate_year", arrFromDate[2]);
            beans.put("toDate_day", arrToDate[0]);
            beans.put("toDate_month", arrToDate[1]);
            beans.put("toDate_year", arrToDate[2]);

            beans.put("item", item);
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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeChungThucTT03CapXa.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload + "ThongkeChungThucTT03CapXa.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/tt03-cap-huyen-export", method = RequestMethod.GET)
    public void exportTT03CapHuyen(HttpServletRequest request, HttpServletResponse response,
                                   @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                                   @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo) {
        try {

            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
            List<ReportCertByTT03CapTinh> itemsPhongTuPhap = new ArrayList<>();
            itemsPhongTuPhap = QueryFactory.getReportCertByTT03PhongTuPhap(userSession.getDistrict_code(), "", dateFrom, dateTo);
            List<ReportCertByTT03CapHuyen> itemsCapHuyen = new ArrayList<>();
            itemsCapHuyen = QueryFactory.getReportCertByTT03ListXaThuocHuyen(userSession.getDistrict_code(), "", dateFrom, dateTo);

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

            beans.put("itemsPhongTuPhap", itemsPhongTuPhap);
            beans.put("itemsCapHuyen", itemsCapHuyen);
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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeChungThucTT03CapHuyen.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload + "ThongkeChungThucTT03CapHuyen.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/tt03-cap-tinh-export", method = RequestMethod.GET)
    public void exportTT03CapTinh(HttpServletRequest request, HttpServletResponse response,
                                   @RequestParam(name = "dateFrom", required = false, defaultValue = "") String dateFrom,
                                   @RequestParam(name = "dateTo", required = false, defaultValue = "") String dateTo) {
        try {

            HttpSession session = request.getSession();
            User userSession = ((CommonContext) session.getAttribute(request.getSession().getId())).getUser();
            List<ReportCertByTT03CapTinh> itemsPhongTuPhap = new ArrayList<>();
            itemsPhongTuPhap = QueryFactory.getReportCertByTT03PhongTuPhap("", "", dateFrom, dateTo);
            List<ReportCertByTT03CapTinh> itemsCapTinh = new ArrayList<>();
            itemsCapTinh = QueryFactory.getReportCertByTT03ListXaThuocTinh("", "", dateFrom, dateTo);

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

            beans.put("itemsPhongTuPhap", itemsPhongTuPhap);
            beans.put("itemsCapTinh", itemsCapTinh);
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
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ThongkeChungThucTT03CapTinh.xls"));
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload + "ThongkeChungThucTT03CapTinh.xls");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
