package com.gdcp.design.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdcp.design.entity.User;
import com.gdcp.design.service.registerService;
import com.gdcp.design.service.userService;
import com.gdcp.design.utils.CodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    private registerService registerService;
    @Autowired
    private userService userService;
//    进行注册
    @RequestMapping("register.do")
    @ResponseBody
    public boolean UserRegister(User user,String code,HttpServletRequest req, HttpServletResponse resp){
        String scode=(String) req.getSession().getAttribute("code");//获取存在session中的code
        //判断用户输入的验证码是否正确
        if(code.equalsIgnoreCase(scode)){
            boolean flag= registerService.UserRegister(user);
            User user1=userService.getUserDetail(user.getUsername());
            Boolean flag01=registerService.UserDataRegister(user1.getId());
            return flag;
        }
        return false;
    }

//    检查用户名是否可用
    @RequestMapping("registerCheckUername.do")
    @ResponseBody
    public String UserRegisterCheckUsername(String username) throws JsonProcessingException {
        String str=registerService.UserRegisterCheckUsername(username);
        if(str==null){
            return "1";//用户名可用
        }else {
            return "0";//用户名不可用
        }
    }

//    生成验证码
    @RequestMapping("generateCode.do")
    @ResponseBody
    public void generateCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //创建对象
        CodeUtils vc = new CodeUtils();
        //获取图片对象
        BufferedImage bi = vc.getImage();
        //获得图片的文本内容
        String text = vc.getText();
        // 将系统生成的文本内容保存到session中，便于进行用户输入的验证码与生成的验证码
        req.getSession().setAttribute("code", text);
        //向浏览器输出图片
        vc.output(bi, resp.getOutputStream());
    }
}
