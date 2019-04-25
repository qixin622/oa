package cn.edu.huat.oa.dao;

import cn.edu.huat.oa.entity.Department;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("departmentDao")
public interface DepartmentDao {

    void insert(Department department);

    void update(Department department);

    void delete(String sn);

    void deleteBatch(String[] sns);

    Department select(String sn);

    List<Department> selectAll();
}
