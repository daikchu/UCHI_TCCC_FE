package com.vn.osp.controller;

import com.vn.osp.common.util.PagingResult;
import com.vn.osp.modelview.CitizenVerifyOrders;
import com.vn.osp.modelview.CitizenVerifyOrdersWrapper;
import com.vn.osp.modelview.User;
import com.vn.osp.service.APIUtil;
import com.vn.osp.service.QueryFactory;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.*;

@Controller
@RequestMapping("/giao-dich-phi-xac-thuc")
public class CitizenVerifyOrderController {
    @RequestMapping(value = "/danh-sach", method = RequestMethod.GET)
    public ModelAndView privyList(CitizenVerifyOrdersWrapper citizenVerifyOrdersWrapper,
                                  HttpServletRequest request,
                                  RedirectAttributes redirectAttributes){
        PagingResult page = new PagingResult();
        page.setPageNumber(citizenVerifyOrdersWrapper.getPage());
        try{
            page = QueryFactory.getPageCitizenVerifyOrder(citizenVerifyOrdersWrapper);
        }catch (Exception e){
            redirectAttributes.addFlashAttribute("getMessage","Truy xuất thất bại, kiểm tra kết nối server trung gian hoặc liên hệ Admin!");
        }

        List<User> users = QueryFactory.getAllUser();
//        page = TemplateFactory.getPageCitizenVerifyOrders(page);
        citizenVerifyOrdersWrapper.setCitizenVerifyOrders((List<CitizenVerifyOrders>) page.getItems());
        citizenVerifyOrdersWrapper.setTotal(page.getRowCount());
        citizenVerifyOrdersWrapper.setTotalPage(page.getPageCount());
        citizenVerifyOrdersWrapper.setUser_updates(users);

        return new ModelAndView("citizenVerifyOrder/list","dataWrapper",citizenVerifyOrdersWrapper);
    }
}
