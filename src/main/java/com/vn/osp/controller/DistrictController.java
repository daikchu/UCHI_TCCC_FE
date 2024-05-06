package com.vn.osp.controller;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.BaseController;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.SystemProperties;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.District;
import com.vn.osp.modelview.DistrictList;
import com.vn.osp.service.QueryFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/system/district")
public class DistrictController extends BaseController {
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView getDistrictList(Model model, DistrictList items, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_XEM) || SystemProperties.getProperty("org_type").equals("0")) return new ModelAndView("/404");
        BaseController.trimAllFieldOfObject(items);
        HttpSession session = request.getSession();
        items = createDistrictList(items);
        String action = (String) session.getAttribute(Constants.SESSION_ACTION);
        items.setAction_status(action);
        session.removeAttribute(Constants.SESSION_ACTION);
        return new ModelAndView("/district/list", "items", items);
    }

    public DistrictList createDistrictList(DistrictList items) {
        int total = 0;
        int totalPage = 0;
        int page = 1;
        String query = items.getFilter();
        total = QueryFactory.countDistricts(query);
        totalPage = QueryFactory.countPage(total);
        items.setTotalPage(totalPage);
        items.setTotal(total);
        if (page < 1) page = 1;
        if (page > totalPage) page = totalPage;
        items.setPage(page);
        items.setItems(QueryFactory.getDistricts(page, query));
        return items;
    }

    @RequestMapping(value = "/add-view", method = RequestMethod.GET)
    public ModelAndView addViewer(HttpServletRequest request) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        District item = new District();
        return new ModelAndView("/district/add", "item", item);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(District item, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_THEM)) return new ModelAndView("/404");
        trimAllFieldOfObject(item);
        HttpSession session = request.getSession();
        item.validate();
        if (item.getSuccess() == false) return new ModelAndView("/district/add", "item", item);

        Boolean checkCode = checkDistrictCodeAdd(item.getCode());
        if(!checkCode) {
            item.setCode_("Mã quận/huyện đã tồn tại!");
            item.setSuccess(false);
            return new ModelAndView("/district/add", "item", item);
        }

        Boolean result = QueryFactory.addDistrict(item.genAddObject(((CommonContext) session.getAttribute(session.getId())).getUser(),item));
        if (!result) {
            item.setSuccess(false);
            return new ModelAndView("/district/add", "item", item);
        }
        CommonContext commonContext = ((CommonContext) session.getAttribute(request.getSession().getId()));

        return new ModelAndView("redirect:/system/district/list");
    }

    @RequestMapping(value = "/update-view/{id}", method = RequestMethod.GET)
    public ModelAndView updateViewer(@PathVariable("id") final String id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        District item = QueryFactory.getDistrictById(Long.valueOf(id));
        if (item != null) {
            return new ModelAndView("/district/edit", "item", item);

        } else {
            redirectAttributes.addFlashAttribute("errorCode", "Quận/huyện không tồn tại !");
            return new ModelAndView("redirect:/system/district/list");
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(District item, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_SUA)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        view.addObject("item", item);
        view.setViewName("/district/edit");
        HttpSession session = request.getSession();
        item.validate();
        if (!item.getSuccess()) return view;

        Boolean checkCode = checkDistrictCodeUpdate(item);
        if(!checkCode) {
            item.setCode_("Mã quận/huyện đã tồn tại!");
            item.setSuccess(false);
            return new ModelAndView("/district/edit", "item", item);
        }

        District itemDB = QueryFactory.getDistrictById(Long.valueOf(item.getId()));
        if (itemDB != null) {
            Boolean resultUpdated = QueryFactory.updateDistrict(item.genUpdateObject(((CommonContext) session.getAttribute(session.getId())).getUser(),item));
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_district_update_success"));
            CommonContext commonContext = ((CommonContext) session.getAttribute(request.getSession().getId()));

            return new ModelAndView("redirect:/system/district/list");
        } else {
            redirectAttributes.addFlashAttribute("errorCode", "Quận/huyện không tồn tại !");
            return new ModelAndView("redirect:/system/district/list");
        }

    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable("id") Long id, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!ValidationPool.checkRoleDetail(request, "34", Constants.AUTHORITY_XOA)) return new ModelAndView("/404");
        HttpSession session = request.getSession();
        /*Boolean result = true;*/
        Boolean result = QueryFactory.removeDistrict(id.toString());
        if (result) {
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_district_delete_success"));
            return new ModelAndView("redirect:/system/district/list");
        } else {
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_district_delete_not"));
            return new ModelAndView("redirect:/system/district/list");
        }
    }

    public boolean checkDistrictCodeAdd(String code){
        List<District> districts = QueryFactory.getDistrictsByFilter(" and di.code = '"+code+"'");
        if(!districts.isEmpty()) return false;
        else return true;
    }

    public boolean checkDistrictCodeUpdate(District item){
        List<District> districts = QueryFactory.getDistrictsByFilter(" and di.code = '"+item.getCode()+"'");
        if(districts.isEmpty() || (districts.size()==1 && districts.get(0).getId().equals(item.getId()))) return true;
        else return false;
    }
}
