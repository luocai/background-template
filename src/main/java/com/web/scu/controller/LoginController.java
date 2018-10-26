package com.web.scu.controller;

import com.web.scu.common.Constant;
import com.web.scu.common.Result;
import com.web.scu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){

        return "login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(Model model, @RequestParam("username") String username,
                        @RequestParam("password") String password){

        System.out.println("简历拉发大方" + username + "密码" + password);

        Result result = userService.login(username,password);

        if (result.getResultCode() == 500){
            model.addAttribute("result",result);
            return "/login";
        }


        return "/admin";
    }
}
