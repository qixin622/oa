package cn.edu.huat.oa.service;

import cn.edu.huat.oa.entity.Department;

import java.util.List;

public interface DepartmentBiz {

    void add(Department department);

    void edit(Department department);

    void remove(String sn);

    void removeBatch(String[] sns);

    Department get(String sn);

    List<Department> getAll();

}
