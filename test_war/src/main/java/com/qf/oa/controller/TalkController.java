package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import com.qf.oa.utils.Utils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/talk")
public class TalkController {

    @RequestMapping("/foryour")
    @ResponseBody
    public void talk(Integer toid,String content){
        Employee employee = (Employee) SecurityUtils.getSubject().getPrincipal();

        //将消息放入数据表中 - from to content state 0 - 未读 1 - 已读

        //发送消息
        Utils.sendMsg(employee.getId() + "", content, toid + "");
    }
}
