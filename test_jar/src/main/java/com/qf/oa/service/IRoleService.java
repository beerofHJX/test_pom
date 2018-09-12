package com.qf.oa.service;

import com.qf.oa.entity.Role;

import java.util.List;

public interface IRoleService {
    List<Role> getAll();

    int insert(Role role);

    List<Role> getAllById(Integer eid);
}
