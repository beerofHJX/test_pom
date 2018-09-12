package com.qf.oa.controller;

import com.qf.oa.entity.Department;
import com.qf.oa.entity.People;
import com.qf.oa.service.IDepService;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/graphical")
public class GraphicalController {

    @Autowired
    private IEmpService empService;

    @Autowired
    private IDepService depService;
//    跳转视图
    @RequestMapping("/sex")
    public String bySex(Model model){
        People bysexlist = empService.bysexlist();
        model.addAttribute("data",bysexlist);
        return "bysexlist";
    }

    @RequestMapping("/some")
    public String bySome(Model model){
        List<Department> count = depService.getCount();
        model.addAttribute("datas",count);
        return "bysomelist";
    }

    /*按照性别查询的数据*/
    @RequestMapping("/bysexlist")
    @ResponseBody
    public People bysexlist(){
        People bysexlist = empService.bysexlist();
        System.out.println(bysexlist);
        return bysexlist;
    }

    /*按照部门查询人数的数据*/
    @RequestMapping("/shape")
    @ResponseBody
    public List byshape(){
        List<Department> count = depService.getCount();
        return count;
    }
}
