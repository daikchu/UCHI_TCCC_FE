package com.vn.osp.controller;

import com.github.cage.Cage;
import com.github.cage.GCage;
import com.vn.osp.util.Utils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class CaptchaController {

    private static final Cage cage = new GCage();

    @RequestMapping(value = "/captcha", method = RequestMethod.GET)
    @ResponseBody
    public String captcha(HttpServletRequest request, HttpServletResponse response) throws IOException {

        generateToken(request.getSession());
        HttpSession session = request.getSession(false);
        String token = session != null ? getToken(session) : null;
        if (token == null || isTokenUsed(session)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Captcha not found.");
            System.out.println("Captcha not found.");
        }
        setResponseHeaders(response);
        markTokenUsed(session, true);
        cage.draw(token, response.getOutputStream());

        return "redirect:/captcha";
        //return "forward:/Captcha";
    }

    public static void generateToken(HttpSession session) {
        String token = Utils.randomCode(3);
        session.setAttribute("captchaToken", token);
        markTokenUsed(session, false);
    }

    public static String getToken(HttpSession session) {
        Object val = session.getAttribute("captchaToken");
        return val != null ? val.toString() : null;
    }

    protected static void markTokenUsed(HttpSession session, boolean used) {
        session.setAttribute("captchaTokenUsed", used);
    }

    protected static boolean isTokenUsed(HttpSession session) {
        return !Boolean.FALSE.equals(session.getAttribute("captchaTokenUsed"));
    }

    protected void setResponseHeaders(HttpServletResponse resp) {
        resp.setContentType("image/" + cage.getFormat());
        resp.setHeader("Cache-Control", "no-cache, no-store");
        resp.setHeader("Pragma", "no-cache");
        long time = System.currentTimeMillis();
        resp.setDateHeader("Last-Modified", time);
        resp.setDateHeader("Date", time);
        resp.setDateHeader("Expires", time);
    }

}
