package com.qf.oa.service.impl;

import com.qf.oa.dao.RescMapper;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RescServiceImpl implements IRescService {

    @Autowired
    private RescMapper rescMapper;

    @Override
    public List<Resc> getAll(Integer rid) {
        return rescMapper.getAll(rid);
    }

    @Override
    public int insert(Resc resc) {
        return rescMapper.insert(resc);
    }

    @Override
    public int addTranslate(Integer rid, Integer[] reids) {
        rescMapper.translate(rid);
        return rescMapper.addTranslate(rid,reids);
    }
}
