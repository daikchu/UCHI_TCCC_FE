package com.vn.osp.controller;

import com.vn.osp.common.util.PagingResult;
import com.vn.osp.modelview.CitizenVerifications;
import com.vn.osp.modelview.CitizenVerificationsWrapper;
import com.vn.osp.modelview.User;
import com.vn.osp.service.QueryFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/xac-thuc-danh-tinh")
public class CitizenVerificationController {
    @RequestMapping(value = "/danh-sach", method = RequestMethod.GET)
    public ModelAndView list(CitizenVerificationsWrapper citizenVerificationsWrapper,
                             HttpServletRequest request,
                             RedirectAttributes redirectAttributes){
        PagingResult page = new PagingResult();
        page.setPageNumber(citizenVerificationsWrapper.getPage());
        List<User> users = QueryFactory.getAllUser();
        try{
            page = QueryFactory.getPageCitizenVerification(citizenVerificationsWrapper);
        }catch (Exception e){
            redirectAttributes.addFlashAttribute("getMessage","Truy xuất thất bại, kiểm tra kết nối server trung gian hoặc liên hệ Admin!");
        }
//        page = TemplateFactory.getPageCitizenVerifyOrders(page);
        citizenVerificationsWrapper.setCitizenVerifications((List<CitizenVerifications>) page.getItems());
        citizenVerificationsWrapper.setTotal(page.getRowCount());
        citizenVerificationsWrapper.setTotalPage(page.getPageCount());
        citizenVerificationsWrapper.setUsers(users);

        return new ModelAndView("citizenVerification/list","dataWrapper",citizenVerificationsWrapper);
    }
}
