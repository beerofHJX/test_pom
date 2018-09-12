package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

    @RequestMapping("/login")
    public String login(String email, String password, Model model){
        System.out.println("email:"+email);
        System.out.println("password:"+password);

        //交给shiro进行认证
        Subject sub = SecurityUtils.getSubject();
        if(!sub.isAuthenticated()){

            UsernamePasswordToken token = new UsernamePasswordToken(email, password);
            try {
                sub.login(token);
            } catch (Exception e){
                return "login";
            }
        }
        //获得当前认证的对象
        Employee emp = (Employee) sub.getPrincipal();
        model.addAttribute("emp", emp);

        return "index";
    }

}
