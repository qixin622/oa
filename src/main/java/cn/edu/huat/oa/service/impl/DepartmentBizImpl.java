package cn.edu.huat.oa.service.impl;

import cn.edu.huat.oa.service.DepartmentBiz;
import cn.edu.huat.oa.dao.DepartmentDao;
import cn.edu.huat.oa.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentBizImpl implements DepartmentBiz {

    @Autowired
    private DepartmentDao departmentDao;

    @Override
    public void add(Department department) {
        departmentDao.insert(department);
    }

    @Override
    public void edit(Department department) {
        departmentDao.update(department);
    }

    @Override
    public void remove(String sn) {
        departmentDao.delete(sn);
    }

    @Override
    public void removeBatch(String[] sns) {
        departmentDao.deleteBatch(sns);
    }

    @Override
    public Department get(String sn) {
        return departmentDao.select(sn);
    }

    @Override
    public List<Department> getAll() {
        return departmentDao.selectAll();
    }
}
