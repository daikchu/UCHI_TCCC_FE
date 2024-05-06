package com.vn.osp.controller;


import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.SystemMessageProperties;
import com.vn.osp.common.util.ValidationPool;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.NotaryBook;
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

import static com.vn.osp.util.StringUtils.trimAllFieldOfObject;

/**
 * Controller Quản lý sổ công chứng
 * Created by TuanNQ on 24/11/2020.
 */
@Controller
@RequestMapping(value = "/notarybook")
public class NotaryBookController {
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(Model model, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM))
            return new ModelAndView("/404");
        HttpSession session = request.getSession();
        String status = (String) session.getAttribute(Constants.SESSION_ACTION);

        session.removeAttribute(Constants.SESSION_ACTION);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("status", status);
        modelAndView.setViewName("notarybook/list");

        return modelAndView;
    }

    @RequestMapping(value = "/add-view", method = RequestMethod.GET)
    public ModelAndView add(Model model, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        NotaryBook item = new NotaryBook();

        model.addAttribute("item", item);
        return new ModelAndView("notarybook/add");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(NotaryBook item, HttpServletRequest request, HttpServletResponse response) {
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        trimAllFieldOfObject(item);
        HttpSession session = request.getSession();
        item.validate();
        if (item.getSuccess() == false)
            return new ModelAndView("notarybook/add", "item", item);

        if(checkValidateStatusNotary(item.getStatus(), item.getType()) == false){
            item.setNotary_book_("Để mở sổ mới, bạn vui lòng khóa sổ hiện tại !");
            item.setSuccess(false);
            return new ModelAndView("notarybook/add", "item", item);
        }

        Boolean result = QueryFactory.addNotaryBook(item.genAddObject(((CommonContext) session.getAttribute(session.getId())).getUser(), item));
        if (!result) {
            item.setSuccess(false);
            return new ModelAndView("notarybook/add", "item", item);
        }
        session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_add_success"));
        return new ModelAndView("redirect:/notarybook/list");
    }

    @RequestMapping(value = "/detail-view/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable("id") Long id, Model model, HttpServletRequest request, HttpServletResponse response,HttpSession session){
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        NotaryBook authenticaterCopies = QueryFactory.getNotaryBookById(id);
        if(authenticaterCopies.getId() == null) return new ModelAndView("/404");
        String status = (String) session.getAttribute(Constants.SESSION_ACTION);
        session.removeAttribute(Constants.SESSION_ACTION);

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("status", status);
        modelAndView.setViewName("notarybook/detail");
        model.addAttribute("item", authenticaterCopies);
        return modelAndView;
    }

    @RequestMapping(value = "/edit-view/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id, Model model, HttpServletRequest request, HttpServletResponse response){
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        NotaryBook notaryBooks = QueryFactory.getNotaryBookById(id);
        if(notaryBooks.getId() == null || notaryBooks.getStatus() == Constants.STATUS_NOTARY_BOOK_LOCK_UP) {
            return new ModelAndView("/404");
        }
        model.addAttribute("item", notaryBooks);
        return new ModelAndView("notarybook/edit");
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(NotaryBook item, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
        ModelAndView view = new ModelAndView();
        view.addObject("item", item);
        view.setViewName("notarybook/edit");
        HttpSession session = request.getSession();

        if(!checkNotaryBookNumberUpdate(item)) {
            item.setNotary_book_("Sổ công chứng đã tồn tại!");
            item.setSuccess(false);
            return new ModelAndView("notarybook/edit", "item", item);
        }

        NotaryBook itemDB = QueryFactory.getNotaryBookById(Long.valueOf(item.getId()));
        if (itemDB != null) {
            Boolean resultUpdated = QueryFactory.updateNotaryBook(item.genUpdateObject(((CommonContext) session.getAttribute(session.getId())).getUser(),item));
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_update_success"));
            return new ModelAndView("redirect:/notarybook/list");
        } else {
            redirectAttributes.addFlashAttribute("errorCode", "Sổ công chứng này không tồn tại !");
            return new ModelAndView("redirect:/notarybook/list");
        }

    }

//    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
//    public ModelAndView delete(@PathVariable("id") Long id, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
//        if (!ValidationPool.checkRoleDetail(request, "39", Constants.AUTHORITY_XEM)) return new ModelAndView("/404");
//        HttpSession session = request.getSession();
//
//        Boolean result = QueryFactory.removeNotaryBook(id.toString());
//        if (result) {
//            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_success"));
//            return new ModelAndView("redirect:/notarybook/list");
//        } else {
//            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_not"));
//            return new ModelAndView("redirect:/notarybook/list");
//        }
//    }
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public ModelAndView delete(HttpServletRequest request,HttpSession session){

        Long id=Long.parseLong(request.getParameter("idNotary"));
        String notary_book=request.getParameter("notaryBook");
        Long type=Long.parseLong(request.getParameter("typeNotaryBook"));
        Boolean bool = QueryFactory.getNotaryBookDelete(notary_book,type);
        if(bool){
            Boolean result = QueryFactory.removeNotaryBook(id.toString());
            if (result) {
                session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_success"));
                return new ModelAndView("redirect:/notarybook/list");
            } else {
                session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_not"));
                return new ModelAndView("redirect:/notarybook/list");
            }
        }else {
            session.setAttribute(Constants.SESSION_ACTION, SystemMessageProperties.getSystemProperty("v3_delete_notary_failure"));
            return new ModelAndView("redirect:/notarybook/detail-view/"+id);
        }

    }

    public boolean checkNotaryBookNumberAdd(String notary_book, Long type){
        List<NotaryBook> notaryBook = QueryFactory.getByNotaryBook(notary_book);
        if(notaryBook != null && notaryBook.isEmpty())
            return false;
        else
            return true;
    }

    public boolean checkNotaryBookNumberUpdate(NotaryBook item){
        NotaryBook notaryBooks = QueryFactory.getNotaryBookById(item.getId());
        if(notaryBooks != null)
            return true;
        else
            return false;
    }

    public boolean checkValidateStatusNotary(Long status, Long type){
        Boolean Status = QueryFactory.getStatusNotary(status, type);
        return Status;
    }
}
