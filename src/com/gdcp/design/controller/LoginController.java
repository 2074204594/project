package com.gdcp.design.controller;

import com.gdcp.design.entity.User;
import com.gdcp.design.service.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    private loginService loginService;

    @RequestMapping("login.do")
    @ResponseBody
    public boolean Login(User user){
        String flag=loginService.login(user);//返回值为1则存在，为null就不存在
        if(flag==null){
            return false;
        }else{
            return true;
        }
    }
}
