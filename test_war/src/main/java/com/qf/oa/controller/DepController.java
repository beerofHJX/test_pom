package com.qf.oa.controller;


import com.qf.oa.entity.Department;
import com.qf.oa.interceptor.Page;
import com.qf.oa.service.IDepService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dep")
public class DepController extends BaseController {

    @Autowired
    private IDepService depService;

    @RequiresPermissions("/dep/deplist")
    @RequestMapping("/deplist")
    public String getAll(Page page, Model model){
        List<Department> list = depService.getAll();
        for (Department department : list) {
            System.out.println(department);
        }
        model.addAttribute("list",list);
        return "deplist";
    }

    @RequiresPermissions("/dep/insertOne")
    @RequestMapping("insertOne")
    public String insertOne(Department department){
        depService.insert(department);
        return "redirect:/dep/deplist";
    }

    @RequestMapping("/queryall")
    @ResponseBody
    public  List<Department>  queryall(){
        List<Department> list = depService.getAll();
        return list;
    }

    @RequestMapping("/delete/{did}")
    public  String  deleteOne(@PathVariable("did") Integer id){
        depService.deleteOne(id);
        return "redirect:/dep/deplist";
    }
}
