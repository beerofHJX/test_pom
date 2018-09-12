package com.qf.oa.service;

import com.qf.oa.entity.Department;

import java.util.List;

public interface IDepService {
    List<Department> getAll();

    void insert(Department department);

    void deleteOne(Integer id);

    List<Department> getCount();
}
