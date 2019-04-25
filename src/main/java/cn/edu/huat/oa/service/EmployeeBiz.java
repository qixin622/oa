package cn.edu.huat.oa.service;

import cn.edu.huat.oa.entity.Employee;

import java.util.List;

public interface EmployeeBiz {
    void add(Employee employee);
    void edit(Employee employee);
    void remove(String sn);
    void removeBatch(String[] del_sns);
    Employee get(String sn);
    List<Employee> getBy(String type,String text);
    List<Employee> getAll();
}
