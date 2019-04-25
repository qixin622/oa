package cn.edu.huat.oa.service;

import cn.edu.huat.oa.entity.Employee;

public interface GlobalBiz {
    Employee login(String sn, String password);
    void changePassword(Employee employee);
}
