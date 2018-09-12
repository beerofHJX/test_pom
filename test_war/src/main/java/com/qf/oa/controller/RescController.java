package com.qf.oa.controller;

import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/resc")
public class RescController {

    @Autowired
    private IRescService rescService;

    @RequestMapping("/resclist")
    public String resclist(Model model){
        List<Resc> list = rescService.getAll(null);
        model.addAttribute("list",list);
        return "resclist";
    }
    @RequestMapping("/queryall")
    @ResponseBody
    public List queryallajjx(Integer rid){
        System.out.println("rid:"+rid);
        List<Resc> list = rescService.getAll(rid);
        return list;
    }
    @RequestMapping("/insertOne")
    public String insertOne(Resc resc){
        int i = rescService.insert(resc);
        return "redirect:/resc/resclist";
    }
    @RequestMapping("/selectresc")
    @ResponseBody
    public Integer selectresc(Integer rid, Integer[] reids){
        for (Integer reid : reids) {
            System.out.println("reids:"+reid);
        }
        int i = rescService.addTranslate(rid,reids);
        return i;
    }
}
