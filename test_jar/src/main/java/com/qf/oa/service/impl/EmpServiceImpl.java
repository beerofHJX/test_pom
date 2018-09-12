package com.qf.oa.service.impl;

import com.qf.oa.dao.EmployeeMapper;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.People;
import com.qf.oa.service.IEmpService;
import com.qf.oa.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpServiceImpl implements IEmpService{
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.getAll();
    }

    @Override
    public int insert(Employee employee) {
        int id = employeeMapper.insert(employee);
        String token = Utils.getToken(employee);
        employee.setToken(token);
        employeeMapper.updateByPrimaryKeySelective(employee);
        return  id;
    }

    @Override
    public Employee queryOne(Integer eid) {
        return employeeMapper.selectByPrimaryKey(eid);
    }

    @Override
    public void relieveRole(Integer eid,Integer[] rids) {
        employeeMapper.relieveRole(eid);
        employeeMapper.insertRole(eid,rids);
    }

    @Override
    public Employee login(String email) {
        return employeeMapper.login(email);
    }

    @Override
    public List<Employee> selectNome(Integer id) {
        return employeeMapper.selectNoMe(id);
    }

    @Override
    public People bysexlist() {
        return employeeMapper.bysexlist();
    }

    @Override
    public List<Employee> queryByKeyWord(String keyword) {
        return employeeMapper.queryByKeyWord(keyword);
    }

}
