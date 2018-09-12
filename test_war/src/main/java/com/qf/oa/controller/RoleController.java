package com.qf.oa.controller;

import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @RequestMapping("/rolelist")
    public String rolelist(Model model){
        List<Role> list = roleService.getAll();
        model.addAttribute("list",list);
        return "rolelist";
    }
    @RequestMapping("/insertOne")
    public String insertOne(Role role){
        int flag = roleService.insert(role);
        return "redirect:/role/rolelist";
    }
    @RequestMapping("/getAll")
    @ResponseBody
    public List<Role> getAll(Integer eid){
        List<Role> list = roleService.getAllById(eid);
        for(Role role:list){
            System.out.println(role.isFlag());
        }
        return list;
    }
}
