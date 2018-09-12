package com.qf.oa.service;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.People;

import java.util.List;

public interface IEmpService {
    List<Employee> getAll();

    int insert(Employee employee);

    Employee queryOne(Integer eid);

    void relieveRole(Integer eid,Integer[] rids);

    Employee login(String email);

    List<Employee> selectNome (Integer id);

    People bysexlist();

    List<Employee> queryByKeyWord(String keyword);
}
