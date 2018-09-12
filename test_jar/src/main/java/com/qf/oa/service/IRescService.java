package com.qf.oa.service;

import com.qf.oa.entity.Resc;

import java.util.List;

public interface IRescService {

    List<Resc> getAll(Integer rid);

    int insert(Resc resc);

    int addTranslate(Integer rid, Integer[] reids);
}
