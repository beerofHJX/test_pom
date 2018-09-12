package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import com.qf.oa.service.IEmpService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/emp")
public class EmpController {

    @Autowired
    private IEmpService empService;

    @RequiresPermissions("/emp/emplist")
    @RequestMapping("/emplist")
    public String emplist(Model model){
        List<Employee> list = empService.getAll();
        model.addAttribute("list",list);
        return "emplist";
    }

    @RequestMapping("/queryall")
    @ResponseBody
    public List<Employee> queryall(Model model){
        List<Employee> list = empService.getAll();
        model.addAttribute("list",list);
        return list;
    }

    @RequiresPermissions("/emp/insertOne")
    @RequestMapping("/insertOne")
    public String insertOne(Employee employee){
        int id = empService.insert(employee);
        return "redirect:/emp/emplist";
    }
    @RequestMapping("/queryById")
    @ResponseBody
    public Employee queryOneAjax(Integer eid){
        Employee emp = empService.queryOne(eid);
        return emp;
    }

    @RequestMapping("/updataRole")
    public String updataRole(Integer eid , Integer[] rid ){
        empService.relieveRole(eid,rid);
        return "redirect:/emp/emplist";
    }
    @RequestMapping("/nome")
    @ResponseBody
    public List nome(){
        Employee employee = (Employee) SecurityUtils.getSubject().getPrincipal();
        List<Employee> emp = empService.selectNome(employee.getId());
        return emp;
    }

    /**
     * 根据关键字查询职工的信息
     */
    @RequestMapping("/querybykeyword")
    @ResponseBody
    public List<String> querybykeyword(String keyword){
        System.out.println(keyword);
        List<Employee> employees = empService.queryByKeyWord(keyword);
        List<String> array = new ArrayList<>();
        for (Employee employee : employees) {
            array.add(employee.getName() + "(" + employee.getEmail() + ")");
        }
        return array;
    }
}
