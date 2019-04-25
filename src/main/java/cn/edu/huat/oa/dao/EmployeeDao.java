package cn.edu.huat.oa.dao;

import cn.edu.huat.oa.entity.Employee;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("employeeDao")
public interface EmployeeDao {
    void insert(Employee employee);
    void update(Employee employee);
    void delete(String sn);
    void deleteBatch(String[] del_sns);
    Employee select(String sn);
    List<Employee> selectBy(@Param("type") String type,@Param("text") String text);
    List<Employee> selectAll();
    List<Employee> selectByPost(String post);
    List<Employee> selectByDepartmentAndPost(@Param("dsn") String dsn, @Param("post") String post);
}
