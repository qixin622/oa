package cn.edu.huat.oa.controller;

import cn.edu.huat.oa.common.Result;
import cn.edu.huat.oa.service.DepartmentBiz;
import cn.edu.huat.oa.service.EmployeeBiz;
import cn.edu.huat.oa.entity.Employee;
import cn.edu.huat.oa.common.Contant;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller("employeeController")
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private DepartmentBiz departmentBiz;
    @Autowired
    private EmployeeBiz employeeBiz;

    @RequestMapping("/list")
    public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                       @RequestParam(value = "type", required = false) String type,
                       @RequestParam(value = "searchText", required = false)String searchText,
                       Map<String,Object> map){
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        if(type!=null && searchText!=null){
            PageInfo page = new PageInfo(employeeBiz.getBy(type,searchText), 5);
            map.put("pageInfo",page);
        } else {
            PageInfo page = new PageInfo(employeeBiz.getAll(), 5);
            map.put("pageInfo",page);
        }
        return "employee_list";
    }

    @RequestMapping("/to_add")
    public String toAdd(Map<String,Object> map){
        map.put("employee",new Employee());
        map.put("dlist",departmentBiz.getAll());
        map.put("plist", Contant.getPosts());
        map.put("qlist",Contant.getQualification());
        map.put("imglist",Contant.getImgUrls());
        return "employee_add";
    }
    @RequestMapping("/add")
    public String add(Employee employee){
        employeeBiz.add(employee);
        return "redirect:list";
    }

    @RequestMapping(value = "/to_update",params = "sn")
    public String toUpdate(String sn,Map<String,Object> map){
        map.put("employee",employeeBiz.get(sn));
        map.put("dlist",departmentBiz.getAll());
        map.put("plist", Contant.getPosts());
        map.put("qlist",Contant.getQualification());
        map.put("imglist",Contant.getImgUrls());
        return "employee_update";
    }
    @RequestMapping("/update")
    public String update(Employee employee){
        employeeBiz.edit(employee);
        return "redirect:list";
    }
    @RequestMapping(value = "/remove",params = "sn")
    public String remove(String sn){
        if(sn.contains(",")){
            String[] del_sns = sn.split(",");
            employeeBiz.removeBatch(del_sns);
        } else {
            employeeBiz.remove(sn);
        }
        return "redirect:list";
    }

    /**
     * 检查职工编号是否可用
     * @param sn
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkSn")
    public Result checkSn(@RequestParam("sn") String sn){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[0-9]{6}$)";
        if(!sn.matches(regx)){
            return Result.fail().add("va_msg", "职工编号为6位数字");
        }

        //数据库用户名重复校验
        Employee emp = employeeBiz.get(sn);
        if(emp!=null){
            return Result.fail().add("va_msg", "职工编号重复");
        }else{
            return Result.success();
        }
    }

}
