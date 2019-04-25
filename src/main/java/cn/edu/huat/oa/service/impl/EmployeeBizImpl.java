package cn.edu.huat.oa.service.impl;

import cn.edu.huat.oa.common.Contant;
import cn.edu.huat.oa.common.MD5Util;
import cn.edu.huat.oa.service.EmployeeBiz;
import cn.edu.huat.oa.dao.EmployeeDao;
import cn.edu.huat.oa.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("employeeBiz")
public class EmployeeBizImpl implements EmployeeBiz {
    @Autowired
    private EmployeeDao employeeDao;

    public void add(Employee employee) {
        employee.setPassword(MD5Util.encodeToHex(Contant.SALT+"000000"));
        employeeDao.insert(employee);
    }

    public void edit(Employee employee) {
        employeeDao.update(employee);
    }

    public void remove(String sn) {
        employeeDao.delete(sn);
    }

    public void removeBatch(String[] del_sns) {
        employeeDao.deleteBatch(del_sns);
    }

    public Employee get(String sn) {
        return employeeDao.select(sn);
    }

    public List<Employee> getBy(String type,String text) {
        return employeeDao.selectBy(type,text);
    }

    public List<Employee> getAll() {
        return employeeDao.selectAll();
    }
}
